package situacion


class DesechoComponenteController extends Seguridad.Shield {

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
            def c = DesechoComponente.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = DesechoComponente.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def desechoComponenteInstanceList = getLista(params, false)
        def desechoComponenteInstanceCount = getLista(params, true).size()
        if (desechoComponenteInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        desechoComponenteInstanceList = getLista(params, false)
        return [desechoComponenteInstanceList: desechoComponenteInstanceList, desechoComponenteInstanceCount: desechoComponenteInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def desechoComponenteInstance = DesechoComponente.get(params.id)
            if (!desechoComponenteInstance) {
                notFound_ajax()
                return
            }
            return [desechoComponenteInstance: desechoComponenteInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def desechoComponenteInstance = new DesechoComponente(params)
        if (params.id) {
            desechoComponenteInstance = DesechoComponente.get(params.id)
            if (!desechoComponenteInstance) {
                notFound_ajax()
                return
            }
        }
        return [desechoComponenteInstance: desechoComponenteInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def desechoComponenteInstance = new DesechoComponente()
        if (params.id) {
            desechoComponenteInstance = DesechoComponente.get(params.id)
            if (!desechoComponenteInstance) {
                notFound_ajax()
                return
            }
        } //update
        desechoComponenteInstance.properties = params
        if (!desechoComponenteInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} DesechoComponente."
            msg += renderErrors(bean: desechoComponenteInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de DesechoComponente exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def desechoComponenteInstance = DesechoComponente.get(params.id)
            if (desechoComponenteInstance) {
                try {
                    desechoComponenteInstance.delete(flush: true)
                    render "OK_Eliminación de DesechoComponente exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar DesechoComponente."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró DesechoComponente."
    } //notFound para ajax

}
