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
