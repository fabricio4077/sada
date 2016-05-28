package plan

class Medida {

    static auditable = true
    String descripcion
    String indicadores
    String plazo

    static mapping = {
        table 'mdda'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'mdda__id'
            descripcion column: 'mddadscr'
            indicadores column: 'mddaindi'
            plazo column: 'mddaplzo'
        }
    }


    static constraints = {

        plazo inList: ['Anual','Semestral','Permanente','Cuando se requiera']

    }
}
