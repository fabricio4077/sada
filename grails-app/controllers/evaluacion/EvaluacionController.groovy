package evaluacion

import auditoria.Auditoria
import auditoria.DetalleAuditoria
import auditoria.Preauditoria
import estacion.Estacion
import groovy.json.JsonBuilder
import legal.MarcoLegal
import legal.MarcoNorma
import objetivo.Objetivo
import objetivo.ObjetivosAuditoria
import plan.AspectoAmbiental
import plan.PlanAuditoria
import tipo.Periodo

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

import static java.awt.RenderingHints.KEY_INTERPOLATION
import static java.awt.RenderingHints.VALUE_INTERPOLATION_BICUBIC


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
        def objetivo =  Objetivo.findByIdentificador('Evaluación Ambiental')
        def obau = ObjetivosAuditoria.findByAuditoriaAndObjetivo(audi,objetivo)

        def leyes = Evaluacion.findAllByDetalleAuditoriaAndMarcoNormaIsNotNull(detalleAuditoria, [sort: 'orden', order: 'asc'])

//        def leyes
//
//        leyes = Evaluacion.withCriteria {
//            eq("detalleAuditoria", detalleAuditoria)
//            isNotNull("marcoNorma")
//            order("orden","asc")
//        }


        def creador = session.usuario.apellido + "_" + session.usuario.login + "_" + session.perfil.codigo
        if (creador == pre?.creador || session.perfil.codigo == 'ADMI') {
            return [pre: pre, auditoria: audi, obau: obau, leyes: leyes]
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su usuario."
            response.sendError(403)
        }


        return [pre: pre, auditoria: audi, obau: obau, leyes: leyes]
    }

    def tablaEvaluacion_ajax () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def leyes

        leyes = Evaluacion.withCriteria {
            eq("detalleAuditoria", detalleAuditoria)
            isNotNull("marcoNorma")
            order("orden","asc")
        }

        return [leyes: leyes, pre: pre]
    }

    def orden_ajax() {
        def evaluacion = Evaluacion.get(params.id)
        return [evaluacion: evaluacion]
    }

    def ordenLicencia_ajax () {
        def evaluacion = Evaluacion.get(params.id)
        return [evaluacion: evaluacion]
    }

    def guardarOrden_ajax () {
        def evaluacion = Evaluacion.get(params.id)
        def orden = params.orden.toInteger()
        def listaOrden = Evaluacion.findAllByDetalleAuditoriaAndMarcoNormaIsNotNull(evaluacion.detalleAuditoria)

        if(listaOrden.orden.contains(orden)){
            render "no_El número de orden ingresado ya se encuentra asignado"
        }else{
            evaluacion.orden = params.orden.toInteger()

            try{
               evaluacion.save(flush: true)
                render"ok"
            }catch (e){
                render "no_Error al asignar el número de orden"
            }

        }
    }

    def guardarOrdenPlan_ajax () {
        def evaluacion = Evaluacion.get(params.id)
        def orden = params.orden.toInteger()
        def listaOrden = Evaluacion.findAllByDetalleAuditoriaAndPlanAuditoriaIsNotNull(evaluacion.detalleAuditoria)

        if(listaOrden.orden.contains(orden)){
            render "no_El número de orden ingresado ya se encuentra asignado"
        }else{
            evaluacion.orden = params.orden.toInteger()

            try{
                evaluacion.save(flush: true)
                render"ok"
            }catch (e){
                render "no_Error al asignar el número de orden"
            }

        }
    }

    def guardarOrdenLic_ajax () {
        def evaluacion = Evaluacion.get(params.id)
        def orden = params.orden.toInteger()
        def listaOrden = Evaluacion.findAllByDetalleAuditoriaAndLicenciaIsNotNull(evaluacion.detalleAuditoria)

        if(listaOrden.orden.contains(orden)){
            render "no_El número de orden ingresado ya se encuentra asignado"
        }else{
            evaluacion.orden = params.orden.toInteger()
            try{
                evaluacion.save(flush: true)
                render"ok"
            }catch (e){
                render "no_Error al asignar el número de orden"
            }

        }
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
        def evaluacion = Evaluacion.get(params.id)
        return [evaluacion: evaluacion, tipo:params.tipo]
    }

    def crearHallazgo_ajax() {
        def evaluacion = Evaluacion.get(params.id)
        return [evaluacion: evaluacion, tipo: params.tipo]
    }

    def comboHallazgo_ajax () {

        def evaluacion = Evaluacion.get(params.id)
        def listaHallazgos

        if(evaluacion.marcoNorma){
            if(evaluacion.marcoNorma.literal){
                listaHallazgos = Hallazgo.findAllByLiteral(evaluacion.marcoNorma.literal)
            }else{
                listaHallazgos = Hallazgo.findAllByArticulo(evaluacion.marcoNorma.articulo)
            }
        }else{
            if(evaluacion.planAuditoria){
                listaHallazgos = Evaluacion.withCriteria {
                    planAuditoria{
                        eq("aspectoAmbiental", evaluacion.planAuditoria.aspectoAmbiental)
                    }

                    isNotNull("hallazgo")
                }.hallazgo
            }else {
                if(evaluacion.licencia){
                    println("entro" + evaluacion.id)
                    listaHallazgos = Evaluacion.withCriteria {
                        licencia{
                            eq("descripcion",evaluacion.licencia.descripcion )
                        }
                        isNotNull("hallazgo")
                    }.hallazgo
                }
            }
       }

//        println("lista hallazgos " + listaHallazgos)


        return [listaHallazgos: listaHallazgos]
    }

    def guardarHallazgo_ajax () {

//        println("params guardar hallazgo " + params)

        def cali = Calificacion.get(params.calificacion)
        def evaluacion = Evaluacion.get(params.id)
        def ref
        def hallazgo = new Hallazgo()

        if(evaluacion.marcoNorma){
            if(evaluacion.marcoNorma.literal){
                hallazgo.literal = evaluacion.marcoNorma.literal
            }else{
                hallazgo.articulo = evaluacion.marcoNorma.articulo
            }
        }

        hallazgo.calificacion = cali
        hallazgo.descripcion = params.descripcion

        try{
            hallazgo.save(flush: true)
            evaluacion.hallazgo = hallazgo
            evaluacion.calificacion = hallazgo.calificacion
            evaluacion.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al guardar nuevo hallazgo")
        }





    }

    def guardarSeleccionado_ajax () {
//        println("seleccionar hallazgo params " + params)

        def evaluacion = Evaluacion.get(params.id)
        def hallazgo = Hallazgo.get(params.combo)

        evaluacion.hallazgo = hallazgo
        evaluacion.calificacion = hallazgo.calificacion

        try {
            evaluacion.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al seleccionar hallazgo" + evaluacion.errors)
        }
    }


    def tablaHallazgo_ajax () {
        def evaluacion = Evaluacion.get(params.id)
        return [evaluacion: evaluacion, tipo: params.tipo]
    }

    def borrarHallazgo_ajax (){

        def evaluacion = Evaluacion.get(params.id)
        evaluacion.hallazgo = null
        evaluacion.calificacion = null

        try {
            evaluacion.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al borrar hallazgo" + evaluacion.errors)
        }
    }

    def calificacion_ajax () {

    }

    def guardarCalificacion_ajax () {
        def evaluacion = Evaluacion.get(params.id)
        def cali = Calificacion.get(params.calificacion)

        evaluacion.calificacion = cali

        try{
            evaluacion.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al guardar la calificacion")
        }
    }

    def anexo_ajax () {
        def eva = Evaluacion.get(params.id)
        return [evas: eva]
    }

    def guardarEvidencia_ajax () {
        def eva = Evaluacion.get(params.id)
        eva.evidencia = params.texto
        try{
            eva.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al guardar el titulo de la evidencia" + eva.errors)
        }
    }

    def uploadFile () {

//        println("params anexos " + params)
        def eva = Evaluacion.get(params.id)
        def anio = new Date().format("yyyy")
        def path = servletContext.getRealPath("/") + "anexos/estacion_${eva?.detalleAuditoria?.auditoria?.preauditoria?.estacion?.id}/" + "periodo_${eva?.detalleAuditoria?.auditoria?.preauditoria?.periodo?.id}" + "/" + "eva-${eva?.id}" + "/"
        new File(path).mkdirs()
        def f = request.getFile('file')  //archivo = name del input type file
        def imageContent = ['image/png': "png", 'image/jpeg': "jpeg", 'image/jpg': "jpg"]
        def okContents = [
                'image/png'                                                                : "png",
                'image/jpeg'                                                               : "jpeg",
                'image/jpg'                                                                : "jpg",

                'application/pdf'                                                          : 'pdf',
                'application/download'                                                     : 'pdf',
                'application/vnd.ms-pdf'                                                   : 'pdf',

                'application/excel'                                                        : 'xls',
                'application/vnd.ms-excel'                                                 : 'xls',
                'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'        : 'xlsx',

                'application/mspowerpoint'                                                 : 'pps',
                'application/vnd.ms-powerpoint'                                            : 'pps',
                'application/powerpoint'                                                   : 'ppt',
                'application/x-mspowerpoint'                                               : 'ppt',
                'application/vnd.openxmlformats-officedocument.presentationml.slideshow'   : 'ppsx',
                'application/vnd.openxmlformats-officedocument.presentationml.presentation': 'pptx',

                'application/msword'                                                       : 'doc',
                'application/vnd.openxmlformats-officedocument.wordprocessingml.document'  : 'docx',

                'application/vnd.oasis.opendocument.text'                                  : 'odt',

                'application/vnd.oasis.opendocument.presentation'                          : 'odp',

                'application/vnd.oasis.opendocument.spreadsheet'                           : 'ods'
        ]

        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext

            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                }
            }

            if (okContents.containsKey(f.getContentType())) {
                ext = okContents[f.getContentType()]
                fileName = fileName.size() < 40 ? fileName : fileName[0..39]
                fileName = fileName.tr(/áéíóúñÑÜüÁÉÍÓÚàèìòùÀÈÌÒÙÇç .!¡¿?&#°"'/, "aeiounNUuAEIOUaeiouAEIOUCc_")

                def nombre = fileName + "." + ext
                def pathFile = path + nombre
                def fn = fileName
                def src = new File(pathFile)
                def i = 1
                while (src.exists()) {
                    nombre = fn + "_" + i + "." + ext
                    pathFile = path + nombre
                    src = new File(pathFile)
                    i++
                }
                try {
                    f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
                } catch (e) {
                    println "????????\n" + e + "\n???????????"
                }

                if (imageContent.containsKey(f.getContentType())) {
                    /* RESIZE */
                    def img = ImageIO.read(new File(pathFile))

                    def scale = 0.5

                    def minW = 200
                    def minH = 200

                    def maxW = minW * 4
                    def maxH = minH * 4

                    def w = img.width
                    def h = img.height

                    if (w > maxW || h > maxH) {
                        int newW = w * scale
                        int newH = h * scale
                        int r = 1
                        if (w > h) {
                            r = w / maxW
                            newW = maxW
                            newH = h / r
                        } else {
                            r = h / maxH
                            newH = maxH
                            newW = w / r
                        }

                        new BufferedImage(newW, newH, img.type).with { j ->
                            createGraphics().with {
                                setRenderingHint(KEY_INTERPOLATION, VALUE_INTERPOLATION_BICUBIC)
                                drawImage(img, 0, 0, newW, newH, null)
                                dispose()
                            }
                            ImageIO.write(j, ext, new File(pathFile))
                        }
                    }
                    /* fin resize */
                } //si es imagen hace resize para que no exceda 800x800
//                println "llego hasta aca"
                def anexo = new Anexo([
                        evaluacion: eva,
                        path      : nombre
//                        path      : pathFile
                ])
                def data
                if (anexo.save(flush: true)) {
                    data = [
                            files: [
                                    [
                                            name: nombre,
//                                            url : resource(dir: "anexos/estacion_${eva?.detalleAuditoria?.auditoria?.preauditoria?.estacion?.id}/" + "periodo_${eva?.detalleAuditoria?.auditoria?.preauditoria?.periodo?.id}" + "/" + "eva-${eva?.id}", file: nombre),
                                            size: f.getSize(),
                                            url : pathFile
                                    ]
                            ]
                    ]
                } else {
                    println "error al guardar: " + anexo.errors
                    data = [
                            files: [
                                    [
                                            name : nombre,
                                            size : f.getSize(),
                                            error: "Ha ocurrido un error al guardar: " + renderErrors(bean: anexo)
                                    ]
                            ]
                    ]
                }
                def json = new JsonBuilder(data)
                render json
                return
            } //ok contents
            else {
                println "llego else no se acepta"
                def data = [
                        files: [
                                [
                                        name : fileName + "." + ext,
                                        size : f.getSize(),
                                        error: "Extensión no permitida"
                                ]
                        ]
                ]

                def json = new JsonBuilder(data)
//                //println json.toPrettyString()
                render json
                return
            }
        } //f && !f.empty
    }


    def tablaAnexos_ajax () {

        def evaluacion = Evaluacion.get(params.id)
        def anexos = Anexo.findAllByEvaluacion(evaluacion)

//        println("lista anexos " + anexos)
        return [existentes: anexos]
    }


    def borrarAnexo_ajax () {
        def anxo = Anexo.get(params.id)
        def band = true
        try {
            def path = servletContext.getRealPath("/") + "anexos/estacion_${anxo?.evaluacion?.detalleAuditoria?.auditoria?.preauditoria?.estacion?.id}/" + "periodo_${anxo?.evaluacion?.detalleAuditoria?.auditoria?.preauditoria?.periodo?.id}" + "/" + "eva-${anxo?.evaluacion?.id}" + "/" + anxo?.path
            def file = new File(path)
            file.delete()
        } catch (e) {
            println "error borrar " + e
            band = false
        }

        if (band) {
            anxo.delete(flush: true)
            render "ok"
        } else {
            println("error al borrar anexo");
            render "no"
        }
    }


    def descargarDoc() {
        def anxo = Anexo.get(params.id)
//        if (session.key == (anxo.path.size() + anxo.path?.encodeAsMD5()?.substring(0, 10))) {
        session.key = null
        def path = servletContext.getRealPath("/") + "anexos/estacion_${anxo?.evaluacion?.detalleAuditoria?.auditoria?.preauditoria?.estacion?.id}/" + "periodo_${anxo?.evaluacion?.detalleAuditoria?.auditoria?.preauditoria?.periodo?.id}" + "/" + "eva-${anxo?.evaluacion?.id}" + "/" + anxo?.path
        def tipo = anxo.path.split("\\.")
        tipo = tipo[1]
        switch (tipo) {
            case "jpeg":
            case "gif":
            case "jpg":
            case "bmp":
            case "png":
                tipo = "application/image"
                break;
            case "pdf":
                tipo = "application/pdf"
                break;
            case "doc":
            case "docx":
            case "odt":
                tipo = "application/msword"
                break;
            case "xls":
            case "xlsx":
                tipo = "application/vnd.ms-excel"
                break;
            default:
                tipo = "application/pdf"
                break;
        }
        try {
            def file = new File(path)
            def b = file.getBytes()
            response.setContentType(tipo)
            response.setHeader("Content-disposition", "attachment; filename=" + (anxo.path))
            response.setContentLength(b.length)
            response.getOutputStream().write(b)
        } catch (e) {
            response.sendError(404)
        }
//        } else {
//            response.sendError(403)
//        }
    }

    def evaluacionPlan () {

        def pre = Preauditoria.get(params.id)
        def periodoActual = pre.periodo.inicio
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(auditoria)

        def anteriores = Preauditoria.withCriteria {
            eq('estacion', pre?.estacion)
            eq("estado",1)
            ne("id",pre?.id)

            periodo{
                or{
                    lt('fin',periodoActual)
                    eq("id", pre?.periodo?.id)
                }

            }
        }


        def auditorias = Auditoria.findAllByPreauditoriaInList(anteriores)
        def detallesAnteriores = DetalleAuditoria.findAllByAuditoriaInList(auditorias)
        def planesAnteriores = PlanAuditoria.findAllByDetalleAuditoriaInListAndPeriodo(detallesAnteriores,'ACT')

        println("planes existentes anteriores " + planesAnteriores.unique())


//        println("anteriores " + anteriores)


        def aupm = PlanAuditoria.findAllByDetalleAuditoriaAndPeriodo(detalleAuditoria,'ANT')


        def creador = session.usuario.apellido + "_" + session.usuario.login + "_" + session.perfil.codigo
        if (creador == pre?.creador || session.perfil.codigo == 'ADMI') {
            return [pre: pre, anteriores: anteriores, planesAnteriores: planesAnteriores?.detalleAuditoria?.auditoria?.preauditoria?.unique(), plan: aupm]
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su usuario."
            response.sendError(403)
        }


    }

    def evaluacionLicencia () {
        def pre = Preauditoria.get(params.id)
        def creador = session.usuario.apellido + "_" + session.usuario.login + "_" + session.perfil.codigo
        if (creador == pre?.creador || session.perfil.codigo == 'ADMI') {
            return [pre: pre]
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su usuario."
            response.sendError(403)
        }


    }

    def asignarPlanAnterior_Ajax (){
        println("asignar plan " + params)

        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(auditoria)

        def apam = AspectoAmbiental.list()
        def aupm
        def error = ''
        def per
        if(params.band == 'true'){
            per = 'ANT'
        }else{
            per = 'ACT'
        }

        apam.each { a->

            aupm = new PlanAuditoria()
            aupm.periodo = per
            aupm.aspectoAmbiental = a
            aupm.detalleAuditoria = detalleAuditoria

            try{
                aupm.save(flush: true)
            }catch (e){
                error += aupm.errors
                println("error al guardar aupm anterior")
            }
        }

        if(error == ''){
            render "ok"
        }else{
            render "no"
        }

    }

    def tablaEvaPlan_ajax () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def planes
