package legal


class ArticuloController extends Seguridad.Shield {

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
            def c = Articulo.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Articulo.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def articuloInstanceList = getLista(params, false)
        def articuloInstanceCount = getLista(params, true).size()
        if (articuloInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        articuloInstanceList = getLista(params, false)

        def mctp = MarcoNorma.list()


        return [articuloInstanceList: articuloInstanceList, articuloInstanceCount: articuloInstanceCount, params: params, mctp: mctp]
    } //list

    def show_ajax() {
        if (params.id) {
            def articuloInstance = Articulo.get(params.id)
            if (!articuloInstance) {
                notFound_ajax()
                return
            }
            return [articuloInstance: articuloInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {

        println("params articulo" + params)

        def nodoPapa = params.papa
        def normaArbol
        def articulo
        def mctp
        def marco

        if(params.norma){
            normaArbol =  MarcoNorma.get(params.norma).norma
        }

        if(params.id){
            articulo = Articulo.get(params.id)
            marco = MarcoNorma.get(params.norma).marcoLegal
            mctp = MarcoNorma.findByArticuloAndNormaAndMarcoLegal(articulo,normaArbol, marco)
        }

        def articuloInstance = new Articulo(params)
        if (params.id) {
            articuloInstance = Articulo.get(params.id)
            if (!articuloInstance) {
                notFound_ajax()
                return
            }
        }
        return [articuloInstance: articuloInstance, normaExistente: normaArbol, papa: nodoPapa, mctp: mctp]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
//        println("params save articulo " + params)
        def articulo
        def error = ''

        if(params.id){
            articulo = Articulo.get(params.id)
            articulo.descripcion = params.descripcion
            articulo.numero = params.numero.toInteger()
            articulo.save(flush: true)

            def mctpEditar = MarcoNorma.get(params.mc)
            if(params.seleccionado == 'on'){
                mctpEditar.seleccionado = 1
            }else{
                mctpEditar.seleccionado = 0
            }

            try{
                mctpEditar.save(flush: true)
            }catch (e){
                println("error al guardar articulo - mctp - arbol")
                error += mctpEditar.errors
            }

        }else{

            articulo = new Articulo()
            articulo.descripcion = params.descripcion
            articulo.numero = params.numero.toInteger()

            try{
                articulo.save(flush: true)
            }catch (e){
                println("error al guardar el articulo - arbol")
                error += articulo.errors
            }

            def ml = MarcoLegal.get(params.papa)
            def norma = Norma.get(params."norma_id")
            def mctp = new MarcoNorma()
            mctp.marcoLegal = ml
            mctp.norma = norma
            mctp.articulo = articulo
            if(params.seleccionado == 'on'){
                mctp.seleccionado = 1
            }

            try{
                mctp.save(flush: true)
            }catch (e){
                println("error al guardar articulo - mctp - arbol")
                error += mctp.errors
            }
        }

//        println("error " + error)

        if(error == ''){
            render "ok"
        }else{
            render "no"
        }

//        if(params.norma_id){
//            params.norma = params.norma_id
//        }
//
//        def articuloInstance = new Articulo()
//        if (params.id) {
//            articuloInstance = Articulo.get(params.id)
//            if (!articuloInstance) {
//                notFound_ajax()
//                return
//            }
//        } //update
//        articuloInstance.properties = params
//        if (!articuloInstance.save(flush: true)) {
//            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Articulo."
//            msg += renderErrors(bean: articuloInstance)
//            render msg
//            return
//        }
//        render "OK_${params.id ? 'Actualización' : 'Creación'} de Articulo exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {

        println("params borrar articulo " + params)

        def articulo = Articulo.get(params.id)

        def marcoLegal = MarcoLegal.get(params.abuelo)
        def norma = MarcoNorma.get(params.papa).norma
        def mctp = MarcoNorma.findByNormaAndArticuloAndMarcoLegal(norma, articulo, marcoLegal)
        def error = ''

        try{
            mctp.delete(flush: true)
        }catch (e){
            println("error al borrar articulo - mctp")
            error += mctp.errors
        }

        def otros = MarcoNorma.findAllByArticulo(articulo)

        if(!otros){
            try{
                articulo.delete(flush: true)
            }catch (e){
                println("error al borrar articulo - articulo")
                error += articulo.errors
            }

        }

        if(error == ''){
            render "ok"
        }else{
            render "no"
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Articulo."
    } //notFound para ajax

    def validar_numero_ajax () {

//        println("params validar " + params)

        def numeroIngresado = params.numero.toInteger();
        def norma = Norma.get(params.id)
        def numerosArticulos = MarcoNorma.findAllByNorma(norma).articulo.numero

//        println("numeros " + numerosArticulos)

        if(numerosArticulos.contains(numeroIngresado)){
            render false
            return
        }else{
            render true
            return
        }


    }

}
