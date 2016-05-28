package plan

class AspectoAmbiental {

    static auditable = true
    PlanManejoAmbiental planManejoAmbiental
    String descripcion
    String impacto

    static mapping = {
        table 'apam'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'apam__id'
            planManejoAmbiental column: 'plma__id'
            descripcion column: 'apamdscr'
            impacto column: 'apamimpc'
        }
    }


    static constraints = {
    }
}
