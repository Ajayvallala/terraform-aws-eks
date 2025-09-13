variable "project" {
  default = "roboshop"
}

variable "env" {
  default = "dev"
}

variable "ingress_alb_sg_name" {
  default = "ingress_alb"
}

variable "ingress_alb_sg_description" {
  default = "created sg for ingress alb"
}

variable "bastion_sg_name" {
  default = "bastion"
}

variable "bastion_sg_description" {
  default = "created sg for bastion instance"
}

variable "backend_alb_sg_name" {
  default = "backend-alb"
}

variable "backend_alb_sg_description" {
  default = "created sg for backend ALB"
}

variable "vpn_sg_name" {
  default = "vpn"
}

variable "vpn_sg_description" {
  default = "created sg for vpn server"
}

variable "vpn_ports" {
  default = [22, 443, 1194, 943]
}


