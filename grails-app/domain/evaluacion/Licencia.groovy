package evaluacion

import auditoria.DetalleAuditoria

class Licencia {

    static auditable = true
    DetalleAuditoria detalleAuditoria
    String descripcion

    static mapping = {
        table 'lcnc'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'lcnc__id'
            detalleAuditoria column: 'dtau__id'
            descripcion column: 'lcncdscr'
        }
    }

    static constraints = {
    }
}
