package auditoria

import complemento.Actividad
import estacion.Estacion
import tipo.Periodo
import tipo.Tipo

class Preauditoria {

    static auditable = true
    Estacion estacion
    Tipo tipo
    Periodo periodo
    int plazo
    String creador
    Date fechaCreacion

    static mapping = {
        table 'prau'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'prau__id'
            estacion column: 'etsv__id'
            tipo column: 'tipo__id'
            periodo column: 'prdo__id'
            plazo column: 'prauplzo'
            creador column: 'praucrea'
            fechaCreacion column: 'praufcha'
        }
    }

    static constraints = {
        estacion(nullable: true)
    }
}
