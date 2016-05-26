package evaluacion

import auditoria.DetalleAuditoria
import legal.MarcoNorma


class Evaluacion {

    static auditable = true
    DetalleAuditoria detalleAuditoria
    Hallazgo hallazgo
    Calificacion calificacion
    MarcoNorma marcoNorma
    PlanAccion planAccion

    static mapping = {
        table 'evam'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'evam__id'
            detalleAuditoria column: 'dtau__id'
            hallazgo column: 'hzgo__id'
            calificacion column: 'clfc__id'
            marcoNorma column: 'mctp__id'
            planAccion column: 'plac__id'
        }
    }

    static constraints = {
        hallazgo(nullable: true)
        calificacion(nullable: true)
        marcoNorma(nullable: true)
        planAccion(nullable: true)

    }
}
