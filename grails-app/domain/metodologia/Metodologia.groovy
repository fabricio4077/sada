package metodologia

class Metodologia {

    static auditable = true
    String descripcion
    String codigo

    static mapping = {
        table 'mtdl'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'mtdl__id'
            descripcion column: 'mtdldscr'
            codigo column: 'mtdlcdgo'

        }
    }

    static constraints = {

        descripcion(nullable: false, blank: false, size: 1..255)
        codigo(nullable: false, blank: false, size: 1..4)
    }
}
