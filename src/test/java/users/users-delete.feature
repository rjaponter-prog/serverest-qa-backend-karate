Feature: API de Usuarios - Eliminacion DELETE

  Background:
    * url 'https://serverest.dev'

  Scenario: CP-API-006 - Eliminar usuario existente

    # Crear datos unicos para disponer de un usuario conocido
* def usuario = call read('classpath:helpers/user-data.js')

    # Crear el usuario que vamos a eliminar
    Given path 'usuarios'
    And request usuario
    When method post
    Then status 201
    And match response._id == '#string'

    * def usuarioId = response._id

    # Eliminar el usuario
    Given path 'usuarios', usuarioId
    When method delete
    Then status 200
    And match response.message == '#string'

    # Verificar que el usuario ya no existe
    Given path 'usuarios', usuarioId
    When method get
    Then status 400
    And match response.message == '#string'

  Scenario: CP-API-007 - Eliminar usuario con ID inexistente

    * def idInexistente = 'ZZZZZZZZZZZZZZZZ'

    Given path 'usuarios', idInexistente
    When method delete
    Then status 200
    And match response.message == 'Nenhum registro excluído'