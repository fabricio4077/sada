package evaluacion


class HallazgoController extends Seguridad.Shield {

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
            def c = Hallazgo.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Hallazgo.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def hallazgoInstanceList = getLista(params, false)
        def hallazgoInstanceCount = getLista(params, true).size()
        if (hallazgoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        hallazgoInstanceList = getLista(params, false)
        return [hallazgoInstanceList: hallazgoInstanceList, hallazgoInstanceCount: hallazgoInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def hallazgoInstance = Hallazgo.get(params.id)
            if (!hallazgoInstance) {
                notFound_ajax()
                return
            }
            return [hallazgoInstance: hallazgoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def hallazgoInstance = new Hallazgo(params)
        if (params.id) {
            hallazgoInstance = Hallazgo.get(params.id)
            if (!hallazgoInstance) {
                notFound_ajax()
                return
            }
        }
        return [hallazgoInstance: hallazgoInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def hallazgoInstance = new Hallazgo()
        if (params.id) {
            hallazgoInstance = Hallazgo.get(params.id)
            if (!hallazgoInstance) {
                notFound_ajax()
                return
            }
        } //update
        hallazgoInstance.properties = params
        if (!hallazgoInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Hallazgo."
            msg += renderErrors(bean: hallazgoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Hallazgo exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def hallazgoInstance = Hallazgo.get(params.id)
            if (hallazgoInstance) {
                try {
                    hallazgoInstance.delete(flush: true)
                    render "OK_Eliminación de Hallazgo exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Hallazgo."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Hallazgo."
    } //notFound para ajax

}
