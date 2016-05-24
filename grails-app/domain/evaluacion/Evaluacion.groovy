package evaluacion

import auditoria.DetalleAuditoria
import legal.MarcoNorma


class Evaluacion {

    static auditable = true
    DetalleAuditoria detalleAuditoria
    Hallazgo hallazgo
    Calificacion calificacion
    String anexo
    MarcoNorma marcoNorma

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
            anexo column: 'evamanxo'
            marcoNorma column: 'mctp__id'
        }
    }

    static constraints = {
        anexo(nullable: true, blank: true)
        hallazgo(nullable: true)
        calificacion(nullable: true)
        marcoNorma(nullable: true)

    }
}
