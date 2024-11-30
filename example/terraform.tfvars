#org_id = "" # In this example TF_VAR_org_id environment variable is used instead

#root_password = "Juniper123" # # In this example TF_VAR_root_password environment variable is used instead

name-prefix = "tf_srx_"

sites = {

  FRANKFURT-DC = {
    role         = "hub"
    name         = "FRANKFURT-DC"
    country_code = "DE"
    timezone     = "Europe/Berlin"
    address      = "Gutleutstraße 310, 60327 Frankfurt am Main, Germany"
    notes        = "Primary DC"
    latlng = {
      lat = 50.099164
      lng = 8.643977
    }
    vars = {
      wan1_address      = "192.168.100.1"
      wan1_address_mask = "24"
      wan1_gw           = "192.168.100.254"
      wan2_address      = "172.16.100.1"
      wan2_address_mask = "24"
      wan2_gw           = "172.16.100.254"
    }
    wan_devices    = ["020001ba166e"]
    switch_devices = [""]
  }

  MEINZ-DC = {
    role         = "hub"
    name         = "MEINZ-DC"
    country_code = "DE"
    timezone     = "Europe/Berlin"
    address      = "Hauptstraße 90A, 55120 Mainz, Germany"
    notes        = "Secondary DC"
    latlng = {
      lat = 50.023595
      lng = 8.228937
    }
    vars = {
      wan1_address      = "192.168.200.1"
      wan1_address_mask = "24"
      wan1_gw           = "192.168.200.254"
      wan2_address      = "172.16.200.1"
      wan2_address_mask = "24"
      wan2_gw           = "172.16.200.254"
    }
    wan_devices    = ["02000137314a"]
    switch_devices = [""]
  }

  WROCLAW = {
    role         = "edge"
    name         = "WROCLAW"
    country_code = "PL"
    timezone     = "Europe/Warsaw"
    address      = "Powstańców Śląskich 95, 53-332 Wrocław, Poland"
    notes        = "Company's branch office in Wroclaw"
    latlng = {
      lat = 51.094701
      lng = 17.018939
    }
    vars = {
      site_network_id = "10"
      site_vlan_id    = "10"
    }
    wan_devices    = ["02000196d153"]
    switch_devices = ["0200048aea47"]
  }

  FRANKFURT = {
    role         = "edge"
    name         = "FRANKFURT"
    country_code = "DE"
    timezone     = "Europe/Berlin"
    address      = "Saalhof 1, 60311 Frankfurt am Main, Germany"
    notes        = "Company's branch office in Frankfurt"
    latlng = {
      lat = 50.109761
      lng = 8.682514
    }
    vars = {
      site_network_id = "20"
      site_vlan_id    = "11"
    }
    wan_devices    = ["0200012f00e5"]
    switch_devices = ["020004e8de33"]
  }

  PARIS = {
    role         = "edge"
    name         = "PARIS"
    country_code = "FR"
    timezone     = "Europe/Paris"
    address      = "Pl. Charles de Gaulle, 75008 Paris, France"
    notes        = "Company's branch office in Paris"
    latlng = {
      lat = 48.873911
      lng = 2.295081
    }
    vars = {
      site_network_id = "30"
      site_vlan_id    = "12"
    }
    wan_devices    = ["02000194708b"]
    switch_devices = ["0200045b08eb"]
  }

}

