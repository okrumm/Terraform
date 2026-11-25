terraform {
  required_version = ">= 1.9.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.123.1"
    }
  }
}

# Credentials are read from the environment, never hardcoded:
#   export PROXMOX_VE_ENDPOINT="https://pve8.herflor.com/"
#   export PROXMOX_VE_API_TOKEN="user@pam!tokenid=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
# TLS certificate validation stays enabled (insecure = false).
provider "proxmox" {
  insecure = false

  ssh {
    agent = true
  }
}
