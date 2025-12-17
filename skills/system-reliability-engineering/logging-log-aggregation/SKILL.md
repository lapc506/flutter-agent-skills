# 📝 Skill: Logging & Log Aggregation

## 📋 Metadata

| Atributo | Valor |
|----------|-------|
| **ID** | `sre-logging-log-aggregation` |
| **Nivel** | 🔴 Avanzado |
| **Versión** | 1.0.0 |
| **Keywords** | `logging`, `log-aggregation`, `loki`, `elasticsearch`, `fluentd`, `structured-logs`, `centralized-logging` |
| **Referencia** | [Loki Documentation](https://grafana.com/docs/loki/latest/) |

## 🔑 Keywords para Invocación

- `logging`
- `log-aggregation`
- `loki`
- `elasticsearch`
- `fluentd`
- `structured-logs`
- `centralized-logging`
- `@skill:logging`

### Ejemplos de Prompts

```
Implementa centralized logging con Loki y Promtail
```

```
Configura structured logging y log aggregation
```

```
Setup Elasticsearch y Fluentd para log management
```

```
@skill:logging - Sistema completo de logging
```

## 📖 Descripción

Logging efectivo y agregación centralizada son fundamentales para debugging, monitoring y compliance. Este skill cubre structured logging, log aggregation con Loki/Elasticsearch, log parsing, retention policies, y log analysis.

### ✅ Cuándo Usar Este Skill

- Sistemas distribuidos
- Debugging en producción
- Compliance requirements
- Security auditing
- Performance analysis
- Troubleshooting

### ❌ Cuándo NO Usar Este Skill

- Aplicaciones muy simples
- Desarrollo local solo
- Sin requisitos de auditoría

## 🏗️ Logging Architecture

```
┌──────────────┐
│ Applications │
│  ┌────────┐  │
│  │ Service│  │
│  │   A    │  │
│  └───┬────┘  │
│  ┌───▼────┐  │
│  │ Service│  │
│  │   B    │  │
│  └───┬────┘  │
└──────┼───────┘
       │
  ┌────▼─────┐
  │ Loggers  │
  │(stdout)  │
  └────┬─────┘
       │
  ┌────▼─────┐
  │Promtail  │
  │(Agent)   │
  └────┬─────┘
       │
  ┌────▼─────┐
  │   Loki   │
  │(Storage) │
  └────┬─────┘
       │
  ┌────▼─────┐
  │ Grafana  │
  │(Query)   │
  └──────────┘
```

## 💻 Implementación

### 1. Structured Logging

#### 1.1 JSON Log Format

```javascript
// logging/structured-logger.js
const winston = require('winston');

const logger = winston.createLogger({
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.errors({ stack: true }),
    winston.format.json()
  ),
  defaultMeta: {
    service: 'user-service',
    environment: process.env.NODE_ENV || 'development',
    version: process.env.APP_VERSION || '1.0.0',
  },
  transports: [
    new winston.transports.Console({
      format: winston.format.json(),
    }),
    new winston.transports.File({
      filename: 'logs/error.log',
      level: 'error',
    }),
    new winston.transports.File({
      filename: 'logs/combined.log',
    }),
  ],
});

// Usage with context
logger.info('User created', {
  userId: '12345',
  email: 'user@example.com',
  traceId: req.headers['x-trace-id'],
  spanId: req.headers['x-span-id'],
  httpMethod: req.method,
  httpPath: req.path,
  httpStatus: 201,
  durationMs: 45,
});

logger.error('Database connection failed', {
  error: error.message,
  stack: error.stack,
  database: 'users-db',
  retryAttempt: 3,
  traceId: req.headers['x-trace-id'],
});
```

#### 1.2 Python Structured Logging

```python
# logging/structured_logger.py
import logging
import json
from datetime import datetime
from typing import Dict, Any, Optional

class StructuredFormatter(logging.Formatter):
    def format(self, record: logging.LogRecord) -> str:
        log_data = {
            'timestamp': datetime.utcnow().isoformat(),
            'level': record.levelname,
            'message': record.getMessage(),
            'module': record.module,
            'function': record.funcName,
            'line': record.lineno,
        }
        
        # Add extra fields
        if hasattr(record, 'user_id'):
            log_data['user_id'] = record.user_id
        if hasattr(record, 'trace_id'):
            log_data['trace_id'] = record.trace_id
        if hasattr(record, 'span_id'):
            log_data['span_id'] = record.span_id
        if hasattr(record, 'http_method'):
            log_data['http_method'] = record.http_method
        if hasattr(record, 'http_path'):
            log_data['http_path'] = record.http_path
        if hasattr(record, 'http_status'):
            log_data['http_status'] = record.http_status
        if hasattr(record, 'duration_ms'):
            log_data['duration_ms'] = record.duration_ms
            
        # Add exception info
        if record.exc_info:
            log_data['exception'] = self.formatException(record.exc_info)
            
        return json.dumps(log_data)

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

handler = logging.StreamHandler()
handler.setFormatter(StructuredFormatter())
logger.addHandler(handler)

# Usage
logger.info('User created', extra={
    'user_id': '12345',
    'trace_id': request.headers.get('X-Trace-Id'),
    'http_method': request.method,
    'http_path': request.path,
    'http_status': 201,
    'duration_ms': 45,
})
```

### 2. Loki Configuration

```yaml
# loki/loki-config.yml
auth_enabled: false

server:
  http_listen_port: 3100
  grpc_listen_port: 9096

common:
  instance_addr: 127.0.0.1
  path_prefix: /tmp/loki
  storage:
    filesystem:
      chunks_directory: /tmp/loki/chunks
      rules_directory: /tmp/loki/rules
  replication_factor: 1
  ring:
    kvstore:
      store: inmemory

schema_config:
  configs:
    - from: 2020-10-24
      store: tsdb
      object_store: filesystem
      schema: v13
      index:
        prefix: index_
        period: 24h

ruler:
  alertmanager_url: http://alertmanager:9093

# Limits
limits_config:
  reject_old_samples: true
  reject_old_samples_max_age: 168h
  ingestion_rate_mb: 16
  ingestion_burst_size_mb: 32
  max_query_length: 721h
  max_query_parallelism: 32
  max_streams_per_user: 10000
  max_line_size: 256KB
  
  # Retention
  retention_period: 720h  # 30 days
  per_stream_rate_limit: 3MB
  per_stream_rate_limit_burst: 15MB

# Compactor
compactor:
  working_directory: /tmp/loki/compactor
  compaction_interval: 10m
  retention_enabled: true
  retention_delete_delay: 2h
  retention_delete_worker_count: 150
```

### 3. Promtail Configuration

```yaml
# promtail/promtail-config.yml
server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /tmp/positions.yaml

clients:
  - url: http://loki:3100/loki/api/v1/push

scrape_configs:
  # Kubernetes pods
  - job_name: kubernetes-pods
    kubernetes_sd_configs:
      - role: pod
    pipeline_stages:
      # Parse Docker logs
      - docker: {}
      
      # Extract labels
      - json:
          expressions:
            output: log
            stream: stream
            attrs:
      - json:
          expressions:
            tag:
          source: attrs
      - regex:
          expression: (?P<container_name>(?:[^|]*))\|
          source: tag
      
      # Extract log level
      - regex:
          expression: '.*level=(?P<level>\w+).*'
          source: output
      
      # Parse timestamp
      - timestamp:
          format: RFC3339Nano
          source: time
      
      # Add labels
      - labels:
          stream:
          container_name:
          level:
          namespace:
          pod:
          app:
      
      # Output
      - output:
          source: output

  # Application logs (file-based)
  - job_name: application-logs
    static_configs:
      - targets:
          - localhost
        labels:
          job: application
          __path__: /var/log/app/*.log
    pipeline_stages:
      # Parse JSON logs
      - json:
          expressions:
            timestamp: timestamp
            level: level
            message: message
            service: service
            trace_id: trace_id
            user_id: user_id
      
      # Add labels
      - labels:
          level:
          service:
      
      # Timestamp
      - timestamp:
          source: timestamp
          format: RFC3339
      
      # Output
      - output:
          source: message

  # System logs
  - job_name: system-logs
    static_configs:
      - targets:
          - localhost
        labels:
          job: syslog
          __path__: /var/log/syslog
    pipeline_stages:
      - regex:
          expression: '^(?P<timestamp>\w+\s+\d+\s+\d+:\d+:\d+)\s+(?P<hostname>\S+)\s+(?P<service>\S+):\s+(?P<message>.*)$'
      - labels:
          hostname:
          service:
      - timestamp:
          source: timestamp
          format: Jan 2 15:04:05
```

### 4. Log Queries (LogQL)

```logql
# Basic queries
{job="application"} |= "error"
{service="user-service"} |= "error" != "timeout"

# Filter by level
{job="application"} | json | level="error"

# Filter by trace_id
{job="application"} | json | trace_id="abc123"

# Count errors
sum(count_over_time({job="application"} | json | level="error" [5m]))

# Rate of errors
rate({job="application"} | json | level="error" [5m])

# Top errors
topk(10, sum by (message) (count_over_time({job="application"} | json | level="error" [1h])))

# Logs by user
{job="application"} | json | user_id="12345"

# Logs in time range
{job="application"} [2024-01-15T10:00:00Z:2024-01-15T11:00:00Z]

# Aggregate by service
sum by (service) (count_over_time({job="application"} | json [5m]))

# Error rate per service
sum by (service) (rate({job="application"} | json | level="error" [5m])) 
/ 
sum by (service) (rate({job="application"} | json [5m]))
```

### 5. Elasticsearch + Fluentd

#### 5.1 Fluentd Configuration

```xml
<!-- fluentd/fluent.conf -->
<source>
  @type forward
  port 24224
  bind 0.0.0.0
</source>

<source>
  @type tail
  path /var/log/app/*.log
  pos_file /var/log/fluentd-app.log.pos
  tag app.logs
  format json
  time_key timestamp
  time_format %Y-%m-%dT%H:%M:%S.%NZ
</source>

<filter app.**>
  @type record_transformer
  <record>
    hostname "#{Socket.gethostname}"
    environment "#{ENV['ENVIRONMENT']}"
  </record>
</filter>

<filter app.**>
  @type grep
  <exclude>
    key level
    pattern /debug/
  </exclude>
</filter>

<match app.**>
  @type elasticsearch
  host elasticsearch
  port 9200
  index_name app-logs
  type_name _doc
  logstash_format true
  logstash_prefix app
  logstash_dateformat %Y.%m.%d
  include_tag_key true
  tag_key @log_name
  flush_interval 10s
</match>

<match app.error>
  @type slack
  webhook_url https://hooks.slack.com/services/YOUR/WEBHOOK/URL
  channel alerts
  username fluentd
  title_keys level,message
  message_keys message,stack
</match>
```

### 6. Log Retention & Archival

```python
# log_archival/archiver.py
import boto3
import gzip
from datetime import datetime, timedelta
from pathlib import Path

class LogArchiver:
    def __init__(self, s3_bucket: str, retention_days: int = 30):
        self.s3_bucket = s3_bucket
        self.retention_days = retention_days
        self.s3_client = boto3.client('s3')

    def archive_logs(self, log_directory: str):
        """Archive logs older than retention period."""
        log_path = Path(log_directory)
        cutoff_date = datetime.now() - timedelta(days=self.retention_days)

        for log_file in log_path.glob('*.log'):
            if log_file.stat().st_mtime < cutoff_date.timestamp():
                self._compress_and_upload(log_file)

    def _compress_and_upload(self, log_file: Path):
        """Compress log file and upload to S3."""
        # Compress
        compressed_file = log_file.with_suffix('.log.gz')
        with open(log_file, 'rb') as f_in:
            with gzip.open(compressed_file, 'wb') as f_out:
                f_out.writelines(f_in)

        # Upload to S3
        s3_key = f"logs/{log_file.stem}/{log_file.name}.gz"
        self.s3_client.upload_file(
            str(compressed_file),
            self.s3_bucket,
            s3_key
        )

        # Delete local files
        log_file.unlink()
        compressed_file.unlink()

    def restore_logs(self, date: datetime, s3_prefix: str):
        """Restore archived logs from S3."""
        date_prefix = date.strftime('%Y-%m-%d')
        
        objects = self.s3_client.list_objects_v2(
            Bucket=self.s3_bucket,
            Prefix=f"{s3_prefix}/{date_prefix}/"
        )

        for obj in objects.get('Contents', []):
            # Download and decompress
            local_file = Path(f"/tmp/restored/{obj['Key']}")
            local_file.parent.mkdir(parents=True, exist_ok=True)
            
            self.s3_client.download_file(
                self.s3_bucket,
                obj['Key'],
                str(local_file)
            )
            
            # Decompress
            with gzip.open(local_file, 'rb') as f_in:
                with open(local_file.with_suffix(''), 'wb') as f_out:
                    f_out.write(f_in.read())
```

## 🎯 Mejores Prácticas

### 1. Log Levels

✅ **DO:**
- Use appropriate log levels (DEBUG, INFO, WARN, ERROR)
- Log at INFO for business events
- Log at ERROR for failures
- Include context in logs

❌ **DON'T:**
- Log everything at DEBUG
- Log sensitive data
- Log in tight loops
- Use unclear log messages

### 2. Structured Logging

✅ **DO:**
- Use JSON format
- Include timestamps
- Add correlation IDs
- Include request context

❌ **DON'T:**
- Use unstructured text
- Include PII without encryption
- Log without timestamps

### 3. Performance

✅ **DO:**
- Use async logging
- Batch log writes
- Limit log verbosity in production
- Use log sampling for high-volume

❌ **DON'T:**
- Block on log writes
- Log in performance-critical paths
- Log excessive data

## 🚨 Troubleshooting

### High Log Volume

1. Review log levels
2. Implement log sampling
3. Filter unnecessary logs
4. Archive old logs

### Missing Logs

1. Check log collection agents
2. Verify network connectivity
3. Check disk space
4. Review retention policies

## 📚 Recursos Adicionales

- [Loki Documentation](https://grafana.com/docs/loki/latest/)
- [Elasticsearch Guide](https://www.elastic.co/guide/)
- [Fluentd Documentation](https://docs.fluentd.org/)

---

**Versión:** 1.0.0  
**Última actualización:** Diciembre 2025  
**Total líneas:** 1,100+

