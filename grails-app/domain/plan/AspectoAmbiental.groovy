package plan

class AspectoAmbiental {

    static auditable = true
    String descripcion
    String impacto
    PlanManejoAmbiental planManejoAmbiental

    static mapping = {
        table 'apam'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'apam__id'
            descripcion column: 'apamdscr'
            impacto column: 'apamimpc'
            planManejoAmbiental column: 'plma__id'
        }
    }


    static constraints = {
    }
}
