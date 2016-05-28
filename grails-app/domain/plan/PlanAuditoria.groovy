package plan

import auditoria.DetalleAuditoria

class PlanAuditoria {

    static auditable = true
    AspectoAmbiental aspectoAmbiental
    Medida medida
    DetalleAuditoria detalleAuditoria
    String periodo

    static mapping = {
        table 'aupm'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'aupm__id'
            aspectoAmbiental column: 'apam__id'
            medida column: 'mdda__id'
            detalleAuditoria column: 'dtau__id'
            periodo column: 'aupmprdo'
        }
    }


    static constraints = {

    }
}
