# Flutter Agentic Boilerplate

Plantilla de inicio para aplicaciones Flutter listas para producción con backend REST.

El objetivo principal de esta plantilla es que puedas comenzar a trabajar rápidamente en tu próximo proyecto Flutter listo para producción sin toda la molestia de la configuración inicial del proyecto.

## ¿Qué es esto?

Esta es una plantilla de boilerplate simple para crear una aplicación Flutter.

**Además, este proyecto incluye un sistema de Agent Skills** que proporciona conocimiento contextual y capacidades especializadas a los asistentes de IA. Los skills agénticos cubren desde patrones arquitectónicos (MVVM, Clean Architecture) hasta integraciones avanzadas (Firebase, GraphQL, CI/CD) y pueden invocarse automáticamente o explícitamente durante el desarrollo.

Puedes usar este boilerplate como base y aprovechar los skills agénticos para guiar la implementación de features específicas, arquitecturas complejas o integraciones con servicios externos. Los skills se cargan progresivamente solo cuando se necesitan, manteniendo la eficiencia y reduciendo la carga cognitiva.

## ¿Qué NO es esto?

Dado que cada desarrollador puede tener opiniones muy fuertes sobre State Management y Arquitectura de Apps, esta plantilla no toma ninguna postura sobre estos temas por defecto.

Por lo tanto, esto NO es tu plantilla de state management y arquitectura de app pre-configurada. Sin embargo, **los skills agénticos sí incluyen guías detalladas** para implementar diferentes patrones arquitectónicos (MVVM, Clean Architecture, Feature-First, Modular) y sistemas de gestión de estado (BLoC, Riverpod, Provider), permitiéndote elegir e implementar el enfoque que prefieras con la ayuda de los agentes de IA.

O haz fork del repo, personaliza la plantilla a tu gusto y hazla tuya.

Dicho esto, los skills agénticos están diseñados para evolucionar y pueden combinarse según tus necesidades específicas.

## Ejemplo de Estructura del Monorepo

```
proyecto/
├── backend/              # Backend REST API
│   ├── src/
│   ├── tests/
│   └── package.json
├── mobile/               # Aplicación Flutter
│   ├── android/
│   ├── ios/
│   ├── lib/
│   │   ├── core/
│   │   ├── features/
│   │   ├── shared/
│   │   └── main.dart
│   ├── test/
│   ├── assets/
│   │   ├── icon/
│   │   └── splash/
│   ├── pubspec.yaml
│   └── .env-sample
├── skills/               # Agent Skills para asistentes de IA
│   ├── flutter/          # Skills de Flutter (28 skills)
│   │   ├── accessibility/
│   │   ├── analytics-tracking/
│   │   ├── animation-motion/
│   │   ├── app-distribution/
│   │   ├── bloc-advanced/
│   │   ├── clean-architecture/
│   │   ├── code-generation/
│   │   ├── deep-linking/
│   │   ├── error-tracking/
│   │   ├── feature-first/
│   │   ├── feature-flags/
│   │   ├── firebase/
│   │   ├── graphql/
│   │   ├── i18n/
│   │   ├── in-app-purchases/
│   │   ├── mobile-integration-testing/
│   │   │   └── scripts/
│   │   ├── mobile-testing/
│   │   │   └── scripts/
│   │   ├── modular-architecture/
│   │   ├── mvvm/
│   │   ├── native-integration/
│   │   ├── offline-first/
│   │   ├── performance/
│   │   ├── platform-channels/
│   │   ├── project-setup/
│   │   │   └── scripts/
│   │   ├── push-notifications/
│   │   ├── riverpod/
│   │   ├── security/
│   │   ├── testing/
│   │   ├── theming/
│   │   ├── webview-integration/
│   │   ├── BEST_PRACTICES_MAPPING.md
│   │   └── flutter-best-practices.md
│   ├── cicd/             # Skills de CI/CD (9 skills)
│   │   ├── ansible-awx/
│   │   ├── argocd/
│   │   ├── aws/
│   │   ├── azure/
│   │   ├── crossplane/
│   │   ├── gcp/
│   │   ├── github-actions/
│   │   ├── ovhcloud/
│   │   ├── terraform/
│   │   └── README.md
│   ├── figma/            # Design Integration Skills
│   │   └── SKILL.md
│   ├── static-analysis/  # Static Analysis Skills
│   │   └── SKILL.md
│   ├── system-reliability-engineering/  # SRE Skills (14 skills)
│   │   ├── alerting-incident-management/
│   │   ├── api-gateway-rate-limiting/
│   │   │   └── scripts/
│   │   ├── chaos-engineering/
│   │   │   └── scripts/
│   │   ├── container-security/
│   │   │   └── scripts/
│   │   ├── cost-optimization-finops/
│   │   │   └── scripts/
│   │   ├── database-reliability/
│   │   │   └── scripts/
│   │   ├── disaster-recovery-business-continuity/
│   │   │   └── scripts/
│   │   ├── load-testing-performance/
│   │   │   └── scripts/
│   │   ├── logging-log-aggregation/
│   │   │   └── scripts/
│   │   ├── network-policies-security/
│   │   │   └── scripts/
│   │   ├── observability-stack/
│   │   │   └── scripts/
│   │   ├── post-mortem/
│   │   ├── security-compliance-automation/
│   │   │   └── scripts/
│   │   ├── service-mesh/
│   │   │   └── scripts/
│   │   └── slo-sli-sla/
│   │       ├── examples/
│   │       └── scripts/
│   ├── CHANGELOG.md
│   ├── CONTRIBUTING.md
│   ├── LICENSE
│   ├── MCP_SETUP.md
│   ├── README.md
│   └── gemini-extension.json
└── README.md
```

