package legal

class Articulo {

    static auditable = true
    Norma norma
    int numero
    String descripcion

    static mapping = {
        table 'artc'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'artc__id'
            norma column: 'nmra__id'
            descripcion column: 'artcdscr'
            numero column: 'artcnmro'
        }
    }

    static constraints = {

        descripcion(nullable: true, blank: true, size: 1..1023)

    }
}
