package estacion


class CantonController extends Seguridad.Shield {

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
            def c = Canton.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Canton.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def cantonInstanceList = getLista(params, false)
        def cantonInstanceCount = getLista(params, true).size()
        if (cantonInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        cantonInstanceList = getLista(params, false)
        return [cantonInstanceList: cantonInstanceList, cantonInstanceCount: cantonInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def cantonInstance = Canton.get(params.id)
            if (!cantonInstance) {
                notFound_ajax()
                return
            }
            return [cantonInstance: cantonInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def cantonInstance = new Canton(params)
        if (params.id) {
            cantonInstance = Canton.get(params.id)
            if (!cantonInstance) {
                notFound_ajax()
                return
            }
        }
        return [cantonInstance: cantonInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def cantonInstance = new Canton()
        if (params.id) {
            cantonInstance = Canton.get(params.id)
            if (!cantonInstance) {
                notFound_ajax()
                return
            }
        } //update
        cantonInstance.properties = params
        if (!cantonInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Canton."
            msg += renderErrors(bean: cantonInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Canton exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def cantonInstance = Canton.get(params.id)
            if (cantonInstance) {
                try {
                    cantonInstance.delete(flush: true)
                    render "OK_Eliminación de Canton exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Canton."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Canton."
    } //notFound para ajax

}
