package situacion


class DesechosController extends Seguridad.Shield {

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
            def c = Desechos.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Desechos.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def desechosInstanceList = getLista(params, false)
        def desechosInstanceCount = getLista(params, true).size()
        if (desechosInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        desechosInstanceList = getLista(params, false)
        return [desechosInstanceList: desechosInstanceList, desechosInstanceCount: desechosInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def desechosInstance = Desechos.get(params.id)
            if (!desechosInstance) {
                notFound_ajax()
                return
            }
            return [desechosInstance: desechosInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def desechosInstance = new Desechos(params)
        if (params.id) {
            desechosInstance = Desechos.get(params.id)
            if (!desechosInstance) {
                notFound_ajax()
                return
            }
        }
        return [desechosInstance: desechosInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def desechosInstance = new Desechos()
        if (params.id) {
            desechosInstance = Desechos.get(params.id)
            if (!desechosInstance) {
                notFound_ajax()
                return
            }
        } //update
        desechosInstance.properties = params
        if (!desechosInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Desechos."
            msg += renderErrors(bean: desechosInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Desechos exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def desechosInstance = Desechos.get(params.id)
            if (desechosInstance) {
                try {
                    desechosInstance.delete(flush: true)
                    render "OK_Eliminación de Desechos exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Desechos."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Desechos."
    } //notFound para ajax

}
