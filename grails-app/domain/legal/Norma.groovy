package legal

class Norma {

    static auditable = true
    TipoNorma tipoNorma
    String nombre
    String descripcion
    Date anio

    static mapping = {
        table 'nmra'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'nmra__id'
            tipoNorma column: 'tpnm__id'
            nombre column: 'nmranmbr'
            descripcion column: 'nmradscr'
            anio column: 'nmraanio'
        }
    }


    static constraints = {
        nombre(nullable: false, blank: false, size: 1..254)
        descripcion(nullable: false, blank: false, size: 1..1023)
     }
}
