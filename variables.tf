variable "node_name" {
  description = "Proxmox node that will host the container."
  type        = string
}

variable "container_id" {
  description = "Numeric VM/CT ID. Leave null to let Proxmox pick the next free ID."
  type        = number
  default     = null
}

variable "hostname" {
  description = "Container hostname."
  type        = string
  default     = "ct-terraform"
}

variable "description" {
  description = "Container description."
  type        = string
  default     = "Managed by Terraform"
}

variable "template_url" {
  description = "HTTPS URL of the LXC template that Terraform downloads to the node's local storage."
  type        = string
  default     = "https://download.proxmox.com/images/system/debian-13-standard_13.6-1_amd64.tar.zst"
}

variable "template_file_name" {
  description = "File name the template is stored under in local:vztmpl."
  type        = string
  default     = "debian-13-standard_13.6-1_amd64.tar.zst"
}

variable "os_type" {
  description = "Guest OS type matching the template (debian, ubuntu, alpine, ...)."
  type        = string
  default     = "debian"
}

variable "cpu_cores" {
  description = "Number of CPU cores."
  type        = number
  default     = 1
}

variable "memory_mb" {
  description = "Dedicated memory in MB."
  type        = number
  default     = 512
}

variable "swap_mb" {
  description = "Swap in MB."
  type        = number
  default     = 512
}

variable "disk_datastore_id" {
  description = "Datastore for the root filesystem."
  type        = string
  default     = "local-lvm"
}

variable "disk_size_gb" {
  description = "Root filesystem size in GB."
  type        = number
  default     = 8
}

variable "bridge" {
  description = "Network bridge."
  type        = string
  default     = "vmbr0"
}

variable "vlan_id" {
  description = "VLAN tag for the network interface. Null for untagged."
  type        = number
  default     = null
}

variable "ipv4_address" {
  description = "IPv4 address in CIDR notation (e.g. 192.168.1.50/24) or \"dhcp\"."
  type        = string
  default     = "dhcp"
}

variable "ipv4_gateway" {
  description = "IPv4 gateway. Required when ipv4_address is static; must be null for dhcp."
  type        = string
  default     = null
}

variable "ipv6_address" {
  description = "IPv6 address in CIDR notation, \"dhcp\", or \"auto\" for SLAAC."
  type        = string
  default     = "auto"
}

variable "ipv6_gateway" {
  description = "IPv6 gateway. Must be null for dhcp/auto."
  type        = string
  default     = null
}

variable "dns_servers" {
  description = "DNS servers for the container."
  type        = list(string)
  default     = []
}

variable "ssh_public_keys" {
  description = "SSH public keys authorized for the root user."
  type        = list(string)
}

variable "root_password" {
  description = "Root password for console login. Supply via TF_VAR_root_password; never put it in a file. Null keeps SSH-key-only access."
  type        = string
  default     = null
  sensitive   = true
}

variable "unprivileged" {
  description = "Run the container unprivileged (recommended)."
  type        = bool
  default     = true
}

variable "start_on_boot" {
  description = "Start the container when the node boots."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to the container."
  type        = list(string)
  default     = ["terraform"]
}
