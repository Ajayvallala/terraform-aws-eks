resource "aws_ssm_parameter" "ingress_sg_id" {
  name  = "/${var.project}/${var.env}/ingress_alb_sg_id"
  type  = "String"
  value = module.ingress_alb.sg_id
}

resource "aws_ssm_parameter" "bastion_sg_id" {
  name  = "/${var.project}/${var.env}/bastion_sg_id"
  type  = "String"
  value = module.bastion.sg_id
}

resource "aws_ssm_parameter" "eks_control_plane_sg_id" {
  name  = "/${var.project}/${var.env}/eks_control_plane_sg_id"
  type  = "String"
  value = module.eks_control_plane.sg_id
}

resource "aws_ssm_parameter" "eks_node_sg_id" {
  name  = "/${var.project}/${var.env}/eks_node_sg_id"
  type  = "String"
  value = module.eks_node.sg_id
}


resource "aws_ssm_parameter" "vpn_sg_id" {
  name  = "/${var.project}/${var.env}/vpn_sg_id"
  type  = "String"
  value = module.vpn.sg_id
}



