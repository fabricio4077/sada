package metodologia

class MetoFase {

    static auditable = true
    Metodologia metodologia
    Fases fases

    static mapping = {
        table 'mtfs'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'mtfs__id'
            metodologia column: 'mtdl__id'
            fases column: 'fses__id'
        }
    }

    static constraints = {
    }
}
