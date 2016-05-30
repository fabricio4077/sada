package plan

class Medida {

    static auditable = true
    String descripcion
    String indicadores
    String plazo
    String verificacion

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
            verificacion column: 'mddavrfc'
        }
    }


    static constraints = {

        plazo inList: ['Una vez','Semestral','Anual','Bi Anual','Permanente','Cuando se requiera', 'Etapa de Abandono del Proyecto']

    }
}
