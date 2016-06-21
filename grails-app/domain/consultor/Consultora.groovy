package consultor

class Consultora {

    static auditable = true
    String nombre
    String administrador
    String telefono
    String ruc
    String registro
    String mail
    String pagina
    String direccion
    String logotipo

    static mapping = {
        table 'cnra'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'cnra__id'
            nombre column: 'cnranmbr'
            administrador column: 'cnracntc'
            telefono column: 'cnratlfn'
            ruc column: 'cnrarucc'
            mail column: 'cnramail'
            pagina column: 'cnrapweb'
            direccion column: 'cnradire'
            registro column: 'cnrargst'
            logotipo column: 'cnralgtp'
        }
    }


    static constraints = {
        nombre (nullable: false, blank: false, size: 1..31)
        administrador (nullable: false, blank: false, size: 1..63)
        logotipo(nullable: true, blank: true)
    }
}
