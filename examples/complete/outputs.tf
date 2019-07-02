output "key_name" {
  value       = module.ssh_key_pair.key_name
  description = "Name of SSH key"
}

output "public_key" {
  value       = module.ssh_key_pair.public_key
  description = "Content of the generated public key"
}
