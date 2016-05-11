package Seguridad

import consultor.Consultora

class Persona {

    static auditable = true
    Consultora consultora
    String nombre
    String apellido
    String telefono
    String mail
    String login
    String password
    int activo
    String cargo
    String titulo


    static mapping = {
        table 'prsn'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'prsn__id'
            consultora column: 'cnra__id'
            nombre column: 'prsnnmbr'
            apellido column: 'prsnapll'
            telefono column: 'prsntlfn'
            mail column: 'prsnmail'
            login column: 'prsnlogn'
            password column: 'prsnpass'
            activo column: 'prsnactv'
            cargo column: 'prsncrgo'
            titulo column: 'prsntitl'
        }
    }

    static constraints = {

        nombre(nullable: false, blank: false, size: 1..31)
        apellido(nullable: false, blank: false, size: 1..31)
        telefono(nullable: true, blank: true)
        mail(nullable: true, blank: true)
        login(nullable: true, blank: false)
        password(nullable: true, blank: false)
        consultora (nullable: true)

    }
}
