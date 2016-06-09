package auditoria

import detalle.Antecendente

class DetalleAuditoria {

    static auditable = true
    Auditoria auditoria
    String introduccion
    String recomendaciones

    static mapping = {
        table 'dtau'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'dtau__id'
            auditoria column: 'audt__id'
            introduccion column: 'dtauintr'
            recomendaciones column: 'dtauccrr'
        }
    }

    static constraints = {
        introduccion(nullable: true, blank: true)
        recomendaciones(nullable: true, blank: true)
    }
}
