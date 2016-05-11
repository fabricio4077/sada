package objetivo


class ObjetivosAuditoriaController extends Seguridad.Shield {

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
            def c = ObjetivosAuditoria.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = ObjetivosAuditoria.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def objetivosAuditoriaInstanceList = getLista(params, false)
        def objetivosAuditoriaInstanceCount = getLista(params, true).size()
        if(objetivosAuditoriaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        objetivosAuditoriaInstanceList = getLista(params, false)
        return [objetivosAuditoriaInstanceList: objetivosAuditoriaInstanceList, objetivosAuditoriaInstanceCount: objetivosAuditoriaInstanceCount, params: params]
    } //list

    def show_ajax() {
        if(params.id) {
            def objetivosAuditoriaInstance = ObjetivosAuditoria.get(params.id)
            if(!objetivosAuditoriaInstance) {
                notFound_ajax()
                return
            }
            return [objetivosAuditoriaInstance: objetivosAuditoriaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def objetivosAuditoriaInstance = new ObjetivosAuditoria(params)
        if(params.id) {
            objetivosAuditoriaInstance = ObjetivosAuditoria.get(params.id)
            if(!objetivosAuditoriaInstance) {
                notFound_ajax()
                return
            }
        }
        return [objetivosAuditoriaInstance: objetivosAuditoriaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def objetivosAuditoriaInstance = new ObjetivosAuditoria()
        if(params.id) {
            objetivosAuditoriaInstance = ObjetivosAuditoria.get(params.id)
            if(!objetivosAuditoriaInstance) {
                notFound_ajax()
                return
            }
        } //update
        objetivosAuditoriaInstance.properties = params
        if(!objetivosAuditoriaInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} ObjetivosAuditoria."
            msg += renderErrors(bean: objetivosAuditoriaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de ObjetivosAuditoria exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def objetivosAuditoriaInstance = ObjetivosAuditoria.get(params.id)
            if(objetivosAuditoriaInstance) {
                try {
                    objetivosAuditoriaInstance.delete(flush:true)
                    render "OK_Eliminación de ObjetivosAuditoria exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar ObjetivosAuditoria."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró ObjetivosAuditoria."
    } //notFound para ajax

}
