package auditoria

import detalle.Antecendente
import situacion.Situacion

class DetalleAuditoria {

    static auditable = true
    Auditoria auditoria
    Situacion situacion
    Antecendente antecendente
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
            situacion column: 'stam__id'
            antecendente column: 'antc__id'
            introduccion column: 'dtauintr'
            recomendaciones column: 'dtauccrr'
        }
    }

    static constraints = {

        situacion(nullable: true)
        antecendente(nullable: true)
        introduccion(nullable: true, blank: true)
        recomendaciones(nullable: true, blank: true)

    }
}
