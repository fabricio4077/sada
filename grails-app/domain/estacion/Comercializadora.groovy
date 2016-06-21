package estacion

class Comercializadora {

    static auditable = true
    String nombre
    String telefono
    String mail
    String direccion
    String representante
    String logotipo


    static mapping = {
        table 'cmlz'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'cmlz__id'
            nombre column: 'cmlznmbr'
            telefono column: 'cmlztlfn'
            mail column: 'cmlzmail'
            direccion column: 'cmlzdire'
            representante column: 'cmlzrplg'
            logotipo column: 'cmlzlgtp'
        }
    }


    static constraints = {

        nombre(nullable: false, blank: false, size: 1..31)
        direccion(nullable: false, blank: false, size: 1..255)
        representante(nullable: false, blank: false, size: 1..31)
        logotipo(nullable: true, blank: true)

    }
}
