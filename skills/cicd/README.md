# 🚀 CI/CD Skills

Esta carpeta contiene skills especializados para Continuous Integration y Continuous Deployment, enfocados en infraestructura y deployment de backends para aplicaciones Flutter en un contexto de monorepo.

## 📦 Skills Disponibles

### 🔄 CI/CD & Deployment

| Skill | Nivel | Keywords | Descripción |
|-------|-------|----------|-------------|
| **GitHub Actions** | 🟡 Intermedio | `github-actions`, `ci`, `workflow` | CI/CD nativo de GitHub para Flutter + Backend |
| **ArgoCD** | 🔴 Avanzado | `argocd`, `gitops`, `kubernetes` | GitOps deployment para Kubernetes |

### 🏗️ Infrastructure as Code

| Skill | Nivel | Keywords | Descripción |
|-------|-------|----------|-------------|
| **Terraform** | 🔴 Avanzado | `terraform`, `iac`, `hcl` | Infrastructure as Code multi-cloud |

### ☁️ Cloud Providers

| Skill | Nivel | Keywords | Descripción |
|-------|-------|----------|-------------|
| **AWS** | 🔴 Avanzado | `aws`, `eks`, `rds`, `lambda` | Amazon Web Services deployment |
| **GCP** | 🔴 Avanzado | `gcp`, `gke`, `cloud-run` | Google Cloud Platform deployment |
| **Azure** | 🔴 Avanzado | `azure`, `aks`, `azure-functions` | Microsoft Azure deployment |
| **OVHCloud** | 🟡 Intermedio | `ovh`, `ovhcloud`, `kubernetes` | OVHCloud deployment (EU-based) |

### 🔧 Automation & Orchestration

| Skill | Nivel | Keywords | Descripción |
|-------|-------|----------|-------------|
| **Ansible AWX** | 🔴 Avanzado | `ansible`, `awx`, `automation` | Configuration management y automation |
| **Crossplane** | 🔴 Avanzado | `crossplane`, `multi-cloud` | Kubernetes-native infrastructure management |

## 🎯 Casos de Uso

### Monorepo Flutter + Backend

```
my-app-monorepo/
├── mobile/           # Flutter app
├── backend/          # Backend (Node.js/Python/Go)
├── infrastructure/   # Terraform/IaC
└── .github/workflows/  # GitHub Actions
```

### Stack Recomendado por Escenario

#### 🚀 Startup/MVP
- **CI/CD**: GitHub Actions
- **Cloud**: AWS (Free tier) o OVHCloud (precio)
- **Deployment**: Simple containers o Lambda

#### 🏢 Enterprise
- **IaC**: Terraform
- **CI/CD**: GitHub Actions + ArgoCD
- **Cloud**: AWS/GCP/Azure (multi-cloud con Crossplane)
- **Orchestration**: Kubernetes (EKS/GKE/AKS)
- **Automation**: Ansible AWX para config management

#### 🌍 Multi-región/Multi-cloud
- **IaC**: Terraform + Crossplane
- **Deployment**: ArgoCD para GitOps
- **Cloud**: Multi-cloud (AWS + GCP o Azure)
- **Automation**: Ansible AWX

## 🔑 Keywords Combinados

Puedes combinar skills en tus prompts:

```bash
"Usa terraform + aws + argocd para setup de backend Flutter en Kubernetes"

"Configura github-actions + gcp + cloud-run para deployment serverless"

"Implementa multi-cloud con crossplane + terraform en AWS y Azure"

"Setup ansible-awx + kubernetes para automatizar deployments"
```

## 📚 Workflow Típico

### 1. Setup Infraestructura
```bash
@skill:terraform - Provision infrastructure en AWS
@skill:aws - Configure EKS cluster y RDS
```

### 2. Configure CI/CD
```bash
@skill:github-actions - Setup pipelines para Flutter y Backend
```

### 3. Setup GitOps
```bash
@skill:argocd - Configure continuous deployment
```

### 4. Automatización
```bash
@skill:ansible-awx - Automatiza configuración de servidores
```

## 🎓 Learning Path

### Nivel Básico
1. Start: **GitHub Actions** - CI/CD básico
2. Cloud: **AWS** o **GCP** - Servicios básicos

### Nivel Intermedio
3. IaC: **Terraform** - Infrastructure as Code
4. GitOps: **ArgoCD** - Continuous Deployment

### Nivel Avanzado
5. Multi-cloud: **Crossplane** - Cloud-agnostic
6. Automation: **Ansible AWX** - Advanced automation

## 🔗 Skills Relacionados

- [Flutter Skills](../flutter/) - Mobile app development
- [Figma Skills](../figma/) - Design integration

---

**Última actualización:** Diciembre 2025  
**Total Skills:** 9

