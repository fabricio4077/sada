package auditoria

import objetivo.Objetivo
import objetivo.ObjetivosAuditoria


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

        println("params ob " + params)
        def pre = Preauditoria.get(params.id)
        def objetivoGeneral = Objetivo.findByTipo("General")
        def objetivosEspecificos = Objetivo.findAllByTipo("Específico")
        def auditoria = Auditoria.findByPreauditoria(pre)

        return [general: objetivoGeneral, especificos: objetivosEspecificos, pre: pre, auditoria: auditoria]

    }


    def cargarObjetivos_ajax () {
        println ("params cargar ob " + params)

        def listaObjetivos = Objetivo.findAllByDefecto("1")
        def preauditoria = Preauditoria.get(params.id)
        def auditoria
        def objetivoAuditoria
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





}
