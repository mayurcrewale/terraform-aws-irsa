# terraform-aws-irsa

Generic, reusable "IAM Roles for Service Accounts" (IRSA) building block:
creates an IAM role trusting an EKS cluster's OIDC provider, scoped to one
Kubernetes namespace/service-account pair, with managed and/or inline
policies attached.

## Usage

```hcl
module "irsa" {
  source = "git::git@github.com:mayurcrewale/terraform-aws-irsa.git?ref=v1.0.0"

  role_name             = "my-app"
  oidc_provider_arn     = module.eks_cluster.oidc_provider_arn
  oidc_provider_url     = module.eks_cluster.oidc_provider_url
  namespace             = "default"
  service_account_name  = "my-app"
  policy_arns           = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
}
```

Used internally by `terraform-aws-lb-controller`; also intended for
per-application service accounts (e.g. the hello-world app's own IAM
permissions in the next phase).
