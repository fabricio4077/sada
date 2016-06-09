package complemento


class AntecedenteController extends Seguridad.Shield {

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
            def c = Antecedente.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Antecedente.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def antecedenteInstanceList = getLista(params, false)
        def antecedenteInstanceCount = getLista(params, true).size()
        if (antecedenteInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        antecedenteInstanceList = getLista(params, false)
        return [antecedenteInstanceList: antecedenteInstanceList, antecedenteInstanceCount: antecedenteInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def antecedenteInstance = Antecedente.get(params.id)
            if (!antecedenteInstance) {
                notFound_ajax()
                return
            }
            return [antecedenteInstance: antecedenteInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def antecedenteInstance = new Antecedente(params)
        if (params.id) {
            antecedenteInstance = Antecedente.get(params.id)
            if (!antecedenteInstance) {
                notFound_ajax()
                return
            }
        }
        return [antecedenteInstance: antecedenteInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def antecedenteInstance = new Antecedente()
        if (params.id) {
            antecedenteInstance = Antecedente.get(params.id)
            if (!antecedenteInstance) {
                notFound_ajax()
                return
            }
        } //update
        antecedenteInstance.properties = params
        if (!antecedenteInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Antecedente."
            msg += renderErrors(bean: antecedenteInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Antecedente exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def antecedenteInstance = Antecedente.get(params.id)
            if (antecedenteInstance) {
                try {
                    antecedenteInstance.delete(flush: true)
                    render "OK_Eliminación de Antecedente exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Antecedente."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Antecedente."
    } //notFound para ajax

}
