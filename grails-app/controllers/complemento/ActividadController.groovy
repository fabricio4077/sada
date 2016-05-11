package complemento

import Seguridad.Persona
import Seguridad.Prfl
import Seguridad.Sesn
import auditoria.Preauditoria


class ActividadController extends Seguridad.Shield {

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
            def c = Actividad.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Actividad.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def actividadInstanceList = getLista(params, false)
        def actividadInstanceCount = getLista(params, true).size()
        if(actividadInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        actividadInstanceList = getLista(params, false)
        return [actividadInstanceList: actividadInstanceList, actividadInstanceCount: actividadInstanceCount, params: params]
    } //list

    def show_ajax() {
        if(params.id) {
            def actividadInstance = Actividad.get(params.id)
            if(!actividadInstance) {
                notFound_ajax()
                return
            }
            return [actividadInstance: actividadInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def actividadInstance = new Actividad(params)
        if(params.id) {
            actividadInstance = Actividad.get(params.id)
            if(!actividadInstance) {
                notFound_ajax()
                return
            }
        }
        return [actividadInstance: actividadInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def actividadInstance = new Actividad()
        if(params.id) {
            actividadInstance = Actividad.get(params.id)
            if(!actividadInstance) {
                notFound_ajax()
                return
            }
        } //update
        actividadInstance.properties = params
        actividadInstance.codigo = params.codigo.toUpperCase()
        if(!actividadInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Actividad."
            msg += renderErrors(bean: actividadInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Actividad exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def actividadInstance = Actividad.get(params.id)
            if(actividadInstance) {
                try {
                    actividadInstance.delete(flush:true)
                    render "OK_Eliminación de Actividad exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Actividad."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Actividad."
    } //notFound para ajax

    def actividades_ajax () {

        def pre = Preauditoria.get(params.id)
        def actividades = ActiAudi.findAllByPreauditoria(pre).actividad.id

        return [pre: pre, actividades: actividades]
    }

    def saveActividades_ajax (){

        def pre = Preauditoria.get(params.id)
        def actividadesAudi = ActiAudi.findAllByPreauditoria(pre).actividad.id
        def arrRemover = actividadesAudi
        def arrAgregar = []
        def errores = ''

        params.acti.each{ pid->
            if(actividadesAudi.contains(pid)){
                arrRemover.remove(pid)
            }else{
                arrAgregar.add(pid)
            }
        }

        arrRemover.each { pid ->
            def act = Actividad.get(pid)
            def acAu = ActiAudi.findByPreauditoriaAndActividad(pre,act)
            try {
                acAu.delete(flush: true)
            } catch (e) {
                println("no se pudo borrar la actividad " + acAu.errors)
                errores += acAu.errors
            }
        }

        arrAgregar.each { pid ->
            def actv = Actividad.get(pid)
            def activi = new ActiAudi([preauditoria: pre, actividad: actv])
            try{
                activi.save(flush: true)
                println("actividad guardada correctamente ")
            }catch (e){
                println("no se pudo guardar la actividad " + activi.errors)
                errores += activi.errors
            }
        }

        if(errores == ''){
            render "ok"
        }else{
            render "no"
            println("errores " + errores)
        }

    }


}
