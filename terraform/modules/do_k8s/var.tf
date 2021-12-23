variable "project" {}

variable "tags" {}

variable "instance_type" {
  default = "s-1vcpu-2gb"
}

variable "node_numb" {
  default = 1
}

variable "do_region" {
  default = "nyc1"
}
