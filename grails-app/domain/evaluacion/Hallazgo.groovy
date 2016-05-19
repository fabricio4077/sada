package evaluacion

import legal.Articulo

class Hallazgo {


    static auditable = true
    String codigo
    String descripcion
    Articulo articulo

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
        }
    }


    static constraints = {

        codigo (nullable: true, blank: true)

    }
}
