locals {
  timezone       = "Europe/Bucharest"
  cloudflare_ntp = "time.cloudflare.com"

  upstream_dns = ["1.1.1.1", "8.8.8.8"]
  adlist       = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
  static_dns = {
    # TrueNAS
    "nas.trst.h.mirceanton.com"  = { address = "192.168.69.245", type = "A", comment = "TrueNAS Trusted" },
    "nas.utrst.h.mirceanton.com" = { address = "192.168.42.245", type = "A", comment = "TrueNAS Untrusted" },
    "nas.svc.h.mirceanton.com"   = { address = "10.0.10.245", type = "A", comment = "TrueNAS Services" },
    "nas.mgmt.h.mirceanton.com"  = { address = "10.0.0.245", type = "A", comment = "TrueNAS Servers" },

    "kvm.mgmt.h.mirceanton.com"     = { address = "10.0.0.254", type = "A", comment = "JetKVM Web UI" },
    "tesmart.mgmt.h.mirceanton.com" = { address = "10.0.0.253", type = "A", comment = "TeSmart KVM" },

    # HomeAssistant
    "hass.home.mirceanton.com"  = { address = "10.0.10.253", type = "A", comment = "HomeAssistant Odroid" },
    "hass.svc.h.mirceanton.com" = { address = "10.0.10.253", type = "A", comment = "HomeAssistant Odroid" },

    # Proxmox
    "pve.mgmt.h.mirceanton.com"   = { address = "10.0.0.20", type = "A", comment = "Proxmox Cluster Management Interface" },
    "pve01.mgmt.h.mirceanton.com" = { address = "10.0.0.21", type = "A", comment = "Proxmox Node 1 Management Interface" },
    "pve02.mgmt.h.mirceanton.com" = { address = "10.0.0.22", type = "A", comment = "Proxmox Node 2 Management Interface" },
    "pve03.mgmt.h.mirceanton.com" = { address = "10.0.0.23", type = "A", comment = "Proxmox Node 3 Management Interface" },
  }

  all_vlans = [for vlan in local.vlans : vlan.name]
  vlans = {
    "Trusted" = {
      name        = "Trusted"
      vlan_id     = 1969
      network     = "192.168.69.0"
      cidr_suffix = "24"
      gateway     = "192.168.69.1"
      dhcp_pool   = ["192.168.69.190-192.168.69.199"]
      dns_servers = ["192.168.69.1"]
      domain      = "trst.h.mirceanton.com"
      static_leases = {
        "192.168.69.69" = { name = "MirkPuter", mac = "74:56:3C:B7:9B:D8" }
        "192.168.69.68" = { name = "BomkPuter", mac = "24:4B:FE:52:D0:65" }
      }
    },
    "Untrusted" = {
      name        = "Untrusted"
      vlan_id     = 1942
      network     = "192.168.42.0"
      cidr_suffix = "24"
      gateway     = "192.168.42.1"
      dhcp_pool   = ["192.168.42.100-192.168.42.199"]
      dns_servers = ["192.168.42.1"]
      domain      = "utrst.h.mirceanton.com"
      static_leases = {
        "192.168.42.250" = { name = "Smart TV", mac = "38:26:56:E2:93:99" }
        "192.168.42.69"  = { name = "Mirk Phone", mac = "A2:AA:9F:C7:AA:3E" }
        "192.168.42.68"  = { name = "Bomk Phone", mac = "5C:70:17:F3:5F:F8" }
        "192.168.42.42"  = { name = "Bomk iPad", mac = "74:8F:3C:34:FA:E8" }
      }
    },
    "Guest" = {
      name          = "Guest"
      vlan_id       = 1742
      network       = "172.16.42.0"
      cidr_suffix   = "24"
      gateway       = "172.16.42.1"
      dhcp_pool     = ["172.16.42.10-172.16.42.250"]
      dns_servers   = ["1.1.1.1", "1.0.0.1", "8.8.8.8"]
      domain        = "gst.h.mirceanton.com"
      static_leases = {}
    },

    "Services" = {
      name        = "Services"
      vlan_id     = 1010
      network     = "10.0.10.0"
      cidr_suffix = "24"
      gateway     = "10.0.10.1"
      dhcp_pool   = ["10.0.10.195-10.0.10.199"]
      dns_servers = ["10.0.10.1"]
      domain      = "svc.h.mirceanton.com"
      static_leases = {
        "10.0.10.253" = { name = "HomeAssistant", mac = "00:1E:06:42:C7:73" }
      }
    },
    "Management" = {
      name        = "Management"
      vlan_id     = 1000
      network     = "10.0.0.0"
      cidr_suffix = "24"
      gateway     = "10.0.0.1"
      dhcp_pool   = ["10.0.0.195-10.0.0.199"]
      dns_servers = ["10.0.0.1"]
      domain      = "srv.h.mirceanton.com"
      static_leases = {
        "10.0.0.2"   = { name = "CRS317", mac = "D4:01:C3:02:5D:52" }
        "10.0.0.3"   = { name = "CRS326", mac = "D4:01:C3:F8:46:EE" }
        "10.0.0.4"   = { name = "hex", mac = "F4:1E:57:31:05:41" }
        "10.0.0.5"   = { name = "cAP-AX", mac = "D4:01:C3:01:26:EB" }
        "10.0.0.21"  = { name = "PVE01", mac = "74:56:3C:9E:BF:1A" }
        "10.0.0.22"  = { name = "PVE02", mac = "74:56:3C:99:5B:CE" }
        "10.0.0.23"  = { name = "PVE03", mac = "74:56:3C:B2:E5:A8" }
        "10.0.0.254" = { name = "JetKVM", mac = "44:B7:D0:E6:2F:29" }
      }
    },

  }
}
