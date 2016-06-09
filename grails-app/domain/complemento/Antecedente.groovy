package complemento

import auditoria.DetalleAuditoria


class Antecedente {

    static auditable = true
    DetalleAuditoria detalleAuditoria
    String descripcion
    String oficio
    Date fechaAprobacion

    static mapping = {
        table 'antc'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'antc__id'
            detalleAuditoria column: 'dtau__id'
            descripcion column: 'antcdscr'
            oficio column: 'antcofic'
            fechaAprobacion column: 'antcfcap'
        }
    }

    static constraints = {
        oficio(nullable: true, blank: true)
    }
}
