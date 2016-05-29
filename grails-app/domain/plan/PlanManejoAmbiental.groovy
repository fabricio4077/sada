package plan

class PlanManejoAmbiental {

    static auditable = true
    String nombre
    String descripcion
    String objetivo
    String codigo

    static mapping = {
        table 'plma'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'plma__id'
            nombre column: 'plmanmbr'
            descripcion column: 'plmadscr'
            objetivo column: 'plmaobjt'
            codigo column: 'plmacdgo'
        }
    }

    static constraints = {
        codigo(nullable: true, blank: true)
    }
}
