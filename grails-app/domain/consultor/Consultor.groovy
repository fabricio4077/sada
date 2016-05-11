package consultor

import Seguridad.Persona

class Consultor {

    static auditable = true
    Persona persona
    Consultora consultora
    String observaciones
    String codigo

    static mapping = {
        table 'cnst'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'cnst__id'
            persona column: 'prsn__id'
            consultora column: 'cnra__id'
            observaciones column: 'cnstobsv'
            codigo column: 'cnstcdgo'
        }
    }

    static constraints = {
        codigo (nullable: false, blank: false, size: 1..4)
    }
}
