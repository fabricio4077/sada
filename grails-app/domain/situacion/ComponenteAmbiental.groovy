package situacion

import auditoria.DetalleAuditoria

class ComponenteAmbiental {

    static auditable = true
    String nombre
    String tipo

    static mapping = {
        table 'cmpt'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'cmpt__id'
            nombre column: 'cmptnmbr'
            tipo column: 'cmpttipo'
        }
    }

    static constraints = {
        tipo inList: ['Físico','Biótico','Social']
    }
}
