package objetivo

class Objetivo {

    static auditable = true
    String descripcion
    String tipo
    String defecto
    String imagen

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
        }
    }

    static constraints = {

        tipo inList: ['General','Específico']
        imagen(nullable: true)

    }
}
