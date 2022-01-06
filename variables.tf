variable "cluster_name" {
  default = "jenkins"
}

variable "docker_enterprise_version" {
  type = string
  default = "3.3.1"
}

variable "docker_engine_version" {
  type = string
  default = "19.03.8"
}

variable "docker_image_repo" {
  type = string
  default = "docker.io/docker"
}

variable "http_proxy" {
  type = string
  default = ""
}

variable "https_proxy" {
  type = string
  default = ""
}

variable dns_ip_list {
  type 		= list(string)
  default = []
}

variable "jenkins_default_address_pool" {
}

variable "ssh_key_path" {
  default = "./ssh_keys/my_rsa"
}

variable "external_network_name" {}
variable "external_network_id" {}

variable "region" {
  default = "RegionOne"
}

variable "admin_password" {
  default = "jenkins-ftw!!!"
}

variable "jenkins_int_net" {
  type = string
  description = "This is the internal jenkins network CIDR"
}

variable "master_count" {
  default = 1
}

variable "worker_count" {
  default = 0
}

variable "master_module" {
  default = true
}

variable "worker_module" {
  default = false
}

variable "master_image_name" {
  default = "ubuntu18.04"
}

variable "worker_image_name" {
  default = "ubuntu18.04"
}

variable "master_flavor" {
  default = "m5.large"
}

variable "worker_flavor" {
  default = "m5.large"
}

variable "master_volume_size" {
  default = 100
}

variable "worker_volume_size" {
  default = 100
}
