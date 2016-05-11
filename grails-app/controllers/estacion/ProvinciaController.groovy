package estacion


class ProvinciaController extends Seguridad.Shield {

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
            def c = Provincia.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Provincia.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def provinciaInstanceList = getLista(params, false)
        def provinciaInstanceCount = getLista(params, true).size()
        if (provinciaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        provinciaInstanceList = getLista(params, false)
        return [provinciaInstanceList: provinciaInstanceList, provinciaInstanceCount: provinciaInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def provinciaInstance = Provincia.get(params.id)
            if (!provinciaInstance) {
                notFound_ajax()
                return
            }
            return [provinciaInstance: provinciaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def provinciaInstance = new Provincia(params)
        if (params.id) {
            provinciaInstance = Provincia.get(params.id)
            if (!provinciaInstance) {
                notFound_ajax()
                return
            }
        }
        return [provinciaInstance: provinciaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def provinciaInstance = new Provincia()
        if (params.id) {
            provinciaInstance = Provincia.get(params.id)
            if (!provinciaInstance) {
                notFound_ajax()
                return
            }
        } //update
        provinciaInstance.properties = params
        provinciaInstance.nombre = params.nombre.toUpperCase()
        provinciaInstance.codigo = params.codigo.toUpperCase()
        if (!provinciaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Provincia."
            msg += renderErrors(bean: provinciaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Provincia exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def provinciaInstance = Provincia.get(params.id)
            if (provinciaInstance) {
                try {
                    provinciaInstance.delete(flush: true)
                    render "OK_Eliminación de Provincia exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Provincia."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Provincia."
    } //notFound para ajax

}
