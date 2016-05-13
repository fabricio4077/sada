package estacion

class Ares {
    static auditable = true
    Estacion estacion
    Area area
    String foto1
    String foto2
    String foto3
    String descripcion
    int capacidad
    String extintor

    static mapping = {
        table 'ares'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'ares__id'
            estacion column: 'etsv__id'
            area column: 'area__id'
            descripcion column: 'aresdscr'
            foto1 column: 'aresfto1'
            foto2 column: 'aresfto2'
            foto3 column: 'aresfto3'
            capacidad column: 'aresexcp'
            extintor column: 'aresextr'
        }
    }

    static constraints = {
        descripcion (nullable: true, blank: true)
        foto1(nullable: true, blank: true)
        foto2(nullable: true, blank: true)
        foto3(nullable: true, blank: true)
        extintor(nullable: true, blank: true)
    }
}
