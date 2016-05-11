package complemento

import auditoria.Preauditoria

class ActiAudi {

    static auditable = true
    Actividad actividad
    Preauditoria preauditoria
    int orden

    static mapping = {
        table 'acpr'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'acpr__id'
            actividad column: 'actv__id'
            preauditoria column: 'prau__id'
            orden column: 'acprordn'
        }
    }

    static constraints = {
    }
}
