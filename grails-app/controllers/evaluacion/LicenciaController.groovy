package evaluacion

import auditoria.Auditoria
import auditoria.DetalleAuditoria
import auditoria.Preauditoria


class LicenciaController extends Seguridad.Shield {

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
            def c = Licencia.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Licencia.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def licenciaInstanceList = getLista(params, false)
        def licenciaInstanceCount = getLista(params, true).size()
        if (licenciaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        licenciaInstanceList = getLista(params, false)
        return [licenciaInstanceList: licenciaInstanceList, licenciaInstanceCount: licenciaInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def licenciaInstance = Licencia.get(params.id)
            if (!licenciaInstance) {
                notFound_ajax()
                return
            }
            return [licenciaInstance: licenciaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def licenciaInstance = new Licencia(params)
        if (params.id) {
            licenciaInstance = Licencia.get(params.id)
            if (!licenciaInstance) {
                notFound_ajax()
                return
            }
        }
        return [licenciaInstance: licenciaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def licenciaInstance = new Licencia()
        if (params.id) {
            licenciaInstance = Licencia.get(params.id)
            if (!licenciaInstance) {
                notFound_ajax()
                return
            }
        } //update
        licenciaInstance.properties = params
        if (!licenciaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Licencia."
            msg += renderErrors(bean: licenciaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Licencia exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def licenciaInstance = Licencia.get(params.id)
            if (licenciaInstance) {
                try {
                    licenciaInstance.delete(flush: true)
                    render "OK_Eliminación de Licencia exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Licencia."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Licencia."
    } //notFound para ajax


    def licencia () {
        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(auditoria)

        return [pre: pre]
    }

    def cargarComboLicencia_ajax () {

        def pre = Preauditoria.get(params.id)
        def estacion = pre.estacion

        def listaPre = Preauditoria.findAllByEstacion(estacion)
        def listaAu = Auditoria.findAllByPreauditoriaInList(listaPre)
        def listaDa = DetalleAuditoria.findAllByAuditoriaInList(listaAu)

        def listaPuntos = Evaluacion.findAllByDetalleAuditoriaInListAndLicenciaIsNotNull(listaDa)

        return [lista: listaPuntos.licencia]
    }

    def dialogLic_ajax () {
        def pre = Preauditoria.get(params.id)
        return [pre: pre]
    }

    def guardarPunto_ajax () {
        println("params guardar punto " + params)

        def pre = Preauditoria.get(params.detalle)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(auditoria)

        def punto = new Licencia()
        punto.descripcion = params.descripcion
        punto.detalleAuditoria = detalleAuditoria

        try{
            punto.save(flush: true)
            render "ok"
        }catch (e){
            println("error al guardar el punto de la licencia " + punto.errors)
            render "no"
        }
    }

    def tablaPuntos_ajax (){
        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(auditoria)
        def listaPuntos = Licencia.findAllByDetalleAuditoria(detalleAuditoria, [sort: 'descripcion', order: 'asc'])
        return [lista: listaPuntos]
    }

    def borrarPunto_ajax () {
        def licencia = Licencia.get(params.id)
        def evam = Evaluacion.findAllByLicencia(licencia)
        if(evam.size() > 0){
            render "no_No es posible borrar este punto, ya se encuentra en evaluación!"
        }else{
            try{
                licencia.delete(flush: true)
                render "ok_Punto de la licencia borrado correctamente"
            }catch (e){
                println("error al borrar el punto - licencia")
                render "no_Error al borrar el punto de la licencia"
            }
        }
    }

    def asignarPuntos_ajax () {

        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(auditoria)

        def listaPuntos = Licencia.findAllByDetalleAuditoria(detalleAuditoria, [sort: 'descripcion', order: 'asc'])
        def evam
        def error = ''

        def todosEvam = Evaluacion.findAllByDetalleAuditoriaAndLicenciaInList(detalleAuditoria, listaPuntos)

        if(todosEvam){
            def inter =  listaPuntos.intersect(todosEvam.licencia)
            def diferente = listaPuntos - inter

            println("diferentes " + diferente)

            if(diferente.size() > 0){
                diferente.each {d->
                    evam = new Evaluacion()
                    evam.licencia = d
                    evam.detalleAuditoria = detalleAuditoria
                    try{
                        evam.save(flush: true)
                    }catch (e){
                        error += errors
                        println("error al asignar la licencia al evam " + evam.errors)
                    }
                }
            }else{
                println("nada q hacer en licencia")
            }
        }else {
            listaPuntos.each {p->
                evam = new Evaluacion()
                evam.licencia = p
                evam.detalleAuditoria = detalleAuditoria
                try{
                    evam.save(flush: true)
                }catch (e){
                    error += errors
                    println("error al asignar la licencia al evam " + evam.errors)
                }
            }
        }



        if(error == ''){
            render "ok"
        }else{
            render "no"
        }
    }
}
