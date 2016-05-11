package estacion


class Coordenadas {

    static auditable = true
    Estacion estacion
    Double coordenadasX
    Double coordenadasY

    static mapping = {
        table 'cddn'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'cddn__id'
            estacion column: 'etsv__id'
            coordenadasX column: 'cddnen_x'
            coordenadasY column: 'cddnen_y'
        }
    }

    static constraints = {
    }
}
