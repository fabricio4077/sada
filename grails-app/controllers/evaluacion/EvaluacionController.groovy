package evaluacion

import auditoria.Auditoria
import auditoria.DetalleAuditoria
import auditoria.Preauditoria
import legal.MarcoLegal
import legal.MarcoNorma


class EvaluacionController extends Seguridad.Shield {

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
            def c = Evaluacion.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Evaluacion.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def evaluacionInstanceList = getLista(params, false)
        def evaluacionInstanceCount = getLista(params, true).size()
        if (evaluacionInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        evaluacionInstanceList = getLista(params, false)
        return [evaluacionInstanceList: evaluacionInstanceList, evaluacionInstanceCount: evaluacionInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def evaluacionInstance = Evaluacion.get(params.id)
            if (!evaluacionInstance) {
                notFound_ajax()
                return
            }
            return [evaluacionInstance: evaluacionInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def evaluacionInstance = new Evaluacion(params)
        if (params.id) {
            evaluacionInstance = Evaluacion.get(params.id)
            if (!evaluacionInstance) {
                notFound_ajax()
                return
            }
        }
        return [evaluacionInstance: evaluacionInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def evaluacionInstance = new Evaluacion()
        if (params.id) {
            evaluacionInstance = Evaluacion.get(params.id)
            if (!evaluacionInstance) {
                notFound_ajax()
                return
            }
        } //update
        evaluacionInstance.properties = params
        if (!evaluacionInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Evaluacion."
            msg += renderErrors(bean: evaluacionInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Evaluacion exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def evaluacionInstance = Evaluacion.get(params.id)
            if (evaluacionInstance) {
                try {
                    evaluacionInstance.delete(flush: true)
                    render "OK_Eliminación de Evaluacion exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Evaluacion."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Evaluacion."
    } //notFound para ajax

    def evaluacionAmbiental () {

        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
//        def leyes = MarcoNorma.findAllByMarcoLegalAndSeleccionado(audi.marcoLegal, 1, [sort:'norma.nombre', order: 'asc'])
        def leyes = Evaluacion.findAllByDetalleAuditoria(detalleAuditoria)

        return [pre: pre, auditoria: audi, leyes: leyes]
    }

    def asignarMarco_ajax () {

//        println("params asignar marco " + params)

        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(auditoria)
        def marcoPredeterminado = MarcoLegal.findByCodigo('DFLT')
        def marco
        def error = ''

        if(params.marco == 'null'){
            auditoria.marcoLegal = marcoPredeterminado
        }else{
            marco = MarcoLegal.get(params.marco)
            auditoria.marcoLegal = marco
        }

        try{
            auditoria.save(flush: true)

        }catch (e){
            error += auditoria.errors
            println("error al asignar el marco legal a la auditoria" + auditoria.errors)
        }


        def leyes = MarcoNorma.findAllByMarcoLegalAndSeleccionado(auditoria.marcoLegal, 1, [sort:'norma.nombre', order: 'asc'])
        def evaluacion


        leyes.each { ly->
            evaluacion = new Evaluacion()
            evaluacion.detalleAuditoria = detalleAuditoria
            evaluacion.marcoNorma = ly

            try{
                evaluacion.save(flush: true)
            }catch (e){
                println("error al crear alguna evam " + evaluacion.errors)
                error += evaluacion.errors
            }
        }

        if(error == ''){
            render "ok"
        }else{
            render "no"
        }

    }

    def cargarHallazgo_ajax () {

//        println("params hallazgo " + params)

        def evaluacion = Evaluacion.get(params.id)
        def listaHallazgos

        if(evaluacion.marcoNorma.literal){
            listaHallazgos = Hallazgo.findByLiteral(evaluacion.marcoNorma.literal)
        }else{
            listaHallazgos = Hallazgo.findByArticulo(evaluacion.marcoNorma.articulo)
        }

        return [listaHallazgos: listaHallazgos]
    }

}
