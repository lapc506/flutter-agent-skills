# ⚡ Skill: Load Testing & Performance

## 📋 Metadata

| Atributo | Valor |
|----------|-------|
| **ID** | `sre-load-testing-performance` |
| **Nivel** | 🔴 Avanzado |
| **Versión** | 1.0.0 |
| **Keywords** | `load-testing`, `performance`, `k6`, `jmeter`, `stress-testing`, `capacity-planning`, `benchmarking`, `rust` |
| **Referencia** | [k6 Documentation](https://k6.io/docs/), [JMeter](https://jmeter.apache.org/) |

## 🔑 Keywords para Invocación

- `load-testing`
- `performance-testing`
- `stress-testing`
- `k6`
- `jmeter`
- `capacity-planning`
- `benchmarking`
- `rust`
- `@skill:load-testing`

### Ejemplos de Prompts

```
Implementa load testing con k6 para APIs
```

```
Configura stress testing y capacity planning
```

```
Setup performance benchmarking y profiling
```

```
@skill:load-testing - Estrategia completa de testing de carga
```

```
Implementa profiling y benchmarking para backend Rust
```

## 📖 Descripción

Load testing y performance optimization son esenciales para entender los límites de un sistema. Este skill cubre herramientas de load testing (k6, JMeter), estrategias de testing, capacity planning, profiling, y optimización de performance.

### ✅ Cuándo Usar Este Skill

- Antes de releases importantes
- Capacity planning
- Performance optimization
- SLA validation
- Stress testing
- Finding bottlenecks

### ❌ Cuándo NO Usar Este Skill

- Prototipos tempranos
- Sistemas sin usuarios reales
- Aplicaciones sin requisitos de performance

## 🏗️ Tipos de Testing

```
Load Testing
    ├── Baseline (Expected load)
    ├── Stress (Beyond capacity)
    ├── Spike (Sudden load increase)
    ├── Endurance (Extended duration)
    └── Volume (Large data sets)
```

## 💻 Implementación

### 1. k6 Load Testing

#### 1.1 Basic Test Script

```javascript
// tests/load/basic-load.js
import http from 'k6/http';
import { check, sleep } from 'k6';
import { Rate, Trend } from 'k6/metrics';

// Custom metrics
const errorRate = new Rate('errors');
const requestDuration = new Trend('request_duration');

export const options = {
  stages: [
    { duration: '2m', target: 100 },  // Ramp up to 100 users
    { duration: '5m', target: 100 },  // Stay at 100 users
    { duration: '2m', target: 200 },  // Ramp up to 200 users
    { duration: '5m', target: 200 },  // Stay at 200 users
    { duration: '2m', target: 0 },    // Ramp down to 0 users
  ],
  thresholds: {
    http_req_duration: ['p(95)<500', 'p(99)<1000'], // 95% under 500ms, 99% under 1s
    http_req_failed: ['rate<0.01'],                  // Error rate under 1%
    errors: ['rate<0.01'],
  },
};

export default function () {
  const baseUrl = 'https://api.example.com';

  // Test endpoint
  const response = http.get(`${baseUrl}/api/v1/users`, {
    headers: {
      'Authorization': 'Bearer ' + __ENV.API_TOKEN,
    },
  });

  // Check response
  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'response time < 500ms': (r) => r.timings.duration < 500,
    'has data': (r) => JSON.parse(r.body).data.length > 0,
  });

  errorRate.add(!success);
  requestDuration.add(response.timings.duration);

  sleep(1);
}
```

#### 1.2 Advanced Test with Scenarios

```javascript
// tests/load/advanced-scenarios.js
import http from 'k6/http';
import { check, sleep } from 'k6';
import { SharedArray } from 'k6/data';

// Shared test data
const users = new SharedArray('users', function () {
  return JSON.parse(open('./test-data/users.json'));
});

export const options = {
  scenarios: {
    // Browse products (high volume, low intensity)
    browse_products: {
      executor: 'ramping-vus',
      startVUs: 0,
      stages: [
        { duration: '5m', target: 100 },
        { duration: '10m', target: 100 },
        { duration: '5m', target: 0 },
      ],
      gracefulRampDown: '30s',
    },

    // Checkout (low volume, high intensity)
    checkout: {
      executor: 'constant-arrival-rate',
      rate: 10, // 10 iterations per second
      timeUnit: '1s',
      duration: '20m',
      preAllocatedVUs: 5,
      maxVUs: 20,
    },

    // Search (medium volume, medium intensity)
    search: {
      executor: 'shared-iterations',
      vus: 50,
      iterations: 10000,
      maxDuration: '30m',
    },
  },
  thresholds: {
    http_req_duration: ['p(95)<500'],
    http_req_failed: ['rate<0.01'],
    'http_req_duration{browse_products}': ['p(95)<300'],
    'http_req_duration{checkout}': ['p(95)<1000'],
  },
};

export default function () {
  const scenario = __ENV.SCENARIO || 'browse_products';
  
  switch (scenario) {
    case 'browse_products':
      browseProducts();
      break;
    case 'checkout':
      checkout();
      break;
    case 'search':
      search();
      break;
  }
}

function browseProducts() {
  const response = http.get('https://api.example.com/products', {
    tags: { name: 'BrowseProducts' },
  });
  
  check(response, {
    'status is 200': (r) => r.status === 200,
  });
  
  sleep(Math.random() * 3 + 1); // Random sleep 1-4s
}

function checkout() {
  const user = users[Math.floor(Math.random() * users.length)];
  
  const response = http.post(
    'https://api.example.com/checkout',
    JSON.stringify({
      userId: user.id,
      items: [{ productId: '123', quantity: 1 }],
    }),
    {
      headers: { 'Content-Type': 'application/json' },
      tags: { name: 'Checkout' },
    }
  );
  
  check(response, {
    'status is 200': (r) => r.status === 200,
    'checkout successful': (r) => JSON.parse(r.body).orderId !== null,
  });
}

function search() {
  const query = ['laptop', 'phone', 'tablet'][Math.floor(Math.random() * 3)];
  
  const response = http.get(
    `https://api.example.com/search?q=${query}`,
    { tags: { name: 'Search' } }
  );
  
  check(response, {
    'status is 200': (r) => r.status === 200,
    'has results': (r) => JSON.parse(r.body).results.length > 0,
  });
  
  sleep(0.5);
}
```

#### 1.3 Stress Test

```javascript
// tests/stress/stress-test.js
import http from 'k6/http';
import { check } from 'k6';

