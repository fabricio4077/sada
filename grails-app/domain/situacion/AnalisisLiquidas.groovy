package situacion

class AnalisisLiquidas {

    static auditable = true
    Elemento elemento
    String referencia
    String limite
    String resultado
    String maximo
    Date fecha

    static mapping = {
        table 'andl'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'andl__id'
            elemento column: 'elmt__id'
            referencia column: 'andlrfrc'
            limite column: 'andllimt'
            resultado column: 'andlrstd'
            maximo column: 'andlfcha'
        }
    }

    static constraints = {
    }
}
