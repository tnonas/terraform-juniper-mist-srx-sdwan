# Create hub gateway profiles, WAN Edge gateway template and site network template for switches
resource "mist_org_deviceprofile_gateway" "this" {
  for_each              = var.hub_profiles
  org_id                = var.org_id
  name                  = join("", [var.name-prefix, each.value.name])
  port_config           = each.value.port_config
  ip_configs            = each.value.ip_configs
  path_preferences      = each.value.path_preferences
  service_policies      = each.value.service_policies
  routing_policies      = each.value.routing_policies
  bgp_config            = each.value.bgp_config
}

resource "mist_org_gatewaytemplate" "this" {
  for_each              = var.edge_template
  org_id                = var.org_id
  name                  = join("", [var.name-prefix, each.value.name])
  type                  = each.value.type
  port_config           = each.value.port_config
  ip_configs            = each.value.ip_configs
  dhcpd_config          = each.value.dhcpd_config
  path_preferences      = each.value.path_preferences
  service_policies      = each.value.service_policies
}

resource "mist_org_networktemplate" "this" {
  for_each                                = var.switch_template
  org_id                                  = var.org_id
  name                                    = join("", [var.name-prefix, each.value.name])
  switch_mgmt                             = each.value.switch_mgmt
  networks                                = each.value.networks
  port_usages                             = each.value.port_usages
  # disabled_system_defined_port_usages     = each.value.disabled_system_defined_port_usages # unsupported by the provider
  switch_matching = each.value.switch_matching
}