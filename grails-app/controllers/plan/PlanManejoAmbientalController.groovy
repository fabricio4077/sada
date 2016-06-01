package plan

import auditoria.Auditoria
import auditoria.DetalleAuditoria
import auditoria.Preauditoria
import evaluacion.Anexo
import evaluacion.Evaluacion


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

        println("params pma " + params)

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

        println("params tabla plan " + params)

        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(auditoria)
        def per
        if(params.band == 'true'){
            per = 'ANT'
        }else{
            per = 'ACT'
        }

        def aupm = PlanAuditoria.findAllByDetalleAuditoriaAndPeriodo(detalleAuditoria, per, [sort: 'aspectoAmbiental.planManejoAmbiental', order: 'asc'])

//        println("aupm " + aupm)

        return [aupm: aupm, pre: pre, band: params.band]
    }

    def cargarMedida_ajax() {

        def aupm = PlanAuditoria.get(params.id)
        def medidasExistentes = PlanAuditoria.findAllByAspectoAmbientalAndMedidaIsNotNull(aupm.aspectoAmbiental).medida

//        println("medidas " + medidasExistentes)

        return [medidasExistentes: medidasExistentes, aupm: aupm]
    }

    def tablaMedida_ajax() {
        def medida = Medida.get(params.id)
        def aupm = PlanAuditoria.get(params.aupm)
        def ver = params.ver
        return [medida: medida, aupm: aupm, ver: ver]
    }

    def crearMedida_ajax (){
        def aupm = PlanAuditoria.get(params.aupm)
        return [aupm: aupm]
    }

    def asignarMedida_ajax (){

        def medida = Medida.get(params.id)
        def aupm = PlanAuditoria.get(params.aupm)

        aupm.medida = medida

        try{
            aupm.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al asignar la medida")
        }
    }

    def verMedida_ajax () {
        def aupm = PlanAuditoria.get(params.aupm)
        return [aupm: aupm]
    }

    def quitarMedida_Ajax () {

        def aupm = PlanAuditoria.get(params.id)
        aupm.medida = null

        try{
            aupm.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al quitar del aupm la medida");
        }
    }

    def asignarAspecto_ajax (){
        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(auditoria)
        def aspecto = AspectoAmbiental.get(params.aspecto)
        def per
        def aupm
        if(params.band == 'true'){
            per = 'ANT'
        }else{
            per = 'ACT'
        }

        aupm = new PlanAuditoria()
        aupm.detalleAuditoria = detalleAuditoria
        aupm.aspectoAmbiental = aspecto
        aupm.periodo = per

        try{
            aupm.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al crear aupm con el nuevo aspecto")
        }
    }

    def comprobarPlan_ajax () {

        println("params comprobar " + params)

        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(auditoria)
        def per
        def faltantes

        if(params.band == 'true'){
            per = 'ANT'
        }else{
            per = 'ACT'
        }

        faltantes = PlanAuditoria.findAllByDetalleAuditoriaAndPeriodoAndMedidaIsNull(detalleAuditoria, per)

        if(faltantes.size() > 0){
         render "no"
        }else{
         render "ok"
        }
    }

    def guardarPlan_Ajax (){

        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(auditoria)
        def per
        def todos
        def evam
        def error = ''
        if(params.band == 'true'){
            per = 'ANT'
        }else{
            per = 'ACT'
        }

        todos = PlanAuditoria.findAllByDetalleAuditoriaAndPeriodo(detalleAuditoria, per)
        def todosEvam = Evaluacion.findAllByDetalleAuditoriaAndPlanAuditoriaInList(detalleAuditoria, todos)

//        println("todos evam " + todosEvam)

        if(todosEvam){
          def inter =  todos.intersect(todosEvam.planAuditoria)
          def diferente = todos - inter

            if(diferente.size() > 0){
                diferente.each { d->
                    evam = new Evaluacion()
                    evam.detalleAuditoria = detalleAuditoria
                    evam.planAuditoria = d

                    try{
                        evam.save(flush: true)
                    }catch (e){
                        println("error al crear alguna evam de PMA " + evam.errors)
                        error += evam.errors
                    }
                }
            }else{
                println("nada q hacer")
            }
        }else{
            todos.each {t->
                evam = new Evaluacion()
                evam.detalleAuditoria = detalleAuditoria
                evam.planAuditoria = t

                try{
                    evam.save(flush: true)
                }catch (e){
                    println("error al crear alguna evam de PMA " + evam.errors)
                    error += evam.errors
                }
            }
        }

        if(error == ''){
            render "ok"
        }else{
            render "no"
        }
    }

    def asociarPlanEvam_ajax () {

        def preAnterior = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(preAnterior)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(auditoria)
        def per = 'ACT'
        def todosAnteriores = PlanAuditoria.findAllByDetalleAuditoriaAndPeriodo(detalleAuditoria, per)
        def evam

        def preActual = Preauditoria.get(params.actual)
        def auditoriaAct = Auditoria.findByPreauditoria(preActual)
        def detalleAuditoriaAct = DetalleAuditoria.findByAuditoria(auditoriaAct)

        def evamPlan = Evaluacion.findAllByDetalleAuditoriaAndPlanAuditoriaIsNotNull(detalleAuditoriaAct)

        if(evamPlan.size() > 0){
            render "no_Ya existe un PMA (anterior) cargado, clic en el botón Borrar PMA si desea continuar"
        }else{

            if(todosAnteriores.size() > 0){
                todosAnteriores.each { a->
                    evam = new Evaluacion()
                    evam.detalleAuditoria = detalleAuditoriaAct
                    evam.planAuditoria = a

                    try{
                        evam.save(flush: true)
                        render "ok_PMA cargado correctamente para ser usado en la evaluación ambiental"
                    }catch (e){
                        println("error al crear alguna evam de PMA anterior " + evam.errors)
                        render "no_Error al cargar el PMA (anterior)"
                    }
                }
            }else{
                render "no_La auditoría seleccionada, no contiene un PMA!"
            }
        }

    }



    def comprobarBorrarMedida_Ajax () {
        def aupm = PlanAuditoria.get(params.idAs)
        def evam = Evaluacion.findByPlanAuditoria(aupm)

        if(evam){
            render "no"
        }else{
            render "ok"
        }
    }

    def borrarAspecto_ajax () {
        def aupm = PlanAuditoria.get(params.id)
        def evam = Evaluacion.findByPlanAuditoria(aupm)
        def anexo = Anexo.findAllByEvaluacion(evam)

        if(evam){
            if(anexo || evam.planAccion){
                render "no"
            }else{
                evam.delete(flush: true)
                aupm.delete(flush: true)
                render "ok"
            }
        }else{
            aupm.delete(flush: true)
            render "ok"
        }
    }

    def removerPlanAnterior_ajax (){
        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(auditoria)
        def per = 'ANT'
        def todos
        def plan
        def aupms
        def anexos
        def evam
        def error = ''

        aupms = PlanAuditoria.findAllByDetalleAuditoriaAndPeriodo(detalleAuditoria,per)

        plan = Evaluacion.findAllByPlanAuditoriaInListAndPlanAccionIsNotNull(aupms)
        todos = Evaluacion.findAllByPlanAuditoriaInList(aupms)
        anexos = Anexo.findAllByEvaluacionInList(todos)

//        println("anexos " + anexos)

        if (anexos || plan){
            render "no"
        }else{

            todos.each {p->
                try{
                    p.delete(flush: true)
                }catch (e){
                   println("error al borrar un evam de borrar todo el PMA " + p.errors)
                    error += errors
                }
            }

            aupms.each { a->
                try{
                    a.delete(flush: true)
                }catch (e){
                    println("error al borrar un aupms de borrar todo el PMA " + a.errors)
                    error += error
                }
            }

            if(error == ''){
                render "ok"
            }else{
                render "no"
            }
        }
    }

    def cargarPlanActual () {

        def pre = Preauditoria.get(params.id)
        def periodoActual = pre.periodo.inicio
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(auditoria)

        def anteriores = Preauditoria.withCriteria {
            eq('estacion', pre?.estacion)
            periodo{
                lt('fin',periodoActual)
            }
        }
        return [pre:pre, anteriores: anteriores, detalle: detalleAuditoria]
    }

    def verificarExistente_ajax () {
        def detalleAuditoria = DetalleAuditoria.get(params.id)
        def per = 'ACT'
        def existentesActuales = PlanAuditoria.findAllByDetalleAuditoriaAndPeriodo(detalleAuditoria, per)

        if(existentesActuales.size()>0){
         render "ok"
        }else{
         render "no"
        }
    }

}