networks = {

  any-n = {
    name                   = "any-n"
    subnet                 = "0.0.0.0/0"
    vlan_id                = null
    disallow_mist_services = true
    vpn_access = {
      OrgOverlay = {
        routed                     = true
        no_readvertise_to_overlay  = false
        no_readvertise_to_lan_bgp  = true
        no_readvertise_to_lan_ospf = true
      }
    }
  }

  branch_lan-n = {
    name                   = "branch_lan-n"
    subnet                 = "10.0.{{site_network_id}}.0/24"
    vlan_id                = "{{site_vlan_id}}"
    disallow_mist_services = false
    vpn_access = {
      OrgOverlay = {
        routed                     = true
        no_readvertise_to_overlay  = false
        no_readvertise_to_lan_bgp  = false
        no_readvertise_to_lan_ospf = false
      }
    }
  }

  branch_lans-n = {
    name                   = "branch_lans-n"
    subnet                 = "10.0.0.0/18"
    vlan_id                = null
    disallow_mist_services = false
    vpn_access = {
      OrgOverlay = {
        routed                     = true
        no_readvertise_to_overlay  = false
        no_readvertise_to_lan_bgp  = false
        no_readvertise_to_lan_ospf = false
      }
    }
  }

  fra_dc_lan-n = {
    name                   = "fra_dc_lan-n"
    subnet                 = "192.168.101.0/24"
    vlan_id                = null
    disallow_mist_services = false
    vpn_access = {
      OrgOverlay = {
        routed                     = true
        no_readvertise_to_overlay  = false
        no_readvertise_to_lan_bgp  = false
        no_readvertise_to_lan_ospf = false
      }
    }
  }

  mei_dc_lan-n = {
    name                   = "mei_dc_lan-n"
    subnet                 = "192.168.201.0/24"
    vlan_id                = null
    disallow_mist_services = false
    vpn_access = {
      OrgOverlay = {
        routed                     = true
        no_readvertise_to_overlay  = false
        no_readvertise_to_lan_bgp  = false
        no_readvertise_to_lan_ospf = false
      }
    }
  }

  fra_dc_servers-n = {
    name                   = "fra_dc_servers-n"
    subnet                 = "10.0.100.0/24"
    vlan_id                = null
    disallow_mist_services = false
    vpn_access = {
      OrgOverlay = {
        routed                     = true
        no_readvertise_to_overlay  = false
        no_readvertise_to_lan_bgp  = false
        no_readvertise_to_lan_ospf = false
      }
    }
  }

  mei_dc_servers-n = {
    name                   = "mei_dc_servers-n"
    subnet                 = "10.0.200.0/24"
    vlan_id                = null
    disallow_mist_services = false
    vpn_access = {
      OrgOverlay = {
        routed                     = true
        no_readvertise_to_overlay  = false
        no_readvertise_to_lan_bgp  = false
        no_readvertise_to_lan_ospf = false
      }
    }
  }

}

services = {

  any = {
    name      = "any"
    type      = "custom"
    addresses = ["0.0.0.0/0"]
    apps      = null
    specs = [{
      protocol   = "any"
      port_range = null
    }]
    traffic_type = "default"
  }

  branch_lans-a = {
    name      = "branch_lans-a"
    type      = "custom"
    addresses = ["10.0.0.0/18"]
    apps      = null
    specs = [{
      protocol   = "any"
      port_range = null
    }]
    traffic_type = "default"
  }

  branch_local_lan-a = {
    name      = "branch_local_lan-a"
    type      = "custom"
    addresses = ["10.0.{{site_network_id}}.0/24"]
    apps      = null
    specs = [{
      protocol   = "any"
      port_range = null
    }]
    traffic_type = "default"
  }

  fra_dc_servers-a = {
    name      = "fra_dc_servers-a"
    type      = "custom"
    addresses = ["10.0.100.0/24"]
    apps      = null
    specs = [{
      protocol   = "any"
      port_range = null
    }]
    traffic_type = "default"
  }

  mei_dc_servers-a = {
    name      = "mei_dc_servers-a"
    type      = "custom"
    addresses = ["10.0.200.0/24"]
    apps      = null
    specs = [{
      protocol   = "any"
      port_range = null
    }]
    traffic_type = "default"
  }

  microsoft_apps-a = {
    name         = "microsoft_apps-a"
    type         = "apps"
    addresses    = null
    apps         = ["ms-teams"]
    specs        = null
    traffic_type = "default"
  }

}

