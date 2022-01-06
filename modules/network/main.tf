terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}

locals {

 jenkins-int-net = {
    name = "${var.cluster_name}-int-net"
    subnet_name = "${var.cluster_name}-net-sub01",
    cidr = var.cidr
  }
}

resource "openstack_networking_router_v2" "generic" {
  name                = "${var.cluster_name}-router"
  external_network_id = var.external_network_id
}

resource "openstack_networking_network_v2" "jenkins-int" {
  name                = local.jenkins-int-net["name"]
}

resource "openstack_networking_subnet_v2" "jenkins-int-subnet" {
  name                = local.jenkins-int-net["subnet_name"]
  network_id          = openstack_networking_network_v2.jenkins-int.id
  cidr                = local.jenkins-int-net["cidr"]
  dns_nameservers     = var.dns_ips
}

resource "openstack_networking_router_interface_v2" "jenkins-int" {
  router_id           = openstack_networking_router_v2.generic.id
  subnet_id           = openstack_networking_subnet_v2.jenkins-int-subnet.id
}

