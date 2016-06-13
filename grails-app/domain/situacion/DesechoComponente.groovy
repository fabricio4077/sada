package situacion

class DesechoComponente {

    static auditable = true
    Desechos desechos
    SituacionAmbiental situacionAmbiental

    static mapping = {
        table 'dscm'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'dscm__id'
            desechos column: 'dsch__id'
            situacionAmbiental column: 'cmau__id'
        }
    }

    static constraints = {
    }
}
