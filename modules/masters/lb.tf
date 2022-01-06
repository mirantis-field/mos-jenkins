resource "openstack_lb_loadbalancer_v2" "lb_jenkins" {
  name = "${var.cluster_name}-jenkins"
  vip_subnet_id = var.internal_subnet_id
}

resource "openstack_lb_listener_v2" "lb_list_jenkins" {
  name = "${var.cluster_name}-jenkins-443"
  protocol = "TCP"
  protocol_port = 443
  loadbalancer_id = openstack_lb_loadbalancer_v2.lb_jenkins.id
}

resource "openstack_lb_pool_v2" "lb_pool_jenkins" {
  name = "${var.cluster_name}-jenkins-443"
  protocol = "TCP"
  lb_method = "ROUND_ROBIN"
  listener_id = openstack_lb_listener_v2.lb_list_jenkins.id
}

resource "openstack_lb_member_v2" "lb_member_jenkins" {
  count = var.master_count
  pool_id = openstack_lb_pool_v2.lb_pool_jenkins.id
  protocol_port = 443
  address = element(openstack_compute_instance_v2.jenkins-master.*.network.0.fixed_ip_v4, count.index)
  subnet_id = var.internal_subnet_id
}

resource "openstack_networking_floatingip_v2" "master_lb_vip" {
  pool = var.external_network_name
}

resource "openstack_networking_floatingip_associate_v2" "master_vip" {
  floating_ip = openstack_networking_floatingip_v2.master_lb_vip.address
  port_id = openstack_lb_loadbalancer_v2.lb_jenkins.vip_port_id
}

# TODO: Change to http check (GA)
resource "openstack_lb_monitor_v2" "jenkins" {
  pool_id     = openstack_lb_pool_v2.lb_pool_jenkins.id
  type        = "PING"
  delay       = 20
  timeout     = 10
  max_retries = 3
}
