package situacion

class Desechos {

    static auditable = true
    String descripcion
    String tipo

    static mapping = {
        table 'dsch'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'dsch__id'
            descripcion column: 'dschdscr'
            tipo column: 'dschtipo'
        }
    }

    static constraints = {
    }
}
