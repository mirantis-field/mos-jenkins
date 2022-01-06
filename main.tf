terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}

provider "openstack" {
  use_octavia = "true"
  cloud       = "openstack"
  region      = "RegionOne"
}

resource "openstack_compute_keypair_v2" "key-pair" {
  name                   = "jenkins-key"
  public_key             = file("${var.ssh_key_path}.pub")
}

module "network" {
  source                 = "./modules/network"
  cluster_name           = var.cluster_name
  external_network_id    = var.external_network_id
  dns_ips                = var.dns_ip_list
}

/* jenkins masters */
module "masters" {
  source                = "./modules/masters"
  count                 = var.master_module ? 1 : 0
  master_count          = var.master_count
  cluster_name          = var.cluster_name
  ssh_key               = "jenkins-key"
  master_image_name     = var.master_image_name
  master_flavor         = var.master_flavor
  external_network_name = var.external_network_name
  internal_network_name = module.network.network_name
  internal_subnet_id    = module.network.subnet_id
  base_sec_group_id     = module.network.base_security_group_id
}

/* jenkins workers */
module "workers" {
  source                = "./modules/workers"
  count                 = var.worker_module ? 1 : 0
  worker_count          = var.worker_count
  cluster_name          = var.cluster_name
  ssh_key               = "jenkins-key"
  worker_image_name     = var.worker_image_name
  worker_flavor         = var.worker_flavor
  external_network_name = var.external_network_name
  internal_network_name = module.network.network_name
  internal_subnet_id    = module.network.subnet_id
  base_sec_group_id     = module.network.base_security_group_id
}


