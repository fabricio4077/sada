package situacion

class Situacion {

    static auditable = true
    String descripcion

    static mapping = {
        table 'stam'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'stam__id'
            descripcion column: 'stamdscr'
        }
    }

    static constraints = {
    }
}
