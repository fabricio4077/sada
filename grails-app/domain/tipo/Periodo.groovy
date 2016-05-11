package tipo


class Periodo {

    static auditable = true
    Date inicio
    Date fin


    static mapping = {
        table 'prdo'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'prdo__id'
            inicio column: 'prdoinic'
            fin column: 'prdofinn'
        }
    }

    static constraints = {
    }
}
