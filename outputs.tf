output "container_id" {
  description = "ID of the created container."
  value       = proxmox_virtual_environment_container.this.vm_id
}

output "hostname" {
  description = "Container hostname."
  value       = var.hostname
}
