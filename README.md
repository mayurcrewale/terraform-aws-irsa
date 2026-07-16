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

## CI / Releasing

[`.github/workflows/terraform-ci.yml`](.github/workflows/terraform-ci.yml)
runs `terraform fmt -check` + `terraform init` + `terraform validate` on
every push to `main` and every pull request.

To cut a new release tag: **Actions** tab → **Terraform CI** → **Run
workflow** → pick `patch`/`minor`/`major` from the `bump` dropdown (leave as
`none` for a validate-only run). It reads the latest `vX.Y.Z` tag, bumps it,
and pushes the new tag — using the workflow's built-in `GITHUB_TOKEN`, no
extra credentials to set up. Consumers pin to that tag via `?ref=vX.Y.Z` in
their `source` — see **Usage** above.
