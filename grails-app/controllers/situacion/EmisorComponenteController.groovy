package situacion


class EmisorComponenteController extends Seguridad.Shield {

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
            def c = EmisorComponente.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = EmisorComponente.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def emisorComponenteInstanceList = getLista(params, false)
        def emisorComponenteInstanceCount = getLista(params, true).size()
        if (emisorComponenteInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        emisorComponenteInstanceList = getLista(params, false)
        return [emisorComponenteInstanceList: emisorComponenteInstanceList, emisorComponenteInstanceCount: emisorComponenteInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def emisorComponenteInstance = EmisorComponente.get(params.id)
            if (!emisorComponenteInstance) {
                notFound_ajax()
                return
            }
            return [emisorComponenteInstance: emisorComponenteInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def emisorComponenteInstance = new EmisorComponente(params)
        if (params.id) {
            emisorComponenteInstance = EmisorComponente.get(params.id)
            if (!emisorComponenteInstance) {
                notFound_ajax()
                return
            }
        }
        return [emisorComponenteInstance: emisorComponenteInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def emisorComponenteInstance = new EmisorComponente()
        if (params.id) {
            emisorComponenteInstance = EmisorComponente.get(params.id)
            if (!emisorComponenteInstance) {
                notFound_ajax()
                return
            }
        } //update
        emisorComponenteInstance.properties = params
        if (!emisorComponenteInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} EmisorComponente."
            msg += renderErrors(bean: emisorComponenteInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de EmisorComponente exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def emisorComponenteInstance = EmisorComponente.get(params.id)
            if (emisorComponenteInstance) {
                try {
                    emisorComponenteInstance.delete(flush: true)
                    render "OK_Eliminación de EmisorComponente exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar EmisorComponente."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró EmisorComponente."
    } //notFound para ajax

}
