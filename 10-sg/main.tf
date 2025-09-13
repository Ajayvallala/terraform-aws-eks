module "ingress_alb" {
  source         = "git::https://github.com/Ajayvallala/terraform-aws-sg.git?ref=main"
  project        = var.project
  env            = var.env
  sg_name        = "ingress-alb"
  sg_description = "for ingress alb"
  vpc_id         = local.vpc_id
}

# Bastion host security group to connect to the instances in private subnet
module "bastion" {
  source         = "git::https://github.com/Ajayvallala/terraform-aws-sg.git?ref=main"
  project        = var.project
  env            = var.env
  sg_name        = var.bastion_sg_name
  sg_description = var.bastion_sg_description
  vpc_id         = local.vpc_id
}

module "eks_control_plane" {
  source         = "git::https://github.com/Ajayvallala/terraform-aws-sg.git?ref=main"
  project        = var.project
  env            = var.env
  sg_name        = "eks_control_plane"
  sg_description = "for eks_control_plane"
  vpc_id         = local.vpc_id
}

module "eks_node" {
  source         = "git::https://github.com/Ajayvallala/terraform-aws-sg.git?ref=main"
  project        = var.project
  env            = var.env
  sg_name        = "eks_node"
  sg_description = "for eks_node"
  vpc_id         = local.vpc_id
}

module "vpn" {
    source = "git::https://github.com/Ajayvallala/terraform-aws-sg.git?ref=main"
    project = var.project
    env = var.env
    sg_name = var.vpn_sg_name
    sg_description = var.vpn_sg_description
    vpc_id = local.vpc_id
  
}

resource "aws_security_group_rule" "ingress_alb" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.ingress_alb.sg_id
}

#Allowing port 22 on bastion SG for ssh 
resource "aws_security_group_rule" "bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

#Opeaning ports 22 443 1194 943 on vpn sg
resource "aws_security_group_rule" "vpn" {
    count = length(var.vpn_ports)
    type = "ingress"
    from_port = var.vpn_ports[count.index]
    to_port = var.vpn_ports[count.index]
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "eks_control_plane_eks_node" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = module.eks_node.sg_id
  security_group_id = module.eks_control_plane.sg_id
}

resource "aws_security_group_rule" "eks_node_eks_control_plane" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = module.eks_control_plane.sg_id
  security_group_id = module.eks_node.sg_id
}

resource "aws_security_group_rule" "eks_control_plane_bastion" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.eks_control_plane.sg_id
}

resource "aws_security_group_rule" "eks_node_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.eks_node.sg_id
}


resource "aws_security_group_rule" "eks_node_vpc" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks = ["10.0.0.0/16"]
  security_group_id = module.eks_node.sg_id
}