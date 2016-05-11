package legal


class ArticuloController extends Seguridad.Shield {

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
            def c = Articulo.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Articulo.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def articuloInstanceList = getLista(params, false)
        def articuloInstanceCount = getLista(params, true).size()
        if (articuloInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        articuloInstanceList = getLista(params, false)
        return [articuloInstanceList: articuloInstanceList, articuloInstanceCount: articuloInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def articuloInstance = Articulo.get(params.id)
            if (!articuloInstance) {
                notFound_ajax()
                return
            }
            return [articuloInstance: articuloInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def articuloInstance = new Articulo(params)
        if (params.id) {
            articuloInstance = Articulo.get(params.id)
            if (!articuloInstance) {
                notFound_ajax()
                return
            }
        }
        return [articuloInstance: articuloInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def articuloInstance = new Articulo()
        if (params.id) {
            articuloInstance = Articulo.get(params.id)
            if (!articuloInstance) {
                notFound_ajax()
                return
            }
        } //update
        articuloInstance.properties = params
        if (!articuloInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Articulo."
            msg += renderErrors(bean: articuloInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Articulo exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def articuloInstance = Articulo.get(params.id)
            if (articuloInstance) {
                try {
                    articuloInstance.delete(flush: true)
                    render "OK_Eliminación de Articulo exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Articulo."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Articulo."
    } //notFound para ajax

}
