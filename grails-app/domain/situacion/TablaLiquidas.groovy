package situacion

class TablaLiquidas {

    static auditable = true
    SituacionAmbiental situacionAmbiental
    Date fecha

    static mapping = {
        table 'tblq'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'tblq__id'
            situacionAmbiental column: 'cmau__id'
            fecha column: 'tblqfcha'
        }
    }


    static constraints = {
    }
}
