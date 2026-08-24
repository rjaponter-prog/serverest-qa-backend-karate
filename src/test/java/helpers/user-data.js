function fn() {

    var randomId = java.util.UUID.randomUUID().toString();

    return {
        nome: 'QA Usuario Helper',
        email: 'qa.helper.' + randomId + '@correo.com',
        password: 'qa123456',
        administrador: 'true'
    };
}