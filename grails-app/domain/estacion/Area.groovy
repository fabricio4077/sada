package estacion

class Area {

    static auditable = true
    String nombre
    String codigo
    String descripcion

    static mapping = {
        table 'area'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'area__id'
            nombre column: 'areanmbr'
            codigo column: 'areacdgo'
            descripcion column: 'areadscr'


        }
    }

    static constraints = {

        nombre(nullable: false, blank: false, size: 1..31)
        descripcion(nullable: false, blank: false, size: 1..255)

    }
}
