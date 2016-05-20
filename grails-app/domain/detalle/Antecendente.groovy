package detalle

class Antecendente {

    static auditable = true
    String oficio
    String descripcion
    Date fechaAprobacion

    static mapping = {
        table 'antc'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'antc__id'
            descripcion column: 'antcdscr'
            oficio column: 'antcofic'
            fechaAprobacion column: 'antcfcap'
        }
    }

    static constraints = {
    }
}