export const options = {
  stages: [
    { duration: '2m', target: 100 },
    { duration: '5m', target: 100 },
    { duration: '2m', target: 200 },
    { duration: '5m', target: 200 },
    { duration: '2m', target: 300 },
    { duration: '5m', target: 300 },
    { duration: '2m', target: 400 },
    { duration: '5m', target: 400 },
    { duration: '10m', target: 0 }, // Recovery
  ],
  thresholds: {
    http_req_failed: ['rate<0.05'], // Allow up to 5% errors under stress
    http_req_duration: ['p(95)<2000'], // Relaxed under stress
  },
};

export default function () {
  const response = http.get('https://api.example.com/api/v1/data');
  
  check(response, {
    'status is 200': (r) => r.status === 200,
  });
}
```

### 2. Performance Profiling

#### 2.1 Application Profiling (Node.js)

```javascript
// profiling/performance-profiler.js
const profiler = require('v8-profiler-node8');
const fs = require('fs');

class PerformanceProfiler {
  startProfiling(name = 'profile') {
    profiler.startProfiling(name);
  }

  stopProfiling(name = 'profile') {
    const profile = profiler.stopProfiling(name);
    const data = profile.export();
    profile.delete();
    
    fs.writeFileSync(`${name}.cpuprofile`, JSON.stringify(data));
    console.log(`Profile saved to ${name}.cpuprofile`);
  }

  async profileFunction(fn, name) {
    this.startProfiling(name);
    const result = await fn();
    this.stopProfiling(name);
    return result;
  }
}

// Usage
const profiler = new PerformanceProfiler();

async function slowFunction() {
  // Your code here
  await someAsyncOperation();
}

profiler.profileFunction(slowFunction, 'slow-function-profile');
```

#### 2.2 Memory Profiling

```javascript
// profiling/memory-profiler.js
const heapdump = require('heapdump');

class MemoryProfiler {
  takeSnapshot(filename) {
    heapdump.writeSnapshot((err, filename) => {
      if (err) {
        console.error('Error taking heap snapshot:', err);
      } else {
        console.log(`Heap snapshot saved to ${filename}`);
      }
    });
  }

