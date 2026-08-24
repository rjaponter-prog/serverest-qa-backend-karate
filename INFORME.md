# Informe de Automatización QA Backend - ServeRest

## 1. Objetivo

Desarrollar una suite de pruebas automatizadas para validar el recurso de usuarios de la API pública ServeRest utilizando Karate DSL.

La automatización contempla los principales flujos CRUD, escenarios positivos y negativos, validación de reglas de negocio y comprobación de la estructura de las respuestas.

## 2. Alcance

Se automatizaron los siguientes endpoints:

- GET `/usuarios`
- GET `/usuarios/{_id}`
- POST `/usuarios`
- PUT `/usuarios/{_id}`
- DELETE `/usuarios/{_id}`

## 3. Tecnologías utilizadas

- Java 21
- Maven
- Karate DSL 2.1.0
- JUnit
- IntelliJ IDEA

## 4. Estrategia de automatización

Los escenarios fueron organizados por operación HTTP mediante archivos Feature independientes.

Se utilizaron datos dinámicos para evitar conflictos entre ejecuciones.

También se implementó un helper reutilizable para la generación de usuarios de prueba:

`src/test/java/helpers/user-data.js`

## 5. Cobertura principal

Se validaron, entre otros, los siguientes escenarios:

- consulta de usuarios;
- creación de usuarios;
- búsqueda por ID;
- actualización;
- eliminación;
- email duplicado;
- campos obligatorios;
- body vacío;
- formato de email inválido;
- valores inválidos del campo administrador;
- tipos de datos incorrectos;
- IDs inexistentes;
- formato de ID inválido;
- PUT sobre ID inexistente;
- DELETE sobre ID inexistente;
- actualización utilizando el email de otro usuario.

## 6. Validaciones realizadas

Las pruebas incluyen validaciones sobre:

- códigos HTTP;
- mensajes de respuesta;
- estructura JSON;
- tipos de datos;
- persistencia;
- unicidad de email;
- formato de campos;
- reglas de negocio.

## 7. Hallazgos relevantes

Durante las pruebas se identificaron comportamientos particulares de la API.

### PUT con ID inexistente

Cuando se realiza un PUT utilizando un ID válido pero inexistente y un body válido, ServeRest crea un nuevo usuario.

La API responde:

`201 Created`

y genera un nuevo `_id`.

### DELETE con ID inexistente

Al eliminar un usuario utilizando un ID válido pero inexistente, la API responde:

`200 OK`

con el mensaje:

`Nenhum registro excluído`

Este comportamiento fue automatizado respetando el contrato observado de la API.

## 8. Resultado de ejecución

La ejecución final de la suite obtuvo:

```text
Tests run: 19
Failures: 0
Errors: 0
Skipped: 0
BUILD SUCCESS
```
## 9. Reportes

Karate genera automáticamente los reportes HTML en:

`target/karate-reports/`

El reporte principal puede consultarse en:

`target/karate-reports/index.html`

## 10. Conclusión

La suite automatizada cubre los principales flujos funcionales del recurso de usuarios y diferentes escenarios negativos.

Se utilizaron buenas prácticas como separación de pruebas por funcionalidad, generación dinámica de datos, helpers reutilizables, validaciones de persistencia y reportes automáticos.