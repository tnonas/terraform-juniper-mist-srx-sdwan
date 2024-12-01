<!-- BEGIN_TF_DOCS -->
# Hub and spoke SD-WAN with Juniper SRX managed with Juniper Mist
## Description

The module allows for rapid deployment of SD-WAN hub and spoke environment based on Juniper SRX managed by Juniper Mist. Branch EX switches can also be included in the deployment. [Example topology](https://github.com/tnonas/terraform-juniper-mist-srx-sdwan/blob/main/modules/srx_hub_and_spoke/README.md):

![The example topology. If it does not render, please refer to the link above.](docs/topology.png)

Note, that only the green colored devices and blue colored IP configuration is covered by the module's contents. The example provided uses this specific addressing. The black and white devices, i.e., PCs, servers and routers are for illustration purposes only and serve as a potential add-on outside the module's scope of automation.

The module creates all Juniper Mist constructs needed for the fully operational environment – sites, organization level WAN networks and services (applications), hub profiles, edge gateway and switch templates.

## Dependencies

- [Juniper Mist account](https://manage.mist.com/signin.html#!signup/register) and an associated Organization ID
- Claimed Juniper Mist compatible [Juniper SRX secure gateways](https://www.juniper.net/documentation/us/en/software/mist/content/mist-supported-hardware.html#xd_a679a623514d95d6-669993c-186f9d4ff5a--7e07__section_srx) or adopted [virtual SRX appliances](https://support.juniper.net/support/downloads/?p=vsrx-evaluation) with AppID license applied.
- Claimed [Juniper EX or QFX switches](https://www.juniper.net/documentation/us/en/software/mist/content/mist-supported-hardware.html#xd_a679a623514d95d6-669993c-186f9d4ff5a--7e07__section_krr_y15_swb) or adopted [vJunos-switch appliances](https://www.juniper.net/us/en/dm/vjunos-labs.html)

Based on the variable values the deployment can also be limited to just SRX devices.

## Example

The example deployment was based on vSRX and vJunos-switch virtual appliances. Example "terraform.tfvars" are provided in module's "example" directory. When copied to the root part of the module (root module) they can be used to configure the provided example topology.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_mist"></a> [mist](#requirement\_mist) | ~> 0.2.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_mist"></a> [mist](#provider\_mist) | ~> 0.2.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| mist_device_gateway.this | resource |
| mist_device_switch.this | resource |
| mist_org_deviceprofile_assign.this | resource |
| mist_org_deviceprofile_gateway.this | resource |
| mist_org_gatewaytemplate.this | resource |
| mist_org_inventory.this | resource |
| mist_org_network.this | resource |
| mist_org_networktemplate.this | resource |
| mist_org_service.this | resource |
| mist_org_sitegroup.this | resource |
| mist_site.this | resource |
| mist_site_setting.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_edge_template"></a> [edge\_template](#input\_edge\_template) | Edge templates to be applied to sites with WAN Edge spoke devices | <pre>map(object({<br/>    name        = string<br/>    type        = string<br/>    port_config = any<br/>    ip_configs = map(object({<br/>      type    = string<br/>      ip      = string<br/>      netmask = string<br/>    }))<br/>    dhcpd_config = any<br/>    path_preferences = any<br/>    service_policies = any<br/>  }))</pre> | n/a | yes |
| <a name="input_hub_profiles"></a> [hub\_profiles](#input\_hub\_profiles) | Device profiles definitions to be applied to WAN Edge hub devices | <pre>map(object({<br/>    name        = string<br/>    port_config = any<br/>    ip_configs = map(object({<br/>      type    = string<br/>      ip      = string<br/>      netmask = string<br/>    }))<br/>    path_preferences = any<br/>    service_policies = any<br/>    routing_policies = any<br/>    bgp_config = any<br/>  }))</pre> | n/a | yes |
| <a name="input_inventory"></a> [inventory](#input\_inventory) | Definition of all devices (WAN gateways – hubs and spokes, and switches) | <pre>map(object({<br/>    name = string<br/>    type = string<br/>    hub_device_profile = string<br/>    site_id = string<br/>    unclaim_when_destroyed = bool<br/>  }))</pre> | n/a | yes |
| <a name="input_name-prefix"></a> [name-prefix](#input\_name-prefix) | A name prefix for resource naming. Please note that some names inside nested variables will have explicit names only. | `string` | n/a | yes |
| <a name="input_networks"></a> [networks](#input\_networks) | Org level WAN networks to be created | <pre>map(object({<br/>    name                   = string<br/>    subnet                 = string<br/>    vlan_id                = any<br/>    disallow_mist_services = bool<br/>    vpn_access = object({<br/>      OrgOverlay = object({<br/>        routed                     = bool<br/>        no_readvertise_to_overlay  = bool<br/>        no_readvertise_to_lan_bgp  = bool<br/>        no_readvertise_to_lan_ospf = bool<br/>      })<br/>    })<br/>  }))</pre> | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | Target Juniper Mist organization ID for all automation operations | `string` | n/a | yes |
| <a name="input_root_password"></a> [root\_password](#input\_root\_password) | Root password for WAN Edges. Note that root password for switches has to be provided explicitly inside switch template variable. | `string` | n/a | yes |
| <a name="input_services"></a> [services](#input\_services) | Org level WAN services (applications) to be created | <pre>map(object({<br/>    name      = string<br/>    type      = string<br/>    addresses = list(string)<br/>    apps      = list(string)<br/>    specs = list(object({<br/>      protocol   = string<br/>      port_range = string<br/>    }))<br/>    traffic_type = string<br/>  }))</pre> | n/a | yes |
| <a name="input_sites"></a> [sites](#input\_sites) | Definition of the sites to be deployed | <pre>map(object({<br/>    role           = string<br/>    name           = string<br/>    country_code   = string<br/>    timezone       = string<br/>    address        = string<br/>    notes          = string<br/>    latlng         = map(number)<br/>    vars           = map(string)<br/>    wan_devices    = list(string)<br/>    switch_devices = list(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_switch_template"></a> [switch\_template](#input\_switch\_template) | Org level network templates for switches | <pre>map(object({<br/>    name = string<br/>    switch_mgmt = any<br/>    networks = any<br/>    port_usages = any<br/>    # disabled_system_defined_port_usages = any<br/>    switch_matching = any<br/>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->    