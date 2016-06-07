package plan


class MedidaController extends Seguridad.Shield {

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
            def c = Medida.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Medida.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def medidaInstanceList = getLista(params, false)
        def medidaInstanceCount = getLista(params, true).size()
        if (medidaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        medidaInstanceList = getLista(params, false)
        return [medidaInstanceList: medidaInstanceList, medidaInstanceCount: medidaInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def medidaInstance = Medida.get(params.id)
            if (!medidaInstance) {
                notFound_ajax()
                return
            }
            return [medidaInstance: medidaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def medidaInstance = new Medida(params)
        if (params.id) {
            medidaInstance = Medida.get(params.id)
            if (!medidaInstance) {
                notFound_ajax()
                return
            }
        }
        return [medidaInstance: medidaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def medidaInstance = new Medida()
        if (params.id) {
            medidaInstance = Medida.get(params.id)
            if (!medidaInstance) {
                notFound_ajax()
                return
            }
        } //update
        medidaInstance.properties = params
        if (!medidaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Medida."
            msg += renderErrors(bean: medidaInstance)
            render msg
            return
        }
//        render "OK_${params.id ? 'Actualización' : 'Creación'} de Medida exitosa."
        render "OK_${params.id}"
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def medidaInstance = Medida.get(params.id)
            if (medidaInstance) {
                try {
                    medidaInstance.delete(flush: true)
                    render "OK_Eliminación de Medida exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Medida."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Medida."
    } //notFound para ajax

    def guardarMedida_ajax (){

//        println("params guardar medida " + params)
        def medida
        medida = new Medida()
        medida.verificacion = params.verificacion
        medida.indicadores = params.indicadores
        medida.descripcion = params.descripcion
        medida.plazo = params.plazo
        medida.costo = params.costo.toDouble()

        try{
            medida.save(flush: true)
            render "ok_${medida?.id}"
        }catch (e){
            render "no"
            println("error al guardar la medida")
        }

    }

}
