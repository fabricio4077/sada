package evaluacion

import auditoria.Auditoria
import auditoria.DetalleAuditoria
import auditoria.Preauditoria
import objetivo.Objetivo
import objetivo.ObjetivosAuditoria


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
        def objetivo =  Objetivo.findByIdentificador('Plan de Acción')
        def obau = ObjetivosAuditoria.findByAuditoriaAndObjetivo(audi,objetivo)
//        def listaCalificaciones = ['NC+','nc-','O']
//        def calificaciones = Calificacion.findAllBySiglaInList(listaCalificaciones)
//        def evaluacionesNo = Evaluacion.findAllByDetalleAuditoriaAndCalificacionInList(detalleAuditoria,calificaciones)

        return [pre: pre, obau: obau]
    }

    def tablaPlan_ajax (){
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def listaCalificaciones = ['NC+','nc-','O']
        def calificaciones = Calificacion.findAllBySiglaInList(listaCalificaciones)
        def evaluacionesNo = Evaluacion.findAllByDetalleAuditoriaAndCalificacionInList(detalleAuditoria,calificaciones, [sort: 'hallazgo.descripcion', order: "asc"])
        return [pre: pre, lista: evaluacionesNo]
    }

    def planes_ajax () {
        def evam = Evaluacion.get(params.id)
        def listaPlanes = Evaluacion.findAllByHallazgoAndPlanAccionIsNotNull(evam?.hallazgo).planAccion
        return[evam: evam, lis: listaPlanes]
    }

    def bodyPlanes_ajax () {
        def evam = Evaluacion.get(params.id)
        def listaPlanes = Evaluacion.findAllByHallazgoAndPlanAccionIsNotNull(evam?.hallazgo).planAccion
        return [lista: listaPlanes, evam: evam]
    }

    def crearActividad_ajax () {
        def evam = Evaluacion.get(params.id)
        return [evam: evam]
    }

    def guardarPlan_ajax (){
        println("params guardar actividad " + params)

        def eva = Evaluacion.get(params.eva)
        def plac = new PlanAccion()
        def error =''

        plac.actividad = params.actividad
        plac.responsable = params.responsable
        plac.costo = params.costo
        plac.plazo = params.plazo.toInteger()
        plac.verficacion = params.verificacion

        try{
            plac.save(flush: true)
        }catch (e){
            println("error a guardar plac" + plac.errors)
            error += errors
        }

        eva.planAccion = plac

        try{
            eva.save(flush: true)
        }catch (e){
            println("error a guardar evam en plac " + eva.errors)
            error += errors
        }

        if(error == ''){
            render 'ok'
        }else{
            render 'no'
        }
    }


    def seleccionarPlan_ajax (){
//        println("params seleccionar plan " + params)

        def evam = Evaluacion.get(params.eva)
        def plan = PlanAccion.get(params.plan)

        evam.planAccion = plan
        try{
            evam.save(flush: true)
            render "ok"
        }catch (e){
            println("error al asignar plan de accion " + evam.errors)
            render "no"
        }
    }

    def completar_ajax () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def objetivo =  Objetivo.findByIdentificador('Plan de Acción')
        def obau = ObjetivosAuditoria.findByAuditoriaAndObjetivo(audi,objetivo)
        obau.completado = 1
        try{
            obau.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
        }
    }

}
