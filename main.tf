module "label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.3.3"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  name       = "${var.name}"
  attributes = "${var.attributes}"
  delimiter  = "${var.delimiter}"
  tags       = "${var.tags}"
}

locals {
  public_key_filename  = "${var.ssh_public_key_path}/${module.label.id}${var.public_key_extension}"
  private_key_filename = "${var.ssh_public_key_path}/${module.label.id}${var.private_key_extension}"
}

resource "tls_private_key" "default_rsa" {
  count = "${var.ssh_key_algorithm == "RSA" ? 1 : 0}"
  algorithm = "${var.ssh_key_algorithm}"
  rsa_bits = "${var.ssh_key_bits}"
}

resource "tls_private_key" "default_ecdsa" {
  algorithm = "${var.ssh_key_algorithm}"
  count = "${var.ssh_key_algorithm == "ECDSA" ? 1 : 0}"
  ecdsa_curve = "${var.ssh_key_curve}"
}

resource "local_file" "public_key_openssh" {
  depends_on = ["tls_private_key.default_rsa", "tls_private_key.default_ecdsa"]
  content    = "${var.ssh_key_algorithm == "RSA" ? tls_private_key.default_rsa.public_key_openssh : tls_private_key.default_ecdsa.public_key_openssh}"
  filename   = "${local.public_key_filename}"
}

resource "local_file" "private_key_pem" {
  depends_on = ["tls_private_key.default_rsa", "tls_private_key.default_ecdsa"]
  content    = "${var.ssh_key_algorithm == "RSA" ? tls_private_key.default_rsa.private_key_pem : tls_private_key.default_ecdsa.private_key_pem}"
  filename   = "${local.private_key_filename}"
}

resource "null_resource" "chmod" {
  count      = "${var.chmod_command != "" ? 1 : 0}"
  depends_on = ["local_file.private_key_pem"]

  provisioner "local-exec" {
    command = "${format(var.chmod_command, local.private_key_filename)}"
  }
}
