package estacion

import auditoria.Preauditoria


class EstacionController extends Seguridad.Shield {

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
            def c = Estacion.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Estacion.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def estacionInstanceList = getLista(params, false)
        def estacionInstanceCount = getLista(params, true).size()
        if (estacionInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        estacionInstanceList = getLista(params, false)
        return [estacionInstanceList: estacionInstanceList, estacionInstanceCount: estacionInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def estacionInstance = Estacion.get(params.id)
            if (!estacionInstance) {
                notFound_ajax()
                return
            }
            return [estacionInstance: estacionInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def estacionInstance = new Estacion(params)
        if (params.id) {
            estacionInstance = Estacion.get(params.id)
            if (!estacionInstance) {
                notFound_ajax()
                return
            }
        }
        return [estacionInstance: estacionInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def estacionInstance = new Estacion()
        if (params.id) {
            estacionInstance = Estacion.get(params.id)
            if (!estacionInstance) {
                notFound_ajax()
                return
            }
        } //update
        estacionInstance.properties = params
        if (!estacionInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Estacion."
            msg += renderErrors(bean: estacionInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Estacion exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def estacionInstance = Estacion.get(params.id)
            if (estacionInstance) {
                try {
                    estacionInstance.delete(flush: true)
                    render "OK_Eliminación de Estacion exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Estacion."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Estacion."
    } //notFound para ajax

    def tablaEstacion_ajax() {

        def estacion
        def preauditoria

        if(params.id){
            preauditoria = Preauditoria.get(params.id)
            if(params.estacion != '0'){
                estacion = Estacion.get(params.estacion)
            }

        }
        return[est: estacion, pre: preauditoria]

    }

    def guardarEstacion_ajax () {
//        println("params estacion " + params)

        def comercializadora = Comercializadora.get(params.comercializadora);
        def provincia = Provincia.get(params.provincia)
        def estacion

        if(params.estacion == '0'){
            estacion = new Estacion()
            estacion.nombre = params.nombre
            estacion.direccion = params.direccion
            estacion.mail = params.mail
            estacion.representante = params.representante
            estacion.comercializadora = comercializadora
            estacion.telefono = params.telefono
            estacion.observaciones = params.observaciones
            estacion.canton = params.canton
            estacion.provincia = provincia
            estacion.administrador = params.administrador

            try{
                estacion.save(flush: true)
//                println("estacion id " + estacion?.id)
                render "ok_guardada_${estacion?.id}"
            }catch (e){
                println("Error al guardar la estacion_pantalla paso2 " + estacion.errors)
                render "no"
            }

        }else{
            estacion = Estacion.get(params.estacion)
            estacion.nombre = params.nombre
            estacion.direccion = params.direccion
            estacion.mail = params.mail
            estacion.representante = params.representante
            estacion.comercializadora = comercializadora
            estacion.telefono = params.telefono
            estacion.observaciones = params.observaciones
            estacion.canton = params.canton
            estacion.provincia = provincia
            estacion.administrador = params.administrador

            try{
                estacion.save(flush: true)
                render "ok_actualizada_${estacion?.id}"
            }catch (e){
                println("Error al actualizar la estacion_pantalla paso2 " + estacion.errors)
                render "no"
            }
        }
    }


    def cargarComboEstacion_ajax() {

//        println("camob params " + params)

        def estacion = Estacion.get(params.id)
        def pre = Preauditoria.get(params.pre)

        return[estacion: estacion, preauditoria: pre]
    }

    def cargarCanton_ajax () {
//        println("params canton " + params)

        def estacion = Estacion.get(params.estacion)
        def provincia = Provincia.get(params.id)
        def cantones = Canton.findAllByProvincia(provincia)

        return [cantones: cantones, estacion: estacion]
    }

}
