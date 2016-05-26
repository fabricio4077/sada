package evaluacion


class AnexoController extends Seguridad.Shield {

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
            def c = Anexo.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Anexo.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def anexoInstanceList = getLista(params, false)
        def anexoInstanceCount = getLista(params, true).size()
        if (anexoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        anexoInstanceList = getLista(params, false)
        return [anexoInstanceList: anexoInstanceList, anexoInstanceCount: anexoInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def anexoInstance = Anexo.get(params.id)
            if (!anexoInstance) {
                notFound_ajax()
                return
            }
            return [anexoInstance: anexoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def anexoInstance = new Anexo(params)
        if (params.id) {
            anexoInstance = Anexo.get(params.id)
            if (!anexoInstance) {
                notFound_ajax()
                return
            }
        }
        return [anexoInstance: anexoInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def anexoInstance = new Anexo()
        if (params.id) {
            anexoInstance = Anexo.get(params.id)
            if (!anexoInstance) {
                notFound_ajax()
                return
            }
        } //update
        anexoInstance.properties = params
        if (!anexoInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Anexo."
            msg += renderErrors(bean: anexoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Anexo exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def anexoInstance = Anexo.get(params.id)
            if (anexoInstance) {
                try {
                    anexoInstance.delete(flush: true)
                    render "OK_Eliminación de Anexo exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Anexo."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Anexo."
    } //notFound para ajax

}
