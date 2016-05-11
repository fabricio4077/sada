package consultor


class ConsultorController extends Seguridad.Shield {

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
            def c = Consultor.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Consultor.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def consultorInstanceList = getLista(params, false)
        def consultorInstanceCount = getLista(params, true).size()
        if (consultorInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        consultorInstanceList = getLista(params, false)
        return [consultorInstanceList: consultorInstanceList, consultorInstanceCount: consultorInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def consultorInstance = Consultor.get(params.id)
            if (!consultorInstance) {
                notFound_ajax()
                return
            }
            return [consultorInstance: consultorInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def consultorInstance = new Consultor(params)
        if (params.id) {
            consultorInstance = Consultor.get(params.id)
            if (!consultorInstance) {
                notFound_ajax()
                return
            }
        }
        return [consultorInstance: consultorInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def consultorInstance = new Consultor()
        if (params.id) {
            consultorInstance = Consultor.get(params.id)
            if (!consultorInstance) {
                notFound_ajax()
                return
            }
        } //update
        consultorInstance.properties = params
        if (!consultorInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Consultor."
            msg += renderErrors(bean: consultorInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Consultor exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def consultorInstance = Consultor.get(params.id)
            if (consultorInstance) {
                try {
                    consultorInstance.delete(flush: true)
                    render "OK_Eliminación de Consultor exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Consultor."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Consultor."
    } //notFound para ajax

}
