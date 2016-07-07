package complemento

import auditoria.Auditoria
import auditoria.DetalleAuditoria
import auditoria.Preauditoria


class AntecedenteController extends Seguridad.Shield {

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
            def c = Antecedente.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Antecedente.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def antecedenteInstanceList = getLista(params, false)
        def antecedenteInstanceCount = getLista(params, true).size()
        if (antecedenteInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        antecedenteInstanceList = getLista(params, false)
        return [antecedenteInstanceList: antecedenteInstanceList, antecedenteInstanceCount: antecedenteInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def antecedenteInstance = Antecedente.get(params.id)
            if (!antecedenteInstance) {
                notFound_ajax()
                return
            }
            return [antecedenteInstance: antecedenteInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def antecedenteInstance = new Antecedente(params)
        if (params.id) {
            antecedenteInstance = Antecedente.get(params.id)
            if (!antecedenteInstance) {
                notFound_ajax()
                return
            }
        }
        return [antecedenteInstance: antecedenteInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def antecedenteInstance = new Antecedente()
        if (params.id) {
            antecedenteInstance = Antecedente.get(params.id)
            if (!antecedenteInstance) {
                notFound_ajax()
                return
            }
        } //update
        antecedenteInstance.properties = params
        if (!antecedenteInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Antecedente."
            msg += renderErrors(bean: antecedenteInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Antecedente exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def antecedenteInstance = Antecedente.get(params.id)
            if (antecedenteInstance) {
                try {
                    antecedenteInstance.delete(flush: true)
                    render "OK_Eliminación de Antecedente exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Antecedente."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Antecedente."
    } //notFound para ajax


    def antecedente () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def ante = Antecedente.findByDetalleAuditoria(detalleAuditoria)
        def creador = session.usuario.apellido + "_" + session.usuario.login

        if (creador == pre?.creador) {

            return [pre:pre, ante: ante, det: detalleAuditoria]
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su usuario."
            response.sendError(403)
        }
    }


    def guardarAntecedente_ajax () {

//        println("params guardar antecedente " + params)

        def detalle = DetalleAuditoria.get(params.det)
        def antecedente
        if(params.id){
            antecedente = Antecedente.get(params.id)
            antecedente.descripcion = params.descripcion
        }else{
            antecedente = new Antecedente()
            antecedente.descripcion = params.descripcion
            antecedente.fechaAprobacion = new Date()
            antecedente.detalleAuditoria = detalle
        }

        try{
            antecedente.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al guardar el antecedente" + antecedente.errors)
        }
    }

}
