# Create networks
resource "mist_org_network" "this" {
  for_each = var.networks
  org_id                  = var.org_id
  name                    = join("", [var.name-prefix, each.value.name])
  subnet                  = each.value.subnet
  vlan_id                 = each.value.vlan_id
  disallow_mist_services  = each.value.disallow_mist_services
  tenants                 = each.value.tenants
  vpn_access              = each.value.vpn_access
}