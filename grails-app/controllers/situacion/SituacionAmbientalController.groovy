package situacion

import auditoria.Auditoria
import auditoria.DetalleAuditoria
import auditoria.Preauditoria
import estacion.Area
import estacion.Ares


class SituacionAmbientalController extends Seguridad.Shield {

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
            def c = SituacionAmbiental.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = SituacionAmbiental.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def situacionAmbientalInstanceList = getLista(params, false)
        def situacionAmbientalInstanceCount = getLista(params, true).size()
        if (situacionAmbientalInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        situacionAmbientalInstanceList = getLista(params, false)
        return [situacionAmbientalInstanceList: situacionAmbientalInstanceList, situacionAmbientalInstanceCount: situacionAmbientalInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def situacionAmbientalInstance = SituacionAmbiental.get(params.id)
            if (!situacionAmbientalInstance) {
                notFound_ajax()
                return
            }
            return [situacionAmbientalInstance: situacionAmbientalInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def situacionAmbientalInstance = new SituacionAmbiental(params)
        if (params.id) {
            situacionAmbientalInstance = SituacionAmbiental.get(params.id)
            if (!situacionAmbientalInstance) {
                notFound_ajax()
                return
            }
        }
        return [situacionAmbientalInstance: situacionAmbientalInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def situacionAmbientalInstance = new SituacionAmbiental()
        if (params.id) {
            situacionAmbientalInstance = SituacionAmbiental.get(params.id)
            if (!situacionAmbientalInstance) {
                notFound_ajax()
                return
            }
        } //update
        situacionAmbientalInstance.properties = params
        if (!situacionAmbientalInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} SituacionAmbiental."
            msg += renderErrors(bean: situacionAmbientalInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de SituacionAmbiental exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def situacionAmbientalInstance = SituacionAmbiental.get(params.id)
            if (situacionAmbientalInstance) {
                try {
                    situacionAmbientalInstance.delete(flush: true)
                    render "OK_Eliminación de SituacionAmbiental exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar SituacionAmbiental."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró SituacionAmbiental."
    } //notFound para ajax

    def situacion () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def lista = [1,2,3,4,5]
        def listaComponentes = ComponenteAmbiental.findAllByIdInList(lista)
        def situaciones = SituacionAmbiental.findAllByDetalleAuditoriaAndComponenteAmbientalInList(detalleAuditoria,listaComponentes, [sort: 'componenteAmbiental', order: "asc"])
//        println("componentes lista " + listaComponentes)
//        println("situaciones lista " + situaciones)
        def inter = listaComponentes.intersect(situaciones.componenteAmbiental)
//        println("inter " + inter)
        def porGrabar = listaComponentes - inter
//        println("por grabar " + porGrabar)
        def situacion

        if(porGrabar){
            println("va a grabar")
            porGrabar.each {p->
                situacion = new SituacionAmbiental()
                situacion.detalleAuditoria = detalleAuditoria
                situacion.componenteAmbiental = p
                try{
                    situacion.save(flush: true)
                }catch (e){
                    println("error al grabar por primera vez las situaciones " + situacion.errors)
                }
            }
        }else{
            println(" nada que hacer en grabar")

        }


        def biotico = SituacionAmbiental.withCriteria {
                                    eq("detalleAuditoria",detalleAuditoria)

                                    componenteAmbiental{
                                        eq("tipo",'Biótico')
                                    }
        }

        def fisicoEmisores = SituacionAmbiental.withCriteria {
            eq("detalleAuditoria",detalleAuditoria)

            componenteAmbiental{
                eq("tipo",'Físico')
                eq("nombre","Emisiones Gaseosas")
            }
        }

//        def texto
//        if(fisicoEmisores?.first()?.descripcion){
//            texto = fisicoEmisores?.first()?.descripcion
//        }else{
//            texto = "La estación de servicios ${pre?.estacion?.nombre}" +
//                    "</br>Al no estar sujeto a monitoreo no se ha realizado un seguimiento de las emisiones del generador. Sin embargo, se asume que no existe una " +
//                    "alteración significativa de la calidad del aire debido a las pocas horas de uso del mismo. "
//        }


//        return [pre: pre, situaciones: situaciones, biotico: biotico.first(), fisicoEmisor: fisicoEmisores.first(), texto: texto]
        return [pre: pre, situaciones: situaciones, biotico: biotico.first(), fisicoEmisor: fisicoEmisores.first()]
    }

    def emisor_ajax () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def componente = ComponenteAmbiental.get(1)
        def situacion = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)
        def existentes = EmisorComponente.findAllBySituacionAmbiental(situacion).emisor.id
//        println("existentes " + existentes)
        def listaEmisores = Emisor.list([sort: 'nombre', order: 'asc']).id
//        println("lista emisores " + listaEmisores)

        def comunes = listaEmisores.intersect(existentes)
//        println("comunes " + comunes)
        def diferentes = listaEmisores.plus(existentes)
        diferentes.removeAll(comunes)

//        println("diferentes " + diferentes)
        def elegibles = Emisor.findAllByIdInList(diferentes)
//        println("elegibles " + elegibles)

        return [diferentes: elegibles]
    }

    def revisarGenerador_ajax () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)

        def area = Area.findByCodigo('GNRD')
        def existe = Ares.findByAreaAndEstacion(area, pre.estacion)

        def componente = ComponenteAmbiental.get(1)
        def situacion = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)

        def emisor = Emisor.findByCodigo('GNRD')
        def exc = EmisorComponente.findByEmisorAndSituacionAmbiental(emisor,situacion)


        if(existe && !exc){
            render "ok"
        }else{
            render "no"
        }

    }

