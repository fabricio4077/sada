package estacion

class Extintor {

    static auditable = true
    Ares ares
    String tipo
    int capacidad = 0

    static mapping = {
        table 'exas'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'exas__id'
            ares column: 'ares__id'
            tipo column: 'exastipo'
            capacidad column: 'exascpcd'
        }
    }

    static constraints = {
        tipo inList: ['Agua-espuma','CO2','PQS']
        capacidad inList: [5,10,15,20,30,50,100]
    }
}
