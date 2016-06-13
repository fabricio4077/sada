package situacion


class ElementoController extends Seguridad.Shield {

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
            def c = Elemento.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Elemento.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def elementoInstanceList = getLista(params, false)
        def elementoInstanceCount = getLista(params, true).size()
        if(elementoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        elementoInstanceList = getLista(params, false)
        return [elementoInstanceList: elementoInstanceList, elementoInstanceCount: elementoInstanceCount, params: params]
    } //list

    def show_ajax() {
        if(params.id) {
            def elementoInstance = Elemento.get(params.id)
            if(!elementoInstance) {
                notFound_ajax()
                return
            }
            return [elementoInstance: elementoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def elementoInstance = new Elemento(params)
        if(params.id) {
            elementoInstance = Elemento.get(params.id)
            if(!elementoInstance) {
                notFound_ajax()
                return
            }
        }
        return [elementoInstance: elementoInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def elementoInstance = new Elemento()
        if(params.id) {
            elementoInstance = Elemento.get(params.id)
            if(!elementoInstance) {
                notFound_ajax()
                return
            }
        } //update
        elementoInstance.properties = params
        if(!elementoInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Elemento."
            msg += renderErrors(bean: elementoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Elemento exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def elementoInstance = Elemento.get(params.id)
            if(elementoInstance) {
                try {
                    elementoInstance.delete(flush:true)
                    render "OK_Eliminación de Elemento exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Elemento."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Elemento."
    } //notFound para ajax

}