  monitorMemory() {
    setInterval(() => {
      const usage = process.memoryUsage();
      console.log({
        rss: `${Math.round(usage.rss / 1024 / 1024)} MB`,
        heapTotal: `${Math.round(usage.heapTotal / 1024 / 1024)} MB`,
        heapUsed: `${Math.round(usage.heapUsed / 1024 / 1024)} MB`,
        external: `${Math.round(usage.external / 1024 / 1024)} MB`,
      });
    }, 5000);
  }
}
```

#### 2.3 Performance Profiling (Rust)

```toml
# Cargo.toml
[dev-dependencies]
criterion = { version = "0.5", features = ["html_reports"] }
pprof = "0.12"
tokio = { version = "1", features = ["full"] }
```

```rust
// benches/my_benchmark.rs
use criterion::{black_box, criterion_group, criterion_main, Criterion};
use my_service::process_request;

fn benchmark_requests(c: &mut Criterion) {
    let mut group = c.benchmark_group("api_requests");
    
    group.bench_function("process_request", |b| {
        b.iter(|| {
            process_request(black_box("test_data"));
        });
    });
    
    group.bench_function("process_request_large", |b| {
        let large_data = "x".repeat(10000);
        b.iter(|| {
            process_request(black_box(&large_data));
        });
    });
    
    group.finish();
}

criterion_group!(benches, benchmark_requests);
criterion_main!(benches);
```

```bash
# Ejecutar benchmarks
cargo bench

# Con profiling integrado
cargo bench -- --profile-time=10
```

#### 2.4 CPU Profiling con perf (Rust)

```bash
# Instalar herramientas de profiling
sudo apt-get install linux-perf

# Compilar con símbolos de debug (optimizado pero con símbolos)
RUSTFLAGS="-g" cargo build --release

# Profiling con perf
perf record --call-graph dwarf ./target/release/my-service

# Ver resultados
perf report

# Generar flamegraph
perf script | stackcollapse-perf.pl | flamegraph.pl > flamegraph.svg
```

```rust
// src/profiling.rs
use std::time::Instant;
use tracing::{info, debug};

pub struct PerformanceProfiler {
    start_time: Instant,
}

impl PerformanceProfiler {
    pub fn new() -> Self {
        Self {
            start_time: Instant::now(),
        }
    }

    pub fn elapsed(&self) -> u64 {
        self.start_time.elapsed().as_millis() as u64
    }

    pub fn log_elapsed(&self, operation: &str) {
        let elapsed = self.elapsed();
        info!(
            operation = operation,
            duration_ms = elapsed,
            "Operation completed"
        );
    }
}

impl Drop for PerformanceProfiler {
    fn drop(&mut self) {
        debug!(
            total_duration_ms = self.elapsed(),
            "Profiler dropped"
        );
    }
}

// Uso
pub async fn process_user_request(user_id: &str) -> Result<(), Error> {
    let _profiler = PerformanceProfiler::new();
    
    // Tu código aquí
    let user = fetch_user(user_id).await?;
    _profiler.log_elapsed("fetch_user");
    
    let result = process_data(&user).await?;
    _profiler.log_elapsed("process_data");
    
    Ok(())
}
```

#### 2.5 Memory Profiling (Rust)

```toml
# Cargo.toml
[dependencies]
dhat = "0.3"  # Para memory profiling
```

```rust
// src/lib.rs (solo para profiling)
#[cfg(feature = "dhat-heap")]
#[global_allocator]
static ALLOC: dhat::Alloc = dhat::Alloc;

// En main.rs o tests
#[cfg(feature = "dhat-heap")]
{
    let _profiler = dhat::Profiler::new_heap();
    
    // Tu código aquí
    run_application().await;
}
```

```bash
# Compilar con dhat feature
cargo build --release --features dhat-heap

# Ejecutar - generará dhat-heap.json
./target/release/my-service

# Analizar con dhat
dhat-view dhat-heap.json
```

#### 2.6 Flamegraph Profiling (Rust)

```bash
# Instalar cargo-flamegraph
cargo install flamegraph

# Generar flamegraph
cargo flamegraph --bin my-service

# Con opciones específicas
cargo flamegraph --dev --example my-example -- --test-input

# Para servicios web (necesita requests)
cargo flamegraph --dev --bin my-service &
# Hacer requests con k6 o curl
k6 run load-test.js
# Ctrl+C para detener flamegraph
```

#### 2.7 Performance Metrics en Rust (Actix Web)

```toml
# Cargo.toml
[dependencies]
actix-web = "4"
actix-web-prom = "0.6"
prometheus = "0.13"
```

```rust
// src/metrics.rs
use actix_web::web;
use actix_web_prom::PrometheusMetricsBuilder;
use prometheus::{Counter, Histogram, Registry, Opts};