hub_profiles = {

  FRA_DC = {
    name = "FRA_DC"

    port_config = {
      "ge-0/0/0" = {
        usage = "wan"
        name  = "wan-1"
        ip_config = {
          type    = "static"
          ip      = "192.168.100.1"
          netmask = "/24"
          gateway = "192.168.100.254"
        }
        vpn_paths = {
          "tf_srx_FRA_DC-wan-1.OrgOverlay" = {
            key         = 0
            role        = "hub"
            bfd_profile = "broadband"
          }
        }
      }
      "ge-0/0/1" = {
        usage = "wan"
        name  = "wan-2"
        ip_config = {
          type    = "static"
          ip      = "172.16.100.1"
          netmask = "/24"
          gateway = "172.16.100.254"
        }
        vpn_paths = {
          "tf_srx_FRA_DC-wan-2.OrgOverlay" = {
            key         = 1
            role        = "hub"
            bfd_profile = "broadband"
          }
        }
      }
      "ge-0/0/2" = {
        usage    = "lan"
        networks = ["tf_srx_fra_dc_lan-n"]
      }
    }

    ip_configs = {
      "tf_srx_fra_dc_lan-n" = {
        type    = "static"
        ip      = "192.168.101.1"
        netmask = "/24"
      }
    }

    path_preferences = {
      hub_spokes_overlay = {
        paths = [
          {
            type = "vpn"
            name = "tf_srx_FRA_DC-wan-1.OrgOverlay"
          },
          {
            type = "vpn"
            name = "tf_srx_FRA_DC-wan-2.OrgOverlay"
          }
        ]
        strategy = "ordered"
      }
      local_Internet = {
        paths = [
          {
            type = "wan"
            name = "wan-2"
          }
        ]
        strategy = "ordered"
      }
      local_LAN = {
        paths = [
          {
            type = "local"
            networks = ["tf_srx_fra_dc_lan-n"]
          }
        ]
        strategy = "ordered"
      }
    }

    service_policies = [
      {
        name = "both_dcs_servers_to_branch_lans"
        tenants = ["tf_srx_fra_dc_servers-n", "tf_srx_mei_dc_servers-n"]
        services = ["tf_srx_branch_lans-a"]
        action = "allow"
        path_preference = "hub_spokes_overlay"
      },
      {
        name = "branch_lans_to_both_dcs_servers"
        tenants = ["tf_srx_branch_lans-n"]
        services = ["tf_srx_fra_dc_servers-a", "tf_srx_mei_dc_servers-a"]
        action = "allow"
        path_preference = "local_LAN"
      },
      {
        name = "branch_lans_to_branch_lans"
        tenants = ["tf_srx_branch_lans-n"]
        services = ["tf_srx_branch_lans-a"]
        action = "allow"
        path_preference = "hub_spokes_overlay"
      },
      {
        name = "centralized_Internet"
        tenants = ["tf_srx_branch_lans-n", "tf_srx_fra_dc_lan-n"]
        services = ["tf_srx_any"]
        action = "allow"
        path_preference = "local_Internet"
      }
    ]

    routing_policies = {
        any_prefix = {
            terms = [
                {
                    matching = {
                        prefix = ["0.0.0.0/0-32"]
                    },
                    actions = {
                        accept = true
                    }
                }
            ]
        }
    }

    "bgp_config": {
        "FRA-DC-ROUTER": {
            "networks": [
                "tf_srx_fra_dc_lan-n"
            ],
            "via": "lan",
            "type": "external",
            "no_readvertise_to_overlay": false,
            "local_as": 64551,
            "hold_time": 90,
            "graceful_restart_time": 120,
            "export_policy": "any_prefix",
            "import_policy": "any_prefix",
            "neighbors": {
                "192.168.101.2": {
                    "disabled": false,
                    "neighbor_as": 64552
                }
            },
            "disable_bfd": false
        }
    }

  }

  MEI_DC = {
    name = "MEI_DC"

    port_config = {
      "ge-0/0/0" = {
        usage = "wan"
        name  = "wan-1"
        ip_config = {
          type    = "static"
          ip      = "192.168.200.1"
          netmask = "/24"
          gateway = "192.168.200.254"
        }
        vpn_paths = {
          "tf_srx_MEI_DC-wan-1.OrgOverlay" = {
            key         = 1
            role        = "hub"
            bfd_profile = "broadband"
          }
        }
      }
      "ge-0/0/1" = {
        usage = "wan"
        name  = "wan-2"
        ip_config = {
          type    = "static"
          ip      = "172.16.200.1"
          netmask = "/24"
          gateway = "172.16.200.254"
        }
        vpn_paths = {
          "tf_srx_MEI_DC-wan-2.OrgOverlay" = {
            key         = 1
            role        = "hub"
            bfd_profile = "broadband"
          }
        }
      }
      "ge-0/0/2" = {
        usage    = "lan"
        networks = ["tf_srx_mei_dc_lan-n"]
      }
    }

    ip_configs = {
      "tf_srx_mei_dc_lan-n" = {
        type    = "static"
        ip      = "192.168.201.1"
        netmask = "/24"
      }
    }

    path_preferences = {
      hub_spokes_overlay = {
        paths = [
          {
            type = "vpn"
            name = "tf_srx_MEI_DC-wan-1.OrgOverlay"
          },
          {
            type = "vpn"
            name = "tf_srx_MEI_DC-wan-2.OrgOverlay"
          }
        ]
        strategy = "ordered"
      }
      local_Internet = {
        paths = [
          {
            type = "wan"
            name = "wan-2"
          }
        ]
        strategy = "ordered"
      }
      local_LAN = {
        paths = [
          {
            type = "local"
            networks = ["tf_srx_mei_dc_lan-n"]
          }
        ]
        strategy = "ordered"
      }
    }

    service_policies = [
      {
        name = "both_dcs_servers_to_branch_lans"
        tenants = ["tf_srx_fra_dc_servers-n", "tf_srx_mei_dc_servers-n"]
        services = ["tf_srx_branch_lans-a"]
        action = "allow"
        path_preference = "hub_spokes_overlay"
      },
      {
        name = "branch_lans_to_both_dcs_servers"
        tenants = ["tf_srx_branch_lans-n"]
        services = ["tf_srx_fra_dc_servers-a", "tf_srx_mei_dc_servers-a"]
        action = "allow"
        path_preference = "local_LAN"
      },
      {
        name = "branch_lans_to_branch_lans"
        tenants = ["tf_srx_branch_lans-n"]
        services = ["tf_srx_branch_lans-a"]
        action = "allow"
        path_preference = "hub_spokes_overlay"
      },
      {
        name = "centralized_Internet"
        tenants = ["tf_srx_branch_lans-n", "tf_srx_mei_dc_lan-n"]
        services = ["tf_srx_any"]
        action = "allow"
        path_preference = "local_Internet"
      }
    ]

    routing_policies = {
        any_prefix = {
            terms = [
                {
                    matching = {
                        prefix = ["0.0.0.0/0-32"]
                    },
                    actions = {
                        accept = true
                    }
                }
            ]
        }
    }

    "bgp_config": {
        "MEI-DC-ROUTER": {
            "networks": [
                "tf_srx_mei_dc_lan-n"
            ],
            "via": "lan",
            "type": "external",
            "no_readvertise_to_overlay": false,
            "local_as": 64561,
            "hold_time": 90,
            "graceful_restart_time": 120,
            "export_policy": "any_prefix",
            "import_policy": "any_prefix",
            "neighbors": {
                "192.168.201.2": {
                    "disabled": false,
                    "neighbor_as": 64562
                }
            },
            "disable_bfd": false
        }
    }

  }

}