    def generador_ajax () {
        def men
        if(params.mensaje){
            men = params.mensaje
        }
        return [mensaje: men]
    }

    def guardarGenerador_ajax () {

        println("params guardar generador " + params)

        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def componente = ComponenteAmbiental.get(1)
        def situacion = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)
        def emisor = Emisor.findByCodigo('GNRD')

        def em = new EmisorComponente()
        em.emisor = emisor
        em.situacionAmbiental = situacion
        em.hora = params.hora.toInteger()
        if(params.si == 'true'){
            em.mantenimiento = 1
        }else{
            em.mantenimiento = 0
        }

        try{
            em.save(flush: true)
            render 'ok'
        }catch (e){
            render 'no'
            println("error al guardar el generador")
        }
    }


    def guardarBiotico_ajax () {

//        println("bioritoc params " + params)

        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def componente = ComponenteAmbiental.get(4)
        def situacionBiotico = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)

        situacionBiotico.descripcion = params.descripcion

        try{
            situacionBiotico.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al guardar el texto del componente biotico" + situacionBiotico.errors)
        }
    }

    def guardarSocial_ajax () {


        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def componente = ComponenteAmbiental.get(5)
        def situacionSocial = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)

        situacionSocial.descripcion = params.descripcion

        try{
            situacionSocial.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al guardar el texto del componente biotico" + situacionSocial.errors)
        }
    }

    def tablaEmisores_ajax () {

        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def componente = ComponenteAmbiental.get(1)
        def situacionSocial = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)
        def emisores = EmisorComponente.findAllBySituacionAmbiental(situacionSocial)

//        println("emisores " + emisores)
        return [emisores: emisores]
    }


    def guardarEmisiones_ajax () {

        println("params guardar emisiones " + params)


        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def componente = ComponenteAmbiental.get(1)
        def situacionEmisores = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)

        situacionEmisores.descripcion = params.descripcion

        try{
            situacionEmisores.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al guardar el texto del emisor" + situacionEmisores.errors)
        }
    }

    def editorE_ajax () {

        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def componente = ComponenteAmbiental.get(1)
        def situacionEmisores = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)

        def texto
        if(situacionEmisores?.descripcion){
            texto = situacionEmisores?.descripcion
        }else{
            texto = "La estación de servicios ${pre?.estacion?.nombre}" +
                    "</br>Al no estar sujeto a monitoreo no se ha realizado un seguimiento de las emisiones del generador. Sin embargo, se asume que no existe una " +
                    "alteración significativa de la calidad del aire debido a las pocas horas de uso del mismo. "
        }

        return[pre: pre, texto: texto]
    }

    def agregarEmisor_ajax () {

    }

    def agregarTablaLiquidas_ajax () {

    }

    def crearTabla_ajax (){

        println("params crear tabla " + params)

        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def componente = ComponenteAmbiental.get(2)
        def situacion= SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)
        def fecha = new Date().parse("dd-MM-yyyy",params.fecha)

        def tabla = new TablaLiquidas()
        tabla.situacionAmbiental = situacion
        tabla.fecha = fecha
        try{
            tabla.save(flush: true)
            render "ok_${tabla?.id}"
        }catch (e){
            render "no"
        }

    }

    def tablaAnalisis_ajax () {
        def tabla = TablaLiquidas.get(params.id)
        return [tabla: tabla]
    }


    def tablaAnalisisV2_ajax () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def componente = ComponenteAmbiental.get(2)
        def situacion= SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)

        def tablas = TablaLiquidas.findAllBySituacionAmbiental(situacion)

        return [tablas: tablas]

    }

    def datosTablaLiquidas_ajax () {

        def tabla = TablaLiquidas.get(params.id)
        def datos =  AnalisisLiquidas.findAllByTablaLiquidas(tabla)

        return[datos: datos]
    }


    def agregarDatosTablaLiquidas_ajax () {
        def tabla = TablaLiquidas.get(params.id)

        def analisis = new AnalisisLiquidas()
        analisis.tablaLiquidas = tabla
        analisis.save(flush: true)

        return [tabla: tabla, analisis: analisis]
    }

    def cargarUnidad_ajax () {
        def elemento = Elemento.get(params.id)
        return [elemento: elemento]
    }

    def borrarFila_ajax () {
        println("params b " + params)


        def analisis = AnalisisLiquidas.get(params.id)

        try{
            analisis.delete(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al borrar la fila de la tabla de liquidas " + analisis?.errors)
        }
    }

}
