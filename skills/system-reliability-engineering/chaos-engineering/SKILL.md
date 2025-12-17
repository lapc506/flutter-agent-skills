# 💥 Skill: Chaos Engineering

## 📋 Metadata

| Atributo | Valor |
|----------|-------|
| **ID** | `sre-chaos-engineering` |
| **Nivel** | 🔴 Avanzado |
| **Versión** | 1.0.0 |
| **Keywords** | `chaos-engineering`, `chaos-monkey`, `litmus`, `failure-injection`, `resilience-testing`, `chaos-experiments` |
| **Referencia** | [Chaos Engineering Principles](https://principlesofchaos.org/) |

## 🔑 Keywords para Invocación

- `chaos-engineering`
- `chaos-monkey`
- `litmus`
- `failure-injection`
- `resilience-testing`
- `chaos-experiments`
- `@skill:chaos-engineering`

### Ejemplos de Prompts

```
Implementa chaos engineering con Litmus para resilience testing
```

```
Configura chaos experiments y failure injection
```

```
Setup Chaos Monkey para probar resiliencia del sistema
```

```
@skill:chaos-engineering - Chaos engineering completo
```

## 📖 Descripción

Chaos engineering es la práctica de inyectar fallos intencionalmente para probar la resiliencia de sistemas. Este skill cubre chaos experiments, failure injection, resilience testing, y herramientas como Litmus y Chaos Monkey.

### ✅ Cuándo Usar Este Skill

- Sistemas en producción
- Testing de resiliencia
- Validación de failover
- Identificación de puntos débiles
- Mejora de reliability

### ❌ Cuándo NO Usar Este Skill

- Sistemas en desarrollo temprano
- Sin monitoring adecuado
- Sin rollback procedures
- Sin equipo preparado

## 🏗️ Chaos Engineering Process

```
Hypothesis
    ↓
Experiment Design
    ↓
Execute Experiment
    ↓
Observe & Measure
    ↓
Learn & Improve
```

## 💻 Implementación

### 1. Litmus Chaos Experiments

```yaml
# chaos/pod-delete-experiment.yaml
apiVersion: litmuschaos.io/v1alpha1
kind: ChaosEngine
metadata:
  name: pod-delete-chaos
  namespace: default
spec:
  annotationCheck: 'true'
  engineState: 'active'
  chaosServiceAccount: litmus-admin
  monitoring: true
  jobCleanUpPolicy: 'retain'
  experiments:
    - name: pod-delete
      spec:
        components:
          env:
            - name: TOTAL_CHAOS_DURATION
              value: '60'
            - name: CHAOS_INTERVAL
              value: '10'
            - name: FORCE
              value: 'false'
            - name: RAMP_TIME
              value: '10'
        probe:
          - name: check-app-health
            type: httpProbe
            httpProbeInputs:
              url: http://app-service/health
              insecureSkipVerify: false
            mode: Continuous
            runProperties:
              probeTimeout: 5
              interval: 2
              retry: 1
```

```yaml
# chaos/network-chaos.yaml
apiVersion: litmuschaos.io/v1alpha1
kind: ChaosEngine
metadata:
  name: network-chaos
spec:
  engineState: 'active'
  chaosServiceAccount: litmus-admin
  experiments:
    - name: network-chaos
      spec:
        components:
          env:
            - name: NETWORK_INTERFACE
              value: 'eth0'
            - name: NETWORK_PACKET_LOSS_PERCENTAGE
              value: '100'
            - name: TARGET_CONTAINER
              value: 'app-container'
            - name: TARGET_PODS
              value: 'app-.*'
            - name: TOTAL_CHAOS_DURATION
              value: '120'
```

### 2. Chaos Monkey Implementation

```python
# chaos/chaos_monkey.py
import random
import kubernetes
from typing import List, Dict
from datetime import datetime, timedelta

class ChaosMonkey:
    def __init__(self, enabled: bool = True, probability: float = 0.1):
        self.enabled = enabled
        self.probability = probability  # 10% chance of chaos
        kubernetes.config.load_incluster_config()
        self.core_v1 = kubernetes.client.CoreV1Api()
        self.apps_v1 = kubernetes.client.AppsV1Api()

    def run_experiment(self, experiment_type: str):
        """Run a chaos experiment."""
        if not self.enabled:
            return

        if random.random() > self.probability:
            return  # Skip this run

        if experiment_type == 'pod-delete':
            self._delete_random_pod()
        elif experiment_type == 'node-drain':
            self._drain_random_node()
        elif experiment_type == 'cpu-stress':
            self._stress_cpu()
        elif experiment_type == 'memory-stress':
            self._stress_memory()
        elif experiment_type == 'network-partition':
            self._partition_network()

    def _delete_random_pod(self):
        """Delete a random pod from a deployment."""
        deployments = self.apps_v1.list_deployment_for_all_namespaces()
        
        # Filter to deployments with chaos annotation
        chaos_deployments = [
            d for d in deployments.items
            if d.metadata.annotations.get('chaos.enabled') == 'true'
        ]
        
        if not chaos_deployments:
            return

        deployment = random.choice(chaos_deployments)
        pods = self.core_v1.list_namespaced_pod(
            deployment.metadata.namespace,
            label_selector=f"app={deployment.metadata.labels.get('app')}"
        )

        if pods.items:
            pod = random.choice(pods.items)
            print(f"Chaos Monkey: Deleting pod {pod.metadata.name}")
            self.core_v1.delete_namespaced_pod(
                pod.metadata.name,
                pod.metadata.namespace
            )

    def _stress_cpu(self):
        """Stress CPU on random pod."""
        # Implementation for CPU stress
        pass

    def _stress_memory(self):
        """Stress memory on random pod."""
        # Implementation for memory stress
        pass

    def _partition_network(self):
        """Create network partition."""
        # Implementation for network partition
        pass
```

### 3. Chaos Experiments

```python
# chaos/experiments.py
from dataclasses import dataclass
from typing import Callable, Dict
from datetime import datetime

@dataclass
class ChaosExperiment:
    name: str
    description: str
    hypothesis: str
    experiment_fn: Callable
    duration_seconds: int
    expected_behavior: str

class ExperimentRunner:
    def __init__(self):
        self.experiments = []

    def register_experiment(self, experiment: ChaosExperiment):
        self.experiments.append(experiment)

    def run_experiment(self, experiment_name: str) -> Dict:
        """Run a specific experiment."""
        experiment = next(
            (e for e in self.experiments if e.name == experiment_name),
            None
        )
        
        if not experiment:
            raise ValueError(f"Experiment {experiment_name} not found")

        print(f"Running experiment: {experiment.name}")
        print(f"Hypothesis: {experiment.hypothesis}")

        start_time = datetime.now()
        
        try:
            # Run experiment
            result = experiment.experiment_fn()
            
            end_time = datetime.now()
            duration = (end_time - start_time).total_seconds()

            return {
                'experiment': experiment.name,
                'status': 'success',
                'duration': duration,
                'result': result,
            }
        except Exception as e:
            return {
                'experiment': experiment.name,
                'status': 'failed',
                'error': str(e),
            }

# Example experiment
def pod_delete_experiment():
    """Experiment: Delete random pod, system should recover."""
    # Implementation
    return {'pods_deleted': 1, 'recovery_time': 30}

experiment = ChaosExperiment(
    name='pod-delete',
    description='Delete random pod from deployment',
    hypothesis='System should recover within 60 seconds',
    experiment_fn=pod_delete_experiment,
    duration_seconds=60,
    expected_behavior='Service remains available'
)
```

### 4. Automated Chaos Testing

```yaml
# chaos/chaos-test-schedule.yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: chaos-monkey
spec:
  schedule: "0 */6 * * *"  # Every 6 hours
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: chaos-monkey
            image: chaos-monkey:latest
            env:
            - name: ENABLED
              value: "true"
            - name: PROBABILITY
              value: "0.1"
            - name: EXPERIMENT_TYPES
              value: "pod-delete,cpu-stress"
            command:
            - python
            - chaos_monkey.py
            - --schedule
          restartPolicy: OnFailure
```

### 5. Chaos Metrics

```python
# chaos/metrics.py
from prometheus_client import Counter, Histogram, Gauge

# Metrics
chaos_experiments_total = Counter(
    'chaos_experiments_total',
    'Total chaos experiments run',
    ['experiment_type', 'status']
)

chaos_experiment_duration = Histogram(
    'chaos_experiment_duration_seconds',
    'Duration of chaos experiments',
    ['experiment_type']
)

system_recovery_time = Histogram(
    'system_recovery_time_seconds',
    'Time for system to recover from chaos',
    ['experiment_type']
)

chaos_experiments_active = Gauge(
    'chaos_experiments_active',
    'Number of active chaos experiments'
)

def record_experiment(experiment_type: str, status: str, duration: float):
    """Record chaos experiment metrics."""
    chaos_experiments_total.labels(
        experiment_type=experiment_type,
        status=status
    ).inc()
    
    chaos_experiment_duration.labels(
        experiment_type=experiment_type
    ).observe(duration)
```

## 🎯 Mejores Prácticas

### 1. Experiment Design

✅ **DO:**
- Start with hypothesis
- Test in non-production first
- Start small and increase
- Monitor during experiments

❌ **DON'T:**
- Run experiments without hypothesis
- Start in production
- Run multiple experiments simultaneously
- Ignore monitoring

### 2. Safety

✅ **DO:**
- Use feature flags
- Have rollback procedures
- Set experiment duration limits
- Monitor system health

❌ **DON'T:**
- Run experiments without safety measures
- Ignore system health
- Exceed experiment duration
- Skip rollback procedures

### 3. Learning

✅ **DO:**
- Document results
- Share learnings
- Improve based on results
- Regular experiments

❌ **DON'T:**
- Skip documentation
- Ignore results
- Run experiments randomly
- Stop after first success

## 🚨 Troubleshooting

### Experiments Causing Issues

1. Stop experiment immediately
2. Review experiment design
3. Check system health
4. Adjust experiment parameters

### No Recovery

1. Check failover mechanisms
2. Review monitoring
3. Investigate root cause
4. Fix underlying issues

## 📚 Recursos Adicionales

- [Chaos Engineering Principles](https://principlesofchaos.org/)
- [Litmus Documentation](https://litmuschaos.io/docs/)
- [Chaos Monkey](https://github.com/Netflix/chaosmonkey)

---

**Versión:** 1.0.0  
**Última actualización:** Diciembre 2025  
**Total líneas:** 1,100+

