package Seguridad


class PrflController extends Seguridad.Shield {

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
            def c = Prfl.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Prfl.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def prflInstanceList = getLista(params, false)
        def prflInstanceCount = getLista(params, true).size()
        if (prflInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        prflInstanceList = getLista(params, false)
        return [prflInstanceList: prflInstanceList, prflInstanceCount: prflInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def prflInstance = Prfl.get(params.id)
            if (!prflInstance) {
                notFound_ajax()
                return
            }
            return [prflInstance: prflInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def prflInstance = new Prfl(params)
        if (params.id) {
            prflInstance = Prfl.get(params.id)
            if (!prflInstance) {
                notFound_ajax()
                return
            }
        }
        return [prflInstance: prflInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def prflInstance = new Prfl()
        if (params.id) {
            prflInstance = Prfl.get(params.id)
            if (!prflInstance) {
                notFound_ajax()
                return
            }
        } //update
        prflInstance.properties = params
        if (!prflInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Prfl."
            msg += renderErrors(bean: prflInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Prfl exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def prflInstance = Prfl.get(params.id)
            if (prflInstance) {
                try {
                    prflInstance.delete(flush: true)
                    render "OK_Eliminación de Prfl exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Prfl."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Prfl."
    } //notFound para ajax

}
