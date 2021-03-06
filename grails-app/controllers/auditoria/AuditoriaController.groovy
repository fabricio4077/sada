package auditoria

import Seguridad.Persona
import consultor.Asignados
import estacion.Coordenadas
import evaluacion.Calificacion
import evaluacion.Evaluacion
import objetivo.Objetivo
import objetivo.ObjetivosAuditoria
import org.h2.api.DatabaseEventListener
import plan.PlanAuditoria


class AuditoriaController extends Seguridad.Shield {

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
            def c = Auditoria.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Auditoria.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def auditoriaInstanceList = getLista(params, false)
        def auditoriaInstanceCount = getLista(params, true).size()
        if (auditoriaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        auditoriaInstanceList = getLista(params, false)
        return [auditoriaInstanceList: auditoriaInstanceList, auditoriaInstanceCount: auditoriaInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def auditoriaInstance = Auditoria.get(params.id)
            if (!auditoriaInstance) {
                notFound_ajax()
                return
            }
            return [auditoriaInstance: auditoriaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def auditoriaInstance = new Auditoria(params)
        if (params.id) {
            auditoriaInstance = Auditoria.get(params.id)
            if (!auditoriaInstance) {
                notFound_ajax()
                return
            }
        }
        return [auditoriaInstance: auditoriaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def auditoriaInstance = new Auditoria()
        if (params.id) {
            auditoriaInstance = Auditoria.get(params.id)
            if (!auditoriaInstance) {
                notFound_ajax()
                return
            }
        } //update
        auditoriaInstance.properties = params
        if (!auditoriaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Auditoria."
            msg += renderErrors(bean: auditoriaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Auditoria exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def auditoriaInstance = Auditoria.get(params.id)
            if (auditoriaInstance) {
                try {
                    auditoriaInstance.delete(flush: true)
                    render "OK_Eliminación de Auditoria exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Auditoria."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Auditoria."
    } //notFound para ajax


    def objetivos (){
        def creador = session.usuario.apellido + "_" + session.usuario.login + "_" + session.perfil.codigo
//        println("params ob " + params)
        def pre = Preauditoria.get(params.id)
        def objetivoGeneral = Objetivo.findByTipo("General")
        def objetivosEspecificos = Objetivo.findAllByTipo("Específico")
        def auditoria = Auditoria.findByPreauditoria(pre)

        if (creador == pre?.creador || session.perfil.codigo == 'ADMI') {
            return [general: objetivoGeneral, especificos: objetivosEspecificos, pre: pre, auditoria: auditoria]
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su usuario."
            response.sendError(403)
        }

    }


    def cargarObjetivos_ajax () {
//        println ("params cargar ob " + params)

        def listaObjetivos = Objetivo.findAllByDefecto("1")
        def preauditoria = Preauditoria.get(params.id)
        def auditoria
        def objetivoAuditoria
        def detalleAuditoria
        def error = ''


        if(params.idA){

            auditoria = Auditoria.get(params.idA)

        }else{

            auditoria = new Auditoria()
            auditoria.preauditoria = preauditoria
            auditoria.fechaInicio = new Date()

            try{
                auditoria.save(flush: true)
            }catch (e){
                error += auditoria.errors
                println("error al guardar la auditoria " + auditoria.errors)
            }

            detalleAuditoria = new DetalleAuditoria()
            detalleAuditoria.auditoria = auditoria

            detalleAuditoria.save(flush: true)



            listaObjetivos.each {k->

                objetivoAuditoria = new ObjetivosAuditoria()
                objetivoAuditoria.auditoria = auditoria
                objetivoAuditoria.objetivo = k
                try{
                    objetivoAuditoria.save(flush: true)
                }catch (e){
                    error += objetivoAuditoria.errors
                    println("error al guardar los objetivos de la auditoria" + objetivoAuditoria.errors)
                }
            }


        }

        if(error == ''){
            render "ok"
        }else{
            render "no"
        }

    }

    def cargarTablaObjetivos_ajax (){


        def objetivoGeneral
        def especificos
        def auditoria = Auditoria.get(params.idA)

        objetivoGeneral = ObjetivosAuditoria.withCriteria {

            eq("auditoria",auditoria)

            objetivo{
                eq("tipo","General")
            }
        }

        especificos = ObjetivosAuditoria.withCriteria {

            eq("auditoria",auditoria)

            objetivo{
                eq("tipo","Específico")
            }

            order("objetivo","asc")
        }

        return [auditoria: auditoria, general: objetivoGeneral, especificos: especificos]

    }

    def leyes () {
        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def creador = session.usuario.apellido + "_" + session.usuario.login + "_" + session.perfil.codigo

        if (creador == pre?.creador || session.perfil.codigo == 'ADMI') {
            return [pre: pre, auditoria: auditoria]
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su usuario."
            response.sendError(403)
        }
    }


    def guardarFechaFin_ajax () {
        println("params " + params)
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)

        def fecha = new Date().parse("dd-MM-yyyy", params.fecha)

        audi.fechaFin = fecha

        try{
            audi.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("Error al guardar la fecha de fin desde cronograma")
        }

    }

    def cronograma (){

        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def per = 'ACT'

        def planes = PlanAuditoria.findAllByDetalleAuditoriaAndPeriodoAndMedidaIsNotNull(detalleAuditoria,per)

        println("planes " + planes)

        def colores = ['#ef3724','#ffa61a','#1ab1ff',' #fd4fda','#567b24']


        def creador = session.usuario.apellido + "_" + session.usuario.login + "_" + session.perfil.codigo

        if (creador == pre?.creador || session.perfil.codigo == 'ADMI') {

            return [pre:pre, planes: planes, colores: colores]
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su usuario."
            response.sendError(403)
        }
    }

    def recomendaciones () {
        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalle = DetalleAuditoria.findByAuditoria(auditoria)
        def objetivo =  Objetivo.findByIdentificador('Recomendaciones')
        def obau = ObjetivosAuditoria.findByAuditoriaAndObjetivo(auditoria,objetivo)
        def listaCalificacionesMayor = ['NC+']
        def listaCalificacionesMenor = ['nc-']
        def calificacionesMayor = Calificacion.findAllBySiglaInList(listaCalificacionesMayor)
        def calificacionesMenor = Calificacion.findAllBySiglaInList(listaCalificacionesMenor)
        def evaluacionesMayores = Evaluacion.findAllByDetalleAuditoriaAndCalificacionInList(detalle,calificacionesMayor, [sort: 'hallazgo.descripcion', order: "asc"])
        def evaluacionesMenores = Evaluacion.findAllByDetalleAuditoriaAndCalificacionInList(detalle,calificacionesMenor, [sort: 'hallazgo.descripcion', order: "asc"])
        def creador = session.usuario.apellido + "_" + session.usuario.login + "_" + session.perfil.codigo
        def texto

        texto = "<p style='text-align:justify'>Para verificar el cumplimiento de la Normativa Ambiental vigente y " +
                "Plan de Manejo Ambiental, se realizaron inspecciones de campo, así como " +
                "la revisión documental de respaldo. Mediante los mecanismos mencionados se" +
                " pudo determinar el grado de cumplimiento a la legislación por parte de la Estación '${pre?.estacion?.nombre}'.</p>" +
                "<br><b>Resultados:</b>" +
                "<br>Como resultado de la auditoría se pudieron identificar las siguientes no conformidades:" +
                "<br><b>No Conformidades Mayores</b>" +
                "<br><ul>"

        evaluacionesMayores.each {
            texto += "<li style='text-align:justify'>" + it?.hallazgo?.descripcion + "</li>"
        }

        texto += "</ul>"

        if(evaluacionesMenores){
            texto += "<br><b>No Conformidades Menores</b>" +
                    "<br><ul>"

            evaluacionesMenores.each {
                texto += "<li style='text-align:justify'>" + it?.hallazgo?.descripcion + "</li>"
            }
            texto += "</ul>"
        }

        if (creador == pre?.creador || session.perfil.codigo == 'ADMI') {
            return [det: detalle, texto: texto, mayores: evaluacionesMayores, pre: pre, obau: obau]
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su usuario."
            response.sendError(403)
        }
    }

    def completar_ajax () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def objetivo =  Objetivo.findByIdentificador('Recomendaciones')
        def obau = ObjetivosAuditoria.findByAuditoriaAndObjetivo(audi,objetivo)
        obau.completado = 1
        try{
            obau.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
        }
    }

    def editorRecomendaciones_ajax () {
        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalle = DetalleAuditoria.findByAuditoria(auditoria)

        return [det: detalle, texto: params.texto]
    }

    def guardarRecomendacion_ajax () {
        println("texto " + params)
        def detalle = DetalleAuditoria.get(params.det)
        detalle.recomendaciones = params.descripcion

        try{
            detalle.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
        }
    }


}
