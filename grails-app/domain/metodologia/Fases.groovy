package metodologia

class Fases {

    static auditable = true
    String nombre
    String descripcion
    String codigo

    static mapping = {
        table 'fses'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'fses__id'
            nombre column: 'fsesnmbr'
            descripcion column: 'fsesdscr'
            codigo column: 'fsescdgo'

        }
    }

    static constraints = {
        nombre (nullable: false, blank: false, size: 1..63)
        descripcion(nullable: false, blank: false, size: 1..1023)
        codigo(nullable: true, blank: true, size: 1..4)

    }
}
