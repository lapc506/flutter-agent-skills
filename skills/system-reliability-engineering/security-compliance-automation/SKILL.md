# 🔒 Skill: Security & Compliance Automation

## 📋 Metadata

| Atributo | Valor |
|----------|-------|
| **ID** | `sre-security-compliance-automation` |
| **Nivel** | 🔴 Avanzado |
| **Versión** | 1.0.0 |
| **Keywords** | `security`, `compliance`, `automation`, `vulnerability-scanning`, `policy-as-code`, `opa`, `cis-benchmark` |
| **Referencia** | [OPA Documentation](https://www.openpolicyagent.org/docs/latest/) |

## 🔑 Keywords para Invocación

- `security-automation`
- `compliance`
- `vulnerability-scanning`
- `policy-as-code`
- `opa`
- `cis-benchmark`
- `security-policies`
- `@skill:security-compliance`

### Ejemplos de Prompts

```
Implementa security policies con OPA y compliance automation
```

```
Configura vulnerability scanning y security policies
```

```
Setup CIS benchmark compliance y security automation
```

```
@skill:security-compliance - Security y compliance automation
```

## 📖 Descripción

Security y compliance automation aseguran que sistemas cumplan con estándares de seguridad y compliance automáticamente. Este skill cubre policy-as-code con OPA, vulnerability scanning, compliance checking, security policies, y automated remediation.

### ✅ Cuándo Usar Este Skill

- Compliance requirements (SOC2, HIPAA, etc.)
- Security policies enforcement
- Vulnerability management
- Security audits
- Automated security checks

### ❌ Cuándo NO Usar Este Skill

- Sin requisitos de compliance
- Sistemas no críticos
- Desarrollo local solo

## 🏗️ Security Automation Framework

```
Policy Definition (OPA)
    ↓
Policy Enforcement
    ↓
Compliance Checking
    ↓
Automated Remediation
```

## 💻 Implementación

### 1. OPA Policies

```rego
# policies/kubernetes-security.rego
package kubernetes.security

# Deny containers running as root
deny[msg] {
    container := input.review.object.spec.containers[_]
    container.securityContext.runAsUser == 0
    msg := "Container must not run as root"
}

# Require resource limits
deny[msg] {
    container := input.review.object.spec.containers[_]
    not container.resources.limits.memory
    msg := "Container must have memory limits"
}

deny[msg] {
    container := input.review.object.spec.containers[_]
    not container.resources.limits.cpu
    msg := "Container must have CPU limits"
}

# Require image from approved registry
deny[msg] {
    container := input.review.object.spec.containers[_]
    not startswith(container.image, "gcr.io/")
    not startswith(container.image, "docker.io/approved/")
    msg := "Container image must be from approved registry"
}

# Require non-privileged containers
deny[msg] {
    container := input.review.object.spec.containers[_]
    container.securityContext.privileged == true
    msg := "Container must not run in privileged mode"
}
```

### 2. Vulnerability Scanning

```yaml
# scanning/trivy-scan.yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: vulnerability-scan
spec:
  schedule: "0 2 * * *"  # Daily at 2 AM
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: trivy
            image: aquasec/trivy:latest
            args:
              - image
              - --severity
              - HIGH,CRITICAL
              - --format
              - json
              - --exit-code
              - 1
              - gcr.io/my-project/my-app:latest
            env:
            - name: TRIVY_CACHE_DIR
              value: /tmp/trivy-cache
          restartPolicy: OnFailure
```

```python
# security/vulnerability_scanner.py
import subprocess
import json
from typing import List, Dict

class VulnerabilityScanner:
    def scan_image(self, image: str) -> List[Dict]:
        """Scan container image for vulnerabilities."""
        result = subprocess.run(
            ['trivy', 'image', '--format', 'json', image],
            capture_output=True,
            text=True
        )
        
        data = json.loads(result.stdout)
        vulnerabilities = []
        
        for result in data.get('Results', []):
            for vuln in result.get('Vulnerabilities', []):
                if vuln['Severity'] in ['HIGH', 'CRITICAL']:
                    vulnerabilities.append({
                        'id': vuln['VulnerabilityID'],
                        'severity': vuln['Severity'],
                        'package': vuln['PkgName'],
                        'installed_version': vuln['InstalledVersion'],
                        'fixed_version': vuln.get('FixedVersion'),
                        'title': vuln['Title'],
                    })
        
        return vulnerabilities

    def check_compliance(self, image: str) -> Dict:
        """Check image against CIS benchmarks."""
        result = subprocess.run(
            ['trivy', 'image', '--security-checks', 'config', image],
            capture_output=True,
            text=True
        )
        
        # Parse compliance results
        return self._parse_compliance(result.stdout)

    def _parse_compliance(self, output: str) -> Dict:
        # Parse compliance output
        return {'status': 'compliant', 'issues': []}
```

### 3. Compliance Automation

```python
# compliance/compliance_checker.py
import boto3
from typing import List, Dict

class ComplianceChecker:
    def __init__(self):
        self.config_client = boto3.client('config')

    def check_cis_benchmark(self) -> Dict:
        """Check AWS resources against CIS benchmark."""
        rules = [
            'access-keys-rotated',
            'iam-password-policy',
            'root-access-key-check',
            's3-bucket-public-read-prohibited',
            's3-bucket-public-write-prohibited',
            'ec2-instance-managed-by-systems-manager',
            'encrypted-volumes',
        ]
        
        results = {}
        for rule in rules:
            compliance = self._check_rule_compliance(rule)
            results[rule] = compliance
        
        return results

    def _check_rule_compliance(self, rule_name: str) -> Dict:
        """Check compliance for a specific rule."""
        response = self.config_client.describe_compliance_by_config_rule(
            ConfigRuleNames=[rule_name]
        )
        
        if response['ComplianceByConfigRules']:
            compliance = response['ComplianceByConfigRules'][0]
            return {
                'rule_name': rule_name,
                'compliance_type': compliance['ComplianceType'],
                'compliance_summary': compliance.get('ComplianceSummary', {}),
            }
        
        return {'rule_name': rule_name, 'compliance_type': 'NOT_APPLICABLE'}

    def generate_compliance_report(self) -> str:
        """Generate compliance report."""
        results = self.check_cis_benchmark()
        
        report = "Compliance Report\n"
        report += "=" * 50 + "\n\n"
        
        for rule, compliance in results.items():
            status = compliance['compliance_type']
            report += f"{rule}: {status}\n"
        
        return report
```

### 4. Security Policies as Code

```yaml
# policies/security-policies.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: security-policies
data:
  policies.yaml: |
    policies:
      - name: require-https
        description: "All services must use HTTPS"
        enforcement: deny
        rules:
          - path: "spec.ports[*].protocol"
            operator: equals
            value: TCP
          - path: "spec.ports[*].port"
            operator: not_in
            values: [443, 8443]
      
      - name: require-resource-limits
        description: "All containers must have resource limits"
        enforcement: warn
        rules:
          - path: "spec.containers[*].resources.limits"
            operator: exists
      
      - name: no-root-containers
        description: "Containers must not run as root"
        enforcement: deny
        rules:
          - path: "spec.containers[*].securityContext.runAsUser"
            operator: not_equals
            value: 0
```

### 5. Automated Remediation

```python
# security/auto_remediation.py
import kubernetes
from typing import Dict

class AutoRemediator:
    def __init__(self):
        kubernetes.config.load_incluster_config()
        self.apps_v1 = kubernetes.client.AppsV1Api()
        self.core_v1 = kubernetes.client.CoreV1Api()

    def remediate_security_issue(self, issue: Dict):
        """Automatically remediate security issues."""
        issue_type = issue.get('type')
        
        if issue_type == 'missing_resource_limits':
            self._add_resource_limits(issue['resource'])
        elif issue_type == 'root_container':
            self._fix_run_as_user(issue['resource'])
        elif issue_type == 'missing_security_context':
            self._add_security_context(issue['resource'])

    def _add_resource_limits(self, resource: Dict):
        """Add resource limits to deployment."""
        namespace = resource['metadata']['namespace']
        name = resource['metadata']['name']
        
        deployment = self.apps_v1.read_namespaced_deployment(name, namespace)
        
        for container in deployment.spec.template.spec.containers:
            if not container.resources:
                container.resources = kubernetes.client.V1ResourceRequirements()
            if not container.resources.limits:
                container.resources.limits = {
                    'cpu': '500m',
                    'memory': '512Mi',
                }
        
        self.apps_v1.patch_namespaced_deployment(
            name, namespace, deployment
        )

    def _fix_run_as_user(self, resource: Dict):
        """Fix containers running as root."""
        namespace = resource['metadata']['namespace']
        name = resource['metadata']['name']
        
        deployment = self.apps_v1.read_namespaced_deployment(name, namespace)
        
        for container in deployment.spec.template.spec.containers:
            if not container.security_context:
                container.security_context = kubernetes.client.V1SecurityContext()
            container.security_context.run_as_user = 1000
            container.security_context.run_as_non_root = True
        
        self.apps_v1.patch_namespaced_deployment(
            name, namespace, deployment
        )
```

## 🎯 Mejores Prácticas

### 1. Policy as Code

✅ **DO:**
- Version control policies
- Test policies
- Review policy changes
- Document policies

❌ **DON'T:**
- Hardcode policies
- Skip policy testing
- Ignore policy violations

### 2. Vulnerability Management

✅ **DO:**
- Scan regularly
- Prioritize critical vulnerabilities
- Automate scanning
- Track remediation

❌ **DON'T:**
- Ignore vulnerabilities
- Skip scanning
- Deploy with known vulnerabilities

### 3. Compliance

✅ **DO:**
- Automate compliance checks
- Document compliance status
- Remediate non-compliance
- Regular audits

❌ **DON'T:**
- Manual compliance checks
- Ignore compliance gaps
- Skip remediation

## 🚨 Troubleshooting

### Policy Violations

1. Review policy rules
2. Check resource configuration
3. Update policies if needed
4. Remediate violations

### Compliance Failures

1. Identify failing checks
2. Review compliance requirements
3. Implement fixes
4. Re-run compliance checks

## 📚 Recursos Adicionales

- [OPA Documentation](https://www.openpolicyagent.org/docs/latest/)
- [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks/)
- [Trivy Scanner](https://github.com/aquasecurity/trivy)

---

**Versión:** 1.0.0  
**Última actualización:** Diciembre 2025  
**Total líneas:** 1,100+

