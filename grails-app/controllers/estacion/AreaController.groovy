package estacion

import auditoria.Auditoria
import auditoria.Preauditoria
import groovy.json.JsonBuilder
import objetivo.Objetivo
import objetivo.ObjetivosAuditoria

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

import static java.awt.RenderingHints.KEY_INTERPOLATION
import static java.awt.RenderingHints.VALUE_INTERPOLATION_BICUBIC

//import static org.apache.commons.collections.CollectionUtils.*


class AreaController extends Seguridad.Shield {

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
            def c = Area.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Area.list(params)
        }
        return lista
    }

    def list() {

        if (session.perfil.codigo == 'ADMI') {
            params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
            def areaInstanceList = getLista(params, false)
            def areaInstanceCount = getLista(params, true).size()
            if (areaInstanceList.size() == 0 && params.offset && params.max) {
                params.offset = params.offset - params.max
            }
            areaInstanceList = getLista(params, false)
            return [areaInstanceList: areaInstanceList, areaInstanceCount: areaInstanceCount, params: params]
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su perfil."
            response.sendError(403)
        }



    } //list

    def show_ajax() {
        if (params.id) {
            def areaInstance = Area.get(params.id)
            if (!areaInstance) {
                notFound_ajax()
                return
            }
            return [areaInstance: areaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def areaInstance = new Area(params)
        if (params.id) {
            areaInstance = Area.get(params.id)
            if (!areaInstance) {
                notFound_ajax()
                return
            }
        }
        return [areaInstance: areaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def areaInstance = new Area()
        if (params.id) {
            areaInstance = Area.get(params.id)
            if (!areaInstance) {
                notFound_ajax()
                return
            }
        } //update
        areaInstance.properties = params
        if (!areaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Area."
            msg += renderErrors(bean: areaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Area exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def areaInstance = Area.get(params.id)
            if (areaInstance) {
                try {
                    areaInstance.delete(flush: true)
                    render "OK_Eliminación de Area exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Area."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Area."
    } //notFound para ajax

    def areas () {
        def creador = session.usuario.apellido + "_" + session.usuario.login + "_" + session.perfil.codigo
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def objetivo =  Objetivo.findByIdentificador('Evaluar Áreas de la Estación')
        def obau = ObjetivosAuditoria.findByAuditoriaAndObjetivo(audi,objetivo)

//        println("obau " + obau)

        if (creador == pre?.creador || session.perfil.codigo == 'ADMI') {
            if(obau){
                return [pre:pre, obau: obau]
            }else{
                response.sendError(404)
            }
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su usuario."
            response.sendError(403)
        }
    }


    def comboArea_ajax () {
        def pre = Preauditoria.get(params.id)
        def estacion = Preauditoria.get(params.id).estacion
        def listaAreas = Area.list([sort: 'nombre', order: 'asc'])
        def areasEstacion = Ares.findAllByEstacionAndPreauditoria(estacion,pre).area
        def comunes = listaAreas.intersect(areasEstacion)
        def diferentes = listaAreas.plus(areasEstacion)
        diferentes.removeAll(comunes)

//        println("diferentes " + diferentes)

        return [diferentes: diferentes]
    }


    def acordeonAreas_ajax () {
        def pre = Preauditoria.get(params.id)
        def estacion = pre.estacion
        def areasEstacion = Ares.findAllByEstacionAndPreauditoria(estacion,pre, [sort: 'area.nombre', order: 'asc'])

        return [areas: areasEstacion, pre: pre]
    }

    def asignarArea_ajax () {
//        println("params asign area " + params)
        def pre = Preauditoria.get(params.id)
        def estacion = Preauditoria.get(params.id).estacion
        def area = Area.get(params.area)

        def aresInstance = new Ares()
        aresInstance.estacion = estacion
        aresInstance.area = area
        aresInstance.preauditoria = pre

        try{
            aresInstance.save(flush: true)
            render "ok"
        }catch (e){
            println("error al asignar area " + aresInstance.errors + e)
            render "no"
        }
    }

    def eliminarArea_ajax () {
//        println("params eliminar area " + params)
        def areaEstacion = Ares.get(params.id)
        try{
            areaEstacion.delete(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("erro al borrar el área de la estación" + areaEstacion.errors)
        }

    }

    def uploadFile() {
//        println("params upload " + params)
        def path = servletContext.getRealPath("/") + "images/areas/"    //web-app/images/areas
        new File(path).mkdirs()
        def dia = new Date().format("dd-MM-yyyy_HH_mm_ss").toString()
        def estacion = Preauditoria.get(params.pre).estacion.id
        def pre = Preauditoria.get(params.pre).id
        def nombre
        def ares = Ares.get(params.id)
        def f = request.getFile('file')  //archivo = name del input type file

        def okContents = ['image/png': "png", 'image/jpeg': "jpeg", 'image/jpg': "jpg"]

        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext

            if (okContents.containsKey(f.getContentType())) {
                ext = okContents[f.getContentType()]
                fileName = "area_${params.id}_${estacion}_${pre}_${dia}" + "." + ext
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

                def pos




//                if (!ares.foto1 || !ares.foto2 || !ares.foto3) {

//                    println("entro f")
//                    def fotoOld = ares.foto1
//                    if (fotoOld) {
//                        def file = new File(path + fotoOld)
//                        file.delete()
//                    }

                if(!ares.foto1 || ares.foto1 == ''){
                    println("entro 1")
                    def fotoOld = ares.foto1
                    if (fotoOld) {
                        def file = new File(path + fotoOld)
                        file.delete()
                    }

                    ares.foto1 = nombre
                }else{
                    if(!ares.foto2 || ares.foto2 == ''){

                        def fotoOld = ares.foto2
                        if (fotoOld) {
                            def file = new File(path + fotoOld)
                            file.delete()
                        }
                        ares.foto2 = nombre
                    }else{

                        def fotoOld = ares.foto3
                        if (fotoOld) {
                            def file = new File(path + fotoOld)
                            file.delete()
                        }

                        ares.foto3 = nombre
                    }
                }

                println("ares " + ares.foto1)

                if (ares.save(flush: true)) {
                    def data = [
                            files: [
                                    [
                                            name: nombre,
                                            url : resource(dir: 'images/areas/', file: nombre),
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
//                } else {
//                    def data = [
//                            files: [
//                                    [
//                                            name: nombre,
//                                            url : resource(dir: 'images/areas/', file: nombre),
//                                            size: f.getSize(),
//                                            url : pathFile
//                                    ]
//                            ]
//                    ]
//                    def json = new JsonBuilder(data)
//                    render json
//                    return
//                }
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


    def borrarImagen_ajax () {

//        println("params borrar imagen" + params)
        def file
        def path = servletContext.getRealPath("/") + "images/areas/"

        def ares = Ares.get(params.id)
        if(params.foto == '1'){
            println("entro 1")
            file = new File(path + ares.foto1)
            ares.foto1 = ''
        }
        if(params.foto == '2'){
            file = new File(path + ares.foto2)
            ares.foto2 = ''
        }
        if(params.foto == '3'){
            file = new File(path + ares.foto3)
            ares.foto3 = ''
        }

        try{
            file.delete()
            ares.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error" + ares.errors)
        }
    }



    //guardar datos del area en ares

    def guardarDatosArea_ajax () {
//        println("params area datos " + params)

        def ares = Ares.get(params.id)
        ares.descripcion = params.descripcion

        try{
            ares.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("Error al guardar los datos del area" + ares.errors )
        }
    }

    def cargarExtintor_ajax () {
        def ares = Ares.get(params.id)
        return[ares: ares]
    }

    def tablaExtintores_ajax () {
//        println("params tabla ex" + params)
        def aresArea = Ares.get(params.id)
//        def lista = Extintor.findAllByAres(ares)
        def lista = Extintor.withCriteria {
            eq("ares",aresArea)
        }
//        println("lista " + lista)
        return [lista: lista]
     }

    def agregarExtintor_ajax (){

//        println("params gregar extintor " + params )

        def ares = Ares.get(params.idA)

        def extintorArea = new Extintor(params)
        extintorArea.ares = ares
        extintorArea.tipo = params.tipo
        extintorArea.capacidad = params.capacidad.toInteger()

        try{
            extintorArea.save(flush: true)
            render "ok"
        }catch(e){
            render"no"
            println("Error al agregar el extintor")
        }
    }

    def grabarExtintor_ajax() {
        def ares = Ares.get(params.id)
        def nuevoEx = new Extintor()
        nuevoEx.ares = ares
        nuevoEx.tipo = params.tipo
        nuevoEx.capacidad = params.capacidad.toInteger()
        nuevoEx.save(flush: true)
        render "ok"
    }


    //funcion para borrar un extintor del área

    def borrarExtintor_ajax() {

        def extintor = Extintor.get(params.id)
        extintor.delete(flush: true)

       render "ok"
    }

    def completar_ajax () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def objetivo =  Objetivo.findByIdentificador('Evaluar Áreas de la Estación')
        def objetivoGeo = Objetivo.findByIdentificador('Datos Geográficos')
        def obau = ObjetivosAuditoria.findByAuditoriaAndObjetivo(audi,objetivo)
        def obau2 = ObjetivosAuditoria.findByAuditoriaAndObjetivo(audi,objetivoGeo)
        obau2.completado = 1
        obau2.save(flush: true)
        obau.completado = 1
        try{
            obau.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
        }
    }


}