## Comenzando

### Prerrequisitos

- Flutter SDK instalado (versión estable recomendada)
- Dart SDK (incluido con Flutter)
- Android Studio / Xcode para desarrollo móvil
- Git

### Inicialización Rápida

Puedes inicializar el proyecto de dos formas:

#### Opción 1: Usando el Skill Agéntico (Recomendado)

Invoca el skill `@skill:flutter-project-setup` con tu asistente de IA para obtener una configuración guiada y personalizada del proyecto.

#### Opción 2: Usando Scripts Automatizados

Este proyecto incluye scripts automatizados que forman parte del skill `project-setup`:

**Windows (PowerShell):**

```powershell
.\skills\flutter\project-setup\scripts\setup.ps1
```

**Linux/macOS (Bash):**

```bash
chmod +x skills/flutter/project-setup/scripts/setup.sh
./skills/flutter/project-setup/scripts/setup.sh
```

Los scripts de setup realizarán automáticamente:
1. Verificación de instalación de Flutter
2. Creación de la estructura del monorepo (`backend/` y `mobile/`)
3. Inicialización del proyecto Flutter en `mobile/`
4. Instalación de dependencias
5. Configuración básica del proyecto (`.env-sample`, `.gitignore`, README)

## Despliegue

Antes de lanzar tu app de Android, asegúrate de firmarla:

1. Genera un archivo Keystore si aún no tienes uno. Si tienes uno, ignora este paso y ve al siguiente.
2. Ve a `mobile/android/key.properties` e incluye la ruta de tu Keystore, alias y contraseña.

## Skills Agénticos Disponibles

Este proyecto incluye un sistema de **Agent Skills** que proporciona conocimiento contextual y capacidades especializadas a los asistentes de IA. Los skills se invocan automáticamente basándose en keywords en tus prompts o explícitamente usando la sintaxis `@skill:`.

Para más detalles sobre cada skill, consulta [AGENTS.md](AGENTS.md).

### 🎨 Flutter Skills (28)

1. MVVM
2. Clean Architecture
3. Project Setup
4. Testing Strategy
5. BLoC Avanzado
6. Riverpod
7. Feature-First Architecture
8. Arquitectura Modular
9. Code Generation
10. Performance Optimization
11. Accessibility (a11y)
12. Animation & Motion Design
13. Theming Avanzado
14. Internacionalización (i18n)
15. Firebase Integration
16. GraphQL Integration
17. Offline-First Architecture
18. Deep Linking & Universal Links
19. Push Notifications
20. Analytics & Tracking
21. Error Tracking & Crash Reporting
22. Feature Flags & Remote Config
23. In-App Purchases (IAP)
24. App Distribution & Deployment
25. Platform Channels & Native Integration
26. Native Integration (Swift/Kotlin)
27. WebView Integration
28. Security Best Practices

### 🚀 CI/CD Skills (9)

1. GitHub Actions
2. ArgoCD
3. Terraform
4. AWS
5. Google Cloud Platform (GCP)
6. Microsoft Azure
7. OVHCloud
8. Ansible AWX
9. Crossplane

### 🎨 Design Integration Skills (1)

1. Figma Dev Mode

### 🔍 Static Analysis Skills (1)

1. Static Analysis

## Desarrollo

### Ejecutar la App

```bash
cd mobile
flutter run
```

### Ejecutar Tests

```bash
cd mobile
flutter test
```

### Generar Builds

```bash
# Android
cd mobile
flutter build apk --release

# iOS
cd mobile
flutter build ios --release
```

## Contribuir

Las contribuciones son bienvenidas. Por favor:

1. Haz fork del proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

## Soporte

Si encuentras algún problema o tienes preguntas, por favor abre un issue en el repositorio.

---

**¡Feliz desarrollo!** 🚀

