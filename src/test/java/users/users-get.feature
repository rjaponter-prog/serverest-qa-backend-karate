Feature: API de Usuarios - Consultas GET

  Background:
    * url 'https://serverest.dev'

  Scenario: CP-API-001 - Consultar lista de usuarios
    Given path 'usuarios'
    When method get
    Then status 200
    And match response.quantidade == '#number'
    And match response.usuarios == '#[]'
    And match each response.usuarios contains
    """
    {
      nome: '#string',
      email: '#string',
      password: '#string',
      administrador: '#string',
      _id: '#string'
    }
    """