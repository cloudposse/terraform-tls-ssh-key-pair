provider "aws" {
  region = var.region
}

module "ssh_key_pair" {
  source              = "../../"
  context             = module.this.context
  ssh_public_key_path = var.ssh_public_key_path
}
