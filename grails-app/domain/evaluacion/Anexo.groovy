package evaluacion

class Anexo {

    static auditable = true
    Evaluacion evaluacion
    String path

    static mapping = {
        table 'anxo'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'anxo__id'
            evaluacion column: 'evam__id'
            path column: 'anxopath'
        }
    }

    static constraints = {
    }
}
