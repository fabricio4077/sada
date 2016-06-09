package metodologia


class MetodologiaController extends Seguridad.Shield {

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
            def c = Metodologia.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Metodologia.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def metodologiaInstanceList = getLista(params, false)
        def metodologiaInstanceCount = getLista(params, true).size()
        if (metodologiaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        metodologiaInstanceList = getLista(params, false)
        return [metodologiaInstanceList: metodologiaInstanceList, metodologiaInstanceCount: metodologiaInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def metodologiaInstance = Metodologia.get(params.id)
            if (!metodologiaInstance) {
                notFound_ajax()
                return
            }
            return [metodologiaInstance: metodologiaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def metodologiaInstance = new Metodologia(params)
        if (params.id) {
            metodologiaInstance = Metodologia.get(params.id)
            if (!metodologiaInstance) {
                notFound_ajax()
                return
            }
        }
        return [metodologiaInstance: metodologiaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def metodologiaInstance = new Metodologia()
        if (params.id) {
            metodologiaInstance = Metodologia.get(params.id)
            if (!metodologiaInstance) {
                notFound_ajax()
                return
            }
        } //update
        metodologiaInstance.properties = params
        if (!metodologiaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Metodologia."
            msg += renderErrors(bean: metodologiaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Metodologia exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def metodologiaInstance = Metodologia.get(params.id)
            if (metodologiaInstance) {
                try {
                    metodologiaInstance.delete(flush: true)
                    render "OK_Eliminación de Metodologia exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Metodologia."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Metodologia."
    } //notFound para ajax

    def metodologia () {

        def metodologia = Metodologia.get(1)
//        println("met " + metodologia)

        return[met: metodologia]
    }

    def verMetodologia (){

    }

    def guardarMetodologia_ajax () {
//        println("params guardar metodologia " + params)
        def metodologia

        if(params.id){
            metodologia = Metodologia.get(params.id)
            metodologia.descripcion = params.met
        }else{
            metodologia = new Metodologia()
            metodologia.descripcion = params.met
        }

        try{
            metodologia.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al guardar metodologia - ckeditor " + metodologia.errors)
        }


    }

}
