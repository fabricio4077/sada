package consultor


class ConsultoraController extends Seguridad.Shield {

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
            def c = Consultora.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Consultora.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def consultoraInstanceList = getLista(params, false)
        def consultoraInstanceCount = getLista(params, true).size()
        if(consultoraInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        consultoraInstanceList = getLista(params, false)
        return [consultoraInstanceList: consultoraInstanceList, consultoraInstanceCount: consultoraInstanceCount, params: params]
    } //list

    def show_ajax() {
        if(params.id) {
            def consultoraInstance = Consultora.get(params.id)
            if(!consultoraInstance) {
                notFound_ajax()
                return
            }
            return [consultoraInstance: consultoraInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def consultoraInstance = new Consultora(params)
        if(params.id) {
            consultoraInstance = Consultora.get(params.id)
            if(!consultoraInstance) {
                notFound_ajax()
                return
            }
        }
        return [consultoraInstance: consultoraInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def consultoraInstance = new Consultora()
        if(params.id) {
            consultoraInstance = Consultora.get(params.id)
            if(!consultoraInstance) {
                notFound_ajax()
                return
            }
        } //update
        consultoraInstance.properties = params
        if(!consultoraInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Consultora."
            msg += renderErrors(bean: consultoraInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Consultora exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def consultoraInstance = Consultora.get(params.id)
            if(consultoraInstance) {
                try {
                    consultoraInstance.delete(flush:true)
                    render "OK_Eliminación de Consultora exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Consultora."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Consultora."
    } //notFound para ajax

}
