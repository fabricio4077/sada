package complemento

import auditoria.Auditoria
import auditoria.DetalleAuditoria

class Alcance {

    static auditable = true
    Auditoria auditoria
    String descripcion

    static mapping = {
        table 'alce'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'alce__id'
            auditoria column: 'audt__id'
            descripcion column: 'alcedscr'
        }
    }


    static constraints = {
    }
}
