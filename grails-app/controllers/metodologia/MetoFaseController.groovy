package metodologia


class MetoFaseController extends Seguridad.Shield {

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
            def c = MetoFase.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = MetoFase.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def metoFaseInstanceList = getLista(params, false)
        def metoFaseInstanceCount = getLista(params, true).size()
        if (metoFaseInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        metoFaseInstanceList = getLista(params, false)
        return [metoFaseInstanceList: metoFaseInstanceList, metoFaseInstanceCount: metoFaseInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def metoFaseInstance = MetoFase.get(params.id)
            if (!metoFaseInstance) {
                notFound_ajax()
                return
            }
            return [metoFaseInstance: metoFaseInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def metoFaseInstance = new MetoFase(params)
        if (params.id) {
            metoFaseInstance = MetoFase.get(params.id)
            if (!metoFaseInstance) {
                notFound_ajax()
                return
            }
        }
        return [metoFaseInstance: metoFaseInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def metoFaseInstance = new MetoFase()
        if (params.id) {
            metoFaseInstance = MetoFase.get(params.id)
            if (!metoFaseInstance) {
                notFound_ajax()
                return
            }
        } //update
        metoFaseInstance.properties = params
        if (!metoFaseInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} MetoFase."
            msg += renderErrors(bean: metoFaseInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de MetoFase exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def metoFaseInstance = MetoFase.get(params.id)
            if (metoFaseInstance) {
                try {
                    metoFaseInstance.delete(flush: true)
                    render "OK_Eliminación de MetoFase exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar MetoFase."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró MetoFase."
    } //notFound para ajax

}