edge_template = {

  srx_branches = {
    name = "branches"

    type = "spoke"

    port_config = {
      "ge-0/0/0" = {
        usage = "wan"
        name  = "wan-1"
        description = "Towards ISP-1"
        ip_config = {
          type    = "dhcp"
        }
        vpn_paths = {
          "tf_srx_FRA_DC-wan-1.OrgOverlay" = {
            key         = 0
            role        = "spoke"
            bfd_profile = "broadband"
          }
          "tf_srx_MEI_DC-wan-1.OrgOverlay" = {
            key         = 0
            role        = "spoke"
            bfd_profile = "broadband"
          }
        }
      }
      "ge-0/0/1" = {
        usage = "wan"
        name  = "wan-2"
        description = "Towards ISP-2"
        ip_config = {
          type    = "dhcp"
        }
        vpn_paths = {
          "tf_srx_FRA_DC-wan-2.OrgOverlay" = {
            key         = 0
            role        = "spoke"
            bfd_profile = "broadband"
          }
          "tf_srx_MEI_DC-wan-2.OrgOverlay" = {
            key         = 0
            role        = "spoke"
            bfd_profile = "broadband"
          }
        }
      }
      "ge-0/0/2" = {
        usage    = "lan"
        networks = ["tf_srx_branch_lan-n"]
      }
    }

    ip_configs = {
      "tf_srx_branch_lan-n" = {
        type    = "static"
        ip      = "10.0.{{site_network_id}}.254"
        netmask = "/24"
      }
    }

    dhcpd_config = {
      config = {
        tf_srx_branch_lan-n = {
          dns_servers = ["9.9.9.9", "1.1.1.1"]
          gateway = "10.0.{{site_network_id}}.254"
          ip_end = "10.0.{{site_network_id}}.200"
          ip_start = "10.0.{{site_network_id}}.100"
          type = "local"
      }
      }
    }

    path_preferences = {
      spoke_to_fra_hub_overlay = {
        paths = [
          {
            type = "vpn"
            name = "tf_srx_FRA_DC-wan-1.OrgOverlay"
          },
          {
            type = "vpn"
            name = "tf_srx_FRA_DC-wan-2.OrgOverlay"
          },
          {
            type = "vpn"
            name = "tf_srx_MEI_DC-wan-1.OrgOverlay"
          },
          {
            type = "vpn"
            name = "tf_srx_MEI_DC-wan-2.OrgOverlay"
          }
        ]
        strategy = "ordered"
      }
      spoke_to_mei_hub_overlay = {
        paths = [
          {
            type = "vpn"
            name = "tf_srx_MEI_DC-wan-1.OrgOverlay"
          },
          {
            type = "vpn"
            name = "tf_srx_MEI_DC-wan-2.OrgOverlay"
          },
          {
            type = "vpn"
            name = "tf_srx_FRA_DC-wan-1.OrgOverlay"
          },
          {
            type = "vpn"
            name = "tf_srx_FRA_DC-wan-2.OrgOverlay"
          }
        ]
        strategy = "ordered"
      }
      spoke_to_Internet_overlay = {
        paths = [
          {
            type = "vpn"
            name = "tf_srx_FRA_DC-wan-2.OrgOverlay"
          },
          {
            type = "vpn"
            name = "tf_srx_MEI_DC-wan-2.OrgOverlay"
          }
        ]
        strategy = "ecmp"
      }
      spoke_to_spoke_overlay = {
        paths = [
          {
            type = "vpn"
            name = "tf_srx_FRA_DC-wan-2.OrgOverlay"
          },
          {
            type = "vpn"
            name = "tf_srx_MEI_DC-wan-2.OrgOverlay"
          },
          {
            type = "vpn"
            name = "tf_srx_FRA_DC-wan-1.OrgOverlay"
          },
          {
            type = "vpn"
            name = "tf_srx_MEI_DC-wan-1.OrgOverlay"
          }
        ]
        strategy = "ecmp"
      }
      local_Internet = {
        paths = [
          {
            type = "wan"
            name = "wan-2"
          }
        ]
        strategy = "ordered"
      }
      local_LAN = {
        paths = [
          {
            type = "local"
            networks = ["tf_srx_branch_lan-n"]
          }
        ]
        strategy = "ordered"
      }
    }

    service_policies = [
      {
        name = "branch_lans_to_fra_dc_servers"
        tenants = ["tf_srx_branch_lan-n"]
        services = ["tf_srx_fra_dc_servers-a"]
        action = "allow"
        path_preference = "spoke_to_fra_hub_overlay"
      },
      {
        name = "branch_lans_to_mei_dc_servers"
        tenants = ["tf_srx_branch_lan-n"]
        services = ["tf_srx_mei_dc_servers-a"]
        action = "allow"
        path_preference = "spoke_to_mei_hub_overlay"
      },
      {
        name = "both_dcs_servers_to_branch_lans"
        tenants = ["tf_srx_mei_dc_servers-n", "tf_srx_fra_dc_servers-n"]
        services = ["tf_srx_branch_local_lan-a"]
        action = "allow"
        path_preference = "local_LAN"
      },
      {
        name = "branch_local_lan_to_branch_lans"
        tenants = ["tf_srx_branch_lan-n"]
        services = ["tf_srx_branch_lans-a"]
        action = "allow"
        path_preference = "spoke_to_spoke_overlay"
      },
      {
        name = "branch_lans_to_branch_local_lan"
        tenants = ["tf_srx_branch_lans-n"]
        services = ["tf_srx_branch_local_lan-a"]
        action = "allow"
        path_preference = "local_LAN"
      },
      {
        name = "centralized_Internet"
        tenants = ["tf_srx_branch_lan-n"]
        services = ["tf_srx_any"]
        action = "allow"
        path_preference = "spoke_to_Internet_overlay"
      },
      # {
      #   name = "local_Internet"
      #   tenants = ["tf_srx_branch_lan-n"]
      #   services = ["tf_srx_microsoft_apps-a"]
      #   action = "allow"
      #   path_preference = "local_Internet"
      # }

    ]

  }

}

