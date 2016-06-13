package situacion

import auditoria.Auditoria
import auditoria.DetalleAuditoria
import auditoria.Preauditoria
import estacion.Area
import estacion.Ares


class SituacionAmbientalController extends Seguridad.Shield {

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
            def c = SituacionAmbiental.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = SituacionAmbiental.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def situacionAmbientalInstanceList = getLista(params, false)
        def situacionAmbientalInstanceCount = getLista(params, true).size()
        if (situacionAmbientalInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        situacionAmbientalInstanceList = getLista(params, false)
        return [situacionAmbientalInstanceList: situacionAmbientalInstanceList, situacionAmbientalInstanceCount: situacionAmbientalInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def situacionAmbientalInstance = SituacionAmbiental.get(params.id)
            if (!situacionAmbientalInstance) {
                notFound_ajax()
                return
            }
            return [situacionAmbientalInstance: situacionAmbientalInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def situacionAmbientalInstance = new SituacionAmbiental(params)
        if (params.id) {
            situacionAmbientalInstance = SituacionAmbiental.get(params.id)
            if (!situacionAmbientalInstance) {
                notFound_ajax()
                return
            }
        }
        return [situacionAmbientalInstance: situacionAmbientalInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def situacionAmbientalInstance = new SituacionAmbiental()
        if (params.id) {
            situacionAmbientalInstance = SituacionAmbiental.get(params.id)
            if (!situacionAmbientalInstance) {
                notFound_ajax()
                return
            }
        } //update
        situacionAmbientalInstance.properties = params
        if (!situacionAmbientalInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} SituacionAmbiental."
            msg += renderErrors(bean: situacionAmbientalInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de SituacionAmbiental exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def situacionAmbientalInstance = SituacionAmbiental.get(params.id)
            if (situacionAmbientalInstance) {
                try {
                    situacionAmbientalInstance.delete(flush: true)
                    render "OK_Eliminación de SituacionAmbiental exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar SituacionAmbiental."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró SituacionAmbiental."
    } //notFound para ajax

    def situacion () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def lista = [1,2,3]
        def listaComponentes = ComponenteAmbiental.findAllByIdInList(lista)
        def situaciones = SituacionAmbiental.findAllByDetalleAuditoriaAndComponenteAmbientalInList(detalleAuditoria,listaComponentes, [sort: 'componenteAmbiental', order: "asc"])
//        println("componentes lista " + listaComponentes)
//        println("situaciones lista " + situaciones)
        def inter = listaComponentes.intersect(situaciones.componenteAmbiental)
//        println("inter " + inter)
        def porGrabar = listaComponentes - inter
//        println("por grabar " + porGrabar)
        def situacion

        if(porGrabar){
            println("va a grabar")
            porGrabar.each {p->
                situacion = new SituacionAmbiental()
                situacion.detalleAuditoria = detalleAuditoria
                situacion.componenteAmbiental = p
                try{
                    situacion.save(flush: true)
                }catch (e){
                    println("error al grabar por primera vez las situaciones " + situacion.errors)
                }
            }
        }else{
            println(" nada que hacer en grabar")

        }

        return [pre: pre, situaciones: situaciones]
    }

    def emisor_ajax () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def componente = ComponenteAmbiental.get(1)
        def situacion = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)

        def existentes = EmisorComponente.findAllBySituacionAmbiental(situacion)
        def listaEmisores = Emisor.list()

        def comunes = listaEmisores.intersect(existentes.emisor)
        def diferentes = listaEmisores.plus(existentes.emisor)
        diferentes.removeAll(comunes)

//        println("diferentes " + diferentes)

        return [diferentes: diferentes]
    }

    def revisarGenerador_ajax () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)

        def area = Area.findByCodigo('GNRD')
        def existe = Ares.findByAreaAndEstacion(area, pre.estacion)

        def componente = ComponenteAmbiental.get(1)
        def situacion = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)

        def emisor = Emisor.get(1)
        def exc = EmisorComponente.findByEmisorAndSituacionAmbiental(emisor,situacion)


        if(existe && !exc){
            render "ok"
        }else{
            render "no"
        }

    }

    def generador_ajax () {
        def emisor = Emisor.get(1)


    }

    def guardarGenerador_ajax () {

        println("params guardar generador " + params)




    }

}
