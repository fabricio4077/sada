package complemento

class Actividad {

    static auditable = true
    String descripcion
    String codigo

    static mapping = {
        table 'actv'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'actv__id'
            descripcion column: 'actvdscr'
            codigo column: 'actvcdgo'
        }
    }

    static constraints = {
        descripcion(nullable: false, blank: false, size: 1..63)
    }
}