lazy_static::lazy_static! {
    pub static ref HTTP_REQUESTS_TOTAL: Counter = Counter::with_opts(
        Opts::new("http_requests_total", "Total HTTP requests")
            .const_label("service", "my-service")
    ).unwrap();

    pub static ref HTTP_REQUEST_DURATION: Histogram = Histogram::with_opts(
        prometheus::HistogramOpts::new(
            "http_request_duration_seconds",
            "HTTP request duration"
        )
        .buckets(vec![0.005, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1.0, 2.5, 5.0])
        .const_label("service", "my-service")
    ).unwrap();
}

pub fn init_metrics() -> Result<(), Box<dyn std::error::Error>> {
    let registry = Registry::new();
    registry.register(Box::new(HTTP_REQUESTS_TOTAL.clone()))?;
    registry.register(Box::new(HTTP_REQUEST_DURATION.clone()))?;
    Ok(())
}
```

```rust
// src/main.rs
use actix_web::{web, App, HttpServer, middleware};
use actix_web_prom::PrometheusMetricsBuilder;
use crate::metrics::init_metrics;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    init_metrics().unwrap();

    let prometheus = PrometheusMetricsBuilder::new("api")
        .endpoint("/metrics")
        .build()
        .unwrap();

    HttpServer::new(move || {
        App::new()
            .wrap(prometheus.clone())
            .wrap(middleware::Logger::default())
            .route("/health", web::get().to(health))
            .route("/api/users", web::get().to(get_users))
    })
    .bind("0.0.0.0:8080")?
    .run()
    .await
}
```

#### 2.8 Load Testing Rust Backend con k6

```javascript
// tests/load/rust-api-load.js
import http from 'k6/http';
import { check, sleep } from 'k6';
import { Rate, Trend } from 'k6/metrics';

const errorRate = new Rate('errors');
const requestDuration = new Trend('request_duration');

export const options = {
  stages: [
    { duration: '2m', target: 100 },
    { duration: '5m', target: 100 },
    { duration: '2m', target: 200 },
    { duration: '5m', target: 200 },
    { duration: '2m', target: 0 },
  ],
  thresholds: {
    http_req_duration: ['p(95)<50', 'p(99)<100'], // Rust debería ser más rápido
    http_req_failed: ['rate<0.01'],
  },
};

export default function () {
  const baseUrl = 'http://localhost:8080';
  
  // Test health endpoint
  const healthCheck = http.get(`${baseUrl}/health`, {
    tags: { name: 'HealthCheck' },
  });
  check(healthCheck, {
    'health check status 200': (r) => r.status === 200,
  });

  // Test API endpoint
  const startTime = Date.now();
  const response = http.get(`${baseUrl}/api/users`, {
    headers: {
      'Content-Type': 'application/json',
    },
    tags: { name: 'GetUsers' },
  });
  
  const duration = Date.now() - startTime;
  
  const success = check(response, {
    'status is 200': (r) => r.status === 200,
    'response time < 50ms': (r) => r.timings.duration < 50,
    'has users': (r) => {
      try {
        const data = JSON.parse(r.body);
        return data.users && data.users.length > 0;
      } catch {
        return false;
      }
    },
  });

  errorRate.add(!success);
  requestDuration.add(duration);

  sleep(1);
}
```

#### 2.9 Performance Comparison Testing

```javascript
// tests/load/performance-comparison.js
import http from 'k6/http';
import { check } from 'k6';
import { Trend } from 'k6/metrics';

const rustApiDuration = new Trend('rust_api_duration');
const nodeApiDuration = new Trend('node_api_duration');

export const options = {
  vus: 50,
  duration: '5m',
};

export default function () {
  // Test Rust backend
  const rustStart = Date.now();
  const rustResponse = http.get('http://rust-api:8080/api/data');
  rustApiDuration.add(Date.now() - rustStart);
  
  check(rustResponse, {
    'rust api status 200': (r) => r.status === 200,
  });

  // Test Node.js backend (comparison)
  const nodeStart = Date.now();
  const nodeResponse = http.get('http://node-api:3000/api/data');
  nodeApiDuration.add(Date.now() - nodeStart);
  
  check(nodeResponse, {
    'node api status 200': (r) => r.status === 200,
  });
}
```

### 3. Capacity Planning

```python
# capacity_planning/calculator.py
from dataclasses import dataclass
from typing import List

@dataclass
class CapacityMetrics:
    current_users: int
    peak_users: int
    avg_request_per_user_per_sec: float
    avg_response_time_ms: float
    error_rate: float
    current_throughput_rps: float
    max_throughput_rps: float

