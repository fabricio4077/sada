package situacion


class SituacionController extends Seguridad.Shield {

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
            def c = Situacion.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Situacion.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def situacionInstanceList = getLista(params, false)
        def situacionInstanceCount = getLista(params, true).size()
        if(situacionInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        situacionInstanceList = getLista(params, false)
        return [situacionInstanceList: situacionInstanceList, situacionInstanceCount: situacionInstanceCount, params: params]
    } //list

    def show_ajax() {
        if(params.id) {
            def situacionInstance = Situacion.get(params.id)
            if(!situacionInstance) {
                notFound_ajax()
                return
            }
            return [situacionInstance: situacionInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def situacionInstance = new Situacion(params)
        if(params.id) {
            situacionInstance = Situacion.get(params.id)
            if(!situacionInstance) {
                notFound_ajax()
                return
            }
        }
        return [situacionInstance: situacionInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def situacionInstance = new Situacion()
        if(params.id) {
            situacionInstance = Situacion.get(params.id)
            if(!situacionInstance) {
                notFound_ajax()
                return
            }
        } //update
        situacionInstance.properties = params
        if(!situacionInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Situacion."
            msg += renderErrors(bean: situacionInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Situacion exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def situacionInstance = Situacion.get(params.id)
            if(situacionInstance) {
                try {
                    situacionInstance.delete(flush:true)
                    render "OK_Eliminación de Situacion exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Situacion."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Situacion."
    } //notFound para ajax

}
