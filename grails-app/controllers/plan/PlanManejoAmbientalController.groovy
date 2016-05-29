package plan

import auditoria.Auditoria
import auditoria.DetalleAuditoria
import auditoria.Preauditoria


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
        planManejoAmbientalInstance.codigo = params.codigo.toUpperCase();
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

    def planManejoAmbiental () {

//        println("params pma " + params)

        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(auditoria)
        
        return [pre: pre, band: params.band]
    }

    def cargarAspectos_ajax () {

        def plan = PlanManejoAmbiental.get(params.id)
        def aspectos = AspectoAmbiental.findAllByPlanManejoAmbiental(plan)

        return [listaAspectos: aspectos]
    }

    def tablaPlan_ajax() {

//        println("params tabla plan " + params)

        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(auditoria)
        def per
        if(params.band){
            per = 'ANT'
        }else{
            per = 'ACT'
        }

        def aupm = PlanAuditoria.findAllByDetalleAuditoriaAndPeriodo(detalleAuditoria, per, [sort: 'aspectoAmbiental.planManejoAmbiental', order: 'asc'])

//        println("aupm " + aupm)

        return [aupm: aupm]
    }

    def cargarMedida_ajax() {

        def aupm = PlanAuditoria.get(params.id).aspectoAmbiental

        def medidasExistentes = PlanAuditoria.findAllByAspectoAmbientalAndMedidaIsNotNull(aupm)

//        println("medidas " + medidasExistentes)

        return [medidasExistentes: medidasExistentes]
    }

    def tablaMedida_ajax() {
        def medida = Medida.get(params.id)
        return [medida: medida]
    }

    def crearMedida_ajax (){

    }

}