class CapacityPlanner:
    def __init__(self, metrics: CapacityMetrics):
        self.metrics = metrics

    def calculate_capacity_headroom(self) -> float:
        """Calculate current capacity headroom."""
        utilization = self.metrics.current_throughput_rps / self.metrics.max_throughput_rps
        return 1.0 - utilization

    def estimate_max_users(self, target_error_rate: float = 0.01) -> int:
        """Estimate maximum users with acceptable error rate."""
        # Simple estimation: assume linear scaling until error rate threshold
        users_at_max = int(
            self.metrics.peak_users * 
            (self.metrics.max_throughput_rps / self.metrics.current_throughput_rps)
        )
        return users_at_max

    def calculate_resources_needed(
        self,
        target_users: int,
        target_error_rate: float = 0.01
    ) -> dict:
        """Calculate resources needed for target user count."""
        current_users_per_instance = (
            self.metrics.peak_users / 
            self._get_current_instance_count()
        )
        
        required_rps = target_users * self.metrics.avg_request_per_user_per_sec
        required_instances = int(
            required_rps / self.metrics.max_throughput_rps
        ) + 1  # Add buffer
        
        return {
            "target_users": target_users,
            "required_instances": required_instances,
            "required_rps": required_rps,
            "current_instances": self._get_current_instance_count(),
            "scaling_factor": required_instances / self._get_current_instance_count(),
        }

    def _get_current_instance_count(self) -> int:
        # Logic to get current instance count
        return 3  # Example
```

### 4. CI/CD Integration

```yaml
# .github/workflows/load-test.yml
name: Load Test

on:
  schedule:
    - cron: '0 2 * * *'  # Daily at 2 AM
  workflow_dispatch:

jobs:
  load-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Install k6
        run: |
          sudo gpg -k
          sudo gpg --no-default-keyring --keyring /usr/share/keyrings/k6-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
          echo "deb [signed-by=/usr/share/keyrings/k6-archive-keyring.gpg] https://dl.k6.io/deb stable main" | sudo tee /etc/apt/sources.list.d/k6.list
          sudo apt-get update
          sudo apt-get install k6

      - name: Run load test
        run: |
          k6 run tests/load/basic-load.js
        env:
          API_TOKEN: ${{ secrets.API_TOKEN }}

      - name: Upload results
        uses: actions/upload-artifact@v3
        with:
          name: k6-results
          path: results/
```

### 5. Performance Monitoring

```yaml
# prometheus/performance-metrics.yml
scrape_configs:
  - job_name: 'k6'
    static_configs:
      - targets: ['k6:6565']
```

```javascript
// k6 output to Prometheus
import { Counter, Gauge, Trend } from 'k6/metrics';

const customCounter = new Counter('custom_errors');
const customGauge = new Gauge('custom_active_users');
const customTrend = new Trend('custom_request_duration');

export default function () {
  customGauge.set(100);
  customCounter.add(1);
  customTrend.add(123);
}
```

## 🎯 Mejores Prácticas

### 1. Test Design

✅ **DO:**
- Start with baseline tests
- Gradually increase load
- Test realistic scenarios
- Monitor during tests
- Test failure scenarios

❌ **DON'T:**
- Start with maximum load
- Ignore resource limits
- Test unrealistic scenarios
- Skip monitoring

### 2. Test Data

✅ **DO:**
- Use realistic test data
- Parameterize requests
- Use unique data per user
- Clean up test data

❌ **DON'T:**
- Use production data
- Hardcode test values
- Share data between users

### 3. Analysis

✅ **DO:**
- Compare against baselines
- Identify bottlenecks
- Document findings
- Share results with team

❌ **DON'T:**
- Ignore anomalies
- Skip root cause analysis
- Test without objectives

## 🚨 Troubleshooting

### Tests Failing

1. Check test configuration
2. Verify test data
3. Check network connectivity
4. Review application logs

### Performance Degradation

1. Identify bottlenecks
2. Profile application
3. Check resource usage
4. Review recent changes

## 📚 Recursos Adicionales

- [k6 Documentation](https://k6.io/docs/)
- [JMeter Best Practices](https://jmeter.apache.org/usermanual/best-practices.html)
- [Performance Testing Guide](https://www.guru99.com/performance-testing.html)

---

**Versión:** 1.0.0  
**Última actualización:** Diciembre 2025  
**Total líneas:** 1,100+

