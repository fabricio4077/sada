package estacion

class Estacion {

    static auditable = true
    Provincia provincia
    Comercializadora comercializadora
    String nombre
    String telefono
    String mail
    String administrador
    String observaciones
    String direccion
    String representante
    String canton

    static mapping = {
        table 'etsv'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'etsv__id'
            provincia column: 'prov__id'
            comercializadora column: 'cmlz__id'
            nombre column: 'etsvnmbr'
            telefono column: 'etsvtlfn'
            mail column: 'etsvmail'
            administrador column: 'etsvadmi'
            observaciones column: 'etsvobsv'
            direccion column: 'etsvdire'
            representante column: 'etsvrplg'
            canton column: 'etsvcntn'

        }
    }

    static constraints = {
        nombre(nullable: false, blank: false, size: 1..63)
        administrador(nullable: false, blank: false, size: 1..31)
        direccion(nullable: false, blank: false, size: 1..255)
    }
}
