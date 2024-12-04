variable "org_id" { # Mandatory
  type        = string
  description = "Target Juniper Mist organization ID for all automation operations"
  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.org_id)) # Must have UUID length and structure
    error_message = "Not a valid string for Mist org's ID"
  }
}

variable "name-prefix" {
  type        = string
  description = "A name prefix for resource naming. Please note that some names inside nested variables will have explicit names only."
}

variable "sites" { # Mandatory
  type = map(object({
    role           = string
    name           = string
    country_code   = string
    timezone       = string
    address        = string
    notes          = string
    latlng         = map(number)
    vars           = map(string)
    wan_devices    = list(string)
    switch_devices = list(string)
  }))
  description = "Definition of the sites to be deployed"
}

variable "root_password" {
  type        = string
  sensitive   = true
  description = "Root password for WAN Edges. Note that root password for switches has to be provided explicitly inside switch template variable."
}

variable "networks" {
  type = map(object({
    name                   = string
    subnet                 = string
    vlan_id                = any
    disallow_mist_services = bool
    tenants                = optional(any)
    vpn_access = object({
      OrgOverlay = object({
        routed                     = bool
        no_readvertise_to_overlay  = bool
        no_readvertise_to_lan_bgp  = bool
        no_readvertise_to_lan_ospf = bool
      })
    })
  }))
  description = "Org level WAN networks to be created"
}

variable "services" {
  type = map(object({
    name      = string
    type      = string
    addresses = list(string)
    apps      = list(string)
    specs = list(object({
      protocol   = string
      port_range = string
    }))
    traffic_type = string
  }))
  description = "Org level WAN services (applications) to be created"
}

variable "hub_profiles" {
  type = map(object({
    name        = string
    port_config = any
    ip_configs = map(object({
      type    = string
      ip      = string
      netmask = string
    }))
    path_preferences = any
    service_policies = any
    routing_policies = any
    bgp_config = any
  }))
  description = "Device profiles definitions to be applied to WAN Edge hub devices"
}

variable "edge_template" {
  type = map(object({
    name        = string
    type        = string
    port_config = any
    ip_configs = map(object({
      type    = string
      ip      = string
      netmask = string
    }))
    dhcpd_config = any
    path_preferences = any
    service_policies = any
  }))
  description = "Edge templates to be applied to sites with WAN Edge spoke devices"
}

variable "switch_template" {
  type = map(object({
    name = string
    switch_mgmt = any
    networks = any
    port_usages = any
    # disabled_system_defined_port_usages = any
    switch_matching = any
  }))
  description = "Org level network templates for switches"
}

variable "inventory" {
  type = map(object({
    name = string
    type = string
    hub_device_profile = string
    site_id = string
    unclaim_when_destroyed = bool
  }))
  description = "Definition of all devices (WAN gateways – hubs and spokes, and switches)"
}