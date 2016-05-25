package evaluacion

import auditoria.Auditoria
import auditoria.DetalleAuditoria
import auditoria.Preauditoria


class PlanAccionController extends Seguridad.Shield {

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
            def c = PlanAccion.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = PlanAccion.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def planAccionInstanceList = getLista(params, false)
        def planAccionInstanceCount = getLista(params, true).size()
        if (planAccionInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        planAccionInstanceList = getLista(params, false)
        return [planAccionInstanceList: planAccionInstanceList, planAccionInstanceCount: planAccionInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def planAccionInstance = PlanAccion.get(params.id)
            if (!planAccionInstance) {
                notFound_ajax()
                return
            }
            return [planAccionInstance: planAccionInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def planAccionInstance = new PlanAccion(params)
        if (params.id) {
            planAccionInstance = PlanAccion.get(params.id)
            if (!planAccionInstance) {
                notFound_ajax()
                return
            }
        }
        return [planAccionInstance: planAccionInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def planAccionInstance = new PlanAccion()
        if (params.id) {
            planAccionInstance = PlanAccion.get(params.id)
            if (!planAccionInstance) {
                notFound_ajax()
                return
            }
        } //update
        planAccionInstance.properties = params
        if (!planAccionInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} PlanAccion."
            msg += renderErrors(bean: planAccionInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de PlanAccion exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def planAccionInstance = PlanAccion.get(params.id)
            if (planAccionInstance) {
                try {
                    planAccionInstance.delete(flush: true)
                    render "OK_Eliminación de PlanAccion exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar PlanAccion."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró PlanAccion."
    } //notFound para ajax

    def planAccionActual () {

        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def listaCalificaciones = ['NC+','nc-','O']
        def calificaciones = Calificacion.findAllBySiglaInList(listaCalificaciones)
        def evaluacionesNo = Evaluacion.findAllByDetalleAuditoriaAndCalificacionInList(detalleAuditoria,calificaciones)

        println("no " + evaluacionesNo)


        return [pre: pre, lista: evaluacionesNo]

    }

}
