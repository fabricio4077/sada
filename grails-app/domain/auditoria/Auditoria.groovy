package auditoria

import legal.MarcoLegal
import metodologia.Metodologia

class Auditoria {

    static auditable = true
    Preauditoria preauditoria
    Metodologia metodologia
    MarcoLegal marcoLegal
    Date fechaInicio
    Date fechaFin
    Date fechaAprobacion

    static mapping = {
        table 'audt'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'audt__id'
            preauditoria column: 'prau__id'
            metodologia column: 'mtdl__id'
            marcoLegal column: 'mclg__id'
            fechaInicio column: 'audtfcin'
            fechaFin column: 'audtfcfn'
            fechaAprobacion column: 'audtfcap'
        }
    }

    static constraints = {

        metodologia (nullable: true)
        marcoLegal(nullable: true)
        fechaFin(nullable: true)
        fechaAprobacion(nullable: true)

    }
}
