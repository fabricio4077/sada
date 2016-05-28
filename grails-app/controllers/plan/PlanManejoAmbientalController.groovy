package plan


class PlanManejoAmbientalController extends Seguridad.Shield {

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
            def c = PlanManejoAmbiental.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = PlanManejoAmbiental.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def planManejoAmbientalInstanceList = getLista(params, false)
        def planManejoAmbientalInstanceCount = getLista(params, true).size()
        if(planManejoAmbientalInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        planManejoAmbientalInstanceList = getLista(params, false)
        return [planManejoAmbientalInstanceList: planManejoAmbientalInstanceList, planManejoAmbientalInstanceCount: planManejoAmbientalInstanceCount, params: params]
    } //list

    def show_ajax() {
        if(params.id) {
            def planManejoAmbientalInstance = PlanManejoAmbiental.get(params.id)
            if(!planManejoAmbientalInstance) {
                notFound_ajax()
                return
            }
            return [planManejoAmbientalInstance: planManejoAmbientalInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def planManejoAmbientalInstance = new PlanManejoAmbiental(params)
        if(params.id) {
            planManejoAmbientalInstance = PlanManejoAmbiental.get(params.id)
            if(!planManejoAmbientalInstance) {
                notFound_ajax()
                return
            }
        }
        return [planManejoAmbientalInstance: planManejoAmbientalInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def planManejoAmbientalInstance = new PlanManejoAmbiental()
        if(params.id) {
            planManejoAmbientalInstance = PlanManejoAmbiental.get(params.id)
            if(!planManejoAmbientalInstance) {
                notFound_ajax()
                return
            }
        } //update
        planManejoAmbientalInstance.properties = params
        if(!planManejoAmbientalInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} PlanManejoAmbiental."
            msg += renderErrors(bean: planManejoAmbientalInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de PlanManejoAmbiental exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def planManejoAmbientalInstance = PlanManejoAmbiental.get(params.id)
            if(planManejoAmbientalInstance) {
                try {
                    planManejoAmbientalInstance.delete(flush:true)
                    render "OK_Eliminación de PlanManejoAmbiental exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar PlanManejoAmbiental."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró PlanManejoAmbiental."
    } //notFound para ajax

}
