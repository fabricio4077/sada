package legal

class Literal {

    static auditable = true
    String descripcion
    String identificador

    static mapping = {
        table 'ltrl'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'ltrl__id'
            descripcion column: 'ltrldscr'
            identificador column: 'ltrliden'

        }
    }

    static constraints = {
    }
}
