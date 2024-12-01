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
