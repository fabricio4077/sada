package tipo


class PeriodoController extends Seguridad.Shield {

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
            def c = Periodo.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Periodo.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def periodoInstanceList = getLista(params, false)
        def periodoInstanceCount = getLista(params, true).size()
        if (periodoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        periodoInstanceList = getLista(params, false)
        return [periodoInstanceList: periodoInstanceList, periodoInstanceCount: periodoInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def periodoInstance = Periodo.get(params.id)
            if (!periodoInstance) {
                notFound_ajax()
                return
            }
            return [periodoInstance: periodoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def periodoInstance = new Periodo(params)
        if (params.id) {
            periodoInstance = Periodo.get(params.id)
            if (!periodoInstance) {
                notFound_ajax()
                return
            }
        }
        return [periodoInstance: periodoInstance]
    } //form para cargar con ajax en un dialog

    def fin_ajax () {
        return [fin: params.anio.toInteger() + 1]
    }

    def save_ajax() {
//        println("params prdo " + params)

        def inicio = new Date().parse("yyyy",params.inicio_year)
        def fin = new Date().parse("yyyy",params.fin_year)
//
//        println("inicio " + inicio)
//        println("fin " + fin)

        def listaPeriodos = Periodo.list()
        def tiene = ''

        listaPeriodos.each {p->
            if((p.inicio.format("yyyy") == params.inicio_year) && (p.fin.format("yyyy") == params.fin_year)){
               tiene += 'tiene'
            }else{

            }
        }

        println("tiene " + tiene)

        if(tiene != ''){
            render "no_Este período ya existe!"
        }else{
            def periodoInstance = new Periodo()
            if (params.id) {
                periodoInstance = Periodo.get(params.id)
                if (!periodoInstance) {
                    notFound_ajax()
                    return
                }
            } //update
            periodoInstance.properties = params
            if (!periodoInstance.save(flush: true)) {
                def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} el Período."
                msg += renderErrors(bean: periodoInstance)
                render msg
                return
            }
            render "OK_${params.id ? 'Actualización' : 'Creación'} de Periodo exitosa."
        }





    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def periodoInstance = Periodo.get(params.id)
            if (periodoInstance) {
                try {
                    periodoInstance.delete(flush: true)
                    render "OK_Eliminación de Periodo exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Periodo."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Periodo."
    } //notFound para ajax

}
