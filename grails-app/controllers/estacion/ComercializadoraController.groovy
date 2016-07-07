package estacion

import consultor.Consultora
import groovy.json.JsonBuilder

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

import static java.awt.RenderingHints.KEY_INTERPOLATION
import static java.awt.RenderingHints.VALUE_INTERPOLATION_BICUBIC


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

        if (session.perfil.codigo == 'ADMI') {

            params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
            def comercializadoraInstanceList = getLista(params, false)
            def comercializadoraInstanceCount = getLista(params, true).size()
            if(comercializadoraInstanceList.size() == 0 && params.offset && params.max) {
                params.offset = params.offset - params.max
            }
            comercializadoraInstanceList = getLista(params, false)
            return [comercializadoraInstanceList: comercializadoraInstanceList, comercializadoraInstanceCount: comercializadoraInstanceCount, params: params]

        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su perfil."
            response.sendError(403)
        }


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

    def cargarLogoComer_ajax () {
        def comercializadora = Comercializadora.get(params.id)
        return [comercializadora: comercializadora]
    }

    def comercializadoraLogo_ajax() {

        def comercializadora = Comercializadora.get(params.id)

        def path = servletContext.getRealPath("/") + "images/logos/" //web-app/archivos
        def img
        def w
        def h
        if (comercializadora?.logotipo) {
            if(ImageIO?.read(new File(path + comercializadora.logotipo))){
                img = ImageIO?.read(new File(path + comercializadora.logotipo));
                w = img.getWidth();
                h = img.getHeight();
            }
        } else {
            w = 0
            h = 0
        }
        return [comercializadora: comercializadora, w: w, h:h]
    }

    def uploadFile() {
        println("params upload " + params)
        def path = servletContext.getRealPath("/") + "images/logos/"
        new File(path).mkdirs()
        def dia = new Date().format("dd-MM-yyyy_HH_mm_ss").toString()
        def nombre
        def comercializadora = Comercializadora.get(params.id)

        def f = request.getFile('file')  //archivo = name del input type file

        def okContents = ['image/png': "png", 'image/jpeg': "jpeg", 'image/jpg': "jpg"]

        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext

            if (okContents.containsKey(f.getContentType())) {
                ext = okContents[f.getContentType()]
                fileName = "logo_comer_${params.id}_${dia}" + "." + ext
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

                if (!comercializadora.logotipo || comercializadora.logotipo != nombre) {
                    def fotoOld = comercializadora.logotipo
                    if (fotoOld) {
                        def file = new File(path + fotoOld)
                        file.delete()
                    }
                    comercializadora.logotipo = nombre
                    if (comercializadora.save(flush: true)) {
                        def data = [
                                files: [
                                        [
                                                name: nombre,
                                                url : resource(dir: 'images/logos/', file: nombre),
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
                                            url : resource(dir: 'images/logos/', file: nombre),
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


}
