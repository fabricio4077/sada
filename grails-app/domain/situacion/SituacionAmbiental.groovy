package situacion

import auditoria.DetalleAuditoria

class SituacionAmbiental {

    static auditable = true
    String descripcion
    DetalleAuditoria detalleAuditoria
    ComponenteAmbiental componenteAmbiental

    static mapping = {
        table 'cmau'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'cmau__id'
            descripcion column: 'cmaudscr'
            detalleAuditoria column: 'dtau__id'
            componenteAmbiental column: 'cmpt__id'
        }
    }

    static constraints = {
        descripcion(nullable: true, blank: true)
        componenteAmbiental(nullable: true)
    }
}
