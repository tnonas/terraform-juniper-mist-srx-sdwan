# Assign devices to respective sites
resource "mist_org_inventory" "this" {
  for_each                  = var.inventory
  org_id                    = var.org_id
  inventory = {
    (each.key) = {
      # site_id                = ""
      site_id                = mist_site.this[each.value.site_id].id
      unclaim_when_destroyed = each.value.unclaim_when_destroyed
    }
  }
}

# Assign gateway device profiles to hub gateways
resource "mist_org_deviceprofile_assign" "this" {
  depends_on              = [mist_org_inventory.this] # Static dependency to mitigate double tf apply issue
  # Loop over var.inventory entries containing attribute type = "gateway" and name which contains "-DC" substring
  for_each                = {for k, v in var.inventory : k => v if v.type == "gateway" && v.hub_device_profile != "" }
  org_id                  = var.org_id
  deviceprofile_id        = mist_org_deviceprofile_gateway.this[each.value.hub_device_profile].id
  macs                    = [each.key]
}

# Name or rename gateways based on inventory data
resource "mist_device_gateway" "this" {
  depends_on = [mist_org_deviceprofile_assign.this]
  # Loop over var.inventory entries containing attribute type = "switch"
  for_each                = {for k, v in var.inventory : k => v if v.type == "gateway"}
  # Get switch device ID by MAC entry found in var.inventory. "each_key" defines both mist_org_inventory.this resource and MAC address to look for
  device_id               = provider::mist::search_inventory_by_mac(resource.mist_org_inventory.this[(each.key)], (each.key)).id
  # device_id               = mist_org_inventory.this[each.key].id
  name                    = each.value.name
  site_id                 = mist_site.this[each.value.site_id].id
  managed                 = true
}

# Name or rename switches based on inventory data
resource "mist_device_switch" "this" {
  # Loop over var.inventory entries containing attribute type = "switch"
  for_each                = {for k, v in var.inventory : k => v if v.type == "switch"}
  # Get switch device ID by MAC entry found in var.inventory. "each_key" defines both mist_org_inventory.this resource and MAC address to look for
  device_id               = provider::mist::search_inventory_by_mac(resource.mist_org_inventory.this[(each.key)], (each.key)).id
  # device_id               = mist_org_inventory.this[each.key].id
  name                    = each.value.name
  site_id                 = mist_site.this[each.value.site_id].id
  managed                 = true
}