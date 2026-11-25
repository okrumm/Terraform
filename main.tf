resource "proxmox_download_file" "template" {
  node_name    = var.node_name
  datastore_id = "local"
  content_type = "vztmpl"
  url          = var.template_url
  file_name    = var.template_file_name
}

resource "proxmox_virtual_environment_container" "this" {
  node_name     = var.node_name
  vm_id         = var.container_id
  description   = var.description
  tags          = var.tags
  unprivileged  = var.unprivileged
  start_on_boot = var.start_on_boot
  started       = true

  # Debian 13 (systemd 257) needs nesting for getty/credentials setup in LXC.
  features {
    nesting = true
  }

  cpu {
    cores = var.cpu_cores
  }

  memory {
    dedicated = var.memory_mb
    swap      = var.swap_mb
  }

  disk {
    datastore_id = var.disk_datastore_id
    size         = var.disk_size_gb
  }

  operating_system {
    template_file_id = proxmox_download_file.template.id
    type             = var.os_type
  }

  network_interface {
    name    = "eth0"
    bridge  = var.bridge
    vlan_id = var.vlan_id
  }

  initialization {
    hostname = var.hostname

    ip_config {
      ipv4 {
        address = var.ipv4_address
        gateway = var.ipv4_gateway
      }

      ipv6 {
        address = var.ipv6_address
        gateway = var.ipv6_gateway
      }
    }

    dynamic "dns" {
      for_each = length(var.dns_servers) > 0 ? [1] : []
      content {
        servers = var.dns_servers
      }
    }

    user_account {
      keys     = var.ssh_public_keys
      password = var.root_password
    }
  }
}
