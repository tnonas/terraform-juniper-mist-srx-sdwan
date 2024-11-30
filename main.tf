module "srx_hub_and_spoke" {

  source = "./modules/srx_hub_and_spoke"

  org_id        = var.org_id
  name-prefix   = var.name-prefix
  root_password = var.root_password
  sites         = var.sites
  networks      = var.networks
  services      = var.services
  hub_profiles  = var.hub_profiles
  edge_template  = var.edge_template
  switch_template = var.switch_template
  inventory       = var.inventory
}