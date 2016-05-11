package estacion

import auditoria.Preauditoria


class CoordenadasController extends Seguridad.Shield {

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
            def c = Coordenadas.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Coordenadas.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def coordenadasInstanceList = getLista(params, false)
        def coordenadasInstanceCount = getLista(params, true).size()
        if(coordenadasInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        coordenadasInstanceList = getLista(params, false)
        return [coordenadasInstanceList: coordenadasInstanceList, coordenadasInstanceCount: coordenadasInstanceCount, params: params]
    } //list

    def show_ajax() {
        if(params.id) {
            def coordenadasInstance = Coordenadas.get(params.id)
            if(!coordenadasInstance) {
                notFound_ajax()
                return
            }
            return [coordenadasInstance: coordenadasInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def coordenadasInstance = new Coordenadas(params)
        if(params.id) {
            coordenadasInstance = Coordenadas.get(params.id)
            if(!coordenadasInstance) {
                notFound_ajax()
                return
            }
        }
        return [coordenadasInstance: coordenadasInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def coordenadasInstance = new Coordenadas()
        if(params.id) {
            coordenadasInstance = Coordenadas.get(params.id)
            if(!coordenadasInstance) {
                notFound_ajax()
                return
            }
        } //update
        coordenadasInstance.properties = params
        if(!coordenadasInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Coordenadas."
            msg += renderErrors(bean: coordenadasInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Coordenadas exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def coordenadasInstance = Coordenadas.get(params.id)
            if(coordenadasInstance) {
                try {
                    coordenadasInstance.delete(flush:true)
                    render "OK_Eliminación de Coordenadas exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Coordenadas."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Coordenadas."
    } //notFound para ajax


    def agregarCoordenadas_ajax() {
        def estacion = Preauditoria.get(params.id).estacion
        def coordenada
        if (params.coordenada){
           coordenada = Coordenadas.get(params.coordenada)
        }
        return [estacion: estacion, coordenada: coordenada]
    }

    def tablaCoordenadas_ajax() {
//        println("params tabla c" + params)
        def preauditoria = Preauditoria.get(params.id)
        def coordenadas = Coordenadas.findAllByEstacion(preauditoria?.estacion)
//        println("coordenadas " + coordenadas)
        return [coordenadas: coordenadas, preauditoria: preauditoria]
    }

    def borrarCoordenadas_ajax () {

        def coordenada = Coordenadas.get(params.id)

        try{
            coordenada.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar coordenadas" + coordenada.errors)
            render "no"
        }


    }

}
