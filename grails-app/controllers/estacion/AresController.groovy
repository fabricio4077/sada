package estacion


class AresController extends Seguridad.Shield {

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
            def c = Ares.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Ares.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def aresInstanceList = getLista(params, false)
        def aresInstanceCount = getLista(params, true).size()
        if (aresInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        aresInstanceList = getLista(params, false)
        return [aresInstanceList: aresInstanceList, aresInstanceCount: aresInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def aresInstance = Ares.get(params.id)
            if (!aresInstance) {
                notFound_ajax()
                return
            }
            return [aresInstance: aresInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def aresInstance = new Ares(params)
        if (params.id) {
            aresInstance = Ares.get(params.id)
            if (!aresInstance) {
                notFound_ajax()
                return
            }
        }
        return [aresInstance: aresInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def aresInstance = new Ares()
        if (params.id) {
            aresInstance = Ares.get(params.id)
            if (!aresInstance) {
                notFound_ajax()
                return
            }
        } //update
        aresInstance.properties = params
        if (!aresInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Ares."
            msg += renderErrors(bean: aresInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Ares exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def aresInstance = Ares.get(params.id)
            if (aresInstance) {
                try {
                    aresInstance.delete(flush: true)
                    render "OK_Eliminación de Ares exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Ares."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Ares."
    } //notFound para ajax

}
