package plan


class AspectoAmbientalController extends Seguridad.Shield {

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
            def c = AspectoAmbiental.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = AspectoAmbiental.list(params)
        }
        return lista
    }

    def list() {
        if (session.perfil.codigo == 'ADMI') {
            params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
            def aspectoAmbientalInstanceList = getLista(params, false)
            def aspectoAmbientalInstanceCount = getLista(params, true).size()
            if (aspectoAmbientalInstanceList.size() == 0 && params.offset && params.max) {
                params.offset = params.offset - params.max
            }
            aspectoAmbientalInstanceList = getLista(params, false)
            return [aspectoAmbientalInstanceList: aspectoAmbientalInstanceList, aspectoAmbientalInstanceCount: aspectoAmbientalInstanceCount, params: params]
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su perfil."
            response.sendError(403)
        }

    } //list

    def show_ajax() {
        if (params.id) {
            def aspectoAmbientalInstance = AspectoAmbiental.get(params.id)
            if (!aspectoAmbientalInstance) {
                notFound_ajax()
                return
            }
            return [aspectoAmbientalInstance: aspectoAmbientalInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def aspectoAmbientalInstance = new AspectoAmbiental(params)
        if (params.id) {
            aspectoAmbientalInstance = AspectoAmbiental.get(params.id)
            if (!aspectoAmbientalInstance) {
                notFound_ajax()
                return
            }
        }
        return [aspectoAmbientalInstance: aspectoAmbientalInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {

        println("params save aspecto " + params)

        def aspectoAmbientalInstance = new AspectoAmbiental()
        if (params.id) {
            aspectoAmbientalInstance = AspectoAmbiental.get(params.id)
            if (!aspectoAmbientalInstance) {
                notFound_ajax()
                return
            }
        } //update
        aspectoAmbientalInstance.properties = params
        if (!aspectoAmbientalInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} AspectoAmbiental."
            msg += renderErrors(bean: aspectoAmbientalInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de AspectoAmbiental exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def aspectoAmbientalInstance = AspectoAmbiental.get(params.id)
            if (aspectoAmbientalInstance) {
                try {
                    aspectoAmbientalInstance.delete(flush: true)
                    render "OK_Eliminación de AspectoAmbiental exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar AspectoAmbiental."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró AspectoAmbiental."
    } //notFound para ajax

    def crearAspecto_ajax () {
//        println("params crear aspecto " + params)
        def plan = PlanManejoAmbiental.get(params.id)
        return [plan: plan]
    }

}
