package tipo


class TipoController extends Seguridad.Shield {

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
            def c = Tipo.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Tipo.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def tipoInstanceList = getLista(params, false)
        def tipoInstanceCount = getLista(params, true).size()
        if(tipoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        tipoInstanceList = getLista(params, false)
        return [tipoInstanceList: tipoInstanceList, tipoInstanceCount: tipoInstanceCount, params: params]
    } //list

    def show_ajax() {
        if(params.id) {
            def tipoInstance = Tipo.get(params.id)
            if(!tipoInstance) {
                notFound_ajax()
                return
            }
            return [tipoInstance: tipoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def tipoInstance = new Tipo(params)
        if(params.id) {
            tipoInstance = Tipo.get(params.id)
            if(!tipoInstance) {
                notFound_ajax()
                return
            }
        }
        return [tipoInstance: tipoInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        println("params " + params)
        def tipoInstance = new Tipo()
        if(params.id) {
            tipoInstance = Tipo.get(params.id)
            if(!tipoInstance) {
                notFound_ajax()
                return
            }
        } //update
        tipoInstance.properties = params
        tipoInstance.codigo = params.codigo.toUpperCase()

        if(!tipoInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Tipo."
            msg += renderErrors(bean: tipoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Tipo exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def tipoInstance = Tipo.get(params.id)
            if(tipoInstance) {
                try {
                    tipoInstance.delete(flush:true)
                    render "OK_Eliminación de Tipo exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Tipo."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Tipo."
    } //notFound para ajax

    def parametros () {
        if (session.perfil.codigo == 'ADMI') {
            return []
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su perfil."
            response.sendError(403)
        }

    }

}
