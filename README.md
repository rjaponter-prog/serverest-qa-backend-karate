# ServeRest QA Backend Automation

Proyecto de automatización de pruebas de API REST desarrollado con Karate DSL, Java y Maven sobre la API pública ServeRest.

## Objetivo

Automatizar los principales flujos CRUD del recurso de usuarios y validar escenarios positivos y negativos relacionados con reglas de negocio, estructura JSON, códigos HTTP y persistencia de datos.

API utilizada:

https://serverest.dev

## Tecnologías

- Java 21
- Maven
- Karate DSL 2.1.0
- JUnit
- IntelliJ IDEA
- Git / GitHub

## Endpoints automatizados

- GET `/usuarios`
- GET `/usuarios/{_id}`
- POST `/usuarios`
- PUT `/usuarios/{_id}`
- DELETE `/usuarios/{_id}`

## Cobertura de pruebas

La suite incluye escenarios como:

- consulta de lista de usuarios;
- creación de usuario;
- consulta por ID;
- actualización de usuario;
- eliminación de usuario;
- email duplicado;
- body vacío;
- campos obligatorios;
- email con formato inválido;
- valor inválido en `administrador`;
- tipo de dato incorrecto en `administrador`;
- ID inexistente;
- ID con formato inválido;
- DELETE con ID inexistente;
- PUT con ID inexistente;
- actualización con email perteneciente a otro usuario;
- validación de persistencia mediante consultas posteriores;
- validación de estructura y tipos de datos del response.

## Datos dinámicos

Para evitar colisiones entre ejecuciones se utilizan datos dinámicos mediante UUID.

Además, se implementó el helper:

`src/test/java/helpers/user-data.js`

Este helper genera usuarios de prueba reutilizables con emails únicos.

## Estructura del proyecto

```text
src
└── test
    └── java
        ├── helpers
        │   └── user-data.js
        └── users
            ├── users-get.feature
            ├── users-get-by-id.feature
            ├── users-post.feature
            ├── users-put.feature
            ├── users-delete.feature
            └── UsersTest.java
```
## Ejecución de pruebas

Desde la raíz del proyecto ejecutar:

```bash
mvn test
```
## Reportes

Después de ejecutar la suite, Karate genera reportes HTML dentro de:

```text
target/karate-reports/
```

El reporte principal puede visualizarse desde:

```text
target/karate-reports/index.html
```

## Resultado actual

Resultado de la suite automatizada:

```text
Tests run: 19
Failures: 0
Errors: 0
Skipped: 0
BUILD SUCCESS
```

## Enfoque QA

Las pruebas no validan únicamente códigos HTTP.

También se validan:

- mensajes de negocio;
- estructura JSON;
- tipos de datos;
- persistencia de información;
- reglas de unicidad;
- validaciones de formato;
- comportamiento del API ante recursos inexistentes.