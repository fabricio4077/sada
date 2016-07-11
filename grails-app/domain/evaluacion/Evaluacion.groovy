package evaluacion

import auditoria.DetalleAuditoria
import legal.MarcoNorma
import plan.PlanAuditoria


class Evaluacion {

    static auditable = true
    DetalleAuditoria detalleAuditoria
    Hallazgo hallazgo
    Calificacion calificacion
    MarcoNorma marcoNorma
    PlanAccion planAccion
    PlanAuditoria planAuditoria
    Licencia licencia
    String evidencia
    int orden = 0

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
            planAuditoria column: 'aupm__id'
            licencia column: 'lcnc__id'
            evidencia column: 'evamevid'
            orden column: 'evamordn'
        }
    }

    static constraints = {
        hallazgo(nullable: true)
        calificacion(nullable: true)
        marcoNorma(nullable: true)
        planAccion(nullable: true)
        planAuditoria(nullable: true)
        licencia(nullable: true)
        evidencia(nullable: true, blank: true)

    }
}
