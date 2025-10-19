locals {
  name            = "eks-assignment"
  domain          = "lab.ridwanahmed.com"
  region          = "eu-west-2"
  hosted_zone_arn = "arn:aws:route53:::hostedzone/Z0717143R661NCU61KOX"

  cluster_name = "cluster-lab"

  tags = {
    Environment = "sandbox"
    Project     = "EKS Assignment 2"
    Owner       = "Ridwan"
  }
}