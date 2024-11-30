# Create initial site containers
resource "mist_site" "this" {
  for_each      = var.sites
  org_id        = var.org_id
  sitegroup_ids = [mist_org_sitegroup.this.id]
  name          = join("", [var.name-prefix, each.value.name]) # Creating name based on var.name-prefix
  country_code  = each.value.country_code
  timezone      = each.value.timezone
  address       = each.value.address
  notes         = each.value.notes
  latlng        = each.value.latlng
  # Assign switch and WAN edge templates to the created site if the site has "edge" role. The ids will be known once the templates are created.
  networktemplate_id = each.value.role == "edge" ? mist_org_networktemplate.this["branch_switch"].id : null
  gatewaytemplate_id = each.value.role == "edge" ? mist_org_gatewaytemplate.this["srx_branches"].id : null
}

# Modify sites settings
resource "mist_site_setting" "this" {
  for_each = var.sites
  site_id  = mist_site.this[each.value.name].id
  vars     = each.value.vars
  gateway_mgmt = {
    root_password = var.root_password
    app_usage = true # Enable App Track license on site level
  }
}
