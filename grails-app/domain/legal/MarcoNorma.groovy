package legal

class MarcoNorma {

    static auditable = true
    MarcoLegal marcoLegal
    Norma norma
    Articulo articulo
    Literal literal
    int seleccionado = 0

    static mapping = {
        table 'mctp'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'mctp__id'
            marcoLegal column: 'mclg__id'
            norma column: 'nmra__id'
            articulo column: 'artc__id'
            literal column: 'ltrl__id'
            seleccionado column: 'mctpsele'
        }
    }

    static constraints = {

        articulo(nullable: true)
        literal(nullable: true)


    }
}
