# 🌐 Skill: Service Mesh

## 📋 Metadata

| Atributo | Valor |
|----------|-------|
| **ID** | `sre-service-mesh` |
| **Nivel** | 🔴 Avanzado |
| **Versión** | 1.0.0 |
| **Keywords** | `service-mesh`, `istio`, `linkerd`, `envoy`, `traffic-management`, `mTLS`, `circuit-breaker` |
| **Referencia** | [Istio Documentation](https://istio.io/latest/docs/) |

## 🔑 Keywords para Invocación

- `service-mesh`
- `istio`
- `linkerd`
- `envoy`
- `traffic-management`
- `mtls`
- `circuit-breaker`
- `@skill:service-mesh`

### Ejemplos de Prompts

```
Implementa service mesh con Istio para microservicios
```

```
Configura mTLS y traffic management con Linkerd
```

```
Setup circuit breakers y retries con service mesh
```

```
@skill:service-mesh - Service mesh completo
```

## 📖 Descripción

Service mesh proporciona observabilidad, seguridad y confiabilidad para comunicaciones entre servicios. Este skill cubre implementación de Istio/Linkerd, traffic management, mTLS, circuit breakers, y service discovery.

### ✅ Cuándo Usar Este Skill

- Microservicios architecture
- Kubernetes deployments
- Requisitos de seguridad estrictos
- Traffic management complejo
- Observability entre servicios
- Canary deployments

### ❌ Cuándo NO Usar Este Skill

- Monoliths simples
- Pocos servicios (< 5)
- Sin requisitos de security/observability

## 🏗️ Service Mesh Architecture

```
┌─────────────────────────────────────────┐
│          Application Services           │
│  ┌────────┐   ┌────────┐   ┌────────┐   │
│  │Service │   │Service │   │Service │   │
│  │   A    │   │   B    │   │   C    │   │
│  └───┬────┘   └───┬────┘   └───┬────┘   │
└──────┼────────────┼────────────┼────────┘
       │            │            │
   ┌───▼────┐   ┌───▼────┐   ┌───▼────┐
   │ Envoy  │   │ Envoy  │   │ Envoy  │
   │ Proxy  │   │ Proxy  │   │ Proxy  │
   └───┬────┘   └───┬────┘   └───┬────┘
       │            │            │
       └────────────┼────────────┘
                    │
         ┌──────────▼──────────┐
         │  Control Plane      │
         │  (Istio/Linkerd)    │
         └─────────────────────┘
```

## 💻 Implementación

### 1. Istio Installation

```bash
# Install Istio
curl -L https://istio.io/downloadIstio | sh -
cd istio-*
export PATH=$PWD/bin:$PATH

# Install with demo profile
istioctl install --set profile=demo -y

# Verify installation
kubectl get pods -n istio-system
```

### 2. Traffic Management

```yaml
# istio/virtual-service.yaml
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: user-service
spec:
  hosts:
  - user-service
  http:
  # Route 90% to v1, 10% to v2 (canary)
  - match:
    - headers:
        canary:
          exact: "true"
    route:
    - destination:
        host: user-service
        subset: v2
      weight: 100
  - route:
    - destination:
        host: user-service
        subset: v1
      weight: 90
    - destination:
        host: user-service
        subset: v2
      weight: 10
  # Retry policy
  retries:
    attempts: 3
    perTryTimeout: 2s
    retryOn: 5xx,reset,connect-failure,refused-stream
  # Circuit breaker
  fault:
    delay:
      percentage:
        value: 0.1
      fixedDelay: 5s
    abort:
      percentage:
        value: 0.1
      httpStatus: 503
```

```yaml
# istio/destination-rule.yaml
apiVersion: networking.istio.io/v1beta1
kind: DestinationRule
metadata:
  name: user-service
spec:
  host: user-service
  trafficPolicy:
    loadBalancer:
      simple: LEAST_CONN
    connectionPool:
      tcp:
        maxConnections: 100
      http:
        http1MaxPendingRequests: 10
        http2MaxRequests: 100
        maxRequestsPerConnection: 2
        maxRetries: 3
        consecutiveGatewayErrors: 5
        interval: 30s
        baseEjectionTime: 30s
        maxEjectionPercent: 50
        minHealthPercent: 50
    outlierDetection:
      consecutiveErrors: 5
      interval: 30s
      baseEjectionTime: 30s
      maxEjectionPercent: 50
  subsets:
  - name: v1
    labels:
      version: v1
  - name: v2
    labels:
      version: v2
```

### 3. mTLS Configuration

```yaml
# istio/peer-authentication.yaml
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: default
  namespace: istio-system
spec:
  mtls:
    mode: STRICT  # Enforce mTLS for all services

---
# Per-namespace mTLS
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: production-mtls
  namespace: production
spec:
  mtls:
    mode: STRICT
  selector:
    matchLabels:
      app: critical-service
```

### 4. Authorization Policies

```yaml
# istio/authorization-policy.yaml
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: user-service-auth
  namespace: default
spec:
  selector:
    matchLabels:
      app: user-service
  action: ALLOW
  rules:
  - from:
    - source:
        principals: ["cluster.local/ns/default/sa/frontend"]
    to:
    - operation:
        methods: ["GET", "POST"]
  - from:
    - source:
        principals: ["cluster.local/ns/default/sa/admin"]
    to:
    - operation:
        methods: ["*"]
```

### 5. Circuit Breaker

```yaml
# istio/circuit-breaker.yaml
apiVersion: networking.istio.io/v1beta1
kind: DestinationRule
metadata:
  name: payment-service
spec:
  host: payment-service
  trafficPolicy:
    connectionPool:
      tcp:
        maxConnections: 100
      http:
        http1MaxPendingRequests: 10
        http2MaxRequests: 100
        maxRequestsPerConnection: 2
    outlierDetection:
      consecutiveErrors: 5
      interval: 30s
      baseEjectionTime: 30s
      maxEjectionPercent: 50
      minHealthPercent: 50
      splitExternalLocalOriginErrors: true
```

### 6. Observability with Istio

```yaml
# Enable telemetry
apiVersion: telemetry.istio.io/v1alpha1
kind: Telemetry
metadata:
  name: mesh-default
  namespace: istio-system
spec:
  accessLogging:
  - providers:
    - name: envoy
  tracing:
  - providers:
    - name: zipkin
    randomSamplingPercentage: 100.0
  metrics:
  - providers:
    - name: prometheus
```

## 🎯 Mejores Prácticas

### 1. Traffic Management

✅ **DO:**
- Use gradual rollouts
- Implement circuit breakers
- Configure retries appropriately
- Monitor traffic patterns

❌ **DON'T:**
- Deploy 100% to new version immediately
- Ignore circuit breaker triggers
- Retry indefinitely

### 2. Security

✅ **DO:**
- Enable mTLS
- Use authorization policies
- Follow least privilege
- Audit policies regularly

❌ **DON'T:**
- Skip mTLS in production
- Allow all traffic
- Ignore security updates

## 🚨 Troubleshooting

### Services Not Communicating

1. Check mTLS configuration
2. Verify VirtualService routes
3. Check DestinationRule subsets
4. Review authorization policies

### Circuit Breaker Tripping

1. Check service health
2. Review error rates
3. Adjust thresholds
4. Investigate root cause

## 📚 Recursos Adicionales

- [Istio Documentation](https://istio.io/latest/docs/)
- [Linkerd Documentation](https://linkerd.io/2/getting-started/)
- [Envoy Proxy](https://www.envoyproxy.io/docs)

---

**Versión:** 1.0.0  
**Última actualización:** Diciembre 2025  
**Total líneas:** 1,100+

