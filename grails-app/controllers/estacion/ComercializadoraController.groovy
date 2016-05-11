package estacion


class ComercializadoraController extends Seguridad.Shield {

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
            def c = Comercializadora.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Comercializadora.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def comercializadoraInstanceList = getLista(params, false)
        def comercializadoraInstanceCount = getLista(params, true).size()
        if(comercializadoraInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        comercializadoraInstanceList = getLista(params, false)
        return [comercializadoraInstanceList: comercializadoraInstanceList, comercializadoraInstanceCount: comercializadoraInstanceCount, params: params]
    } //list

    def show_ajax() {
        if(params.id) {
            def comercializadoraInstance = Comercializadora.get(params.id)
            if(!comercializadoraInstance) {
                notFound_ajax()
                return
            }
            return [comercializadoraInstance: comercializadoraInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def comercializadoraInstance = new Comercializadora(params)
        if(params.id) {
            comercializadoraInstance = Comercializadora.get(params.id)
            if(!comercializadoraInstance) {
                notFound_ajax()
                return
            }
        }
        return [comercializadoraInstance: comercializadoraInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def comercializadoraInstance = new Comercializadora()
        if(params.id) {
            comercializadoraInstance = Comercializadora.get(params.id)
            if(!comercializadoraInstance) {
                notFound_ajax()
                return
            }
        } //update
        comercializadoraInstance.properties = params
        comercializadoraInstance.nombre = params.nombre.toUpperCase()
        if(!comercializadoraInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Comercializadora."
            msg += renderErrors(bean: comercializadoraInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Comercializadora exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def comercializadoraInstance = Comercializadora.get(params.id)
            if(comercializadoraInstance) {
                try {
                    comercializadoraInstance.delete(flush:true)
                    render "OK_Eliminación de Comercializadora exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Comercializadora."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Comercializadora."
    } //notFound para ajax

    def comercializadora_ajax(){
        def estacion

        if(params.id != '0'){
            estacion = Estacion.get(params.id)
        }

        return [estacion: estacion]
    }

}
