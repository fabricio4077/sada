package evaluacion

import auditoria.DetalleAuditoria


class Evaluacion {

    static auditable = true
    DetalleAuditoria detalleAuditoria
    Hallazgo hallazgo
    Calificacion calificacion
    String anexo

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
        }
    }

    static constraints = {
        anexo(nullable: true, blank: true)
    }
}
