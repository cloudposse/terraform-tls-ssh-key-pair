output "key_name" {
  value       = "${module.label.id}"
  description = "Name of SSH key"
}

output "public_key" {
  value       = "${var.ssh_key_algorithm == "RSA" ? join("", tls_private_key.default_rsa.*.public_key_openssh) : join("", tls_private_key.default_ecdsa.*.public_key_openssh)}"
  description = "Contents of the generated public key"
}
