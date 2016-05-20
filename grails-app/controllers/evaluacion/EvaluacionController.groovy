package evaluacion


class EvaluacionController extends Seguridad.Shield {

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
            def c = Evaluacion.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Evaluacion.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def evaluacionInstanceList = getLista(params, false)
        def evaluacionInstanceCount = getLista(params, true).size()
        if (evaluacionInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        evaluacionInstanceList = getLista(params, false)
        return [evaluacionInstanceList: evaluacionInstanceList, evaluacionInstanceCount: evaluacionInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def evaluacionInstance = Evaluacion.get(params.id)
            if (!evaluacionInstance) {
                notFound_ajax()
                return
            }
            return [evaluacionInstance: evaluacionInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def evaluacionInstance = new Evaluacion(params)
        if (params.id) {
            evaluacionInstance = Evaluacion.get(params.id)
            if (!evaluacionInstance) {
                notFound_ajax()
                return
            }
        }
        return [evaluacionInstance: evaluacionInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def evaluacionInstance = new Evaluacion()
        if (params.id) {
            evaluacionInstance = Evaluacion.get(params.id)
            if (!evaluacionInstance) {
                notFound_ajax()
                return
            }
        } //update
        evaluacionInstance.properties = params
        if (!evaluacionInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Evaluacion."
            msg += renderErrors(bean: evaluacionInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Evaluacion exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def evaluacionInstance = Evaluacion.get(params.id)
            if (evaluacionInstance) {
                try {
                    evaluacionInstance.delete(flush: true)
                    render "OK_Eliminación de Evaluacion exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Evaluacion."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Evaluacion."
    } //notFound para ajax

}
