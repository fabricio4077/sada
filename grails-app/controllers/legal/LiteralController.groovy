package legal


class LiteralController extends Seguridad.Shield {

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def getLista(params, all) {
        params = params.clone()
        if (all) {
            params.remove("offset")
            params.remove("max")
        }
        def lista
        if (params.search) {
            def c = Literal.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Literal.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def literalInstanceList = getLista(params, false)
        def literalInstanceCount = getLista(params, true).size()
        if (literalInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        literalInstanceList = getLista(params, false)
        return [literalInstanceList: literalInstanceList, literalInstanceCount: literalInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def literalInstance = Literal.get(params.id)
            if (!literalInstance) {
                notFound_ajax()
                return
            }
            return [literalInstance: literalInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {

//        println("params literal " + params)

        def articulo = Articulo.get(params.articulo)
        def norma
        def marco
        def mctp
        def litera

        if(params.norma){
            norma = MarcoNorma.get(params.norma).norma
        }

        if(params.marco){
            marco = MarcoLegal.get(params.marco)
        }

        if(params.id){
            litera = Literal.get(params.id)
           mctp = MarcoNorma.findByArticuloAndLiteralAndMarcoLegal(articulo,litera, marco)
        }

        def literalInstance = new Literal(params)
        if (params.id) {
            literalInstance = Literal.get(params.id)
            if (!literalInstance) {
                notFound_ajax()
                return
            }
        }
        return [literalInstance: literalInstance, articulo: articulo, norma: norma, marco: marco, mctp: mctp]
    } //form para cargar con ajax en un dialog

    def save_ajax() {

//        println("save params literal " + params)
        def articulo = Articulo.get(params.articulo)
        def marco

        def literal
        def error = ''

        if(params.id){
            literal = Literal.get(params.id)
            literal.identificador = params.identificador.toUpperCase()
            literal.descripcion = params.descripcion

            try{
                literal.save(flush: true)
            }catch (e){
                println("error al guardar el literal editar " + literal.errors)
                error += literal.errors
            }

            marco = MarcoLegal.get(params.marco)

            def mctpEditar = MarcoNorma.findByMarcoLegalAndArticuloAndLiteral(marco, articulo, literal)
            if(params.seleccionado == 'on'){
                mctpEditar.seleccionado = 1
            }else{
                mctpEditar.seleccionado = 0
            }

            try{
                mctpEditar.save(flush: true)
            }catch (e){
                error += mctpEditar.errors
            }


        }else{

            marco = MarcoLegal.get(params.marco)
            def norma = Norma.get(params.norma)

            literal = new Literal()
            literal.identificador = params.identificador.toUpperCase()
            literal.descripcion = params.descripcion

            try{
                literal.save(flush: true)
            }catch (e){
                println("error al guardar el literal editar " + literal.errors)
                error += literal.errors
            }

            def mctp = new MarcoNorma()
            mctp.literal = literal
            mctp.norma = norma
            mctp.articulo = articulo
            mctp.marcoLegal = marco
            if(params.seleccionado == 'on'){
                mctp.seleccionado = 1
            }

            try{
                mctp.save(flush: true)
            }catch (e){
                println("error al guardar el literal editar " + mctp.errors)
                error += mctp.errors
            }
        }

        if(error == ''){
            render 'ok'
        }else{
            render 'no'
        }
    } //save para grabar desde ajax

    def delete_ajax() {

        println("params borrar literal " + params)

        def articulo = Articulo.get(params.papa)
        def literal = Literal.get(params.id)
        def marco = MarcoLegal.get(params.abuelo)
        def mctp = MarcoNorma.findByArticuloAndMarcoLegalAndLiteral(articulo,marco, literal)

        def error = ''



        try{
            mctp.delete(flush: true)
        }catch (e){
            error += mctp.errors
        }


        def otros = MarcoNorma.findAllByLiteral(literal)
        if (!otros){
            try{
                literal.delete(flush: true)
            }catch (e){
                error += literal.errors
            }
        }

        if(error == ''){
            render "ok"
        }else{
            render "no"
        }



//        if (params.id) {
//            def literalInstance = Literal.get(params.id)
//            if (literalInstance) {
//                try {
//                    literalInstance.delete(flush: true)
//                    render "OK_Eliminación de Literal exitosa."
//                } catch (e) {
//                    render "NO_No se pudo eliminar Literal."
//                }
//            } else {
//                notFound_ajax()
//            }
//        } else {
//            notFound_ajax()
//        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Literal."
    } //notFound para ajax

}
