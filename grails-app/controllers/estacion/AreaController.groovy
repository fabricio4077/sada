package estacion


class AreaController extends Seguridad.Shield {

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
            def c = Area.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Area.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def areaInstanceList = getLista(params, false)
        def areaInstanceCount = getLista(params, true).size()
        if (areaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        areaInstanceList = getLista(params, false)
        return [areaInstanceList: areaInstanceList, areaInstanceCount: areaInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def areaInstance = Area.get(params.id)
            if (!areaInstance) {
                notFound_ajax()
                return
            }
            return [areaInstance: areaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def areaInstance = new Area(params)
        if (params.id) {
            areaInstance = Area.get(params.id)
            if (!areaInstance) {
                notFound_ajax()
                return
            }
        }
        return [areaInstance: areaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def areaInstance = new Area()
        if (params.id) {
            areaInstance = Area.get(params.id)
            if (!areaInstance) {
                notFound_ajax()
                return
            }
        } //update
        areaInstance.properties = params
        if (!areaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Area."
            msg += renderErrors(bean: areaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Area exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def areaInstance = Area.get(params.id)
            if (areaInstance) {
                try {
                    areaInstance.delete(flush: true)
                    render "OK_Eliminación de Area exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Area."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Area."
    } //notFound para ajax

}
