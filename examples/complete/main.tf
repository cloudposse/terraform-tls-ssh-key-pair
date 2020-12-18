provider "aws" {
  region = var.region
}

module "ssh_key_pair" {
  source              = "../../"
  ssh_public_key_path = var.ssh_public_key_path

  context = module.this.context
}