//        Evaluacion.findAllByDetalleAuditoriaAndPlanAuditoriaIsNotNull(detalleAuditoria, [sort: 'planAuditoria.aspectoAmbiental.planManejoAmbiental.nombre', order: "asc"])

        planes = Evaluacion.withCriteria {
            eq("detalleAuditoria", detalleAuditoria)
            isNotNull("planAuditoria")
            order("orden","asc")
        }

        return[planes: planes]
    }

    def ordenPlan_ajax () {
        def evaluacion = Evaluacion.get(params.id)
        return [evaluacion: evaluacion]
     }

    def verificarLegislacion_ajax(){

        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)
        def marcoLegal = auditoria.marcoLegal
        def detalle = DetalleAuditoria.findByAuditoria(auditoria)
        def error = ''

        def evam = Evaluacion.withCriteria {
            eq("detalleAuditoria",detalle)
            isNotNull("marcoNorma")
            isNotNull("hallazgo")
            isNotNull("calificacion")
        }

//        println("existen " + evam)

        if(evam.size() > 0){
            render "ok_No se puede cambiar el Marco Legal, ya se encuentra en Evaluación"
        }else{
            def porBorrar = Evaluacion.withCriteria {
                eq("detalleAuditoria",detalle)
                isNotNull("marcoNorma")
            }

            porBorrar.each {po->
                try{
                    po.delete(flush: true)
                }catch (e){
                    error += po.errors
                }
            }

            if(error == ''){
                auditoria.marcoLegal = null
                auditoria.save(flush: true)
                render "no_Marco legal removido correctamente"
            }else{
                render "ok_Error al cambiar el marco legal"
            }

        }
    }

    def tablaEvaLicencia_ajax () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        println("det " + detalleAuditoria)
        def licencias
//        Evaluacion.findAllByDetalleAuditoriaAndLicenciaIsNotNull(detalleAuditoria, [sort: 'licencia.descripcion', order: 'asc'])

        licencias = Evaluacion.withCriteria {
            eq("detalleAuditoria", detalleAuditoria)
            isNotNull("licencia")
            order("orden","asc")
        }

        return [licencias: licencias]
    }

    def completar_ajax () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def objetivo =  Objetivo.findByIdentificador('Evaluación Ambiental')
        def obau = ObjetivosAuditoria.findByAuditoriaAndObjetivo(audi,objetivo)
        obau.completado = 1
        try{
            obau.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
        }
    }


}
