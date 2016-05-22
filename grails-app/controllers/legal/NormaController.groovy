package legal



class NormaController extends Seguridad.Shield {

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
            def c = Norma.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Norma.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def normaInstanceList = getLista(params, false)
        def normaInstanceCount = getLista(params, true).size()
        if (normaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        normaInstanceList = getLista(params, false)
        return [normaInstanceList: normaInstanceList, normaInstanceCount: normaInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def normaInstance = Norma.get(params.id)
            if (!normaInstance) {
                notFound_ajax()
                return
            }
            return [normaInstance: normaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
//        println("params norma legal " + params)
        def marco
        if(params.idMarco){
            marco = params.idMarco
            if(MarcoNorma.get(marco)?.norma?.id){
                params.id = MarcoNorma.get(marco).norma.id
            }

        }

        def normaInstance = new Norma(params)
        if (params.id) {
            normaInstance = Norma.get(params.id)
            if (!normaInstance) {
                notFound_ajax()
                return
            }
        }
        return [normaInstance: normaInstance, marco: marco]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def normaInstance = new Norma()
        if (params.id) {
            normaInstance = Norma.get(params.id)
            if (!normaInstance) {
                notFound_ajax()
                return
            }
        } //update
        normaInstance.properties = params
        if (!normaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Norma."
            msg += renderErrors(bean: normaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Norma exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def normaInstance = Norma.get(params.id)
            if (normaInstance) {
                try {
                    normaInstance.delete(flush: true)
                    render "OK_Eliminación de Norma exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Norma."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Norma."
    } //notFound para ajax

    def guardarNorma_ajax () {
//        println("params guardar norma " + params)
        def norma
        def error = ''

        if(params.id){

            norma = Norma.get(params.id)
            norma.nombre = params.nombre
            norma.descripcion = params.descripcion
            norma.anio = params.anio
            norma.tipoNorma = TipoNorma.get(params."tipoNorma.id")

            try{
                norma.save(flush: true)
            }catch (e){
                error += norma.errors
                println("Error al guardar la norma (arbol)" + norma.errors)
            }

        }else{

            norma = new Norma()
            norma.nombre = params.nombre
            norma.descripcion = params.descripcion
            norma.anio = params.anio
            norma.tipoNorma = TipoNorma.get(params."tipoNorma.id")
            try{
                norma.save(flush: true)
            }catch (e){
                error += norma.errors
                println("Error al guardar la norma (arbol)" + norma.errors)
            }

            def marcoNorma = new MarcoNorma()
            marcoNorma.norma = norma
            marcoNorma.marcoLegal = MarcoLegal.get(params.marco)

            try{
                marcoNorma.save(flush: true)
            }catch (e){
                error += marcoNorma.errors
                println("Error al guardar el marco x norma (arbol)" + marcoNorma.errors)
            }
        }

        if(error == ''){
            render "ok"
        }else{
            render "no"
        }
    }

    def borrarNorma_ajax () {

        println("params borrar norma " + params)
        def norma = MarcoNorma.get(params.id).norma
        def ml = MarcoLegal.get(params.marco)
        def mctp = MarcoNorma.findAllByNormaAndMarcoLegal(norma,ml)
        def mn = MarcoNorma.findByNormaAndMarcoLegalAndArticuloIsNull(norma, ml)
        def error = ''

        def articulos = MarcoNorma.findAllByNormaAndMarcoLegalAndArticuloIsNotNull(norma,ml).articulo

        println("norma " + norma)
        println("ml " + ml)
        println("mctp " + mctp)
        println("mn " + mn)

        mctp.each {k->
            try{
                k.delete(flush: true)
            }catch (e){
                error += k.errors
            }
        }

        def otros = MarcoNorma.findAllByNorma(norma)
        println("otros " + otros)
        println("articulos " + articulos)

        if(!otros){
            try{
                norma.delete(flush: true)

            }catch (e){
                error += norma.errors
            }
        }

            if(error == ''){
                render "ok"
            }else{
                render "no"
            }
    }

}
