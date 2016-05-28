package plan


class PlanAuditoriaController extends Seguridad.Shield {

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
            def c = PlanAuditoria.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = PlanAuditoria.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def planAuditoriaInstanceList = getLista(params, false)
        def planAuditoriaInstanceCount = getLista(params, true).size()
        if (planAuditoriaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        planAuditoriaInstanceList = getLista(params, false)
        return [planAuditoriaInstanceList: planAuditoriaInstanceList, planAuditoriaInstanceCount: planAuditoriaInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def planAuditoriaInstance = PlanAuditoria.get(params.id)
            if (!planAuditoriaInstance) {
                notFound_ajax()
                return
            }
            return [planAuditoriaInstance: planAuditoriaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def planAuditoriaInstance = new PlanAuditoria(params)
        if (params.id) {
            planAuditoriaInstance = PlanAuditoria.get(params.id)
            if (!planAuditoriaInstance) {
                notFound_ajax()
                return
            }
        }
        return [planAuditoriaInstance: planAuditoriaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def planAuditoriaInstance = new PlanAuditoria()
        if (params.id) {
            planAuditoriaInstance = PlanAuditoria.get(params.id)
            if (!planAuditoriaInstance) {
                notFound_ajax()
                return
            }
        } //update
        planAuditoriaInstance.properties = params
        if (!planAuditoriaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} PlanAuditoria."
            msg += renderErrors(bean: planAuditoriaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de PlanAuditoria exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def planAuditoriaInstance = PlanAuditoria.get(params.id)
            if (planAuditoriaInstance) {
                try {
                    planAuditoriaInstance.delete(flush: true)
                    render "OK_Eliminación de PlanAuditoria exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar PlanAuditoria."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró PlanAuditoria."
    } //notFound para ajax

}
