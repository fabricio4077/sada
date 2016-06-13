package situacion


class AnalisisLiquidasController extends Seguridad.Shield {

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
            def c = AnalisisLiquidas.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = AnalisisLiquidas.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def analisisLiquidasInstanceList = getLista(params, false)
        def analisisLiquidasInstanceCount = getLista(params, true).size()
        if (analisisLiquidasInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        analisisLiquidasInstanceList = getLista(params, false)
        return [analisisLiquidasInstanceList: analisisLiquidasInstanceList, analisisLiquidasInstanceCount: analisisLiquidasInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def analisisLiquidasInstance = AnalisisLiquidas.get(params.id)
            if (!analisisLiquidasInstance) {
                notFound_ajax()
                return
            }
            return [analisisLiquidasInstance: analisisLiquidasInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def analisisLiquidasInstance = new AnalisisLiquidas(params)
        if (params.id) {
            analisisLiquidasInstance = AnalisisLiquidas.get(params.id)
            if (!analisisLiquidasInstance) {
                notFound_ajax()
                return
            }
        }
        return [analisisLiquidasInstance: analisisLiquidasInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def analisisLiquidasInstance = new AnalisisLiquidas()
        if (params.id) {
            analisisLiquidasInstance = AnalisisLiquidas.get(params.id)
            if (!analisisLiquidasInstance) {
                notFound_ajax()
                return
            }
        } //update
        analisisLiquidasInstance.properties = params
        if (!analisisLiquidasInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} AnalisisLiquidas."
            msg += renderErrors(bean: analisisLiquidasInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de AnalisisLiquidas exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def analisisLiquidasInstance = AnalisisLiquidas.get(params.id)
            if (analisisLiquidasInstance) {
                try {
                    analisisLiquidasInstance.delete(flush: true)
                    render "OK_Eliminación de AnalisisLiquidas exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar AnalisisLiquidas."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró AnalisisLiquidas."
    } //notFound para ajax

}
