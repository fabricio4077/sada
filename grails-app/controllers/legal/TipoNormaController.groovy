package legal

import Seguridad.Shield


class TipoNormaController extends Shield {

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
            def c = TipoNorma.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = TipoNorma.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tipoNormaInstanceList = getLista(params, false)
        def tipoNormaInstanceCount = getLista(params, true).size()
        if(tipoNormaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tipoNormaInstanceList = getLista(params, false)
        return [tipoNormaInstanceList: tipoNormaInstanceList, tipoNormaInstanceCount: tipoNormaInstanceCount, params: params]
    } //list

    def show_ajax() {
        if(params.id) {
            def tipoNormaInstance = TipoNorma.get(params.id)
            if(!tipoNormaInstance) {
                notFound_ajax()
                return
            }
            return [tipoNormaInstance: tipoNormaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tipoNormaInstance = new TipoNorma(params)
        if(params.id) {
            tipoNormaInstance = TipoNorma.get(params.id)
            if(!tipoNormaInstance) {
                notFound_ajax()
                return
            }
        }
        return [tipoNormaInstance: tipoNormaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def tipoNormaInstance = new TipoNorma()
        if(params.id) {
            tipoNormaInstance = TipoNorma.get(params.id)
            if(!tipoNormaInstance) {
                notFound_ajax()
                return
            }
        } //update
        tipoNormaInstance.properties = params
        if(!tipoNormaInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} TipoNorma."
            msg += renderErrors(bean: tipoNormaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de TipoNorma exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def tipoNormaInstance = TipoNorma.get(params.id)
            if(tipoNormaInstance) {
                try {
                    tipoNormaInstance.delete(flush:true)
                    render "OK_Eliminación de TipoNorma exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar TipoNorma."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró TipoNorma."
    } //notFound para ajax

}
