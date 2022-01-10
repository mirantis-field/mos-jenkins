resource "openstack_networking_secgroup_v2" "jenkins-master" {
  name = "${var.cluster_name}-master"
  description = "Open ingress ports to master nodes"
}

resource "openstack_networking_secgroup_rule_v2" "master_https" {
  direction = "ingress"
  ethertype = "IPv4"
  port_range_min = 443
  port_range_max = 443
  protocol = "tcp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.jenkins-master.id
}

resource "openstack_networking_secgroup_rule_v2" "master_http" {
  direction = "ingress"
  ethertype = "IPv4"
  port_range_min = 80
  port_range_max = 80
  protocol = "tcp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.jenkins-master.id
}
