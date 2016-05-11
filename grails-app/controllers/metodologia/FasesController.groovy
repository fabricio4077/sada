package metodologia


class FasesController extends Seguridad.Shield {

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
            def c = Fases.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Fases.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def fasesInstanceList = getLista(params, false)
        def fasesInstanceCount = getLista(params, true).size()
        if(fasesInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        fasesInstanceList = getLista(params, false)
        return [fasesInstanceList: fasesInstanceList, fasesInstanceCount: fasesInstanceCount, params: params]
    } //list

    def show_ajax() {
        if(params.id) {
            def fasesInstance = Fases.get(params.id)
            if(!fasesInstance) {
                notFound_ajax()
                return
            }
            return [fasesInstance: fasesInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def fasesInstance = new Fases(params)
        if(params.id) {
            fasesInstance = Fases.get(params.id)
            if(!fasesInstance) {
                notFound_ajax()
                return
            }
        }
        return [fasesInstance: fasesInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def fasesInstance = new Fases()
        if(params.id) {
            fasesInstance = Fases.get(params.id)
            if(!fasesInstance) {
                notFound_ajax()
                return
            }
        } //update
        fasesInstance.properties = params
        if(!fasesInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Fases."
            msg += renderErrors(bean: fasesInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Fases exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def fasesInstance = Fases.get(params.id)
            if(fasesInstance) {
                try {
                    fasesInstance.delete(flush:true)
                    render "OK_Eliminación de Fases exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Fases."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Fases."
    } //notFound para ajax

}
