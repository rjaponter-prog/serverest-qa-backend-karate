Feature: API de Usuarios - Consulta GET por ID

  Background:
    * url 'https://serverest.dev'

  Scenario: CP-API-003 - Buscar usuario existente por ID

    # Crear datos unicos para disponer de un usuario conocido
    * def randomId = karate.uuid()
    * def emailDinamico = 'qa.getid.' + randomId + '@correo.com'

    * def usuario =
    """
    {
      nome: 'QA Usuario GET ID',
      email: '#(emailDinamico)',
      password: 'qa123456',
      administrador: 'true'
    }
    """

    # Crear el usuario
    Given path 'usuarios'
    And request usuario
    When method post
    Then status 201
    And match response._id == '#string'

    * def usuarioId = response._id

    # Buscar el usuario por el ID generado
    Given path 'usuarios', usuarioId
    When method get
    Then status 200

    # Validar datos y esquema
    And match response.nome == usuario.nome
    And match response.email == usuario.email
    And match response.password == usuario.password
    And match response.administrador == usuario.administrador
    And match response._id == usuarioId

    And match response contains
    """
    {
      nome: '#string',
      email: '#string',
      password: '#string',
      administrador: '#string',
      _id: '#string'
    }
    """

  Scenario: CP-API-004 - Buscar usuario con ID inexistente

    * def idInexistente = 'ZZZZZZZZZZZZZZZZ'

    Given path 'usuarios', idInexistente
    When method get
    Then status 400
    And match response.message == 'Usuário não encontrado'

  Scenario: CP-API-019 - Buscar usuario con ID de formato invalido

    * def idInvalido = 'ID_INEXISTENTE_123456789'

    Given path 'usuarios', idInvalido
    When method get
    Then status 400
    And match response.id == 'id deve ter exatamente 16 caracteres alfanuméricos'