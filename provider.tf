
provider "openstack" {
  domain_name = "${var.global_domain}"
  user_name   = "${var.global_username}"
  tenant_name = "${var.global_domain}"
  auth_url    = "${var.global_auth_url}"
  password    = "${var.api_password}"
  region      = "RegionOne"
}

terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}
resource "openstack_compute_keypair_v2" "arctic-keypair" {
  name       = "arctic-keypair"
  public_key = "${file(var.ssh_key_file)}"
}

