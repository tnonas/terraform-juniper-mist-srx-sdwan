# Create services (applications)
resource "mist_org_service" "this" {
  for_each = var.services
  org_id                  = var.org_id
  name                    = join("", [var.name-prefix, each.value.name])
  type = each.value.type
  addresses               = each.value.addresses
  apps                    = each.value.apps
  specs                   = each.value.specs
  traffic_type            = each.value.traffic_type
}