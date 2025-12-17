# 🔍 Skill: Static Analysis

## 📋 Metadata

| Atributo | Valor |
|----------|-------|
| **ID** | `static-analysis` |
| **Nivel** | 🟡 Intermedio |
| **Versión** | 1.0.0 |
| **Keywords** | `static-analysis`, `analyze`, `lint`, `code-quality`, `sast`, `security-scan` |
| **Referencia** | [Dart Analysis Tools](https://dart.dev/tools/analysis) |

## 🔑 Keywords para Invocación

- `static-analysis`
- `analyze`
- `lint`
- `code-quality`
- `sast`
- `security-scan`
- `dart-analyze`
- `@skill:static-analysis`

### Ejemplos de Prompts

```
Configura análisis estático para el proyecto
```

```
Agrega herramientas de análisis de código y seguridad
```

```
@skill:static-analysis - Integra Dart Analyzer, Datadog y CodeRabbit
```

## 📖 Descripción

Skill para configurar y utilizar herramientas de análisis estático de código que detectan errores, vulnerabilidades de seguridad, problemas de calidad y code smells antes de que el código llegue a producción. Incluye integración con herramientas nativas de Dart, plataformas de seguridad como Datadog y herramientas de revisión de código con IA como CodeRabbit.

### ✅ Cuándo Usar Este Skill

- Necesitas detectar errores y vulnerabilidades temprano
- Quieres mantener alta calidad de código
- Requieres análisis de seguridad automatizado
- Deseas integrar análisis en CI/CD pipelines
- Necesitas métricas de calidad de código

### ❌ Cuándo NO Usar Este Skill

- Proyectos muy pequeños o prototipos rápidos
- Cuando el overhead de análisis es prohibitivo
- Proyectos legacy que requieren migración gradual

## 🛠️ Herramientas Incluidas

### 1. Dart Analysis Tools

Herramientas nativas de Dart para análisis estático de código.

**Referencia:** [Dart Analysis Tools](https://dart.dev/tools/analysis)

#### Comandos Principales

```bash
# Análisis estático básico
dart analyze

# Análisis con salida JSON
dart analyze --format=json

# Análisis con fatal-infos (falla si hay infos)
dart analyze --fatal-infos

# Análisis de un directorio específico
dart analyze lib/

# Verificar formato de código
dart format --set-exit-if-changed .
```

#### Configuración: analysis_options.yaml

```yaml
# analysis_options.yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
    - "**/*.mocks.dart"
  errors:
    invalid_annotation_target: ignore
  language:
    strict-casts: true
    strict-inference: true
    strict-raw-types: true

linter:
  rules:
    # Errores comunes
    - always_declare_return_types
    - avoid_print
    - avoid_unnecessary_containers
    - prefer_const_constructors
    - prefer_const_literals_to_create_immutables
    
    # Seguridad
    - avoid_web_libraries_in_flutter
    - no_duplicate_case_values
    
    # Calidad
    - prefer_single_quotes
    - require_trailing_commas
    - sort_pub_dependencies
```

#### Integración en CI/CD

```yaml
# .github/workflows/analyze.yml
name: Static Analysis

on: [push, pull_request]

jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Dart
        uses: dart-lang/setup-dart@v1
        with:
          dart-version: '3.0.0'
      
      - name: Install dependencies
        run: dart pub get
      
      - name: Verify formatting
        run: dart format --output=none --set-exit-if-changed .
      
      - name: Analyze code
        run: dart analyze --fatal-infos
```

### 2. Datadog Static Analysis Engine

Plataforma de análisis estático de código (SAST) que detecta vulnerabilidades de seguridad y problemas de calidad.

**Referencia:** [Datadog Static Analysis](https://docs.datadoghq.com/es/security/code_security/static_analysis/static_analysis_rules/)

#### Características Principales

- **Detección de vulnerabilidades:** Identifica problemas de seguridad comunes
- **Integración IDE:** Plugins para VS Code, IntelliJ, etc.
- **CI/CD Integration:** Integración nativa con pipelines
- **Reglas personalizables:** Configuración de reglas específicas del proyecto
- **Reportes detallados:** Dashboard con métricas y tendencias

#### Configuración Básica

```yaml
# datadog-static-analysis.yml
version: '1.0'

rules:
  # Reglas de seguridad
  - id: sql-injection
    severity: high
    enabled: true
  
  - id: xss-vulnerability
    severity: high
    enabled: true
  
  # Reglas de calidad
  - id: code-smell
    severity: medium
    enabled: true
  
  - id: performance-issue
    severity: low
    enabled: true

exclude:
  - "**/*.g.dart"
  - "**/generated/**"
```

#### Integración en CI/CD

```yaml
# .github/workflows/datadog-sast.yml
name: Datadog SAST

on: [push, pull_request]

jobs:
  datadog-sast:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Run Datadog Static Analysis
        uses: datadog/static-analysis-action@v1
        with:
          api-key: ${{ secrets.DATADOG_API_KEY }}
          app-key: ${{ secrets.DATADOG_APP_KEY }}
          fail-on-error: true
```

#### Configuración en VS Code

```json
// .vscode/settings.json
{
  "datadog.staticAnalysis.enabled": true,
  "datadog.staticAnalysis.severity": {
    "high": "error",
    "medium": "warning",
    "low": "info"
  },
  "datadog.staticAnalysis.exclude": [
    "**/*.g.dart",
    "**/generated/**"
  ]
}
```

### 3. CodeRabbit CLI

Herramienta de revisión de código impulsada por IA que detecta problemas antes de commits.

**Referencia:** [CodeRabbit CLI](https://docs.coderabbit.ai/cli/overview)

#### Instalación

```bash
# Instalación global
npm install -g @coderabbitai/cli

# O con yarn
yarn global add @coderabbitai/cli

# Verificar instalación
coderabbit --version
```

#### Configuración Básica

```yaml
# .coderabbit.yaml
language: dart
framework: flutter

rules:
  enabled:
    - security
    - performance
    - best-practices
    - code-quality
  
  disabled:
    - style-only

severity:
  critical: error
  high: error
  medium: warning
  low: info

exclude:
  - "**/*.g.dart"
  - "**/*.freezed.dart"
  - "test/**"
```

#### Uso Básico

```bash
# Análisis de cambios en staging
coderabbit review --staged

# Análisis de un commit específico
coderabbit review --commit HEAD

# Análisis de un rango de commits
coderabbit review --range main..feature-branch

# Análisis completo del proyecto
coderabbit review --all

# Análisis con salida JSON
coderabbit review --staged --format json

# Análisis con configuración personalizada
coderabbit review --config .coderabbit.yaml
```

#### Integración en Git Hooks

```bash
#!/bin/sh
# .git/hooks/pre-commit

# Ejecutar CodeRabbit en archivos staged
coderabbit review --staged --fail-on-error

if [ $? -ne 0 ]; then
  echo "❌ CodeRabbit encontró problemas. Por favor, corrígelos antes de commitear."
  exit 1
fi
```

#### Integración en CI/CD

```yaml
# .github/workflows/coderabbit.yml
name: CodeRabbit Review

on: [pull_request]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
      
      - name: Install CodeRabbit CLI
        run: npm install -g @coderabbitai/cli
      
      - name: Run CodeRabbit Review
        env:
          CODERABBIT_API_KEY: ${{ secrets.CODERABBIT_API_KEY }}
        run: |
          coderabbit review \
            --range ${{ github.event.pull_request.base.sha }}..${{ github.event.pull_request.head.sha }} \
            --format json \
            --output coderabbit-report.json
      
      - name: Upload Report
        uses: actions/upload-artifact@v3
        with:
          name: coderabbit-report
          path: coderabbit-report.json
```

## 🏗️ Estructura de Configuración

```
project-root/
├── analysis_options.yaml          # Configuración Dart Analyzer
├── .coderabbit.yaml                # Configuración CodeRabbit
├── datadog-static-analysis.yml     # Configuración Datadog SAST
├── .github/
│   └── workflows/
│       ├── analyze.yml             # Workflow Dart Analyzer
│       ├── datadog-sast.yml        # Workflow Datadog
│       └── coderabbit.yml          # Workflow CodeRabbit
└── .git/
    └── hooks/
        └── pre-commit              # Git hook con CodeRabbit
```

## 📊 Flujo de Trabajo Recomendado

### Desarrollo Local

1. **Pre-commit Hook:** CodeRabbit revisa cambios antes de commit
2. **IDE Integration:** Datadog muestra problemas en tiempo real
3. **Verificación Manual:** `dart analyze` antes de push

### CI/CD Pipeline

1. **Dart Analyzer:** Verificación de formato y análisis estático
2. **Datadog SAST:** Escaneo de seguridad y vulnerabilidades
3. **CodeRabbit Review:** Análisis de cambios en PRs

### Post-Deployment

1. **Monitoreo Continuo:** Datadog dashboard con métricas
2. **Reportes Periódicos:** Análisis de tendencias de calidad
3. **Retroalimentación:** Mejora continua de reglas

## 🎯 Mejores Prácticas

### 1. Configuración Gradual

```yaml
# Comienza con reglas básicas y aumenta gradualmente
linter:
  rules:
    # Fase 1: Reglas críticas
    - avoid_print
    - avoid_unnecessary_containers
    
    # Fase 2: Agregar después de estabilizar
    # - prefer_const_constructors
    # - require_trailing_commas
```

### 2. Exclusiones Inteligentes

```yaml
analyzer:
  exclude:
    # Código generado
    - "**/*.g.dart"
    - "**/*.freezed.dart"
    
    # Dependencias externas
    - ".dart_tool/**"
    - "build/**"
    
    # Archivos de configuración
    - "**/*.config.dart"
```

### 3. Severidad Configurada

```yaml
analyzer:
  errors:
    # Errores críticos
    missing_return: error
    invalid_assignment: error
    
    # Warnings importantes
    unused_element: warning
    dead_code: warning
    
    # Infos informativos
    todo: info
```

### 4. Integración en Desarrollo

```dart
// Usar comentarios para supresión controlada
// ignore: avoid_print
print('Debug info'); // Solo cuando sea necesario

// ignore_for_file: prefer_const_constructors
// Para archivos generados o legacy
```

## 🔧 Solución de Problemas

### Dart Analyzer muy lento

```yaml
# analysis_options.yaml
analyzer:
  exclude:
    - "**/*.g.dart"
    - "build/**"
  # Reducir profundidad de análisis
  strong-mode:
    implicit-casts: false
```

### Falsos positivos en Datadog

```yaml
# datadog-static-analysis.yml
rules:
  - id: false-positive-rule
    enabled: false
    # O ajustar severidad
    severity: low
```

### CodeRabbit no detecta cambios

```bash
# Asegurar que los cambios están staged
git add .
coderabbit review --staged

# O especificar rango explícito
coderabbit review --range HEAD~1..HEAD
```

## 📚 Recursos Adicionales

- [Dart Analysis Tools Documentation](https://dart.dev/tools/analysis)
- [Datadog Static Analysis Rules](https://docs.datadoghq.com/es/security/code_security/static_analysis/static_analysis_rules/)
- [CodeRabbit CLI Documentation](https://docs.coderabbit.ai/cli/overview)
- [Flutter Lints Package](https://pub.dev/packages/flutter_lints)
- [Dart Code Metrics](https://pub.dev/packages/dart_code_metrics)

## 🎓 Ejemplos de Uso

### Ejemplo 1: Setup Inicial Completo

```bash
# 1. Crear analysis_options.yaml
cat > analysis_options.yaml << EOF
include: package:flutter_lints/flutter.yaml

analyzer:
  exclude:
    - "**/*.g.dart"
  language:
    strict-casts: true

linter:
  rules:
    - avoid_print
    - prefer_const_constructors
EOF

# 2. Instalar CodeRabbit
npm install -g @coderabbitai/cli

# 3. Crear configuración CodeRabbit
cat > .coderabbit.yaml << EOF
language: dart
framework: flutter
rules:
  enabled:
    - security
    - performance
EOF

# 4. Verificar análisis
dart analyze
coderabbit review --all
```

### Ejemplo 2: Integración en CI/CD

```yaml
# .github/workflows/static-analysis.yml
name: Static Analysis Suite

on: [push, pull_request]

jobs:
  dart-analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: dart-lang/setup-dart@v1
      - run: dart pub get
      - run: dart format --set-exit-if-changed .
      - run: dart analyze --fatal-infos

  datadog-sast:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: datadog/static-analysis-action@v1
        with:
          api-key: ${{ secrets.DATADOG_API_KEY }}

  coderabbit-review:
    runs-on: ubuntu-latest
    if: github.event_name == 'pull_request'
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - uses: actions/setup-node@v4
      - run: npm install -g @coderabbitai/cli
      - run: |
          coderabbit review \
            --range ${{ github.event.pull_request.base.sha }}..${{ github.event.pull_request.head.sha }}
```

---

**Última actualización:** Diciembre 2025  
**Versión:** 1.0.0

