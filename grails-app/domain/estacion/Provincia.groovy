package estacion

class Provincia {

    static auditable = true
    String nombre
    String codigo

    static mapping = {
        table 'prov'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'prov__id'
            nombre column: 'provnmbr'
            codigo column: 'provcdgo'
        }
    }

    static constraints = {

        nombre(nullable: false, blank: false, size: 1..31)
        codigo(nullable: false, blank: false, size: 1..4)
    }
}
