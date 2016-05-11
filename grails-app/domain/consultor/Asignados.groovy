package consultor

import Seguridad.Persona
import auditoria.Preauditoria

class Asignados {

    static auditable = true
    Persona persona
    Preauditoria preauditoria

    static mapping = {
        table 'pspr'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'pspr__id'
            persona column: 'prsn__id'
            preauditoria column: 'prau__id'
        }
    }

    static constraints = {
    }
}
