package metodologia

class Metodologia {

    static auditable = true
    String descripcion

    static mapping = {
        table 'mtdl'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'mtdl__id'
            descripcion column: 'mtdldscr'
        }
    }

    static constraints = {
        descripcion(nullable: false, blank: false)
    }
}
