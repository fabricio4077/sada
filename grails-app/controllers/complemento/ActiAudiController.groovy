package complemento


class ActiAudiController extends Seguridad.Shield {

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
            def c = ActiAudi.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = ActiAudi.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def actiAudiInstanceList = getLista(params, false)
        def actiAudiInstanceCount = getLista(params, true).size()
        if (actiAudiInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        actiAudiInstanceList = getLista(params, false)
        return [actiAudiInstanceList: actiAudiInstanceList, actiAudiInstanceCount: actiAudiInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def actiAudiInstance = ActiAudi.get(params.id)
            if (!actiAudiInstance) {
                notFound_ajax()
                return
            }
            return [actiAudiInstance: actiAudiInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def actiAudiInstance = new ActiAudi(params)
        if (params.id) {
            actiAudiInstance = ActiAudi.get(params.id)
            if (!actiAudiInstance) {
                notFound_ajax()
                return
            }
        }
        return [actiAudiInstance: actiAudiInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def actiAudiInstance = new ActiAudi()
        if (params.id) {
            actiAudiInstance = ActiAudi.get(params.id)
            if (!actiAudiInstance) {
                notFound_ajax()
                return
            }
        } //update
        actiAudiInstance.properties = params
        if (!actiAudiInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} ActiAudi."
            msg += renderErrors(bean: actiAudiInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de ActiAudi exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def actiAudiInstance = ActiAudi.get(params.id)
            if (actiAudiInstance) {
                try {
                    actiAudiInstance.delete(flush: true)
                    render "OK_Eliminación de ActiAudi exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar ActiAudi."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró ActiAudi."
    } //notFound para ajax

}
