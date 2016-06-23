package objetivo

class Objetivo {

    static auditable = true
    String descripcion
    String tipo
    String defecto
    String imagen
    String controlador
    String accion
    String identificador

    static mapping = {
        table 'objt'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'objt__id'
            descripcion column: 'objtdscr'
            tipo column: 'objttipo'
            defecto column: 'objtdfto'
            imagen column: 'objtimgn'
            controlador column: 'objtcntr'
            accion column: 'objtactn'
            identificador column: 'objtiden'
        }
    }

    static constraints = {
        tipo inList: ['General','Específico']
        imagen(nullable: true)
        controlador(nullable: true, blank: true)
        accion(nullable: true, blank: true)
        identificador(nullable: true, blank: true)
    }
}
