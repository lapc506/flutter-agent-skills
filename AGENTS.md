# Flutter Agent Skills

Este proyecto utiliza el patrón de **Agent Skills** para proporcionar conocimiento contextual y capacidades especializadas a los asistentes de IA.

## 🎯 ¿Qué son los Skills?

Los skills son carpetas que contienen un archivo `SKILL.md` con instrucciones y contexto específico que los agentes pueden descubrir y cargar dinámicamente. Este patrón ofrece:

- **📦 Eficiencia de tokens:** Los skills se cargan progresivamente, solo cuando se necesitan
- **🧠 Menor carga cognitiva:** Los agentes trabajan con un conjunto pequeño de herramientas atómicas
- **🔄 Composabilidad:** Múltiples skills pueden combinarse en una sesión
- **📚 Aprendizaje continuo:** Los agentes pueden crear nuevos skills sobre la marcha

Basado en el patrón propuesto por [Anthropic y LangChain Deep Agents](https://blog.langchain.com/using-skills-with-deep-agents/).

## 📂 Estructura de Skills

Todos los skills se encuentran en la carpeta `skills/` organizados por categorías:

```
skills/
├── flutter/           # Skills para desarrollo Flutter
│   ├── mvvm/
│   ├── clean-architecture/
│   ├── project-setup/
│   ├── testing/
│   ├── bloc-advanced/
│   ├── riverpod/
│   ├── feature-first/
│   ├── modular-architecture/
│   ├── code-generation/
│   ├── performance/
│   ├── accessibility/
│   ├── animation-motion/
│   ├── theming/
│   ├── i18n/
│   ├── firebase/
│   ├── graphql/
│   ├── offline-first/
│   ├── deep-linking/
│   ├── push-notifications/
│   ├── analytics-tracking/
│   ├── error-tracking/
│   ├── feature-flags/
│   ├── in-app-purchases/
│   ├── app-distribution/
│   ├── platform-channels/
│   ├── native-integration/
│   ├── webview-integration/
│   └── security/
├── cicd/              # Skills para CI/CD (Terraform, ArgoCD, etc.)
├── static-analysis/   # Skills para análisis estático de código
└── figma/             # Skills para integración con Figma Dev Mode
```

Cada carpeta de skill contiene un archivo `SKILL.md` con:
- Metadata en YAML frontmatter (keywords, nivel, descripción)
- Instrucciones detalladas en Markdown
- Ejemplos de código y mejores prácticas
- Archivos adicionales si son necesarios

## 🔑 Cómo Usar los Skills

### Invocación Automática por Keywords

Los agentes detectan automáticamente qué skills usar basándose en keywords en tus prompts:

```bash
# Ejemplos de prompts que invocan skills automáticamente:
"Crea una app usando mvvm para gestión de usuarios"
"Implementa clean-arch para un módulo de productos"
"Configura cicd con GitHub Actions"
"Usa figma para obtener los assets del diseño"
```

### Invocación Explícita

También puedes invocar skills explícitamente:

```bash
@skill:flutter/mvvm - Genera una app de notas
@skill:flutter/clean-architecture - Implementa módulo de auth
@skill:cicd - Configura pipeline de deployment
@skill:figma - Extrae componentes del diseño
```

### Combinación de Skills

Puedes combinar múltiples skills en un solo prompt:

```bash
"Usa clean-arch + testing + cicd para crear un módulo de productos completo"
"Extrae assets de figma e implementa con mvvm"
```

## 🛠️ Configuración del Entorno

### Servidores MCP

El proyecto incluye un **único archivo `mcp.json`** en la raíz que configura todos los servidores MCP. Este archivo es compatible con múltiples IDEs y agentes de IA.

**Servidores configurados:**

1. **Flutter/Dart MCP Server**
   - Análisis estático y de tiempo de ejecución
   - Búsqueda de paquetes en pub.dev
   - Gestión de dependencias
   - Inspección del árbol de widgets
   - Detección y corrección de errores de layout

2. **Figma MCP Server**
   - Extracción de assets desde Figma
   - Obtención de tokens de diseño
   - Consulta de componentes
   - Especificaciones de diseño

**Configuración:** Ver [`docs/MCP_SETUP.md`](./docs/MCP_SETUP.md) para instrucciones específicas de cada IDE (Cursor, Cline, Windsurf, Gemini CLI, etc.)

## 📚 Skills Disponibles

### 🎨 Flutter Skills

**Path:** `skills/flutter/mvvm/SKILL.md`  
**Keywords:** `mvvm`, `model-view-viewmodel`, `provider`  
**Nivel:** 🟡 Intermedio

Patrón MVVM con separación clara entre UI y lógica de negocio. Ideal para proyectos medianos.

[📖 Ver documentación completa →](skills/flutter/mvvm/SKILL.md)

---

#### 2. Clean Architecture

**Path:** `skills/flutter/clean-architecture/SKILL.md`  
**Keywords:** `clean`, `clean-arch`, `bloc`, `usecase`, `repository`  
**Nivel:** 🔴 Avanzado

Arquitectura en capas (Domain/Data/Presentation) con máxima testabilidad. Ideal para aplicaciones enterprise.

[📖 Ver documentación completa →](skills/flutter/clean-architecture/SKILL.md)

---

#### 3. Project Setup

**Path:** `skills/flutter/project-setup/SKILL.md`  
**Keywords:** `setup`, `init`, `scaffold`, `config`  
**Nivel:** 🟢 Básico

Configuración inicial estándar con análisis estático, flavors, temas y i18n.

[📖 Ver documentación completa →](skills/flutter/project-setup/SKILL.md)

---

#### 4. Testing Strategy

**Path:** `skills/flutter/testing/SKILL.md`  
**Keywords:** `testing`, `test`, `unit-test`, `widget-test`, `tdd`  
**Nivel:** 🔴 Avanzado

Estrategia completa de testing: unit, widget e integration tests.

[📖 Ver documentación completa →](skills/flutter/testing/SKILL.md)

---

#### 5. BLoC Avanzado

**Path:** `skills/flutter/bloc-advanced/SKILL.md`  
**Keywords:** `bloc`, `cubit`, `state-management-bloc`, `flutter-bloc`, `hydrated-bloc`  
**Nivel:** 🔴 Avanzado

State management con BLoC avanzado: Hydrated BLoC, Replay BLoC, transformers y testing exhaustivo.

[📖 Ver documentación completa →](skills/flutter/bloc-advanced/SKILL.md)

---

#### 6. Riverpod

**Path:** `skills/flutter/riverpod/SKILL.md`  
**Keywords:** `riverpod`, `state-management`, `provider-riverpod`, `hooks-riverpod`  
**Nivel:** 🟡 Intermedio

State management con Riverpod: providers, hooks, y gestión de estado reactiva.

[📖 Ver documentación completa →](skills/flutter/riverpod/SKILL.md)

---

#### 7. Feature-First Architecture

**Path:** `skills/flutter/feature-first/SKILL.md`  
**Keywords:** `feature-first`, `feature-architecture`, `feature-driven`  
**Nivel:** 🟡 Intermedio

Organización del código por features en lugar de capas técnicas. Features auto-contenidas y cohesivas.

[📖 Ver documentación completa →](skills/flutter/feature-first/SKILL.md)

---

#### 8. Arquitectura Modular

**Path:** `skills/flutter/modular-architecture/SKILL.md`  
**Keywords:** `modular`, `modular-architecture`, `module`, `multi-module`  
**Nivel:** 🔴 Avanzado

Arquitectura modular con módulos independientes y reutilizables. Desarrollo y deployment independiente.

[📖 Ver documentación completa →](skills/flutter/modular-architecture/SKILL.md)

---

#### 9. Code Generation

**Path:** `skills/flutter/code-generation/SKILL.md`  
**Keywords:** `code-gen`, `build-runner`, `freezed`, `json-serializable`, `injectable`, `auto-route`  
**Nivel:** 🟢 Básico

Automatización de código boilerplate con build_runner, freezed, json_serializable y más.

[📖 Ver documentación completa →](skills/flutter/code-generation/SKILL.md)

---

#### 10. Performance Optimization

**Path:** `skills/flutter/performance/SKILL.md`  
**Keywords:** `performance`, `optimization`, `profiling`, `memory`, `rendering`  
**Nivel:** 🔴 Avanzado

Optimización de rendimiento: profiling, memory leaks, rendering optimization y best practices.

[📖 Ver documentación completa →](skills/flutter/performance/SKILL.md)

---

#### 11. Accessibility (a11y)

**Path:** `skills/flutter/accessibility/SKILL.md`  
**Keywords:** `accessibility`, `a11y`, `semantic`, `screen-reader`, `wcag`, `talkback`, `voiceover`  
**Nivel:** 🟡 Intermedio

Implementación de accesibilidad con semantic widgets, screen reader support y cumplimiento WCAG.

[📖 Ver documentación completa →](skills/flutter/accessibility/SKILL.md)

---

#### 12. Animation & Motion Design

**Path:** `skills/flutter/animation-motion/SKILL.md`  
**Keywords:** `animation`, `motion`, `rive`, `lottie`, `hero`, `animationcontroller`, `tween`  
**Nivel:** 🔴 Avanzado

Animaciones avanzadas con Rive, Lottie, Hero animations y AnimationController.

[📖 Ver documentación completa →](skills/flutter/animation-motion/SKILL.md)

---

#### 13. Theming Avanzado

**Path:** `skills/flutter/theming/SKILL.md`  
**Keywords:** `theming`, `theme`, `dark-mode`, `material3`, `design-system`  
**Nivel:** 🟡 Intermedio

Sistema de diseño con múltiples temas, Material 3, dark mode y cambio dinámico de temas.

[📖 Ver documentación completa →](skills/flutter/theming/SKILL.md)

---

#### 14. Internacionalización (i18n)

**Path:** `skills/flutter/i18n/SKILL.md`  
**Keywords:** `i18n`, `l10n`, `internationalization`, `localization`, `translations`  
**Nivel:** 🟡 Intermedio

Soporte para múltiples idiomas con flutter_localizations, ARB files y formateo regional.

[📖 Ver documentación completa →](skills/flutter/i18n/SKILL.md)

---

#### 15. Firebase Integration

**Path:** `skills/flutter/firebase/SKILL.md`  
**Keywords:** `firebase`, `firestore`, `auth`, `cloud-messaging`, `analytics`  
**Nivel:** 🟡 Intermedio

Integración completa con Firebase: Auth, Firestore, Cloud Messaging y Analytics.

[📖 Ver documentación completa →](skills/flutter/firebase/SKILL.md)

---

#### 16. GraphQL Integration

**Path:** `skills/flutter/graphql/SKILL.md`  
**Keywords:** `graphql`, `apollo`, `graphql-client`, `subscriptions`  
**Nivel:** 🔴 Avanzado

Integración con GraphQL: queries, mutations, subscriptions en tiempo real y cache automático.

[📖 Ver documentación completa →](skills/flutter/graphql/SKILL.md)

---

#### 17. Offline-First Architecture

**Path:** `skills/flutter/offline-first/SKILL.md`  
**Keywords:** `offline-first`, `cache`, `sync`, `local-storage`, `connectivity`  
**Nivel:** 🔴 Avanzado

Arquitectura offline-first con cache inteligente, sincronización bidireccional y detección de conectividad.

[📖 Ver documentación completa →](skills/flutter/offline-first/SKILL.md)

---

#### 18. Deep Linking & Universal Links

**Path:** `skills/flutter/deep-linking/SKILL.md`  
**Keywords:** `deep-linking`, `universal-links`, `app-links`, `go-router`, `navigation`  
**Nivel:** 🟡 Intermedio

Deep linking con universal links (iOS) y app links (Android) usando go_router.

[📖 Ver documentación completa →](skills/flutter/deep-linking/SKILL.md)

---

#### 19. Push Notifications

**Path:** `skills/flutter/push-notifications/SKILL.md`  
**Keywords:** `push-notifications`, `fcm`, `firebase-messaging`, `local-notifications`, `apns`  
**Nivel:** 🟡 Intermedio

Push notifications con Firebase Cloud Messaging, local notifications y deep linking desde notificaciones.

[📖 Ver documentación completa →](skills/flutter/push-notifications/SKILL.md)

---

#### 20. Analytics & Tracking

**Path:** `skills/flutter/analytics-tracking/SKILL.md`  
**Keywords:** `analytics`, `tracking`, `mixpanel`, `amplitude`, `firebase-analytics`, `events`  
**Nivel:** 🟡 Intermedio

Analytics y tracking de eventos con Firebase Analytics, Mixpanel y Amplitude.

[📖 Ver documentación completa →](skills/flutter/analytics-tracking/SKILL.md)

---

#### 21. Error Tracking & Crash Reporting

**Path:** `skills/flutter/error-tracking/SKILL.md`  
**Keywords:** `error-tracking`, `sentry`, `crashlytics`, `crash-reporting`, `logging`, `monitoring`  
**Nivel:** 🟡 Intermedio

Monitoreo de errores con Sentry y Firebase Crashlytics, incluyendo contexto enriquecido y breadcrumbs.

[📖 Ver documentación completa →](skills/flutter/error-tracking/SKILL.md)

---

#### 22. Feature Flags & Remote Config

**Path:** `skills/flutter/feature-flags/SKILL.md`  
**Keywords:** `feature-flags`, `remote-config`, `firebase-remote-config`, `launchdarkly`, `ab-testing`  
**Nivel:** 🟡 Intermedio

Feature flags y remote configuration con Firebase Remote Config y LaunchDarkly para A/B testing.

[📖 Ver documentación completa →](skills/flutter/feature-flags/SKILL.md)

---

#### 23. In-App Purchases (IAP)

**Path:** `skills/flutter/in-app-purchases/SKILL.md`  
**Keywords:** `in-app-purchases`, `iap`, `subscriptions`, `revenue-cat`, `app-store`, `play-billing`  
**Nivel:** 🔴 Avanzado

In-App Purchases y subscriptions con RevenueCat, productos consumibles y restore purchases.

[📖 Ver documentación completa →](skills/flutter/in-app-purchases/SKILL.md)

---

#### 24. App Distribution & Deployment

**Path:** `skills/flutter/app-distribution/SKILL.md`  
**Keywords:** `app-distribution`, `testflight`, `play-console`, `firebase-distribution`, `fastlane`, `beta-testing`  
**Nivel:** 🟡 Intermedio

Distribución de apps: TestFlight, Google Play Internal Testing, Firebase App Distribution y Fastlane.

[📖 Ver documentación completa →](skills/flutter/app-distribution/SKILL.md)

---

#### 25. Platform Channels & Native Integration

**Path:** `skills/flutter/platform-channels/SKILL.md`  
**Keywords:** `platform-channels`, `methodchannel`, `eventchannel`, `ffi`, `native`, `swift`, `kotlin`  
**Nivel:** 🔴 Avanzado

Comunicación bidireccional con código nativo: MethodChannel, EventChannel y FFI.

[📖 Ver documentación completa →](skills/flutter/platform-channels/SKILL.md)

---

#### 26. Native Integration (Swift/Kotlin)

**Path:** `skills/flutter/native-integration/SKILL.md`  
**Keywords:** `native-integration`, `swift`, `kotlin`, `uikit`, `android-sdk`, `native-ui`  
**Nivel:** 🔴 Avanzado

Integración profunda con APIs nativas de iOS (Swift/UIKit) y Android (Kotlin/Android SDK).

[📖 Ver documentación completa →](skills/flutter/native-integration/SKILL.md)

---

#### 27. WebView Integration

**Path:** `skills/flutter/webview-integration/SKILL.md`  
**Keywords:** `webview`, `flutter-inappwebview`, `javascript`, `web-integration`, `hybrid`  
**Nivel:** 🟡 Intermedio

Integración de WebViews con flutter_inappwebview, JavaScript channels y comunicación bidireccional.

[📖 Ver documentación completa →](skills/flutter/webview-integration/SKILL.md)

---

#### 28. Security Best Practices

**Path:** `skills/flutter/security/SKILL.md`  
**Keywords:** `security`, `obfuscation`, `certificate-pinning`, `secure-storage`, `encryption`, `biometric`  
**Nivel:** 🔴 Avanzado

Mejores prácticas de seguridad: code obfuscation, certificate pinning, secure storage y biometric auth.

[📖 Ver documentación completa →](skills/flutter/security/SKILL.md)

---

### 📋 Mapeo de Mejores Prácticas

**Path:** `skills/flutter/BEST_PRACTICES_MAPPING.md`  
**Keywords:** `best-practices`, `mapping`, `requirements`, `standards`  
**Nivel:** 🟡 Intermedio

Documento que mapea las prácticas de `flutter-best-practices.md` a cada skill de Flutter, identificando qué requisitos (REQ-FLT-XXX) son relevantes para cada skill específico. Este mapeo ayuda a los agentes a aplicar las mejores prácticas correctas cuando se invoca un skill.

**Uso:**
- Los agentes deben consultar este mapeo cuando implementen cualquier skill de Flutter
- Cada skill tiene prácticas "Altamente Relevantes" y "Complementarias" identificadas
- Las prácticas están referenciadas con códigos REQ-FLT-XXX para trazabilidad

[📖 Ver mapeo completo →](skills/flutter/BEST_PRACTICES_MAPPING.md)

---

### 🚀 CI/CD Skills

#### 1. GitHub Actions

**Path:** `skills/cicd/github-actions/SKILL.md`  
**Keywords:** `github-actions`, `ci`, `cd`, `pipeline`, `automation`, `workflow`  
**Nivel:** 🟡 Intermedio

CI/CD nativo de GitHub para automatizar testing, building y deployment de aplicaciones Flutter y sus backends en un monorepo.

[📖 Ver documentación completa →](skills/cicd/github-actions/SKILL.md)

---

#### 2. ArgoCD

**Path:** `skills/cicd/argocd/SKILL.md`  
**Keywords:** `argocd`, `gitops`, `kubernetes`, `cd`, `continuous-deployment`  
**Nivel:** 🔴 Avanzado

GitOps deployment para Kubernetes, sincronizando automáticamente el estado del cluster con repositorios Git.

[📖 Ver documentación completa →](skills/cicd/argocd/SKILL.md)

---

#### 3. Terraform

**Path:** `skills/cicd/terraform/SKILL.md`  
**Keywords:** `terraform`, `iac`, `infrastructure-as-code`, `hcl`, `provisioning`  
**Nivel:** 🔴 Avanzado

Infrastructure as Code multi-cloud para definir y provision infraestructura de manera declarativa usando HCL.

[📖 Ver documentación completa →](skills/cicd/terraform/SKILL.md)

---

#### 4. AWS

**Path:** `skills/cicd/aws/SKILL.md`  
**Keywords:** `aws`, `eks`, `rds`, `s3`, `lambda`, `cloud`  
**Nivel:** 🔴 Avanzado

Amazon Web Services deployment: EKS para containers, RDS para databases, S3 para storage, Lambda para serverless.

[📖 Ver documentación completa →](skills/cicd/aws/SKILL.md)

---

#### 5. Google Cloud Platform (GCP)

**Path:** `skills/cicd/gcp/SKILL.md`  
**Keywords:** `gcp`, `gke`, `cloud-run`, `cloud-sql`, `firebase`  
**Nivel:** 🔴 Avanzado

Google Cloud Platform deployment: GKE (Kubernetes), Cloud Run (serverless containers), Cloud SQL, Firebase.

[📖 Ver documentación completa →](skills/cicd/gcp/SKILL.md)

---

#### 6. Microsoft Azure

**Path:** `skills/cicd/azure/SKILL.md`  
**Keywords:** `azure`, `aks`, `azure-functions`, `cosmos-db`  
**Nivel:** 🔴 Avanzado

Microsoft Azure deployment: AKS (Kubernetes), Azure Functions (serverless), Azure SQL, Cosmos DB.

[📖 Ver documentación completa →](skills/cicd/azure/SKILL.md)

---

#### 7. OVHCloud

**Path:** `skills/cicd/ovhcloud/SKILL.md`  
**Keywords:** `ovh`, `ovhcloud`, `kubernetes`, `object-storage`  
**Nivel:** 🟡 Intermedio

OVHCloud deployment (EU-based): Managed Kubernetes, Object Storage, Databases con precios competitivos.

[📖 Ver documentación completa →](skills/cicd/ovhcloud/SKILL.md)

---

#### 8. Ansible AWX

**Path:** `skills/cicd/ansible-awx/SKILL.md`  
**Keywords:** `ansible`, `awx`, `automation`, `configuration-management`  
**Nivel:** 🔴 Avanzado

Configuration management y automation con Ansible AWX (upstream de Red Hat Ansible Tower) para automatizar configuración y deployment.

[📖 Ver documentación completa →](skills/cicd/ansible-awx/SKILL.md)

---

#### 9. Crossplane

**Path:** `skills/cicd/crossplane/SKILL.md`  
**Keywords:** `crossplane`, `multi-cloud`, `kubernetes`, `infrastructure`  
**Nivel:** 🔴 Avanzado

Kubernetes-native infrastructure management multi-cloud. Permite provisioning declarativo usando APIs de Kubernetes.

[📖 Ver documentación completa →](skills/cicd/crossplane/SKILL.md)

---

### 🎨 Design Integration Skills

#### 1. Figma Dev Mode

**Path:** `skills/figma/SKILL.md`  
**Keywords:** `figma`, `design`, `assets`, `components`, `dev-mode`  
**Nivel:** 🟡 Intermedio

Integración con Figma Dev Mode vía MCP para extraer assets y componentes directamente desde diseños.

[📖 Ver documentación completa →](skills/figma/SKILL.md)

---

### 🔍 Static Analysis Skills

#### 1. Static Analysis

**Path:** `skills/static-analysis/SKILL.md`  
**Keywords:** `static-analysis`, `analyze`, `lint`, `code-quality`, `sast`, `security-scan`  
**Nivel:** 🟡 Intermedio

Herramientas de análisis estático de código: Dart Analyzer, Datadog SAST y CodeRabbit CLI para detectar errores, vulnerabilidades y problemas de calidad.

[📖 Ver documentación completa →](skills/static-analysis/SKILL.md)

---

## 📋 Documentación y Estándares

### Plantilla IEEE 830 para ERS

# Regla de Cursor: Generar ERS según IEEE 830

Sigue esta plantilla para generar un documento de Especificación de Requisitos Software (ERS) completo, basado en la estructura del estándar IEEE 830.

---

## Especificación de Requisitos Software: [Nombre del Proyecto]

### 1. Introducción

*Instrucción: Proporciona una introducción a todo el documento ERS*.

#### 1.1. Propósito

*Instrucción: Define el propósito de este ERS y especifica la audiencia (a quién va dirigido) del documento*.

#### 1.2. Ámbito del Sistema

*Instrucción: Incluye lo siguiente:*

* *Nombra el sistema (p.ej., MiSistema)*.
* *Explica qué hará el sistema y qué no hará*.
* *Describe los beneficios, objetivos y metas que se espera alcanzar con el sistema*.
* *Referencia documentos de nivel superior, si existen*.

#### 1.3. Definiciones, Acrónimos y Abreviaturas

*Instrucción: Define todos los términos, acrónimos y abreviaturas utilizados en esta ERS*.

#### 1.4. Referencias

*Instrucción: Muestra una lista completa de todos los documentos referenciados en la ERS*.

#### 1.5. Visión General del Documento

*Instrucción: Describe brevemente los contenidos y la organización del resto de la ERS*.

---

### 2. Descripción General

*Instrucción: Describe los factores que afectan al producto y sus requisitos. Esta sección describe el **contexto** de los requisitos, no los requisitos en sí*.

#### 2.1. Perspectiva del Producto

*Instrucción: Relaciona el producto software con otros productos. Especifica si es un producto totalmente independiente o si es parte de un sistema mayor. Si es parte de un sistema mayor, identifica las interfaces entre ellos. (Se recomienda usar diagramas de bloques).*

#### 2.2. Funciones del Producto

*Instrucción: Muestra un resumen a grandes rasgos de las funciones del sistema. (Por ejemplo, para un software de contabilidad: mantenimiento de cuentas, estado de cuentas, facturación, sin entrar en detalles).*

#### 2.3. Características de los Usuarios

*Instrucción: Describe las características generales de los usuarios del producto, incluyendo su nivel educacional, experiencia y experiencia técnica*.

#### 2.4. Restricciones

*Instrucción: Describe las limitaciones impuestas a los desarrolladores. Ejemplos incluyen: políticas de la empresa, limitaciones de hardware, interfaces con otras aplicaciones, lenguajes de programación, protocolos de comunicación o consideraciones de seguridad.*

#### 2.5. Suposiciones y Dependencias

*Instrucción: Describe aquellos factores que, si cambian, pueden afectar a los requisitos. (Por ejemplo, presuponer que el sistema correrá sobre cierto sistema operativo).*

#### 2.6. Requisitos Futuros

*Instrucción: Esboza futuras mejoras al sistema que podrán implementarse en un futuro*.

---

### 3. Requisitos Específicos

*Instrucción: Contiene los requisitos a un nivel de detalle suficiente para que los diseñadores puedan diseñar el sistema y el equipo de pruebas pueda planificar las pruebas. Todo requisito debe describir comportamientos externos del sistema.*

*Principios a aplicar en esta sección:*

* *Cada requisito debe ser unívocamente identificable (con un código o numeración)*.
* *Los requisitos deben ser:*
  * ***Correctos:*** *Reflejar una necesidad real*.
  * ***No ambiguos:*** *Tener una sola interpretación*.
  * ***Completos:*** *Incluir todas las respuestas a entradas válidas y no válidas*.
  * ***Consistentes:*** *No ser contradictorios*.
  * ***Clasificados:*** *Por importancia (esenciales, opcionales) o estabilidad*.
  * ***Verificables:*** *Debe existir un proceso finito y no costoso para probar que el sistema cumple el requisito*.
  * ***Modificables:*** *Estructurados para que los cambios sean fáciles*.
  * ***Trazables:*** *Se debe conocer el origen (trazabilidad hacia atrás) y a qué componentes del diseño afecta (trazabilidad hacia delante).*

#### 3.0.1. Convenciones de redacción de requisitos

Para mejorar la legibilidad sin contravenir IEEE 830, se recomienda añadir un "título corto" opcional a cada requisito:

- **Formato recomendado:** `REQ-XXX-YYY: Título corto descriptivo`
- **Ubicación:** En una línea independiente antes del enunciado del requisito (la línea que inicia con "CUANDO...").
- **Criterios del título corto:** 3–8 palabras, concretas, enfocadas al objetivo del requisito.

Ejemplo:

```
**REQ-ABC-001: Autenticación con JWT**

CUANDO un usuario se autentique ENTONCES el sistema DEBERÁ emitir un JWT con expiración definida.
```

#### 3.1. Interfaces Externas

*Instrucción: Describe los requisitos que afecten a la interfaz de usuario, interfaz con hardware, interfaz con software e interfaces de comunicaciones*.

#### 3.2. Funciones

*Instrucción: Especifica todas las acciones (funciones) que el software deberá llevar a cabo. Normalmente expresables como "el sistema deberá...".*

*Organiza esta subsección usando una de las siguientes alternativas (y justifica la elección):*

* ***Por tipos de usuario:*** *Especifica los requisitos funcionales para cada clase de usuario*.
* ***Por objetos:*** *Para cada entidad del mundo real, detalla sus atributos y funciones*.
* ***Por objetivos:*** *Para cada servicio u objetivo del sistema, detalla las funciones que lo realizan*.
* ***Por estímulos:*** *Especifica los estímulos que recibe el sistema y las funciones relacionadas*.
* ***Por jerarquía funcional:*** *Especifica una jerarquía de funciones (entrada, proceso, salida) y subfunciones*.

#### 3.3. Requisitos de Rendimiento

*Instrucción: Detalla los requisitos relacionados con la carga del sistema. (Por ejemplo: número de usuarios simultáneos, número de transacciones por segundo). También incluye requisitos de datos (frecuencia de uso, cantidad de registros esperados).*

#### 3.4. Restricciones de Diseño

*Instrucción: Detalla todo aquello que restrinja las decisiones de diseño (restricciones de otros estándares, limitaciones de hardware, etc.)*.

#### 3.5. Atributos del Sistema

*Instrucción: Detalla los atributos de calidad. Incluye fiabilidad, mantenibilidad, portabilidad y, muy importante, la **seguridad**. Especifica qué tipos de usuario están autorizados para qué tareas y cómo se implementará la seguridad (p.ej., login y password).*

#### 3.6. Otros Requisitos

*Instrucción: Incluye cualquier otro requisito que no encaje en las secciones anteriores*.

---

### 4. Apéndices

*Instrucción: Incluye información relevante que no forma parte propiamente de la ERS. (Por ejemplo: formatos de entrada/salida de datos, resultados de análisis de costes, etc.).*

---

### Especificación de Requisitos Software: Patrones de Diseño de Agentes de IA

## 1. Introducción

Este documento establece la especificación completa de requisitos para la implementación de patrones de diseño de agentes de inteligencia artificial en sistemas de software modernos, proporcionando un marco de trabajo estructurado para el desarrollo de soluciones basadas en agentes inteligentes.

### 1.1. Propósito

Esta ERS define los patrones arquitectónicos, requisitos funcionales y no funcionales para el diseño e implementación de sistemas de agentes de IA. Está dirigido a:

- Arquitectos de software especializados en IA
- Desarrolladores de sistemas de agentes inteligentes
- Ingenieros de machine learning y NLP
- Equipos de producto que implementan soluciones de IA
- Especialistas en DevOps para sistemas de IA

### 1.2. Ámbito del Sistema

**Sistema:** Framework de Patrones de Diseño de Agentes de IA

**Funcionalidades que incluye:**

- 20 patrones arquitectónicos fundamentales para agentes de IA
- Especificaciones técnicas para implementación de cada patrón
- Requisitos de rendimiento y escalabilidad
- Protocolos de comunicación entre agentes
- Mecanismos de seguridad y control de calidad
- Sistemas de monitoreo y evaluación

**Funcionalidades que NO incluye:**

- Implementaciones específicas de modelos de lenguaje
- Configuraciones de infraestructura cloud específicas
- Interfaces de usuario finales
- Lógica de negocio específica de dominio

**Beneficios esperados:**

- Arquitecturas de IA modulares y reutilizables
- Sistemas de agentes escalables y robustos
- Reducción de complejidad en desarrollo de IA
- Mejora en la calidad y confiabilidad de sistemas inteligentes
- Facilidad de mantenimiento y evolución

### 1.3. Definiciones, Acrónimos y Abreviaturas

- **Agente de IA**: Sistema de software autónomo capaz de percibir su entorno y tomar acciones para alcanzar objetivos específicos
- **LLM**: Large Language Model (Modelo de Lenguaje Grande)
- **RAG**: Retrieval-Augmented Generation (Generación Aumentada por Recuperación)
- **API**: Application Programming Interface
- **ETL**: Extract, Transform, Load
- **KPI**: Key Performance Indicator
- **PII**: Personally Identifiable Information
- **QA**: Quality Assurance
- **SMART**: Specific, Measurable, Achievable, Relevant, Time-bound
- **Context Explosion**: Acumulación excesiva de datos en el contexto del agente
- **Drift**: Desviación gradual en el comportamiento del modelo
- **Fallback**: Mecanismo de respaldo ante fallos

### 1.4. Referencias

- Especificación de Patrones de Diseño de Agentes de IA (documento fuente)
- IEEE Std 830-1998 - IEEE Recommended Practice for Software Requirements Specifications
- Principios de Arquitectura de Microservicios
- Documentación de APIs de modelos de lenguaje (OpenAI, Google, etc.)
- Estándares de seguridad para sistemas de IA

### 1.5. Visión General del Documento

Este documento se organiza en secciones que cubren desde los fundamentos arquitectónicos hasta los requisitos específicos de implementación de cada patrón, incluyendo consideraciones de rendimiento, seguridad y operación.

## 2. Descripción General

### 2.1. Perspectiva del Producto

El framework de patrones de diseño de agentes de IA es un sistema arquitectónico que define estructuras y comportamientos estándar para sistemas inteligentes. Se integra con:

- Plataformas de modelos de lenguaje (OpenAI, Google, etc.)
- Sistemas de bases de datos vectoriales
- Infraestructura de contenedores y orquestación
- Herramientas de monitoreo y observabilidad
- Sistemas de gestión de configuración

### 2.2. Funciones del Producto

**Funciones principales:**

- Definición de 20 patrones arquitectónicos fundamentales
- Especificación de protocolos de comunicación entre agentes
- Gestión de memoria y contexto distribuido
- Mecanismos de control de calidad y evaluación
- Sistemas de recuperación ante fallos
- Optimización de recursos y costos

### 2.3. Características de los Usuarios

**Arquitectos de Software:**

- Nivel educacional: Universitario en informática o ingeniería
- Experiencia: Avanzado en diseño de sistemas distribuidos
- Conocimientos técnicos: Patrones arquitectónicos, sistemas de IA, microservicios

**Desarrolladores de IA:**

- Nivel educacional: Técnico superior o universitario
- Experiencia: Intermedio a avanzado en machine learning y NLP
- Conocimientos técnicos: Python, APIs de IA, bases de datos vectoriales

### 2.4. Restricciones

- **Tecnológicas**: Dependencia de APIs de modelos de lenguaje externos
- **Rendimiento**: Latencia inherente de modelos de IA generativa
- **Costos**: Limitaciones presupuestarias para uso de APIs premium
- **Seguridad**: Cumplimiento con regulaciones de protección de datos
- **Escalabilidad**: Limitaciones de rate limiting de proveedores de IA

### 2.5. Suposiciones y Dependencias

- Disponibilidad de APIs de modelos de lenguaje estables
- Conectividad a internet para servicios cloud
- Infraestructura de contenedores disponible
- Sistemas de monitoreo y logging configurados
- Bases de datos vectoriales operativas

### 2.6. Requisitos Futuros

- Soporte para modelos de IA multimodales
- Integración con sistemas de IA cuántica
- Patrones para agentes autónomos avanzados
- Optimizaciones para edge computing

## 3. Requisitos Específicos

### 3.0.1. Convenciones de redacción de requisitos

Para mejorar la legibilidad, cada requisito incluye un código identificador único y título descriptivo:

**Formato:** `REQ-AGT-XXX: Título descriptivo`

Ejemplo:

```
**REQ-AGT-001: Encadenamiento secuencial de prompts**

CUANDO se implemente el patrón de encadenamiento ENTONCES el sistema DEBERÁ validar la salida de cada paso antes de proceder al siguiente.
```

### 3.1. Interfaces Externas

#### 3.1.1. Interfaces de APIs de IA

- Integración con APIs de OpenAI, Google, y otros proveedores
- Protocolos REST y WebSocket para comunicación en tiempo real
- Autenticación mediante tokens y claves API

#### 3.1.2. Interfaces de Bases de Datos

- Conexiones a bases de datos vectoriales (Pinecone, Weaviate, Chroma)
- Interfaces SQL para bases de datos relacionales
- APIs NoSQL para almacenamiento de documentos

#### 3.1.3. Interfaces de Monitoreo

- Integración con sistemas de observabilidad (Prometheus, Grafana)
- APIs de logging estructurado
- Webhooks para alertas y notificaciones

### 3.2. Funciones

Organización por **patrones arquitectónicos** según especialización funcional:

#### 3.2.1. Patrones de Procesamiento Secuencial

**REQ-AGT-001: Encadenamiento de prompts obligatorio**

CUANDO se implemente procesamiento de múltiples pasos ENTONCES el sistema DEBERÁ usar el patrón de encadenamiento de prompts con validación entre etapas.

**REQ-AGT-002: Validación de salida entre pasos**

CUANDO se ejecute cada paso del encadenamiento ENTONCES el sistema DEBERÁ validar la salida antes de pasarla al siguiente paso.

**REQ-AGT-003: Manejo de errores en cadena**

CUANDO ocurra un error en cualquier paso ENTONCES el sistema DEBERÁ implementar mecanismos de recuperación y no propagar errores inválidos.

#### 3.2.2. Patrones de Enrutamiento Inteligente

**REQ-AGT-010: Enrutamiento basado en especialización**

CUANDO se reciba una solicitud ENTONCES el sistema DEBERÁ analizar el contenido y enrutar al agente especialista apropiado.

**REQ-AGT-011: Solicitud de aclaración en incertidumbre**

CUANDO el nivel de confianza del enrutamiento sea menor al 80% ENTONCES el sistema DEBERÁ solicitar preguntas de aclaración.

**REQ-AGT-012: Registro de decisiones de enrutamiento**

CUANDO se realice un enrutamiento ENTONCES el sistema DEBERÁ registrar la decisión y el nivel de confianza para auditoría.

#### 3.2.3. Patrones de Procesamiento Paralelo

**REQ-AGT-020: Paralelización de subtareas independientes**

CUANDO se identifiquen subtareas independientes ENTONCES el sistema DEBERÁ procesarlas simultáneamente usando múltiples agentes trabajadores.

**REQ-AGT-021: Normalización de resultados paralelos**

CUANDO se recopilen resultados de procesamiento paralelo ENTONCES el sistema DEBERÁ normalizar y unificar el formato antes de la fusión.

**REQ-AGT-022: Gestión de recursos de trabajadores**

CUANDO se ejecute procesamiento paralelo ENTONCES el sistema DEBERÁ gestionar dinámicamente la asignación de agentes trabajadores.

#### 3.2.4. Patrones de Control de Calidad

**REQ-AGT-030: Reflexión con agente crítico**

CUANDO se genere contenido ENTONCES el sistema DEBERÁ implementar un agente crítico que revise contra rúbricas de calidad.

**REQ-AGT-031: Iteración hasta estándar de calidad**

CUANDO la calidad no alcance el umbral definido ENTONCES el sistema DEBERÁ iterar el proceso de generación y revisión.

**REQ-AGT-032: Feedback estructurado**

CUANDO el agente crítico identifique problemas ENTONCES DEBERÁ proporcionar feedback estructurado y específico.

#### 3.2.5. Patrones de Uso de Herramientas

**REQ-AGT-040: Descubrimiento dinámico de herramientas**

CUANDO se analice una solicitud ENTONCES el sistema DEBERÁ descubrir automáticamente las herramientas disponibles y relevantes.

**REQ-AGT-041: Verificación de permisos de seguridad**

CUANDO se identifique una herramienta ENTONCES el sistema DEBERÁ verificar permisos de seguridad antes de la ejecución.

**REQ-AGT-042: Lógica de fallback para herramientas**

CUANDO una herramienta falle ENTONCES el sistema DEBERÁ activar mecanismos de fallback alternativos.

#### 3.2.6. Patrones de Planificación Estratégica

**REQ-AGT-050: Planificación detallada paso a paso**

CUANDO se reciba un objetivo complejo ENTONCES el sistema DEBERÁ crear un plan detallado con hitos y dependencias.

**REQ-AGT-051: Revisión de restricciones**

CUANDO se cree un plan ENTONCES el sistema DEBERÁ revisar restricciones de autorización, presupuesto y plazos.

**REQ-AGT-052: Adaptabilidad del plan**

CUANDO cambien las condiciones del entorno ENTONCES el sistema DEBERÁ adaptar el plan manteniendo el objetivo principal.

#### 3.2.7. Patrones de Colaboración Multiagente

**REQ-AGT-060: Orquestación central de agentes**

CUANDO múltiples agentes colaboren ENTONCES DEBERÁ existir un orquestador central que coordine el flujo de trabajo.

**REQ-AGT-061: Memoria compartida entre agentes**

CUANDO los agentes colaboren ENTONCES DEBERÁN compartir una memoria común accesible por todos los participantes.

**REQ-AGT-062: Especialización de agentes**

CUANDO se asignen tareas ENTONCES cada agente DEBERÁ especializarse en un dominio específico de conocimiento.

#### 3.2.8. Patrones de Gestión de Memoria

**REQ-AGT-070: Clasificación de información por temporalidad**

CUANDO se reciba información ENTONCES el sistema DEBERÁ clasificarla en memoria a corto plazo, episódica o a largo plazo.

**REQ-AGT-071: Metadatos de relevancia y recencia**

CUANDO se almacene información ENTONCES el sistema DEBERÁ incluir metadatos de relevancia y recencia.

**REQ-AGT-072: Base de datos vectorial para memoria**

CUANDO se implemente memoria a largo plazo ENTONCES el sistema DEBERÁ usar una base de datos vectorial optimizada.

#### 3.2.9. Patrones de Aprendizaje y Adaptación

**REQ-AGT-080: Recopilación de señales de calidad**

CUANDO se ejecuten tareas ENTONCES el sistema DEBERÁ recopilar feedback, correcciones y calificaciones de usuarios.

**REQ-AGT-081: Validación de datos de feedback**

CUANDO se reciba feedback ENTONCES el sistema DEBERÁ limpiar y validar los datos antes de la incorporación.

**REQ-AGT-082: Actualización de prompts y políticas**

CUANDO se valide el feedback ENTONCES el sistema DEBERÁ actualizar prompts, políticas y ejemplos del agente.

#### 3.2.10. Patrones de Monitoreo de Objetivos

**REQ-AGT-090: Definición de metas SMART**

CUANDO se establezcan objetivos ENTONCES estos DEBERÁN ser específicos, medibles, alcanzables, relevantes y con plazos definidos.

**REQ-AGT-091: KPIs y monitoreo continuo**

CUANDO se definan metas ENTONCES el sistema DEBERÁ establecer KPIs y monitorear continuamente el progreso.

**REQ-AGT-092: Análisis de desviaciones**

CUANDO se detecten desviaciones ENTONCES el sistema DEBERÁ analizar las causas y ajustar el plan o alcance.

### 3.3. Requisitos de Rendimiento

**REQ-AGT-100: Latencia máxima por patrón**

CUANDO se ejecute cualquier patrón ENTONCES la latencia total NO DEBERÁ exceder los límites definidos por tipo:

- Patrones simples (enrutamiento): < 2 segundos
- Patrones complejos (planificación): < 30 segundos
- Patrones intensivos (paralelización): < 60 segundos

**REQ-AGT-101: Throughput mínimo**

CUANDO el sistema esté en operación ENTONCES DEBERÁ procesar mínimo 100 solicitudes concurrentes por patrón.

**REQ-AGT-102: Escalabilidad horizontal**

CUANDO aumente la carga ENTONCES el sistema DEBERÁ escalar horizontalmente añadiendo más instancias de agentes.

**REQ-AGT-103: Optimización de costos de API**

CUANDO se usen APIs de IA ENTONCES el sistema DEBERÁ optimizar el uso de tokens para minimizar costos operativos.

### 3.4. Restricciones de Diseño

**REQ-AGT-110: Arquitectura basada en microservicios**

CUANDO se implemente cualquier patrón ENTONCES DEBERÁ seguir arquitectura de microservicios con contenedores.

**REQ-AGT-111: APIs REST estándar**

CUANDO se expongan servicios ENTONCES DEBERÁN usar APIs REST con documentación OpenAPI 3.0.

**REQ-AGT-112: Configuración externalizada**

CUANDO se desplieguen agentes ENTONCES la configuración DEBERÁ estar externalizada usando ConfigMaps y Secrets.

**REQ-AGT-113: Stateless por defecto**

CUANDO se diseñen agentes ENTONCES DEBERÁN ser stateless por defecto, externalizando el estado a servicios especializados.

### 3.5. Atributos del Sistema

#### 3.5.1. Fiabilidad

**REQ-AGT-120: Manejo robusto de errores**

CUANDO ocurran errores ENTONCES el sistema DEBERÁ clasificarlos (permanente, temporal, crítico) y aplicar estrategias de recuperación apropiadas.

**REQ-AGT-121: Circuit breaker para APIs externas**

CUANDO las APIs externas fallen ENTONCES el sistema DEBERÁ implementar circuit breakers para evitar cascadas de errores.

#### 3.5.2. Disponibilidad

**REQ-AGT-130: Alta disponibilidad 99.9%**

CUANDO el sistema esté en producción ENTONCES DEBERÁ mantener una disponibilidad mínima del 99.9%.

**REQ-AGT-131: Recuperación automática**

CUANDO se detecten fallos ENTONCES el sistema DEBERÁ recuperarse automáticamente sin intervención manual.

#### 3.5.3. Seguridad

**REQ-AGT-140: Verificación de contenido dañino**

CUANDO se procesen entradas ENTONCES el sistema DEBERÁ verificar contenido dañino, PII y ataques de inyección.

**REQ-AGT-141: Clasificación de riesgo**

CUANDO se detecten amenazas ENTONCES el sistema DEBERÁ clasificar el riesgo (bajo, medio, alto) y aplicar controles apropiados.

**REQ-AGT-142: Auditoría completa**

CUANDO se ejecuten operaciones ENTONCES el sistema DEBERÁ registrar todas las acciones para auditoría y trazabilidad.

#### 3.5.4. Observabilidad

**REQ-AGT-150: Métricas de rendimiento**

CUANDO el sistema esté operativo ENTONCES DEBERÁ generar métricas de latencia, throughput, errores y costos.

**REQ-AGT-151: Trazas distribuidas**

CUANDO se ejecuten patrones multiagente ENTONCES el sistema DEBERÁ generar trazas distribuidas para debugging.

**REQ-AGT-152: Alertas automáticas**

CUANDO se detecten anomalías ENTONCES el sistema DEBERÁ generar alertas automáticas con severidad apropiada.

### 3.6. Otros Requisitos

#### 3.6.1. Requisitos de Integración

**REQ-AGT-160: Compatibilidad con múltiples proveedores de IA**

CUANDO se integren modelos ENTONCES el sistema DEBERÁ soportar múltiples proveedores (OpenAI, Google, etc.).

**REQ-AGT-161: Abstracción de APIs de IA**

CUANDO se cambien proveedores ENTONCES el sistema DEBERÁ usar una capa de abstracción que minimice cambios en código.

#### 3.6.2. Requisitos de Configuración

**REQ-AGT-170: Configuración declarativa**

CUANDO se configuren patrones ENTONCES se DEBERÁ usar configuración declarativa en formato YAML o JSON.

**REQ-AGT-171: Validación de configuración**

CUANDO se cargue configuración ENTONCES el sistema DEBERÁ validar la sintaxis y semántica antes de aplicarla.

#### 3.6.3. Requisitos de Testing

**REQ-AGT-180: Testing automatizado de patrones**

CUANDO se desarrollen patrones ENTONCES DEBERÁN incluir tests unitarios, de integración y end-to-end.

**REQ-AGT-181: Golden test sets**

CUANDO se validen patrones ENTONCES se DEBERÁN usar conjuntos de pruebas de oro para verificar calidad consistente.

#### 3.6.4. Requisitos de Comunicación Interagente (A2A Protocol)

**REQ-AGT-190: Agent Card obligatorio**

CUANDO se implemente comunicación interagente ENTONCES cada agente DEBERÁ exponer un Agent Card en formato JSON en la ruta `/.well-known/agent.json`.

**REQ-AGT-191: Protocolo JSON-RPC 2.0**

CUANDO los agentes se comuniquen ENTONCES DEBERÁN usar JSON-RPC 2.0 sobre HTTP(S) como protocolo de transporte estándar.

**REQ-AGT-192: Descubrimiento de agentes**

CUANDO se requiera colaboración ENTONCES el sistema DEBERÁ implementar mecanismos de descubrimiento de agentes mediante URI estándar, registros centralizados o configuración directa.

**REQ-AGT-193: Gestión de tareas distribuidas**

CUANDO se deleguen tareas entre agentes ENTONCES el sistema DEBERÁ soportar estados de tarea (submitted, working, input-required, completed, failed) con seguimiento completo.

**REQ-AGT-194: Comunicación multi-modal**

CUANDO se intercambien datos ENTONCES los agentes DEBERÁN soportar múltiples tipos de contenido: TextPart, FilePart y DataPart según especificación A2A.

**REQ-AGT-195: Autenticación y autorización interagente**

CUANDO se establezca comunicación ENTONCES los agentes DEBERÁN implementar autenticación mutua usando OAuth 2.0, API keys o esquemas Bearer token.

**REQ-AGT-196: Manejo de interacciones asíncronas**

CUANDO se ejecuten tareas de larga duración ENTONCES el sistema DEBERÁ soportar comunicación asíncrona mediante polling, streaming o push notifications.

**REQ-AGT-197: Trazabilidad de mensajes interagente**

CUANDO se intercambien mensajes ENTONCES cada comunicación DEBERÁ incluir IDs únicos, timestamps y metadatos de trazabilidad para auditoría.

**REQ-AGT-198: Manejo de fallos en comunicación**

CUANDO falle la comunicación entre agentes ENTONCES el sistema DEBERÁ implementar reintentos con backoff exponencial y mecanismos de fallback.

**REQ-AGT-199: Versionado de protocolos**

CUANDO evolucionen las capacidades ENTONCES los agentes DEBERÁN declarar versiones de protocolo soportadas y mantener compatibilidad hacia atrás.

#### 3.6.5. Requisitos de Exploración y Descubrimiento

**REQ-AGT-200: Ciclo DECIDE obligatorio**

CUANDO se implemente exploración y descubrimiento ENTONCES el sistema DEBERÁ seguir el ciclo DECIDE: Decidir (Planificación), Ejecutar (Acción), Criticar (Evaluación), Iterar (Bucle), Descubrir (Novedad) y Estado (Memoria Persistente).

**REQ-AGT-201: Gestión de estado cíclico**

CUANDO se ejecuten bucles de exploración ENTONCES el sistema DEBERÁ mantener estado persistente a través de múltiples iteraciones usando grafos con estado (LangGraph o equivalente).

**REQ-AGT-202: Patrón ReAct para exploración**

CUANDO se explore información ENTONCES el agente DEBERÁ alternar entre razonamiento (Reasoning) y actuación (Acting) para decidir qué herramientas usar e interpretar resultados.

**REQ-AGT-203: Reflexión y autocorrección**

CUANDO se generen resultados de exploración ENTONCES el sistema DEBERÁ implementar un mecanismo de reflexión que evalúe críticamente los resultados y ajuste la estrategia de búsqueda.

**REQ-AGT-204: Límites de iteración**

CUANDO se ejecuten bucles de exploración ENTONCES el sistema DEBERÁ imponer límites máximos de iteraciones (max_iterations) y criterios de parada inteligentes para prevenir bucles infinitos.

**REQ-AGT-205: Búsqueda híbrida de conocimiento**

CUANDO se requiera descubrimiento de información ENTONCES el sistema DEBERÁ combinar búsqueda en conocimiento indexado (RAG) y datos en tiempo real (web scraping) con priorización inteligente.

**REQ-AGT-206: Clustering y análisis de patrones**

CUANDO se explore información ENTONCES el sistema DEBERÁ identificar patrones, agrupar por temas (clustering) y enfocarse en las pistas más prometedoras usando técnicas de análisis semántico.

**REQ-AGT-207: Detección de novedad**

CUANDO se descubra información ENTONCES el sistema DEBERÁ detectar y priorizar contenido novedoso, conexiones no obvias y anomalías significativas en los datos explorados.

**REQ-AGT-208: Trazabilidad de exploración**

CUANDO se ejecute exploración ENTONCES el sistema DEBERÁ generar trazas detalladas de cada paso de razonamiento, decisión de herramienta y resultado para debugging y optimización.

**REQ-AGT-209: Metadatos de fuente**

CUANDO se descubra información ENTONCES el sistema DEBERÁ adjuntar metadatos completos de la fuente (URL, timestamp, confiabilidad) para generar respuestas con citas verificables.

## 4. Apéndices

### 4.1. Catálogo Detallado de Patrones

#### 4.1.1. Patrones de Procesamiento

##### 1. Encadenamiento de Prompts (Prompt Chaining)

**Definición:** Romper una tarea grande en pasos más pequeños que se ejecutan secuencialmente. Cada paso valida la salida del paso anterior antes de pasar los datos al siguiente, actuando como una línea de ensamblaje.

**Uso y Aplicaciones:**

- Procesos complejos de múltiples pasos
- Transformación de datos y ETL (Extract, Transform, Load)
- Generación de código estructurado
- Creación de contenido editorial
- Análisis de documentos legales
- Descripciones de productos de comercio electrónico
- Asistencia para investigación académica

**Ventajas:**

- **Modularidad:** Permite el intercambio de partes de la cadena
- **Mantenibilidad:** Cada paso puede ser optimizado independientemente
- **Trazabilidad:** Fácil identificación de errores en pasos específicos
- **Reutilización:** Componentes pueden reutilizarse en diferentes cadenas

**Desventajas:**

- **Explosión de contexto:** Acumulación de datos entre pasos aumenta probabilidad de alucinación
- **Propagación de errores:** Error inicial se hereda por todos los nodos posteriores
- **Latencia:** Inherentemente más lento por múltiples puntos de inferencia del LLM
- **Complejidad:** Gestión de estado entre pasos puede volverse compleja

**Requisitos Asociados:** REQ-AGT-001, REQ-AGT-002, REQ-AGT-003

##### 2. Paralelización (Parallelization)

**Definición:** Dividir una tarea grande en unidades independientes (subtareas) que pueden ser procesadas simultáneamente por múltiples agentes ("trabajadores"). Los resultados se recopilan, se normalizan (se unifican en un formato), se fusionan y se genera un resumen.

**Uso y Aplicaciones:**

- Operaciones sensibles al tiempo
- Procesamiento de datos a gran escala
- Web scraping distribuido
- Procesamiento masivo de documentos
- Enriquecimiento de datos en lotes
- Automatización de investigación
- Marcos de prueba (testing frameworks)
- Inteligencia de documentos
- Servicios de agregación de noticias

**Ventajas:**

- **Especialización:** Cada trabajador puede optimizarse para tareas específicas
- **Escalabilidad:** Se pueden agregar más recursos/agentes según demanda
- **Velocidad:** Procesamiento simultáneo reduce tiempo total
- **Tolerancia a fallos:** Fallo de un trabajador no afecta a otros

**Desventajas:**

- **Complejidad de gestión:** Necesita un "agente de RR.HH." que gestione trabajadores
- **Unificación difícil:** Dificultad para homogeneizar salida de todos los trabajadores
- **Overhead de coordinación:** Costo adicional de sincronización
- **Dependencias:** Algunas tareas no pueden paralelizarse efectivamente

**Requisitos Asociados:** REQ-AGT-020, REQ-AGT-021, REQ-AGT-022

##### 3. Reflexión (Reflection)

**Definición:** Generar un primer borrador y luego hacer que un agente crítico (el "crítico") lo revise contra rúbricas de calidad o pruebas unitarias. El proceso se repite, generando feedback estructurado, hasta alcanzar el estándar de calidad.

**Uso y Aplicaciones:**

- Control de calidad automatizado
- Tareas de razonamiento complejas
- Resultados creativos que requieren refinamiento
- Generación de contenido (para evitar el AI slop)
- Redacción legal y académica
- Descripciones de productos premium
- Código que requiere revisión automática

**Ventajas:**

- **Calidad superior:** Fuerte enfoque en la calidad del resultado final
- **Mejora iterativa:** Cada iteración mejora la calidad
- **Consistencia:** Aplicación uniforme de criterios de calidad
- **Aprendizaje:** El sistema aprende de sus propios errores

**Desventajas:**

- **Costo elevado:** Aumenta significativamente el costo por múltiples iteraciones
- **API throttling:** Riesgo de limitación de solicitudes por naturaleza iterativa
- **Latencia:** Tiempo de respuesta mucho mayor
- **Convergencia:** No garantiza que siempre alcance el estándar deseado

**Requisitos Asociados:** REQ-AGT-030, REQ-AGT-031, REQ-AGT-032

#### 4.1.2. Patrones de Coordinación

##### 4. Enrutamiento (Routing)

**Definición:** Analiza las solicitudes entrantes para enviarlas al agente especialista adecuado (ej., un agente de soporte técnico o de ventas). Si el enrutador no está seguro, debe solicitar preguntas de aclaración para aumentar la confianza en la decisión.

**Uso y Aplicaciones:**

- Escenarios con múltiples dominios o departamentos
- Segregación de rutas para herramientas específicas
- Servicio al cliente multicanal
- Automatizaciones empresariales
- Triaje de atención médica
- Sistemas de recepción virtual
- Clasificación automática de tickets

**Ventajas:**

- **Especialización:** Cada agente se enfoca en su área de expertise
- **Escalabilidad:** Fácil agregar nuevos especialistas
- **Eficiencia:** Solicitudes llegan directamente al experto apropiado
- **Mantenibilidad:** Cambios en un dominio no afectan otros

**Desventajas:**

- **Enrutamiento incorrecto:** Susceptible a enviar solicitudes al camino equivocado
- **Casos límite:** Propenso a edge cases que no pueden etiquetarse correctamente
- **Complejidad de reglas:** Lógica de enrutamiento puede volverse muy compleja
- **Punto único de fallo:** El enrutador puede convertirse en cuello de botella

**Requisitos Asociados:** REQ-AGT-010, REQ-AGT-011, REQ-AGT-012

##### 5. Colaboración Multiagente (Multi-Agent Collaboration)

**Definición:** Múltiples agentes especializados trabajan juntos en una tarea compleja. Un orquestador central coordina el flujo de trabajo, asignando tareas a los agentes adecuados. Generalmente, comparten una memoria común (Shared Memory).

**Uso y Aplicaciones:**

- Desarrollo de software y productos
- Refinamiento iterativo de soluciones
- Análisis financiero complejo
- Creación de contenido multimedia
- Proyectos de investigación multidisciplinarios
- Sistemas de diagnóstico médico
- Planificación estratégica empresarial

**Ventajas:**

- **Especialización profunda:** Cada agente domina su área específica
- **Procesamiento paralelo:** Múltiples aspectos trabajados simultáneamente
- **Sinergia:** Combinación de expertises genera mejores resultados
- **Flexibilidad:** Fácil reconfiguración de equipos de agentes

**Desventajas:**

- **Configuración rigurosa:** Requiere configuración y pruebas exhaustivas
- **Evolución constante:** Sistemas deben evolucionar con cambios en modelos
- **Complejidad de coordinación:** Gestión de dependencias entre agentes
- **Model drift:** Comportamiento puede "derivar" con actualizaciones de LLMs

**Requisitos Asociados:** REQ-AGT-060, REQ-AGT-061, REQ-AGT-062

##### 6. Comunicación Interagente (Inter-Agent Communication)

**Definición:** Agentes que se comunican entre sí a través de un sistema de mensajería estructurado basado en el protocolo A2A (Agent-to-Agent). Utiliza JSON-RPC 2.0 sobre HTTP(S), Agent Cards para descubrimiento, y soporta comunicación multi-modal con gestión de tareas distribuidas y autenticación mutua.

**Uso y Aplicaciones:**

- Planificación colaborativa de viajes (agentes de vuelos, hoteles, turismo)
- Servicio al cliente empresarial (agentes especializados por dominio)
- Sistemas de ciudades inteligentes con múltiples servicios
- Automatización empresarial con delegación de tareas
- Redes de agentes autónomos para investigación
- Simulaciones complejas multi-agente
- Sistemas distribuidos de toma de decisiones

**Ventajas:**

- **Protocolo estándar:** Basado en JSON-RPC 2.0 y HTTP(S), ampliamente soportado
- **Descubrimiento automático:** Agent Cards permiten descubrimiento dinámico de capacidades
- **Comunicación rica:** Soporte multi-modal (texto, archivos, datos estructurados)
- **Gestión de estado:** Manejo completo de tareas de larga duración con estados
- **Seguridad empresarial:** Autenticación, autorización y trazabilidad integradas
- **Escalabilidad probada:** Basado en estándares web escalables
- **Interoperabilidad:** Agentes de diferentes proveedores pueden colaborar

**Desventajas:**

- **Complejidad de coordinación:** Orquestación de múltiples agentes requiere lógica sofisticada
- **Latencia de red:** Comunicación entre agentes añade overhead de red
- **Gestión de dependencias:** Fallos en un agente pueden afectar toda la cadena
- **Debugging distribuido:** Trazear problemas a través de múltiples agentes es complejo
- **Consistencia de datos:** Mantener estado consistente entre agentes es desafiante
- **Overhead de protocolo:** Metadatos y estructuras A2A añaden complejidad

**Requisitos Asociados:** REQ-AGT-190, REQ-AGT-191, REQ-AGT-192, REQ-AGT-193, REQ-AGT-194, REQ-AGT-195, REQ-AGT-196, REQ-AGT-197, REQ-AGT-198, REQ-AGT-199

#### 4.1.3. Patrones de Recursos

##### 7. Uso de Herramientas (Tool Use)

**Definición:** El agente analiza la solicitud del usuario, descubre las herramientas disponibles (ej. búsqueda web, bases de datos, APIs), verifica los permisos de seguridad y llama a la herramienta correcta con los parámetros apropiados. Debe haber una lógica de fallback si la herramienta falla.

**Uso y Aplicaciones:**

- Flujos de trabajo de múltiples pasos
- Asistencia de investigación automatizada
- Análisis de datos en tiempo real
- Servicio al cliente con acceso a sistemas
- Gestión de contenido dinámico
- Automatización de tareas administrativas

**Ventajas:**

- **Capacidades extendidas:** Mejora significativamente las capacidades del agente
- **Precisión:** Reduce errores al acceder a datos reales
- **Actualización:** Información siempre actualizada desde fuentes autoritativas
- **Versatilidad:** Un agente puede realizar múltiples tipos de tareas

**Desventajas:**

- **Propagación de errores:** Si usa herramienta incorrectamente, error se propaga
- **Dependencias externas:** Fallas en herramientas afectan todo el sistema
- **Complejidad de permisos:** Gestión de seguridad se vuelve compleja
- **Debugging difícil:** Errores pueden originarse en múltiples puntos

**Requisitos Asociados:** REQ-AGT-040, REQ-AGT-041, REQ-AGT-042

##### 8. Gestión de Memoria (Memory Management)

**Definición:** Clasificar la información entrante en memoria a corto plazo (ventana de contexto), eventos episódicos o conocimiento a largo plazo. La información se almacena con metadatos como la recencia y la relevancia, a menudo utilizando una base de datos vectorial.

**Uso y Aplicaciones:**

- Conversaciones que requieren continuidad
- Servicios personalizados a largo plazo
- Asistencia personal inteligente
- Servicio al cliente con historial
- Plataformas de asistencia educativa
- Sistemas de recomendación adaptativos

**Ventajas:**

- **Continuidad:** Preservación del contexto a lo largo del tiempo
- **Personalización:** Adaptación basada en interacciones previas
- **Eficiencia:** Evita repetir información ya conocida
- **Aprendizaje:** Mejora con cada interacción

**Desventajas:**

- **Riesgos de privacidad:** Potencial compromiso de seguridad/privacidad
- **Sobrecarga de almacenamiento:** Crecimiento continuo de datos
- **Gestión de obsolescencia:** Difícil determinar cuándo purgar memorias
- **Complejidad de retrieval:** Recuperar información relevante puede ser complejo

**Requisitos Asociados:** REQ-AGT-070, REQ-AGT-071, REQ-AGT-072

##### 9. Optimización Consciente de Recursos (Resource-Aware Optimization)

**Definición:** Analizar la complejidad de una tarea (simple, media, compleja) y enrutarla al recurso apropiado. Las tareas simples usan modelos rápidos y baratos; las tareas complejas usan modelos más potentes, pero costosos. Se establece un presupuesto (límite de tokens, tiempo o dinero) para cada tarea.

**Uso y Aplicaciones:**

- Operaciones sensibles a los costos
- Procesamiento de alto volumen
- Sistemas con grandes restricciones presupuestarias
- Plataformas empresariales de gran escala
- Servicios freemium con límites de uso

**Ventajas:**

- **Eficiencia de costos:** Reduce significativamente el costo de operación
- **Optimización automática:** Asignación inteligente de recursos
- **Escalabilidad económica:** Permite manejar más volumen con mismo presupuesto
- **Flexibilidad:** Adaptación dinámica a restricciones cambiantes

**Desventajas:**

- **Complejidad del sistema:** Aumenta significativamente la complejidad
- **Desafíos de calibración:** Rúbrica para clasificar complejidad debe ser muy robusta
- **Riesgo de subestimación:** Tareas complejas mal clasificadas dan resultados pobres
- **Overhead de decisión:** Tiempo adicional para clasificar cada tarea

**Requisitos Asociados:** _No hay requisitos específicos definidos - Implementación a nivel de infraestructura_

#### 4.1.4. Patrones de Planificación

##### 10. Planificación (Planning)

**Definición:** Crear un plan detallado paso a paso a partir de un objetivo principal, definiendo hitos, un gráfico de dependencias y revisando las restricciones (autorización, presupuesto, plazos) antes de la ejecución.

**Uso y Aplicaciones:**

- Flujos de trabajo orientados a objetivos ambiciosos
- Gestión de proyectos automatizada
- Desarrollo de software planificado
- Proyectos de investigación estructurados
- Planificación estratégica empresarial
- Automatización de procesos complejos

**Ventajas:**

- **Ejecución estratégica:** Más planificación = más claridad en ejecución
- **Adaptabilidad:** Flujo de trabajo adaptable a variables nuevas
- **Previsión:** Identificación temprana de obstáculos y dependencias
- **Optimización:** Uso eficiente de recursos disponibles

**Desventajas:**

- **Alta complejidad:** Tiempo de configuración inicial muy elevado
- **Coordinación difícil:** Dificultad para coordinar agentes y herramientas
- **Overhead de planificación:** Tiempo significativo invertido en planificar vs. ejecutar
- **Rigidez:** Planes muy detallados pueden ser difíciles de modificar

**Requisitos Asociados:** REQ-AGT-050, REQ-AGT-051, REQ-AGT-052

##### 11. Establecimiento y Monitoreo de Metas (Goal Setting and Monitoring)

**Definición:** Definir objetivos específicos, medibles, alcanzables, relevantes y con plazos (metas SMART). Se establecen KPIs (Key Performance Indicators) y se monitorea continuamente el progreso en comparación con los objetivos. Si el sistema se desvía, analiza la causa y ajusta el plan o el alcance.

**Uso y Aplicaciones:**

- Proyectos complejos con múltiples objetivos
- Operaciones totalmente autónomas
- Ejecución estratégica a largo plazo
- Pipelines de ventas sofisticados
- Optimización de sistemas en tiempo real
- Gestión de costos automatizada

**Ventajas:**

- **Maximización de eficiencia:** Intenta optimizar uso de recursos disponibles
- **Transparencia:** Progreso claramente visible y medible
- **Adaptabilidad:** Ajustes automáticos basados en desempeño real
- **Accountability:** Responsabilidad clara sobre resultados

**Desventajas:**

- **Conflictos de objetivos:** Potenciales conflictos entre metas múltiples
- **Rigidez de restricciones:** Puede requerir mucho tiempo de afinación
- **Complejidad de métricas:** KPIs mal definidos pueden llevar a comportamientos no deseados
- **Overhead de monitoreo:** Recursos significativos dedicados a medición

**Requisitos Asociados:** REQ-AGT-090, REQ-AGT-091, REQ-AGT-092

##### 12. Priorización (Prioritization)

**Definición:** Puntuar las tareas basándose en valor, riesgo, esfuerzo y urgencia. Se construye un gráfico de dependencias para determinar qué debe suceder primero. Es un sistema dinámico que reevalúa las prioridades si la ejecución de una tarea cambia el estado del entorno.

**Uso y Aplicaciones:**

- Entornos dinámicos con recursos limitados
- Sistemas de gestión de tareas inteligentes
- Servicio al cliente con múltiples canales
- Manufactura con líneas de producción flexibles
- Atención médica con triaje automático
- DevOps con múltiples pipelines

**Ventajas:**

- **Adaptabilidad:** Respuesta dinámica a cambios en el entorno
- **Transparencia:** Criterios de priorización claros y auditables
- **Optimización:** Maximiza valor entregado con recursos disponibles
- **Flexibilidad:** Fácil reconfiguración de criterios de priorización

**Desventajas:**

- **Context switching:** Cambio constante si reevaluación es muy frecuente
- **Complejidad determinística:** Difícil hacer reevaluación completamente determinista
- **Overhead de decisión:** Tiempo significativo invertido en priorizar
- **Starvation:** Tareas de baja prioridad pueden nunca ejecutarse

**Requisitos Asociados:** _No hay requisitos específicos definidos - Implementación a nivel de algoritmo_

#### 4.1.5. Patrones de Aprendizaje

##### 13. Aprendizaje y Adaptación (Learning and Adaptation)

**Definición:** Recopilar señales de calidad o feedback (correcciones de usuarios, resultados, calificaciones); limpiar y validar estos datos; y utilizarlos para actualizar los prompts, políticas o ejemplos que el agente usa (similar a ajustar una receta basada en el gusto del cliente).

**Uso y Aplicaciones:**

- Sistemas que requieren incorporación continua de feedback
- Servicios personalizados que evolucionan
- Plataformas donde se adapta experiencia basada en interacción
- Sistemas de recomendación adaptativos
- Chatbots que mejoran con uso
- Herramientas de productividad que aprenden preferencias

**Ventajas:**

- **Mejora continua:** El agente se vuelve mejor con el tiempo
- **Personalización:** Adaptación a preferencias específicas del usuario
- **Relevancia:** Respuestas más relevantes basadas en experiencia
- **Evolución:** Sistema evoluciona sin intervención manual

**Desventajas:**

- **Costos acumulativos:** Cada bucle de feedback añade costo operativo
- **Riesgo de aprendizaje incorrecto:** Puede aprender información maliciosa o incorrecta
- **Complejidad de validación:** Requiere controles y equilibrios robustos
- **Deriva de comportamiento:** Cambios graduales pueden alterar comportamiento original

**Requisitos Asociados:** REQ-AGT-080, REQ-AGT-081, REQ-AGT-082

##### 14. Recuperación de Conocimiento (Knowledge Retrieval/RAG)

**Definición:** Indexar documentos (indexación, fragmentación, creación de embeddings) para que sean buscables y recuperables, permitiendo al agente obtener información específica y actualizada de fuentes externas. Esencialmente, es el patrón de Generación Aumentada por Recuperación (RAG).

**Uso y Aplicaciones:**

- Sistemas que requieren acceso a conocimiento basado en documentos
- Búsqueda empresarial (enterprise search)
- Soporte al cliente con base de conocimientos
- Asistencia de investigación académica
- Documentación técnica interactiva
- Sistemas de preguntas y respuestas especializados

**Ventajas:**

- **Precisión mejorada:** Aumenta significativamente la accuracy del sistema
- **Escalabilidad de conocimiento:** Puede acceder a vastas cantidades de información
- **Actualización dinámica:** Información siempre actualizada sin reentrenar
- **Trazabilidad:** Fuentes de información claramente identificables

**Desventajas:**

- **Costo de infraestructura:** Construir y mantener bases de datos vectoriales
- **Complejidad de indexación:** Proceso complejo de preparación de documentos
- **Calidad de retrieval:** Resultados dependen de calidad de embeddings
- **Latencia adicional:** Tiempo extra para búsqueda y recuperación

**Requisitos Asociados:** _Implementado a través de REQ-AGT-072 (Base de datos vectorial)_

##### 15. Exploración y Descubrimiento (Exploration and Discovery)

**Definición:** Proceso sistemático e iterativo de búsqueda, análisis y síntesis de información novedosa dentro de espacios de conocimiento abiertos o desconocidos. Utiliza el ciclo DECIDE (Decidir, Ejecutar, Criticar, Iterar, Descubrir, Estado) con gestión de estado cíclico, patrón ReAct, reflexión autocorrectiva y búsqueda híbrida entre conocimiento indexado y datos en tiempo real.

**Uso y Aplicaciones:**

- Proyectos de investigación (académica, I+D)
- Análisis competitivo detallado
- Descubrimiento de fármacos (drug discovery)
- Investigación de mercado automatizada
- Análisis de tendencias emergentes
- Minería de datos exploratoria

**Ventajas:**

- **Exploración sistemática:** Ciclo DECIDE proporciona estructura metodológica para investigación autónoma
- **Autocorrección inteligente:** Reflexión y patrón ReAct permiten refinamiento iterativo de estrategias
- **Búsqueda híbrida:** Combina eficientemente conocimiento indexado (RAG) con datos en tiempo real
- **Detección de novedad:** Identifica conexiones no obvias, patrones emergentes y anomalías significativas
- **Gestión de estado persistente:** Mantiene contexto y evita redundancia en exploraciones complejas
- **Trazabilidad completa:** Cada paso de razonamiento es auditable y optimizable
- **Escalabilidad técnica:** Arquitectura basada en grafos con estado soporta exploración compleja

**Desventajas:**

- **Complejidad arquitectónica:** Requiere frameworks especializados (LangGraph, LlamaIndex) y gestión de estado cíclico
- **Riesgo de bucles infinitos:** Necesita límites estrictos de iteración y criterios de parada inteligentes
- **Costo computacional alto:** Múltiples iteraciones de LLM y herramientas externas aumentan costos operativos
- **Latencia variable:** Web scraping y análisis profundo introducen tiempos de respuesta impredecibles
- **Debugging complejo:** Flujos no lineales con reflexión son difíciles de depurar y optimizar
- **Dependencia de herramientas:** Requiere integración robusta con bases de datos vectoriales y APIs externas
- **Calidad no garantizada:** Exploración abierta puede no converger a resultados útiles o relevantes

**Requisitos Asociados:** REQ-AGT-200, REQ-AGT-201, REQ-AGT-202, REQ-AGT-203, REQ-AGT-204, REQ-AGT-205, REQ-AGT-206, REQ-AGT-207, REQ-AGT-208, REQ-AGT-209

#### 4.1.6. Patrones de Control

##### 16. Manejo y Recuperación de Excepciones (Exception Handling and Recovery)

**Definición:** Un mecanismo para detectar errores en los flujos de trabajo. Clasifica el error (permanente, temporal, crítico), activa planes de respaldo (Plan B), y utiliza métodos de recuperación como la espera con retroceso exponencial (exponential backoff) para errores temporales, o la intervención humana en fallos críticos.

**Uso y Aplicaciones:**

- Sistemas de grado empresarial
- Aseguramiento de la calidad (QA)
- Gestión de costos automatizada
- Cualquier sistema donde se deban contabilizar errores vitales
- Sistemas de misión crítica
- Aplicable a prácticamente todos los demás patrones

**Ventajas:**

- **Visibilidad mejorada:** Mayor visibilidad del rendimiento del sistema
- **Confianza del usuario:** Aumenta confianza por existencia de fallbacks
- **Robustez:** Sistema más resistente a fallos inesperados
- **Recuperación automática:** Minimiza intervención manual

**Desventajas:**

- **Infraestructura compleja:** Requiere gran cantidad de infraestructura adicional
- **Complejidad de implementación:** Muy complejo de implementar correctamente
- **Fatiga de alertas:** Riesgo de generar demasiadas falsas alarmas
- **Overhead de monitoreo:** Recursos significativos dedicados a detección

**Requisitos Asociados:** REQ-AGT-120, REQ-AGT-121, REQ-AGT-131

##### 17. Intervención Humana (Human in the Loop)

**Definición:** Incluir a un humano para intervenir en puntos de decisión predefinidos. Esto es crucial en situaciones de alto riesgo, cumplimiento normativo, o cuando se presentan casos límite (edge cases) que el agente no puede manejar con suficiente confianza.

**Uso y Aplicaciones:**

- Decisiones de alto riesgo financiero o legal
- Cumplimiento normativo (donde alucinación es inaceptable)
- Moderación de contenido sensible
- Diagnóstico médico asistido
- Aprobaciones de transacciones importantes
- Sistemas de seguridad crítica

**Ventajas:**

- **Confianza significativamente aumentada:** Supervisión humana genera confianza
- **Curso de acción definido:** Clara escalación para puntos de fallo
- **Cumplimiento regulatorio:** Satisface requisitos de supervisión humana
- **Control de calidad:** Humanos pueden detectar errores sutiles

**Desventajas:**

- **Latencia añadida:** Sistema debe esperar intervención humana
- **Costo de personal:** Requiere recursos humanos dedicados
- **Cuello de botella:** Humanos pueden limitar throughput del sistema
- **Disponibilidad:** Dependiente de disponibilidad de supervisores humanos

**Requisitos Asociados:** _No hay requisitos específicos definidos - Implementación a nivel de proceso_

##### 18. Patrones de Barreras de Seguridad (Guardrails and Safety Patterns)

**Definición:** Verificar todas las entradas (inputs) en busca de contenido dañino, información personal identificable (PII), o ataques de inyección (ej. SQL injection). Clasifica el riesgo (bajo, medio, alto) y aplica controles como filtrado, redacción o bloqueo.

**Uso y Aplicaciones:**

- Sistemas de alto riesgo o públicos
- Cumplimiento normativo estricto
- Protección de marca corporativa
- Seguridad del usuario en plataformas
- Chatbots con caja de texto abierta
- Sistemas que procesan contenido generado por usuarios

**Ventajas:**

- **Mitigación de riesgos:** Protección proactiva contra amenazas
- **Cumplimiento mejorado:** Satisface requisitos regulatorios
- **Protección de marca:** Evita asociación con contenido problemático
- **Confianza del usuario:** Usuarios se sienten más seguros

**Desventajas:**

- **Falsos positivos:** Puede bloquear contenido legítimo incorrectamente
- **Fricción del usuario:** Puede frustrar usuarios con restricciones excesivas
- **Complejidad de reglas:** Difícil balancear seguridad con usabilidad
- **Evolución de amenazas:** Nuevos tipos de ataques requieren actualizaciones constantes

**Requisitos Asociados:** REQ-AGT-140, REQ-AGT-141, REQ-AGT-142

#### 4.1.7. Patrones de Calidad

##### 19. Evaluación y Monitoreo (Evaluation and Monitoring)

**Definición:** Establecer puertas de calidad (quality gates) y conjuntos de pruebas de oro (golden test sets) antes del despliegue. Monitorear continuamente en producción métricas como la precisión, el rendimiento, el costo y la desviación (drift). Busca detectar regresiones y anomalías.

**Uso y Aplicaciones:**

- Sistemas de grado de producción
- Aseguramiento de la calidad (QA) automatizado
- SaaS empresarial con SLAs estrictos
- Atención médica con requisitos de precisión
- Industria financiera con regulaciones estrictas
- Comercio electrónico a gran escala

**Ventajas:**

- **Fiabilidad aumentada:** Aumenta significativamente la robustez del sistema
- **Detección temprana:** Identifica problemas antes de que afecten usuarios
- **Mejora continua:** Datos de monitoreo informan optimizaciones
- **Cumplimiento:** Satisface requisitos de auditoria y regulación

**Desventajas:**

- **Impacto en rendimiento:** Sistema de monitoreo debe ser robusto a gran escala
- **Fatiga de alertas:** Riesgo de generar demasiadas alertas
- **Complejidad de métricas:** Difícil definir métricas que capturen calidad real
- **Overhead de infraestructura:** Recursos significativos dedicados a monitoreo

**Requisitos Asociados:** REQ-AGT-150, REQ-AGT-151, REQ-AGT-152

##### 20. Técnicas de Razonamiento (Reasoning Techniques)

**Definición:** Elegir el método de razonamiento adecuado para el problema. Incluye Chain of Thought (lógica paso a paso), Tree of Thought (exploración de múltiples caminos y poda de ramas no viables), y métodos de debate adversarial entre agentes.

**Uso y Aplicaciones:**

- Técnicas avanzadas solo para problemas muy complejos
- Razonamiento matemático avanzado
- Planificación estratégica a gran escala
- Análisis legal complejo
- Diagnóstico médico diferencial
- Considerado altamente experimental para mayoría de casos de uso

**Ventajas:**

- **Proceso exhaustivo:** Abordaje muy robusto para problemas complejos
- **Calidad de razonamiento:** Mejora significativa en lógica y coherencia
- **Transparencia:** Proceso de razonamiento es visible y auditable
- **Versatilidad:** Aplicable a múltiples dominios de problemas complejos

**Desventajas:**

- **Alto consumo de tokens:** Muy costoso en términos de uso de API
- **Complejidad extrema:** Muy difícil de implementar y mantener
- **Overthinking:** Riesgo de "pensar demasiado" por parte de LLMs
- **Latencia significativa:** Tiempo de respuesta muy elevado

**Requisitos Asociados:** _No hay requisitos específicos definidos - Patrón experimental avanzado_

### 4.2. Matriz de Aplicabilidad por Dominio

| Patrón         | Desarrollo Software | Servicio Cliente | Análisis Datos | Investigación | Automatización |
| -------------- | ------------------- | ---------------- | -------------- | ------------- | -------------- |
| Encadenamiento | ✅ Alto             | ✅ Alto          | ✅ Alto        | ✅ Alto       | ✅ Alto        |
| Enrutamiento   | ✅ Alto             | ✅ Crítico       | ⚠️ Medio       | ⚠️ Medio      | ✅ Alto        |
| Paralelización | ✅ Alto             | ⚠️ Medio         | ✅ Crítico     | ✅ Alto       | ✅ Alto        |
| Reflexión      | ✅ Alto             | ✅ Alto          | ⚠️ Medio       | ✅ Crítico    | ⚠️ Medio       |
| Herramientas   | ✅ Crítico          | ✅ Alto          | ✅ Crítico     | ✅ Crítico    | ✅ Crítico     |

### 4.3. Consideraciones de Implementación

#### 4.3.1. Stack Tecnológico Recomendado

**Lenguajes de Programación:**

- Python 3.9+ (principal)
- TypeScript/Node.js (APIs y frontend)
- Go (servicios de alto rendimiento)

**Frameworks y Librerías:**

- FastAPI (APIs REST)
- LangChain/LlamaIndex (orquestación de IA)
- Celery (procesamiento asíncrono)
- Redis (caché y colas)

**Infraestructura:**

- Kubernetes (orquestación)
- Docker (contenedores)
- Prometheus + Grafana (monitoreo)
- Elasticsearch (logging)

#### 4.3.2. Patrones de Despliegue

**Desarrollo:**

- Entorno local con Docker Compose
- APIs mock para modelos de IA
- Bases de datos en memoria

**Staging:**

- Cluster Kubernetes dedicado
- APIs de IA con límites reducidos
- Datos sintéticos para testing

**Producción:**

- Cluster Kubernetes multi-zona
- APIs de IA con SLA empresarial
- Monitoreo 24/7 y alertas

### 4.4. Métricas y KPIs

#### 4.4.1. Métricas Técnicas

- **Latencia promedio por patrón**: < 5 segundos
- **Throughput**: > 1000 requests/minuto
- **Disponibilidad**: > 99.9%
- **Tasa de error**: < 0.1%

#### 4.4.2. Métricas de Negocio

- **Precisión de respuestas**: > 95%
- **Satisfacción del usuario**: > 4.5/5
- **Costo por transacción**: Optimizado mensualmente
- **Tiempo de resolución**: Reducido 50% vs. baseline

#### 4.4.3. Métricas de Calidad

- **Cobertura de tests**: > 90%
- **Deuda técnica**: < 10% del código
- **Tiempo de despliegue**: < 15 minutos
- **MTTR (Mean Time To Recovery)**: < 30 minutos

### 4.5. Glosario Técnico

#### 4.5.1. Términos de Gestión de Memoria

**Recencia**
: Metadato temporal que indica qué tan reciente o nueva es la información almacenada en el sistema de memoria del agente. Incluye:

- Timestamp de creación de la información
- Timestamp de último acceso
- Edad de la información (tiempo transcurrido desde creación)
- Utilizado para priorización, decisiones de caché y purga de datos obsoletos

**Relevancia**
: Metadato que indica qué tan pertinente o importante es la información para el contexto actual del agente. Se calcula mediante:

- Similitud semántica con la consulta actual
- Frecuencia de acceso histórica
- Puntuación de importancia asignada por el usuario
- Utilizado junto con recencia para algoritmos de scoring de recuperación

**Memoria Episódica**
: Tipo de memoria que almacena eventos específicos y experiencias del agente, incluyendo:

- Conversaciones pasadas con usuarios específicos
- Resultados de tareas ejecutadas
- Contexto temporal de interacciones
- Se diferencia de la memoria semántica (conocimiento general)

**Memoria a Largo Plazo**
: Sistema de almacenamiento persistente que mantiene información más allá de la ventana de contexto inmediata:

- Implementada típicamente con bases de datos vectoriales
- Incluye mecanismos de indexación y recuperación
- Soporta búsqueda semántica eficiente
- Requiere estrategias de gestión de obsolescencia

#### 4.5.2. Términos de Procesamiento

**Context Explosion**
: Fenómeno donde la acumulación de datos entre pasos de procesamiento causa:

- Crecimiento exponencial del contexto del agente
- Aumento en la probabilidad de alucinaciones
- Degradación del rendimiento por tokens excesivos
- Común en patrones de encadenamiento mal diseñados

**Drift (Deriva)**
: Cambio gradual en el comportamiento de modelos de IA a lo largo del tiempo debido a:

- Actualizaciones en los modelos de lenguaje subyacentes
- Cambios en los datos de entrenamiento
- Modificaciones en las APIs de proveedores
- Requiere monitoreo continuo y recalibración

**Fallback**
: Mecanismo de respaldo que se activa cuando falla el proceso principal:

- Estrategias alternativas para completar tareas
- Degradación elegante de funcionalidad
- Prevención de fallos en cascada
- Esencial para sistemas de producción robustos

**API Throttling**
: Limitación de velocidad impuesta por proveedores de servicios de IA:

- Límites de requests por minuto/hora
- Límites de tokens por período
- Puede causar delays o fallos en sistemas intensivos
- Requiere estrategias de rate limiting y retry

#### 4.5.3. Términos de Arquitectura

**Stateless**
: Diseño donde los agentes no mantienen estado interno entre requests:

- Cada request es independiente y autocontenido
- Estado se externaliza a servicios especializados
- Facilita escalabilidad horizontal
- Simplifica recuperación ante fallos

**Circuit Breaker**
: Patrón de diseño que previene llamadas repetidas a servicios que fallan:

- Estados: Cerrado (normal), Abierto (bloqueando), Semi-abierto (probando)
- Evita cascadas de errores en sistemas distribuidos
- Permite recuperación automática de servicios
- Mejora la resiliencia general del sistema

**Orquestador**
: Componente central que coordina la ejecución de múltiples agentes:

- Gestiona flujos de trabajo complejos
- Asigna tareas a agentes especializados
- Maneja dependencias entre tareas
- Proporciona visibilidad y control centralizado

**Embeddings**
: Representaciones vectoriales de texto que capturan significado semántico:

- Vectores de alta dimensionalidad (típicamente 768-1536 dimensiones)
- Permiten búsqueda semántica eficiente
- Base para sistemas RAG y memoria vectorial
- Generados por modelos especializados (OpenAI, Sentence Transformers)

#### 4.5.4. Términos de Calidad y Evaluación

**Golden Test Sets**
: Conjuntos de pruebas curadas manualmente que representan casos de uso ideales:

- Inputs y outputs esperados de alta calidad
- Utilizados para evaluación consistente de modelos
- Benchmark para detectar regresiones
- Requieren mantenimiento y actualización regular

**Quality Gates**
: Puntos de control automatizados que validan calidad antes del despliegue:

- Umbrales mínimos de métricas de calidad
- Tests automatizados que deben pasar
- Validaciones de seguridad y compliance
- Bloquean despliegues que no cumplen estándares

**Alucinación**
: Generación de información incorrecta o inventada por modelos de IA:

- Respuestas que parecen plausibles pero son falsas
- Más común con contextos largos o información ambigua
- Mitigada con técnicas de grounding y validación
- Riesgo crítico en aplicaciones de alta precisión

#### 4.5.5. Términos de Seguridad

**PII (Personally Identifiable Information)**
: Información que puede identificar a individuos específicos:

- Nombres, direcciones, números de teléfono
- Números de identificación, emails
- Requiere protección especial y compliance
- Debe ser detectada y manejada apropiadamente

**Guardrails**
: Mecanismos de seguridad que limitan comportamientos no deseados:

- Filtros de contenido dañino o inapropiado
- Validación de inputs y outputs
- Clasificación de riesgos automática
- Esenciales para sistemas públicos

**Injection Attacks**
: Ataques donde se insertan comandos maliciosos en inputs:

- Prompt injection en sistemas de IA
- SQL injection en bases de datos
- Requieren validación y sanitización rigurosa
- Pueden comprometer seguridad del sistema

#### 4.5.6. Términos de Rendimiento

**Throughput**
: Número de requests o transacciones procesadas por unidad de tiempo:

- Medido típicamente en requests/segundo o requests/minuto
- Indicador clave de capacidad del sistema
- Debe balancearse con latencia y calidad
- Afectado por complejidad de patrones y recursos disponibles

**Latencia**
: Tiempo transcurrido entre request y response:

- Incluye tiempo de procesamiento y comunicación de red
- Crítica para experiencia de usuario
- Varía significativamente entre patrones (simples vs. complejos)
- Debe monitorearse en percentiles (P50, P95, P99)

**Escalabilidad Horizontal**
: Capacidad de aumentar capacidad agregando más instancias:

- Preferida sobre escalabilidad vertical (más recursos por instancia)
- Requiere diseño stateless y load balancing
- Fundamental para sistemas cloud-native
- Permite manejar picos de demanda dinámicamente

#### 4.5.7. Términos de Protocolo A2A

**Agent Card**
: Documento JSON de metadatos que describe completamente las capacidades de un agente A2A:

- Típicamente disponible en `/.well-known/agent.json`
- Incluye nombre, descripción, capacidades, esquemas de autenticación
- Permite descubrimiento automático de agentes
- Facilita la interoperabilidad entre diferentes implementaciones

**JSON-RPC 2.0**
: Protocolo de llamada a procedimientos remotos usado como base para comunicación A2A:

- Formato de mensaje estándar y bien definido
- Soporte para requests síncronos y asíncronos
- Manejo de errores estructurado
- Ampliamente soportado en múltiples lenguajes de programación

**Task State Management**
: Sistema de gestión de estados para tareas distribuidas en A2A:

- Estados: submitted, working, input-required, completed, failed
- Permite seguimiento de tareas de larga duración
- Soporta interacciones multi-turno entre agentes
- Esencial para coordinación compleja entre agentes

**Multi-modal Communication**
: Capacidad de intercambiar diferentes tipos de contenido entre agentes:

- TextPart: Contenido de texto plano
- FilePart: Transferencia de archivos
- DataPart: Datos estructurados (JSON, formularios)
- Permite comunicación rica más allá de texto simple

**Agent Discovery**
: Mecanismos para que los agentes encuentren y se conecten con otros agentes:

- URI Discovery: Rutas estándar como `/.well-known/agent.json`
- Registry Discovery: Directorios centralizados de agentes
- Direct Configuration: Configuración manual de endpoints
- Fundamental para ecosistemas de agentes dinámicos

#### 4.5.8. Términos de Exploración y Descubrimiento

**Ciclo DECIDE**
: Metodología estructurada para exploración autónoma de agentes de IA:

- **D**ecidir: Planificación inicial de la estrategia de exploración
- **E**jecutar: Acción con herramientas (RAG, web scraping, APIs)
- **C**riticar: Evaluación crítica de resultados obtenidos
- **I**terar: Bucle cíclico de refinamiento basado en feedback
- **D**escubrir: Identificación de información novedosa y patrones
- **E**stado: Memoria persistente del contexto y progreso

**Patrón ReAct**
: Alternancia sistemática entre razonamiento y actuación en agentes de exploración:

- Reasoning: LLM genera "pensamiento" sobre qué herramienta usar
- Acting: Ejecución de la herramienta seleccionada con parámetros apropiados
- Interpretación: Análisis de resultados para decidir próximo paso
- Fundamental para exploración iterativa e inteligente

**Reflexión Autocorrectiva**
: Mecanismo de metacognición que permite al agente evaluar y mejorar sus propios resultados:

- Nodo Actor: Genera respuesta o plan de exploración inicial
- Nodo Reflector: Evalúa críticamente la calidad del resultado
- Arista Condicional: Decide si iterar (mejorar) o terminar (satisfactorio)
- Previene errores redundantes y mejora calidad de descubrimientos

**Gestión de Estado Cíclico**
: Capacidad de mantener contexto persistente a través de múltiples iteraciones de exploración:

- Implementado típicamente con LangGraph o frameworks equivalentes
- Permite recordar caminos intentados y resultados parciales
- Evita redundancia y bucles infinitos en exploración
- Esencial para tareas de investigación complejas y de larga duración

**Búsqueda Híbrida**
: Estrategia que combina múltiples fuentes de información para exploración completa:

- RAG (Retrieval-Augmented Generation): Conocimiento indexado y estructurado
- Web Scraping: Datos en tiempo real y fuentes no indexadas
- APIs Externas: Servicios especializados y bases de datos dinámicas
- Priorización inteligente: RAG primero, web scraping cuando sea necesario

**Clustering Semántico**
: Técnica de agrupación de información descubierta por temas y patrones:

- Identifica conexiones no obvias entre conceptos
- Agrupa hallazgos por relevancia y similitud semántica
- Permite enfoque en pistas más prometedoras
- Utiliza embeddings y análisis vectorial para agrupación

**Detección de Novedad**
: Capacidad del agente para identificar información verdaderamente nueva o inesperada:

- Comparación con conocimiento base existente
- Identificación de anomalías y patrones emergentes
- Priorización de descubrimientos únicos o contradictorios
- Fundamental para investigación e innovación automatizada

---

_Esta especificación de requisitos es de cumplimiento obligatorio para garantizar sistemas de agentes de IA robustos, escalables y confiables._

---

## 🔧 Uso del MCP Server

### Comandos Útiles con IA

Con los servidores MCP configurados, puedes solicitar a tu asistente de IA:

1. **Flutter MCP:**
   - "Revisa y corrige errores de análisis estático"
   - "Encuentra un paquete para [funcionalidad] y agrégalo"
   - "Inspecciona el árbol de widgets y optimiza"

2. **Figma MCP:**
   - "Extrae los assets del diseño de Figma"
   - "Implementa este componente según el diseño"
   - "Obtén los estilos y colores desde Figma"

## 🆕 Crear Nuevos Skills

Para agregar un nuevo skill:

1. Crea una carpeta en `skills/` o subcategoría apropiada
2. Crea un archivo `SKILL.md` con:
   - Metadata en YAML frontmatter
   - Keywords para invocación
   - Documentación detallada
   - Ejemplos de código
3. Actualiza este archivo con un enlace al nuevo skill

## 📖 Referencias

- [Documentación Flutter MCP Server](https://dart.dev/tools/mcp-server/)
- [Figma MCP Server Guide](https://github.com/figma/mcp-server-guide/)
- [LangChain Deep Agents + Skills](https://blog.langchain.com/using-skills-with-deep-agents/)

---

**Última actualización:** Diciembre 2025  
**Versión:** 2.0.0
