package evaluacion

import legal.Articulo
import legal.Literal

class Hallazgo {


    static auditable = true
    String codigo
    String descripcion
    Articulo articulo
    Literal literal
    Calificacion calificacion

    static mapping = {
        table 'hzgo'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'hzgo__id'
            descripcion column: 'hzgodscr'
            codigo column: 'hzgocdgo'
            articulo column: 'artc__id'
            literal column: 'ltrl__id'
            calificacion column: 'clfc__id'
        }
    }


    static constraints = {

        codigo (nullable: true, blank: true)
        articulo(nullable: true)
        literal(nullable: true)
        calificacion(nullable: true)

    }
}
