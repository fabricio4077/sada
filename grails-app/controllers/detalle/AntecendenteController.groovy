package detalle


class AntecendenteController extends Seguridad.Shield {

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
            def c = Antecendente.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Antecendente.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def antecendenteInstanceList = getLista(params, false)
        def antecendenteInstanceCount = getLista(params, true).size()
        if(antecendenteInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        antecendenteInstanceList = getLista(params, false)
        return [antecendenteInstanceList: antecendenteInstanceList, antecendenteInstanceCount: antecendenteInstanceCount, params: params]
    } //list

    def show_ajax() {
        if(params.id) {
            def antecendenteInstance = Antecendente.get(params.id)
            if(!antecendenteInstance) {
                notFound_ajax()
                return
            }
            return [antecendenteInstance: antecendenteInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def antecendenteInstance = new Antecendente(params)
        if(params.id) {
            antecendenteInstance = Antecendente.get(params.id)
            if(!antecendenteInstance) {
                notFound_ajax()
                return
            }
        }
        return [antecendenteInstance: antecendenteInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def antecendenteInstance = new Antecendente()
        if(params.id) {
            antecendenteInstance = Antecendente.get(params.id)
            if(!antecendenteInstance) {
                notFound_ajax()
                return
            }
        } //update
        antecendenteInstance.properties = params
        if(!antecendenteInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Antecendente."
            msg += renderErrors(bean: antecendenteInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Antecendente exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def antecendenteInstance = Antecendente.get(params.id)
            if(antecendenteInstance) {
                try {
                    antecendenteInstance.delete(flush:true)
                    render "OK_Eliminación de Antecendente exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Antecendente."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Antecendente."
    } //notFound para ajax

}
