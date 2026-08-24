Feature: API de Usuarios - Registro POST

  Background:
    * url 'https://serverest.dev'

  Scenario: CP-API-002 - Registrar usuario con datos validos

* def nuevoUsuario = call read('classpath:helpers/user-data.js')

    Given path 'usuarios'
    And request nuevoUsuario
    When method post
    Then status 201
    And match response.message == '#string'
    And match response._id == '#string'

    * def usuarioId = response._id

    Given path 'usuarios', usuarioId
    When method get
    Then status 200
    And match response.nome == nuevoUsuario.nome
    And match response.email == nuevoUsuario.email
    And match response.password == nuevoUsuario.password
    And match response.administrador == nuevoUsuario.administrador
    And match response._id == usuarioId

  Scenario: CP-API-008 - No registrar usuario con email duplicado

     * def randomId = karate.uuid()
     * def emailDuplicado = 'qa.duplicado.' + randomId + '@correo.com'

     * def usuarioOriginal =
     """
     {
       nome: 'QA Usuario Original',
       email: '#(emailDuplicado)',
       password: 'qa123456',
       administrador: 'true'
     }
     """

     # Crear primero un usuario valido
     Given path 'usuarios'
     And request usuarioOriginal
     When method post
     Then status 201
     And match response._id == '#string'

     # Intentar crear otro usuario con el mismo email
     * def usuarioDuplicado =
     """
     {
       nome: 'QA Usuario Duplicado',
       email: '#(emailDuplicado)',
       password: 'otraPassword123',
       administrador: 'false'
     }
     """

     Given path 'usuarios'
     And request usuarioDuplicado
     When method post
     Then status 400
     And match response.message == 'Este email já está sendo usado'

  Scenario: CP-API-010 - No registrar usuario con body vacio

    * def bodyVacio = {}

    Given path 'usuarios'
    And request bodyVacio
    When method post
    Then status 400
    And match response ==
    """
    {
      nome: 'nome é obrigatório',
      email: 'email é obrigatório',
      password: 'password é obrigatório',
      administrador: 'administrador é obrigatório'
    }
    """

  Scenario: CP-API-015 - No registrar usuario sin nome

    * def randomId = karate.uuid()
    * def emailDinamico = 'qa.sin.nome.' + randomId + '@correo.com'

    * def usuarioSinNome =
    """
    {
      email: '#(emailDinamico)',
      password: 'qa123456',
      administrador: 'true'
    }
    """

    Given path 'usuarios'
    And request usuarioSinNome
    When method post
    Then status 400
    And match response.nome == 'nome é obrigatório'

  Scenario: CP-API-014 - No registrar usuario sin email

     * def usuarioSinEmail =
     """
     {
       nome: 'QA Usuario Sin Email',
       password: 'qa123456',
       administrador: 'true'
     }
     """

     Given path 'usuarios'
     And request usuarioSinEmail
     When method post
     Then status 400
     And match response.email == 'email é obrigatório'

  Scenario: CP-API-013 - No registrar usuario sin password

      * def randomId = karate.uuid()
      * def emailDinamico = 'qa.sin.password.' + randomId + '@correo.com'

      * def usuarioSinPassword =
      """
      {
        nome: 'QA Usuario Sin Password',
        email: '#(emailDinamico)',
        administrador: 'true'
      }
      """

      Given path 'usuarios'
      And request usuarioSinPassword
      When method post
      Then status 400
      And match response.password == 'password é obrigatório'

  Scenario: CP-API-016 - No registrar usuario sin administrador

   * def randomId = karate.uuid()
   * def emailDinamico = 'qa.sin.admin.' + randomId + '@correo.com'

   * def usuarioSinAdministrador =
   """
   {
     nome: 'QA Usuario Sin Administrador',
     email: '#(emailDinamico)',
     password: 'qa123456'
   }
   """

   Given path 'usuarios'
   And request usuarioSinAdministrador
   When method post
   Then status 400
   And match response.administrador == 'administrador é obrigatório'

  Scenario: CP-API-009 - No registrar usuario con administrador invalido

    * def randomId = karate.uuid()
    * def emailDinamico = 'qa.admin.invalido.' + randomId + '@correo.com'

    * def usuarioAdminInvalido =
    """
    {
      nome: 'QA Usuario Admin Invalido',
      email: '#(emailDinamico)',
      password: 'qa123456',
      administrador: 'admin'
    }
    """

    Given path 'usuarios'
    And request usuarioAdminInvalido
    When method post
    Then status 400
    And match response.administrador == "administrador deve ser 'true' ou 'false'"

 Scenario: CP-API-021 - No registrar usuario con administrador boolean

   * def randomId = karate.uuid()
   * def emailDinamico = 'qa.admin.boolean.' + randomId + '@correo.com'

   * def usuarioAdminBoolean =
   """
   {
     nome: 'QA Usuario Admin Boolean',
     email: '#(emailDinamico)',
     password: 'qa123456',
     administrador: true
   }
   """

   Given path 'usuarios'
   And request usuarioAdminBoolean
   When method post
   Then status 400
   And match response.administrador == "administrador deve ser 'true' ou 'false'"

 Scenario: CP-API-011 - No registrar usuario con formato de email invalido

   * def usuarioEmailInvalido =
   """
   {
     nome: 'QA Usuario Email Invalido',
     email: 'correo-sin-formato',
     password: 'qa123456',
     administrador: 'true'
   }
   """

   Given path 'usuarios'
   And request usuarioEmailInvalido
   When method post
   Then status 400
   And match response.email == 'email deve ser um email válido'