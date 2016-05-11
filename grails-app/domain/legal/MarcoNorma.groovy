package legal

class MarcoNorma {

    static auditable = true
    MarcoLegal marcoLegal
    Norma norma

    static mapping = {
        table 'mctp'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'mctp__id'
            marcoLegal column: 'mclg__id'
            norma column: 'nmra__id'
        }
    }

    static constraints = {
    }
}
