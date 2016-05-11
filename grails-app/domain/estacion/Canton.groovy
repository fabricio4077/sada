package estacion

class Canton {

    static auditable = true
    String nombre
    Provincia provincia

    static mapping = {
        table 'cntn'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'cntn__id'
            nombre column: 'cntnnmbr'
            provincia column: 'prov__id'
        }
    }


    static constraints = {
    }
}
