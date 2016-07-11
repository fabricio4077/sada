package estacion


class Coordenadas {

    static auditable = true
    Estacion estacion
    BigInteger coordenadasX
    BigInteger coordenadasY

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
