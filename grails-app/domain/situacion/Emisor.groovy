package situacion

class Emisor {

    static auditable = true
    String nombre
    String codigo

    static mapping = {
        table 'emsr'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'emsr__id'
            nombre column: 'emsrnmbr'
            codigo column: 'emsrcdgo'
        }
    }

    static constraints = {
        codigo(nullable: true, blank: true)
    }
}
