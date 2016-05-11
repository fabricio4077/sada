package objetivo

import groovy.json.JsonBuilder

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

import static java.awt.RenderingHints.KEY_INTERPOLATION
import static java.awt.RenderingHints.VALUE_INTERPOLATION_BICUBIC


class ObjetivoController extends Seguridad.Shield {

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
            def c = Objetivo.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Objetivo.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def objetivoInstanceList = getLista(params, false)
        def objetivoInstanceCount = getLista(params, true).size()
        if (objetivoInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        objetivoInstanceList = getLista(params, false)
        return [objetivoInstanceList: objetivoInstanceList, objetivoInstanceCount: objetivoInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def objetivoInstance = Objetivo.get(params.id)
            if (!objetivoInstance) {
                notFound_ajax()
                return
            }
            return [objetivoInstance: objetivoInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def objetivoInstance = new Objetivo(params)
        if (params.id) {
            objetivoInstance = Objetivo.get(params.id)
            if (!objetivoInstance) {
                notFound_ajax()
                return
            }
        }
        return [objetivoInstance: objetivoInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def objetivoInstance = new Objetivo()
        if (params.id) {
            objetivoInstance = Objetivo.get(params.id)
            if (!objetivoInstance) {
                notFound_ajax()
                return
            }
        } //update
        objetivoInstance.properties = params
        if (!objetivoInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Objetivo."
            msg += renderErrors(bean: objetivoInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Objetivo exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def objetivoInstance = Objetivo.get(params.id)
            if (objetivoInstance) {
                try {
                    objetivoInstance.delete(flush: true)
                    render "OK_Eliminación de Objetivo exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Objetivo."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Objetivo."
    } //notFound para ajax

    def guardarObjetivo_ajax () {
        println("params grabar obj " + params)
        def objetivo


        if(params.idO){
            objetivo = Objetivo.get(params.idO)
            if(params.marca == 'true'){
                objetivo.defecto = '1'
            }else{
                objetivo.defecto = '0'
            }
            objetivo.descripcion = params.descripcion
            objetivo.tipo = params.tipo

            try {
             objetivo.save(flush: true)
                render "ok"
            }catch (e){
             println("error al guaradar el objetivo" + objetivo.errors)
                render "no"
            }
        }else{

            objetivo = new Objetivo()
            if(params.marca == 'true'){
                objetivo.defecto = '1'
            }else{
                objetivo.defecto = '0'
            }
            objetivo.descripcion = params.descripcion
            objetivo.tipo = params.tipo

            try {
                objetivo.save(flush: true)
                render "ok"
            }catch (e){
                println("error al guaradar el objetivo" + objetivo.errors)
                render "no"
            }

        }
    }

    def validarTipo_ajax () {
        println("validar " + params)
        if(params.tipo == 'null'){
            render false
            return
        }else{
            render true
            return
        }
    }


    def validarPredeterGeneral_ajax () {

        println("params validar pg " + params)
        def objetivo
        def existe


        existe = Objetivo.findByTipoAndDefecto("General","1")

        if(existe){
            if(params.id){
                objetivo = Objetivo.get(params.id)
                if(objetivo == existe){
                    render "no"
                 }else{
                    render "ok"
                }
            }else{
                render "ok"
            }
        }else{
            render "no"
        }
    }


    def uploadFile() {
//        println("params upload " + params)
        def path = servletContext.getRealPath("/") + "images/objetivos/"    //web-app/images/objetivos
        new File(path).mkdirs()
        def dia = new Date().format("dd-MM-yyyy").toString()
        def nombre
        def objetivo = Objetivo.get(params.id)

        def f = request.getFile('file')  //archivo = name del input type file

        def okContents = ['image/png': "png", 'image/jpeg': "jpeg", 'image/jpg': "jpg"]

        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext

            if (okContents.containsKey(f.getContentType())) {
                ext = okContents[f.getContentType()]
                fileName = "objetivo_${params.id}_${dia}" + "." + ext
                def pathFile = path + fileName
                nombre = fileName
                println("nombre " + nombre)
                try {
                    f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
                } catch (e) {
                    println "????????\n" + e + "\n???????????"
                }
                /* RESIZE */
                def img = ImageIO.read(new File(pathFile))
                def scale = 0.5
                def minW = 300 * 0.7
                def minH = 400 * 0.7
                def maxW = minW * 3
                def maxH = minH * 3
                def w = img.width
                def h = img.height

                if (w > maxW || h > maxH || w < minW || h < minH) {
                    def newW = w * scale
                    def newH = h * scale
                    def r = 1
                    if (w > h) {
                        if (w > maxW) {
                            r = w / maxW
                            newW = maxW
                            println "w>maxW:    r=" + r + "   newW=" + newW
                        }
                        if (w < minW) {
                            r = minW / w
                            newW = minW
                            println "w<minW:    r=" + r + "   newW=" + newW
                        }
                        newH = h / r
                        println "newH=" + newH
                    } else {
                        if (h > maxH) {
                            r = h / maxH
                            newH = maxH
                            println "h>maxH:    r=" + r + "   newH=" + newH
                        }
                        if (h < minH) {
                            r = minH / h
                            newH = minH
                            println "h<minxH:    r=" + r + "   newH=" + newH
                        }
                        newW = w / r
                        println "newW=" + newW
                    }
                    println newW + "   " + newH

                    newW = Math.round(newW.toDouble()).toInteger()
                    newH = Math.round(newH.toDouble()).toInteger()

                    println newW + "   " + newH

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

                if (!objetivo.imagen || objetivo.imagen != nombre) {
                    def fotoOld = objetivo.imagen
                    if (fotoOld) {
                        def file = new File(path + fotoOld)
                        file.delete()
                    }
                    objetivo.imagen = nombre
                    if (objetivo.save(flush: true)) {
                        def data = [
                                files: [
                                        [
                                                name: nombre,
                                                url : resource(dir: 'images/objetivos/', file: nombre),
                                                size: f.getSize(),
                                                url : pathFile
                                        ]
                                ]
                        ]
                        def json = new JsonBuilder(data)
                        render json
                        return
                    } else {
                        def data = [
                                files: [
                                        [
                                                name : nombre,
                                                size : f.getSize(),
                                                error: "Ha ocurrido un error al guardar"
                                        ]
                                ]
                        ]
                        def json = new JsonBuilder(data)
                        render json
                        return
                    }
                } else {
                    def data = [
                            files: [
                                    [
                                            name: nombre,
                                            url : resource(dir: 'images/objetivos/', file: nombre),
                                            size: f.getSize(),
                                            url : pathFile
                                    ]
                            ]
                    ]
                    def json = new JsonBuilder(data)
                    render json
                    return
                }
            } else {
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
                render json
                return
            }
        }
        render "OK_${nombre}"
    }


    def cargarImagen_ajax() {

        def objetivo = Objetivo.get(params.id)
        def path = servletContext.getRealPath("/") + "images/objetivos/" //web-app/archivos
        def img
        def w
        def h
        if (objetivo?.imagen) {
            if(ImageIO?.read(new File(path + objetivo.imagen))){
                img = ImageIO?.read(new File(path + objetivo.imagen));
                w = img.getWidth();
                h = img.getHeight();
            }
        } else {
            w = 0
            h = 0
        }
        return [objetivo: objetivo, w: w, h: h]


    }


}
