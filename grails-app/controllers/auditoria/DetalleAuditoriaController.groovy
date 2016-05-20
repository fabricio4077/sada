package auditoria


class DetalleAuditoriaController extends Seguridad.Shield {

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
            def c = DetalleAuditoria.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = DetalleAuditoria.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def detalleAuditoriaInstanceList = getLista(params, false)
        def detalleAuditoriaInstanceCount = getLista(params, true).size()
        if (detalleAuditoriaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        detalleAuditoriaInstanceList = getLista(params, false)
        return [detalleAuditoriaInstanceList: detalleAuditoriaInstanceList, detalleAuditoriaInstanceCount: detalleAuditoriaInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def detalleAuditoriaInstance = DetalleAuditoria.get(params.id)
            if (!detalleAuditoriaInstance) {
                notFound_ajax()
                return
            }
            return [detalleAuditoriaInstance: detalleAuditoriaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def detalleAuditoriaInstance = new DetalleAuditoria(params)
        if (params.id) {
            detalleAuditoriaInstance = DetalleAuditoria.get(params.id)
            if (!detalleAuditoriaInstance) {
                notFound_ajax()
                return
            }
        }
        return [detalleAuditoriaInstance: detalleAuditoriaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def detalleAuditoriaInstance = new DetalleAuditoria()
        if (params.id) {
            detalleAuditoriaInstance = DetalleAuditoria.get(params.id)
            if (!detalleAuditoriaInstance) {
                notFound_ajax()
                return
            }
        } //update
        detalleAuditoriaInstance.properties = params
        if (!detalleAuditoriaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} DetalleAuditoria."
            msg += renderErrors(bean: detalleAuditoriaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de DetalleAuditoria exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def detalleAuditoriaInstance = DetalleAuditoria.get(params.id)
            if (detalleAuditoriaInstance) {
                try {
                    detalleAuditoriaInstance.delete(flush: true)
                    render "OK_Eliminación de DetalleAuditoria exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar DetalleAuditoria."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró DetalleAuditoria."
    } //notFound para ajax

}
