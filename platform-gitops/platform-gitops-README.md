
# Platform GitOps Repository

This repository defines the **declarative GitOps layer** for the Platform EKS cluster.
It is managed entirely by **ArgoCD**, and contains all in-cluster applications and
platform components that are not AWS-managed addons.

---

## 📌 Repository Structure

```
platform-gitops/
├── argocd/
│   ├── install.yaml              # ArgoCD core installation (apply once manually)
│   ├── project-platform.yaml     # ArgoCD project for platform apps
│   └── root-app.yaml             # App-of-apps entrypoint
│
└── apps/
    ├── dev/
    │   ├── app-of-apps.yaml      # Aggregates all GitOps applications for DEV
    │   ├── karpenter/
    │   ├── aws-load-balancer-controller/
    │   ├── external-dns/
    │   ├── metrics-server/
    │   ├── istio/
    │   ├── kyverno/
    │   ├── gatekeeper/
    │   └── my-app/
    │       ├── deployment.yaml
    │       ├── service.yaml
    │       ├── ingress.yaml
    │       └── kustomization.yaml
    │
    ├── uat/
    │   ├── app-of-apps.yaml
    │   ├── same structure as dev...
    │
    └── prod/
        ├── app-of-apps.yaml
        ├── same structure as dev...
```

---

## 🔧 GitOps Responsibility Overview

| Component                         | Managed By | Notes |
|----------------------------------|------------|-------|
| **EBS CSI Driver**               | Terraform  | AWS-managed addon |
| **Karpenter Controller**         | GitOps     | IRSA created by Terraform |
| **AWS Load Balancer Controller** | GitOps     | IRSA created by Terraform |
| **ExternalDNS**                  | GitOps     | IRSA created by Terraform |
| **Metrics Server**               | GitOps     | Deploys to `kube-system` |
| **Istio**                        | GitOps     | Mesh deployment & CRDs |
| **Kyverno**                      | GitOps     | Policy engine |
| **Gatekeeper**                   | GitOps     | Admission control |
| **Applications**                 | GitOps     | e.g., my-app |

---

## 🚀 Bootstrapping ArgoCD

Before GitOps can manage the cluster, ArgoCD must be installed manually once:

```bash
kubectl apply -n argocd -f platform-gitops/argocd/install.yaml
```

Then apply the root app:

```bash
kubectl apply -f platform-gitops/argocd/root-app.yaml
```

ArgoCD will automatically:

- Install all platform components
- Deploy all environment-specific workloads
- Continuously reconcile changes

---

## 🧱 Environments

Each environment (`dev`, `uat`, `prod`) is fully isolated and contains its own
GitOps manifests. ArgoCD maps environments 1:1 via separate **Application** declarations.

---

## 🔐 Security and IRSA

Terraform creates IAM roles through the **IRSA module**, and GitOps consumes
those roles by attaching service accounts inside the manifests.

Example:

- Terraform IRSA role:  
  `arn:aws:iam::<account>:role/platform-eks-dev-external-dns`

- GitOps service account:  
  `metadata.annotations["eks.amazonaws.com/role-arn"]`

---

## 📂 How to Add a New Application

1. Create a folder under:
   ```
   platform-gitops/apps/dev/my-new-app/
   ```
2. Add manifests (`deployment.yaml`, `service.yaml`, etc.)
3. Add a `kustomization.yaml`
4. Reference it in `app-of-apps.yaml`

ArgoCD will automatically deploy it.

---

## 🧹 Platform Update Workflow

1. Modify GitOps manifests
2. Commit and push
3. ArgoCD syncs automatically

No kubectl patching, no manual deploys.

---

## 🏗 Infrastructure vs Runtime Responsibilities

### Terraform manages:
- VPC  
- EKS control plane  
- Node groups  
- IRSA roles for all controllers  
- EBS CSI AWS addon  
- KMS encryption  

### ArgoCD (GitOps) manages:
- All Kubernetes controllers  
- All in-cluster addons  
- All platform applications  
- All mesh/policy components (Istio, Kyverno, Gatekeeper)  

Clear separation → zero drift → enterprise-grade design.

---

## © Platform Team – Enterprise Kubernetes Architecture
