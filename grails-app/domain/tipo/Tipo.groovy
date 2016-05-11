package tipo


class Tipo {

    static auditable = true
    String descripcion
    String codigo
    int tiempo

    static mapping = {
        table 'tipo'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'tipo__id'
            descripcion column: 'tipodscr'
            codigo column: 'tipocdgo'
            tiempo column: 'tipotmpo'
        }
    }


    static constraints = {
        descripcion (nullable: false, blank: false, size: 1..1023)
        codigo (nullable: false, blank: false, size: 1..4)
    }
}
