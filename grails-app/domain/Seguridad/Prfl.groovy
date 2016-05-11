package Seguridad

class Prfl {

    static auditable = true
    String nombre
    String descripcion
    String codigo

    static mapping = {
        table 'prfl'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'prfl__id'
            nombre column: 'prflnmbr'
            descripcion column: 'prfldscr'
            codigo column: 'prflcdgo'
        }
    }

    static constraints = {
        nombre(nullable: false, blank: false, size: 1..63)
        descripcion(nullable: true, blank: true, size: 1..63)
        codigo(nullable: true, blank: true, size: 1..63)
    }
}
