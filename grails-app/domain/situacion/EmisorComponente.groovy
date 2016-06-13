package situacion

class EmisorComponente {

    static auditable = true
    int hora=0
    int mantenimiento = 0
    Emisor emisor
    SituacionAmbiental situacionAmbiental

    static mapping = {
        table 'emcm'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'emcm__id'
            emisor column: 'emsr__id'
            situacionAmbiental column: 'cmau__id'
            hora column: 'emcmhora'
            mantenimiento column: 'emcmmtnm'
        }
    }

    static constraints = {
    }
}
