package estacion


class ExtintorController extends Seguridad.Shield {

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
            def c = Extintor.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Extintor.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def extintorInstanceList = getLista(params, false)
        def extintorInstanceCount = getLista(params, true).size()
        if (extintorInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        extintorInstanceList = getLista(params, false)
        return [extintorInstanceList: extintorInstanceList, extintorInstanceCount: extintorInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def extintorInstance = Extintor.get(params.id)
            if (!extintorInstance) {
                notFound_ajax()
                return
            }
            return [extintorInstance: extintorInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def extintorInstance = new Extintor(params)
        if (params.id) {
            extintorInstance = Extintor.get(params.id)
            if (!extintorInstance) {
                notFound_ajax()
                return
            }
        }
        return [extintorInstance: extintorInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def extintorInstance = new Extintor()
        if (params.id) {
            extintorInstance = Extintor.get(params.id)
            if (!extintorInstance) {
                notFound_ajax()
                return
            }
        } //update
        extintorInstance.properties = params
        if (!extintorInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Extintor."
            msg += renderErrors(bean: extintorInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Extintor exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def extintorInstance = Extintor.get(params.id)
            if (extintorInstance) {
                try {
                    extintorInstance.delete(flush: true)
                    render "OK_Eliminación de Extintor exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Extintor."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Extintor."
    } //notFound para ajax

}
