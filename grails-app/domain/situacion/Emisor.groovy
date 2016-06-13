package situacion

class Emisor {

    static auditable = true
    String nombre

    static mapping = {
        table 'emsr'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'emsr__id'
            nombre column: 'emsrnmbr'
        }
    }

    static constraints = {
    }
}
