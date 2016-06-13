package situacion

class Elemento {

    static auditable = true
    String nombre
    String unidad

    static mapping = {
        table 'elmt'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'elmt__id'
            nombre column: 'elmtnmbr'
            unidad column: 'elmtunid'
        }
    }

    static constraints = {
    }
}
