package objetivo

import auditoria.Auditoria

class ObjetivosAuditoria {

    static auditable = true
    Objetivo objetivo
    Auditoria auditoria

    static mapping = {
        table 'obau'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'obau__id'
            objetivo column: 'objt__id'
            auditoria column: 'audt__id'
       }
    }

    static constraints = {
    }
}
