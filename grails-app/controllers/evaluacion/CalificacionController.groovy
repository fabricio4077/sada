package evaluacion


class CalificacionController extends Seguridad.Shield {

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
            def c = Calificacion.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Calificacion.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def calificacionInstanceList = getLista(params, false)
        def calificacionInstanceCount = getLista(params, true).size()
        if(calificacionInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        calificacionInstanceList = getLista(params, false)
        return [calificacionInstanceList: calificacionInstanceList, calificacionInstanceCount: calificacionInstanceCount, params: params]
    } //list

    def show_ajax() {
        if(params.id) {
            def calificacionInstance = Calificacion.get(params.id)
            if(!calificacionInstance) {
                notFound_ajax()
                return
            }
            return [calificacionInstance: calificacionInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def calificacionInstance = new Calificacion(params)
        if(params.id) {
            calificacionInstance = Calificacion.get(params.id)
            if(!calificacionInstance) {
                notFound_ajax()
                return
            }
        }
        return [calificacionInstance: calificacionInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def calificacionInstance = new Calificacion()
        if(params.id) {
            calificacionInstance = Calificacion.get(params.id)
            if(!calificacionInstance) {
                notFound_ajax()
                return
            }
        } //update
        calificacionInstance.properties = params
        if(!calificacionInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Calificacion."
            msg += renderErrors(bean: calificacionInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Calificacion exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def calificacionInstance = Calificacion.get(params.id)
            if(calificacionInstance) {
                try {
                    calificacionInstance.delete(flush:true)
                    render "OK_Eliminación de Calificacion exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Calificacion."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Calificacion."
    } //notFound para ajax

}
