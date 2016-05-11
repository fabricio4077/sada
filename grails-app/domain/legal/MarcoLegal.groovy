package legal

class MarcoLegal {

    static auditable = true
    String descripcion
    String codigo

    static mapping = {
        table 'mclg'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'mclg__id'
            descripcion column: 'mclgdscr'
            codigo column: 'mclgcdgo'
        }
    }

    static constraints = {
        descripcion(nullable: true, blank: true, size: 1..63)
        codigo(nullable: true, blank: true, size: 1..4)
    }
}
