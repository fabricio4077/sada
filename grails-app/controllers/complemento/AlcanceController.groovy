package complemento

import auditoria.Auditoria
import auditoria.DetalleAuditoria
import auditoria.Preauditoria


class AlcanceController extends Seguridad.Shield {

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
            def c = Alcance.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Alcance.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def alcanceInstanceList = getLista(params, false)
        def alcanceInstanceCount = getLista(params, true).size()
        if (alcanceInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        alcanceInstanceList = getLista(params, false)
        return [alcanceInstanceList: alcanceInstanceList, alcanceInstanceCount: alcanceInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def alcanceInstance = Alcance.get(params.id)
            if (!alcanceInstance) {
                notFound_ajax()
                return
            }
            return [alcanceInstance: alcanceInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def alcanceInstance = new Alcance(params)
        if (params.id) {
            alcanceInstance = Alcance.get(params.id)
            if (!alcanceInstance) {
                notFound_ajax()
                return
            }
        }
        return [alcanceInstance: alcanceInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def alcanceInstance = new Alcance()
        if (params.id) {
            alcanceInstance = Alcance.get(params.id)
            if (!alcanceInstance) {
                notFound_ajax()
                return
            }
        } //update
        alcanceInstance.properties = params
        if (!alcanceInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Alcance."
            msg += renderErrors(bean: alcanceInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Alcance exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def alcanceInstance = Alcance.get(params.id)
            if (alcanceInstance) {
                try {
                    alcanceInstance.delete(flush: true)
                    render "OK_Eliminación de Alcance exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Alcance."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Alcance."
    } //notFound para ajax

    def alcance () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def alc = Alcance.findByAuditoria(audi)
        def creador = session.usuario.apellido + "_" + session.usuario.login

        if (creador == pre?.creador || session.perfil.codigo == 'ADMI') {
            return [pre:pre, alc: alc, audi: audi]
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su usuario."
            response.sendError(403)
        }
    }

    def guardarAlcance_ajax () {

        println("params guardar alcance " + params)
        def auditoria = Auditoria.get(params.audi)
        def alcance

        if(params.id){
            alcance = Alcance.get(params.id)
            alcance.descripcion = params.descripcion
        }else{
            alcance = new Alcance()
            alcance.auditoria = auditoria
            alcance.descripcion = params.descripcion
        }

        try{
            alcance.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al guardar el alcance " + alcance.errors)
        }


    }

}