switch_template = {

  branch_switch = {
    name = "branch_switch"
    switch_mgmt = {
      root_password = "Juniper123"
    }
    networks = {
      pc_network = {
        vlan_id = "{{site_vlan_id}}"
        subnet  = "10.0.{{site_network_id}}.0/24"
      }
    }
    port_usages = {
      pc_network_access = {
        mode = "access"
        port_network = "pc_network"
        poe_disabled = true
        stp_edge: true
        description = "PC access"
      }
      pc_network_trunk = {
        mode = "trunk"
        port_network = "default"
        all_networks = true
        networks = []
        poe_disabled = true
        stp_edge: true
        description = "Trunk to SRX"
      }
    }
    # disabled_system_defined_port_usages = ["ap", "iot", "uplink"]
    switch_matching = {
      enable = true
      rules = [
          {
              name = "branch_switch"
              match_model = "VJUNOS"
              port_config = {
                  "ge-0/0/1" = {
                      usage = "pc_network_access"
                  },
                  "ge-0/0/0" = {
                      usage = "pc_network_trunk"
                  }
              }
          }
      ]
    }
  }
}

inventory = {
  "4c9614663a00" = {
      name                    = "tf_WRO-SRX-1"
      type                    = "gateway"
      hub_device_profile      = ""
      site_id                 = "WROCLAW"
      unclaim_when_destroyed  = false
  },
  "4c9614899800" = {
      name                    = "tf_FRA-SRX-1"
      type                    = "gateway"
      hub_device_profile      = ""
      site_id                 = "FRANKFURT"
      unclaim_when_destroyed  = false
  },
  "4c9614464f00" = {
      name                    = "tf_PAR-SRX-1"
      type                    = "gateway"
      hub_device_profile      = ""
      site_id                 = "PARIS"
      unclaim_when_destroyed  = false
  },
  "4c9614122d00" = {
      name                    = "tf_FRA-DC-SRX-1"
      type                    = "gateway"
      hub_device_profile      = "FRA_DC"
      site_id                 = "FRANKFURT-DC"
      unclaim_when_destroyed  = false
  },
  "4c9614377200" = {
      name                    = "tf_MEI-DC-SRX-1"
      type                    = "gateway"
      hub_device_profile      = "MEI_DC"
      site_id                 = "MEINZ-DC"
      unclaim_when_destroyed  = false
  },
  "0200048aea47" = {
      name                    = "tf_WRO-SWITCH"
      type                    = "switch"
      hub_device_profile      = ""
      site_id                 = "WROCLAW"
      unclaim_when_destroyed  = false
  },
  "020004e8de33" = {
      name                    = "tf_FRA-SWITCH"
      type                    = "switch"
      hub_device_profile      = ""
      site_id                 = "FRANKFURT"
      unclaim_when_destroyed  = false
  },
  "0200045b08eb" = {
      name                    = "tf_PAR-SWITCH"
      type                    = "switch"
      hub_device_profile      = ""
      site_id                 = "PARIS"
      unclaim_when_destroyed  = false
  },
}