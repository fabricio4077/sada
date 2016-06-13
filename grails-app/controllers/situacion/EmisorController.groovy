package situacion


class EmisorController extends Seguridad.Shield {

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
            def c = Emisor.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Emisor.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def emisorInstanceList = getLista(params, false)
        def emisorInstanceCount = getLista(params, true).size()
        if (emisorInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        emisorInstanceList = getLista(params, false)
        return [emisorInstanceList: emisorInstanceList, emisorInstanceCount: emisorInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def emisorInstance = Emisor.get(params.id)
            if (!emisorInstance) {
                notFound_ajax()
                return
            }
            return [emisorInstance: emisorInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def emisorInstance = new Emisor(params)
        if (params.id) {
            emisorInstance = Emisor.get(params.id)
            if (!emisorInstance) {
                notFound_ajax()
                return
            }
        }
        return [emisorInstance: emisorInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def emisorInstance = new Emisor()
        if (params.id) {
            emisorInstance = Emisor.get(params.id)
            if (!emisorInstance) {
                notFound_ajax()
                return
            }
        } //update
        emisorInstance.properties = params
        if (!emisorInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Emisor."
            msg += renderErrors(bean: emisorInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Emisor exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def emisorInstance = Emisor.get(params.id)
            if (emisorInstance) {
                try {
                    emisorInstance.delete(flush: true)
                    render "OK_Eliminación de Emisor exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Emisor."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Emisor."
    } //notFound para ajax

}
