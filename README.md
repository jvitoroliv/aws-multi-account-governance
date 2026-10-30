# Multi-Account AWS Governance — Cloud Infrastructure

**Role:** Cloud Engineer (Contract)
**Stack:** Terraform, AWS (VPC, NAT, EIP, RAM, Route Tables), Azure DevOps, React/TSX

---

## What's Here

Multi-account AWS networking infrastructure built for an enterprise client through a consulting engagement. Three isolated VPCs (staging, shared, production), each with its own CIDR block, NAT configuration, and routing. The whole thing runs on a custom Terraform VPC module hosted in Azure DevOps Git.

This repo also has interactive AWS architecture diagrams written in React/TSX. Four files that render the full cloud topology as a visual. Not a static PNG, an interactive component you can click around.

## Architecture

Three VPCs, three purposes:

| VPC | CIDR | Purpose |
|-----|------|---------|
| Staging | `10.123.0.0/16` | Pre-production validation |
| Shared | `10.125.0.0/16` | Cross-environment services |
| Production | `10.124.0.0/16` | Live workloads, multi-AZ |

Production runs across two availability zones (`us-east-1a`, `us-east-1b`) with separate public and private subnets per AZ. Staging and shared each use a single AZ. Enough for the workload profile, and it keeps NAT costs down.

Every VPC pulls from the same Terraform module sourced from Azure DevOps:
```
git@ssh.dev.azure.com:v3/<org>/tf-module-vpc/tf-module-vpc
```

One module, three instantiations. Consistent config across environments.

## Key Design Decisions

**NAT Gateway Strategy.** Single NAT per VPC with EIP management. I didn't go with one-per-AZ for staging because the traffic doesn't justify it. Production uses the same pattern because the client's budget mattered more than theoretical HA at the NAT layer. If an AZ goes down, we've got bigger problems than NAT routing.

**EKS-Ready Subnet Tagging.** You'll notice commented-out Kubernetes tags in the VPC configs:
```hcl
# "kubernetes.io/cluster/eks-${var.environment}" = "shared"
# "kubernetes.io/role/internal-elb" = 1
```
I left these in on purpose. The client was evaluating EKS, and having the subnet tags pre-planned meant we wouldn't need to touch networking when that decision came through.

**Resource Access Managers.** Cross-account resource sharing configured through AWS RAM so the shared VPC could serve resources to both staging and production accounts without VPC peering complexity.

**Flow Logs.** Templated but disabled. The S3 destination and configuration are ready to go. Flipping `enable_flow_log = true` and uncommenting the bucket ARN is all it takes. I didn't enable them by default because the client wasn't ready for the storage costs.

## Pipeline Consolidation

When I came in, the client had 25 separate Azure DevOps pipelines. Twenty-five. Each environment, each component, each stage had its own YAML file with its own variables and its own drift from every other pipeline.

I consolidated everything into a single dynamic release pipeline. One definition, parameterized by environment and component. That pipeline isn't in this repo (it lived in the DevOps project), but the infrastructure here is what it deployed to.

## FinOps Impact

The client's AWS bill went from $11-12K/month down to under $3K/month. Not a typo. The previous setup had oversized instances, NAT gateways in every AZ for every VPC, unused EIPs accumulating charges, and resources running 24/7 in staging that nobody touched on weekends.

I right-sized everything, consolidated NAT gateways, scheduled non-production environments, and cleaned up orphaned resources. The Terraform here reflects the final lean state.

## Multi-Account Governance

Beyond what's in this repo, the engagement included standing up AWS Control Tower with Landing Zones and AWS Organizations. Proper account structure (security, logging, shared services, workload accounts) instead of the flat single-account setup they had before.

## Repository Structure

```
multi-account-governance/
├── client/repos/terraform/
│   ├── backend.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── vpc.tf                    # Three VPC definitions
│   ├── instances.tf
│   ├── keypair.tf
│   ├── resource-access-managers.tf
│   ├── routetable-production.tf
│   ├── routetable-shared.tf
│   ├── routetable-staging.tf
│   ├── data_igw.tf / data_nat.tf / data_subnet.tf / data_vpc.tf
│   └── .gitignore
└── architecture-diagrams/
    ├── aws-architecture-full.tsx     # Full architecture diagram
    ├── aws-architecture-part1.tsx    # Network layer
    ├── aws-architecture-part2.tsx    # Compute layer
    └── aws-architecture-part3.tsx    # Services layer
```

## Running It

```bash
cd client/repos/terraform
terraform init
terraform plan -var-file=staging.tfvars    # or production.tfvars
terraform apply
```

The VPC module requires access to the Azure DevOps Git repo. If you're outside that org, you'd need to swap the module source for a local path or a different registry.
