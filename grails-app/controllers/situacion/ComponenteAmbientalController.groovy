package situacion


class ComponenteAmbientalController extends Seguridad.Shield {

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
            def c = ComponenteAmbiental.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = ComponenteAmbiental.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def componenteAmbientalInstanceList = getLista(params, false)
        def componenteAmbientalInstanceCount = getLista(params, true).size()
        if (componenteAmbientalInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        componenteAmbientalInstanceList = getLista(params, false)
        return [componenteAmbientalInstanceList: componenteAmbientalInstanceList, componenteAmbientalInstanceCount: componenteAmbientalInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def componenteAmbientalInstance = ComponenteAmbiental.get(params.id)
            if (!componenteAmbientalInstance) {
                notFound_ajax()
                return
            }
            return [componenteAmbientalInstance: componenteAmbientalInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def componenteAmbientalInstance = new ComponenteAmbiental(params)
        if (params.id) {
            componenteAmbientalInstance = ComponenteAmbiental.get(params.id)
            if (!componenteAmbientalInstance) {
                notFound_ajax()
                return
            }
        }
        return [componenteAmbientalInstance: componenteAmbientalInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def componenteAmbientalInstance = new ComponenteAmbiental()
        if (params.id) {
            componenteAmbientalInstance = ComponenteAmbiental.get(params.id)
            if (!componenteAmbientalInstance) {
                notFound_ajax()
                return
            }
        } //update
        componenteAmbientalInstance.properties = params
        if (!componenteAmbientalInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} ComponenteAmbiental."
            msg += renderErrors(bean: componenteAmbientalInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de ComponenteAmbiental exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def componenteAmbientalInstance = ComponenteAmbiental.get(params.id)
            if (componenteAmbientalInstance) {
                try {
                    componenteAmbientalInstance.delete(flush: true)
                    render "OK_Eliminación de ComponenteAmbiental exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar ComponenteAmbiental."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró ComponenteAmbiental."
    } //notFound para ajax

}
