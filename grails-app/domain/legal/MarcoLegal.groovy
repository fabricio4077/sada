package legal

class MarcoLegal {

    static auditable = true
    String descripcion
    String codigo
    String creador

    static mapping = {
        table 'mclg'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'mclg__id'
            descripcion column: 'mclgdscr'
            codigo column: 'mclgcdgo'
            creador column: 'mclgcrea'
        }
    }

    static constraints = {
        descripcion(nullable: false, blank: false, size: 1..63)
        codigo(nullable: true, blank: true, size: 1..4)
    }
}
