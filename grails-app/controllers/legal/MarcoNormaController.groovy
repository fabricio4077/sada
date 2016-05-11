package legal


class MarcoNormaController extends Seguridad.Shield {

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
            def c = MarcoNorma.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = MarcoNorma.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def marcoNormaInstanceList = getLista(params, false)
        def marcoNormaInstanceCount = getLista(params, true).size()
        if (marcoNormaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        marcoNormaInstanceList = getLista(params, false)
        return [marcoNormaInstanceList: marcoNormaInstanceList, marcoNormaInstanceCount: marcoNormaInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def marcoNormaInstance = MarcoNorma.get(params.id)
            if (!marcoNormaInstance) {
                notFound_ajax()
                return
            }
            return [marcoNormaInstance: marcoNormaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def marcoNormaInstance = new MarcoNorma(params)
        if (params.id) {
            marcoNormaInstance = MarcoNorma.get(params.id)
            if (!marcoNormaInstance) {
                notFound_ajax()
                return
            }
        }
        return [marcoNormaInstance: marcoNormaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def marcoNormaInstance = new MarcoNorma()
        if (params.id) {
            marcoNormaInstance = MarcoNorma.get(params.id)
            if (!marcoNormaInstance) {
                notFound_ajax()
                return
            }
        } //update
        marcoNormaInstance.properties = params
        if (!marcoNormaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} MarcoNorma."
            msg += renderErrors(bean: marcoNormaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de MarcoNorma exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def marcoNormaInstance = MarcoNorma.get(params.id)
            if (marcoNormaInstance) {
                try {
                    marcoNormaInstance.delete(flush: true)
                    render "OK_Eliminación de MarcoNorma exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar MarcoNorma."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró MarcoNorma."
    } //notFound para ajax

}
