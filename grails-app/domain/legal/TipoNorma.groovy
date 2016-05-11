package legal

class TipoNorma {

    static auditable = true
    String descripcion
    String codigo

    static mapping = {
        table 'tpnm'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'tpnm__id'
            descripcion column: 'tpnmdscr'
            codigo column: 'tpnmcdgo'
        }
    }


    static constraints = {
        descripcion (nullable: false, blank: false, size: 1..31)
        codigo(nullable: false, blank: false, size: 1..4)
    }
}
