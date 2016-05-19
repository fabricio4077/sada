package evaluacion


class Calificacion {

    static auditable = true
    String nombre
    String sigla
    String tipo

    static mapping = {
        table 'clfc'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'clfc__id'
            nombre column: 'clfcnmbr'
            sigla column: 'clfcsigl'
            tipo column: 'clfctipo'
        }
    }



    static constraints = {
        tipo(nullable: true, blank: true)
    }
}
