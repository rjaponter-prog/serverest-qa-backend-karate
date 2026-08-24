Feature: API de Usuarios - Actualizacion PUT

  Background:
    * url 'https://serverest.dev'

  Scenario: CP-API-005 - Actualizar usuario existente

    # Datos unicos para crear el usuario inicial
    * def randomId = karate.uuid()
    * def emailInicial = 'qa.put.' + randomId + '@correo.com'

    * def usuarioInicial =
    """
    {
      nome: 'QA Usuario Inicial',
      email: '#(emailInicial)',
      password: 'qa123456',
      administrador: 'true'
    }
    """

    # Crear usuario que luego vamos a actualizar
    Given path 'usuarios'
    And request usuarioInicial
    When method post
    Then status 201
    And match response._id == '#string'

    * def usuarioId = response._id

    # Preparar nuevos datos
    * def emailActualizado = 'qa.put.actualizado.' + randomId + '@correo.com'

    * def usuarioActualizado =
    """
    {
      nome: 'QA Usuario Actualizado',
      email: '#(emailActualizado)',
      password: 'qa654321',
      administrador: 'false'
    }
    """

    # Actualizar el usuario
    Given path 'usuarios', usuarioId
    And request usuarioActualizado
    When method put
    Then status 200
    And match response.message == '#string'

    # Verificar que los cambios quedaron guardados
    Given path 'usuarios', usuarioId
    When method get
    Then status 200
    And match response.nome == usuarioActualizado.nome
    And match response.email == usuarioActualizado.email
    And match response.password == usuarioActualizado.password
    And match response.administrador == usuarioActualizado.administrador
    And match response._id == usuarioId

  Scenario: CP-API-017 - PUT con ID inexistente crea un nuevo usuario

    * def randomId = karate.uuid()
    * def emailDinamico = 'qa.put.inexistente.' + randomId + '@correo.com'

    * def idInexistente = 'YYYYYYYYYYYYYYYY'

    * def nuevoUsuario =
    """
    {
      nome: 'QA Usuario Creado por PUT',
      email: '#(emailDinamico)',
      password: 'qa123456',
      administrador: 'true'
    }
    """

    Given path 'usuarios', idInexistente
    And request nuevoUsuario
    When method put
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    And match response._id == '#string'

    * def nuevoUsuarioId = response._id

    # El servidor genera un ID nuevo
    * assert nuevoUsuarioId != idInexistente

    # Verificar que el nuevo usuario realmente existe
    Given path 'usuarios', nuevoUsuarioId
    When method get
    Then status 200
    And match response.nome == nuevoUsuario.nome
    And match response.email == nuevoUsuario.email
    And match response.password == nuevoUsuario.password
    And match response.administrador == nuevoUsuario.administrador
    And match response._id == nuevoUsuarioId

 Scenario: CP-API-018 - No actualizar usuario con email de otro usuario

   * def randomId = karate.uuid()
   * def emailUsuarioA = 'qa.put.a.' + randomId + '@correo.com'
   * def emailUsuarioB = 'qa.put.b.' + randomId + '@correo.com'

   * def usuarioA =
   """
   {
     nome: 'QA Usuario A',
     email: '#(emailUsuarioA)',
     password: 'qa123456',
     administrador: 'true'
   }
   """

   * def usuarioB =
   """
   {
     nome: 'QA Usuario B',
     email: '#(emailUsuarioB)',
     password: 'qa123456',
     administrador: 'false'
   }
   """

   # Crear usuario A
   Given path 'usuarios'
   And request usuarioA
   When method post
   Then status 201
   * def usuarioAId = response._id

   # Crear usuario B
   Given path 'usuarios'
   And request usuarioB
   When method post
   Then status 201
   * def usuarioBId = response._id

   # Intentar actualizar B usando el email de A
   * def usuarioBConEmailDuplicado =
   """
   {
     nome: 'QA Usuario B Actualizado',
     email: '#(emailUsuarioA)',
     password: 'qa654321',
     administrador: 'false'
   }
   """

   Given path 'usuarios', usuarioBId
   And request usuarioBConEmailDuplicado
   When method put
   Then status 400
   And match response.message == 'Este email já está sendo usado'