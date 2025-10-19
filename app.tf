resource "kubernetes_service_account" "myapp" {
  metadata {
    name      = "myapp-sa"
    namespace = "default"
  }
}

data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = var.region
}

# Trust policy for EKS Pod Identity
data "aws_iam_policy_document" "pod_identity_trust" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "myapp_role" {
  name               = "myapp-pod-role"
  assume_role_policy = data.aws_iam_policy_document.pod_identity_trust.json
}

# Example permissions: read from S3
resource "aws_iam_role_policy_attachment" "s3_read" {
  role       = aws_iam_role.myapp_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
