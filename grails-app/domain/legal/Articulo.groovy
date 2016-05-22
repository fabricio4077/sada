package legal

class Articulo {

    static auditable = true
    int numero
    String descripcion
//    Norma norma

    static mapping = {
        table 'artc'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'artc__id'
            descripcion column: 'artcdscr'
            numero column: 'artcnmro'
//            norma column: 'nmra__id'
        }
    }

    static constraints = {

//        descripcion(nullable: true, blank: true, size: 1..1023)

    }
}
