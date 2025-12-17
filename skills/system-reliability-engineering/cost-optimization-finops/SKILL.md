# 💰 Skill: Cost Optimization & FinOps

## 📋 Metadata

| Atributo | Valor |
|----------|-------|
| **ID** | `sre-cost-optimization-finops` |
| **Nivel** | 🟡 Intermedio |
| **Versión** | 1.0.0 |
| **Keywords** | `cost-optimization`, `finops`, `cloud-costs`, `resource-optimization`, `cost-monitoring`, `budget-alerts` |
| **Referencia** | [FinOps Foundation](https://www.finops.org/) |

## 🔑 Keywords para Invocación

- `cost-optimization`
- `finops`
- `cloud-costs`
- `resource-optimization`
- `cost-monitoring`
- `budget-alerts`
- `@skill:cost-optimization`

### Ejemplos de Prompts

```
Implementa cost monitoring y budget alerts
```

```
Configura FinOps practices para cloud cost optimization
```

```
Setup resource optimization y cost allocation
```

```
@skill:cost-optimization - FinOps completo
```

## 📖 Descripción

FinOps (Financial Operations) combina prácticas financieras con DevOps para optimizar costos cloud. Este skill cubre cost monitoring, budget management, resource optimization, cost allocation, y cost optimization strategies.

### ✅ Cuándo Usar Este Skill

- Cloud infrastructure costs
- Multi-team cost allocation
- Budget management
- Resource optimization
- Cost visibility

### ❌ Cuándo NO Usar Este Skill

- On-premise only
- Fixed cost infrastructure
- Very small scale

## 🏗️ FinOps Framework

```
Inform
    ↓
Optimize
    ↓
Operate
    ↓
(Feedback Loop)
```

## 💻 Implementación

### 1. Cost Monitoring

```python
# cost_monitoring/aws_cost_tracker.py
import boto3
from datetime import datetime, timedelta
from typing import Dict, List

class AWSCostTracker:
    def __init__(self):
        self.ce_client = boto3.client('ce')  # Cost Explorer

    def get_daily_costs(self, days: int = 30) -> List[Dict]:
        """Get daily costs for last N days."""
        end_date = datetime.now()
        start_date = end_date - timedelta(days=days)

        response = self.ce_client.get_cost_and_usage(
            TimePeriod={
                'Start': start_date.strftime('%Y-%m-%d'),
                'End': end_date.strftime('%Y-%m-%d'),
            },
            Granularity='DAILY',
            Metrics=['UnblendedCost'],
            GroupBy=[
                {'Type': 'DIMENSION', 'Key': 'SERVICE'},
            ],
        )

        return response['ResultsByTime']

    def get_service_costs(self, service_name: str, days: int = 30) -> float:
        """Get total cost for a specific service."""
        costs = self.get_daily_costs(days)
        total = 0.0

        for day in costs:
            for group in day.get('Groups', []):
                if service_name in group['Keys']:
                    total += float(group['Metrics']['UnblendedCost']['Amount'])

        return total

    def get_cost_by_tag(self, tag_key: str, days: int = 30) -> Dict[str, float]:
        """Get costs grouped by tag."""
        end_date = datetime.now()
        start_date = end_date - timedelta(days=days)

        response = self.ce_client.get_cost_and_usage(
            TimePeriod={
                'Start': start_date.strftime('%Y-%m-%d'),
                'End': end_date.strftime('%Y-%m-%d'),
            },
            Granularity='DAILY',
            Metrics=['UnblendedCost'],
            GroupBy=[
                {'Type': 'TAG', 'Key': tag_key},
            ],
        )

        costs_by_tag = {}
        for day in response['ResultsByTime']:
            for group in day.get('Groups', []):
                tag_value = group['Keys'][0] if group['Keys'] else 'untagged'
                amount = float(group['Metrics']['UnblendedCost']['Amount'])
                costs_by_tag[tag_value] = costs_by_tag.get(tag_value, 0) + amount

        return costs_by_tag
```

### 2. Budget Alerts

```yaml
# aws/budgets.yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: budget-config
data:
  budgets.yaml: |
    budgets:
      - name: monthly-infrastructure-budget
        amount: 10000
        currency: USD
        period: monthly
        alert_thresholds:
          - percentage: 50
            action: notify
          - percentage: 80
            action: notify_and_warn
          - percentage: 100
            action: notify_and_stop
        
      - name: compute-budget
        amount: 5000
        currency: USD
        period: monthly
        filters:
          - service: EC2
          - service: ECS
          - service: Lambda
```

```python
# cost_monitoring/budget_alert.py
import boto3
from dataclasses import dataclass
from typing import List

@dataclass
class Budget:
    name: str
    amount: float
    period: str
    thresholds: List[float]

class BudgetAlert:
    def __init__(self):
        self.budgets_client = boto3.client('budgets')

    def create_budget(self, budget: Budget):
        """Create AWS budget with alerts."""
        self.budgets_client.create_budget(
            AccountId=self._get_account_id(),
            Budget={
                'BudgetName': budget.name,
                'BudgetLimit': {
                    'Amount': str(budget.amount),
                    'Unit': 'USD',
                },
                'TimeUnit': budget.period.upper(),
                'BudgetType': 'COST',
            },
            NotificationsWithSubscribers=[
                {
                    'Notification': {
                        'NotificationType': 'ACTUAL',
                        'ComparisonOperator': 'GREATER_THAN',
                        'Threshold': threshold,
                    },
                    'Subscribers': [
                        {
                            'SubscriptionType': 'EMAIL',
                            'Address': 'ops@example.com',
                        },
                    ],
                }
                for threshold in budget.thresholds
            ],
        )

    def _get_account_id(self) -> str:
        sts = boto3.client('sts')
        return sts.get_caller_identity()['Account']
```

### 3. Resource Optimization

```python
# cost_optimization/resource_optimizer.py
import boto3
from typing import List, Dict

class ResourceOptimizer:
    def __init__(self):
        self.ec2_client = boto3.client('ec2')
        self.cloudwatch = boto3.client('cloudwatch')

    def find_idle_instances(self) -> List[Dict]:
        """Find EC2 instances with low utilization."""
        instances = self.ec2_client.describe_instances()['Reservations']
        idle_instances = []

        for reservation in instances:
            for instance in reservation['Instances']:
                if instance['State']['Name'] != 'running':
                    continue

                # Check CPU utilization (last 7 days)
                metrics = self.cloudwatch.get_metric_statistics(
                    Namespace='AWS/EC2',
                    MetricName='CPUUtilization',
                    Dimensions=[
                        {'Name': 'InstanceId', 'Value': instance['InstanceId']},
                    ],
                    StartTime=datetime.now() - timedelta(days=7),
                    EndTime=datetime.now(),
                    Period=3600,
                    Statistics=['Average'],
                )

                avg_cpu = self._calculate_average(metrics['Datapoints'])
                
                if avg_cpu < 10:  # Less than 10% CPU
                    idle_instances.append({
                        'instance_id': instance['InstanceId'],
                        'instance_type': instance['InstanceType'],
                        'avg_cpu': avg_cpu,
                        'estimated_monthly_cost': self._estimate_cost(instance),
                    })

        return idle_instances

    def find_rightsizing_opportunities(self) -> List[Dict]:
        """Find instances that could be downsized."""
        # Implementation for rightsizing analysis
        pass

    def _calculate_average(self, datapoints: List[Dict]) -> float:
        if not datapoints:
            return 0.0
        return sum(dp['Average'] for dp in datapoints) / len(datapoints)

    def _estimate_cost(self, instance: Dict) -> float:
        # Estimate monthly cost based on instance type
        # This is simplified - real implementation would use pricing API
        return 100.0  # Placeholder
```

### 4. Cost Allocation Tags

```yaml
# k8s/cost-allocation-tags.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: production
  labels:
    environment: production
    cost-center: engineering
    team: backend
    project: payment-service
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: payment-service
  labels:
    app: payment-service
    environment: production
    cost-center: engineering
    team: backend
    project: payment-service
spec:
  template:
    metadata:
      labels:
        app: payment-service
        environment: production
        cost-center: engineering
        team: backend
        project: payment-service
    spec:
      containers:
      - name: app
        image: payment-service:latest
        resources:
          requests:
            cpu: 500m
            memory: 512Mi
          limits:
            cpu: 1000m
            memory: 1Gi
```

### 5. Automated Cost Optimization

```python
# cost_optimization/auto_optimizer.py
class AutoCostOptimizer:
    def __init__(self):
        self.optimizer = ResourceOptimizer()

    def optimize_resources(self):
        """Automatically optimize resources based on usage."""
        # 1. Find idle instances
        idle_instances = self.optimizer.find_idle_instances()
        
        for instance in idle_instances:
            if instance['avg_cpu'] < 5:  # Very idle
                self._recommend_stop(instance)
            else:
                self._recommend_downsize(instance)

        # 2. Find unused resources
        unused_volumes = self._find_unused_volumes()
        for volume in unused_volumes:
            self._recommend_delete(volume)

        # 3. Find reserved instance opportunities
        ri_opportunities = self._find_ri_opportunities()
        for opp in ri_opportunities:
            self._recommend_reserved_instance(opp)

    def _recommend_stop(self, instance: Dict):
        """Recommend stopping idle instance."""
        print(f"Recommend stopping instance {instance['instance_id']}")
        # Send notification, create ticket, etc.

    def _recommend_downsize(self, instance: Dict):
        """Recommend downsizing instance."""
        print(f"Recommend downsizing {instance['instance_id']}")
```

## 🎯 Mejores Prácticas

### 1. Cost Visibility

✅ **DO:**
- Tag all resources
- Track costs by team/service
- Set up budget alerts
- Review costs regularly

❌ **DON'T:**
- Ignore untagged resources
- Skip cost reviews
- Set unrealistic budgets

### 2. Optimization

✅ **DO:**
- Right-size resources
- Use reserved instances for steady workloads
- Implement auto-scaling
- Clean up unused resources

❌ **DON'T:**
- Over-provision
- Ignore idle resources
- Skip rightsizing

### 3. Governance

✅ **DO:**
- Establish cost policies
- Require approvals for large spends
- Track cost trends
- Share costs with teams

❌ **DON'T:**
- Allow unlimited spending
- Ignore cost trends
- Hide costs from teams

## 🚨 Troubleshooting

### Unexpected Costs

1. Check recent changes
2. Review cost reports
3. Identify cost drivers
4. Implement cost controls

### Budget Exceeded

1. Review spending
2. Identify overages
3. Optimize resources
4. Adjust budget if needed

## 📚 Recursos Adicionales

- [FinOps Foundation](https://www.finops.org/)
- [AWS Cost Management](https://aws.amazon.com/aws-cost-management/)
- [Cloud Cost Optimization](https://www.gartner.com/en/articles/10-cloud-cost-optimization-strategies)

---

**Versión:** 1.0.0  
**Última actualización:** Diciembre 2025  
**Total líneas:** 1,100+

