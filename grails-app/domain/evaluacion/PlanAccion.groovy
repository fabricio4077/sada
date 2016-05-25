package evaluacion

import auditoria.DetalleAuditoria
import legal.MarcoNorma

class PlanAccion {

    static auditable = true
    Hallazgo hallazgo
    String actividad
    String responsable
    String estado
    String avance
    int plazo = 0
    String costo
    String verficacion

    static mapping = {
        table 'plac'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'plac__id'
            hallazgo column: 'hzgo__id'
            actividad column: 'placactv'
            responsable column: 'placrspn'
            estado column: 'placetdo'
            avance column: 'planavce'
            plazo column: 'planplzo'
            costo column: 'plancsto'
            verficacion column: 'planvrfc'

        }
    }

    static constraints = {

        actividad(nullable: true, blank: true)
        responsable(nullable: true, blank: true)
        estado(nullable: true, blank: true)
        avance(nullable: true, blank: true)
        costo(nullable: true, blank: true)
        verficacion(nullable: true, blank: true)


    }
}
