package situacion

import auditoria.Auditoria
import auditoria.DetalleAuditoria
import auditoria.Preauditoria
import estacion.Area
import estacion.Ares
import objetivo.Objetivo
import objetivo.ObjetivosAuditoria


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
        def creador = session.usuario.apellido + "_" + session.usuario.login + "_" + session.perfil.codigo
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)

        def objetivo =  Objetivo.findByIdentificador('Situación Ambiental')
        def obau = ObjetivosAuditoria.findByAuditoriaAndObjetivo(audi,objetivo)

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

        def fisicoDescargas = SituacionAmbiental.withCriteria {
            eq("detalleAuditoria",detalleAuditoria)

            componenteAmbiental{
                eq("tipo",'Físico')
                eq("nombre","Descargas Líquidas")
            }
        }

        def fisicoDesechos = SituacionAmbiental.withCriteria {
            eq("detalleAuditoria",detalleAuditoria)

            componenteAmbiental{
                eq("tipo",'Físico')
                eq("nombre","Residuos Sólidos y Líquidos")
            }
        }


        if (creador == pre?.creador || session.perfil.codigo == 'ADMI') {
            return [pre: pre, situaciones: situaciones, biotico: biotico.first(),
                    fisicoEmisor: fisicoEmisores.first(), fisicoDescargas: fisicoDescargas.first(),
                    fisicoDesechos: fisicoDesechos.first(), obau: obau]
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su usuario."
            response.sendError(403)
        }



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
        def existe = Ares.findByAreaAndEstacionAndPreauditoria(area, pre.estacion,pre)

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
//        println("params guardar emisiones " + params)

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

        def emisores = EmisorComponente.findAllBySituacionAmbiental(situacionEmisores)
        def generador = Emisor.findByCodigo('GNRD')

        def generadorEstacion = EmisorComponente.findByEmisorAndSituacionAmbiental(generador, situacionEmisores)
        def texto
        if(situacionEmisores?.descripcion){
            texto = situacionEmisores?.descripcion
        }else{
            if(emisores.size() > 0){
                if(generadorEstacion){
                    if(generadorEstacion.hora > 300){
                        texto="La Estación de servicios ${pre?.estacion?.nombre}, cuenta con un generador eléctrico emergente +" +
                                "<br> Según Registro de Inspección mensual, el generador ha sido utilizado más de 300 horas al año." +
                                "<br> De acuerdo al cuerdo Ministerial 091 R.O. 403 publicado en 2007 en su artículo 5, " +
                                "literal d): “Quedan eximidos del monitoreo de emisiones los generadores emergentes, motores " +
                                "y bombas contra incendios cuya tasa de funcionamiento sea menor a 300 horas por año. " +
                                "No obstante si dichas unidades no son sujetas a un mantenimiento preventivo estricto, " +
                                "la Dirección Nacional de Protección Ambiental puede disponer que sean monitoreadas trimestralmente...”. "
                    }else{
                        if(generadorEstacion.mantenimiento == 1){
                            texto="La Estación de servicios ${pre?.estacion?.nombre}, cuenta con un generador eléctrico emergente" +
                                    "<br>Según el Registro de Inspección mensual, el generador ha sido utilizado menos de 300 horas al año." +
                                    "<br> De acuerdo al cuerdo Ministerial 091 R.O. 403 publicado en 2007 en su artículo 5, " +
                                    "literal d): “Quedan eximidos del monitoreo de emisiones los generadores emergentes, motores " +
                                    "y bombas contra incendios cuya tasa de funcionamiento sea menor a 300 horas por año. " +
                                    "No obstante si dichas unidades no son sujetas a un mantenimiento preventivo estricto, " +
                                    "la Dirección Nacional de Protección Ambiental puede disponer que sean monitoreadas trimestralmente...”. " +
                                    "<br>Sin embargo, de acuerdo a los registros de inspección mensuales que se mantienen dentro del a E/S, " +
                                    "se puede verificar que durante el periodo ${pre?.periodo?.inicio?.format("yyyy") + "-" + pre?.periodo?.fin?.format("yyyy")}, " +
                                    "se han realizado mantenimientos al generador emergente a pesar de no ser utilizado con una " +
                                    "frecuencia mínima."
                        }else{
                            texto="La Estación de servicios ${pre?.estacion?.nombre}, cuenta con un generador eléctrico emergente" +
                                    "<br>Según el Registro de Inspección mensual, el generador ha sido utilizado menos de 300 horas al año." +
                                    "<br> De acuerdo al cuerdo Ministerial 091 R.O. 403 publicado en 2007 en su artículo 5, " +
                                    "literal d): “Quedan eximidos del monitoreo de emisiones los generadores emergentes, motores " +
                                    "y bombas contra incendios cuya tasa de funcionamiento sea menor a 300 horas por año. " +
                                    "No obstante si dichas unidades no son sujetas a un mantenimiento preventivo estricto, " +
                                    "la Dirección Nacional de Protección Ambiental puede disponer que sean monitoreadas trimestralmente”. "
                        }
                    }
                }else{
                    texto = "La estación de servicios ${pre?.estacion?.nombre}" +
                            "</br> no cuenta con un generador eléctrico."
                }
            }else{
                texto = "Durante la inspección de campo de la estación de servicios ${pre?.estacion?.nombre}, no se evidenció ningún emisor de gases"
            }

        }

        return[pre: pre, texto: texto]
    }

    def agregarEmisor_ajax () {


        println("params agregar emisor " + params)
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def componente = ComponenteAmbiental.get(1)
        def situacion = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)
        def emisor = Emisor.get(params.emisor)

        def em = new EmisorComponente()
        em.emisor = emisor
        em.situacionAmbiental = situacion

        try{
            em.save(flush: true)
            render 'ok'
        }catch (e){
            render 'no'
            println("error al guardar el emisor")
        }



    }

    def agregarTablaLiquidas_ajax () {

    }

    def crearTabla_ajax (){

//        println("params crear tabla " + params)

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
        return[datos: datos, tabla: tabla]
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
//        println("params b " + params)
        def analisis = AnalisisLiquidas.get(params.id)

        try{
            analisis.delete(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al borrar la fila de la tabla de liquidas " + analisis?.errors)
        }
    }

    def guardarFila_ajax () {
        println("params guardar fila " + params)
        def tabla = TablaLiquidas.get(params.tabla)
        def elemento = Elemento.get(params.elemento)
        def analisis = AnalisisLiquidas.get(params.id)
        analisis.tablaLiquidas = tabla
        analisis.limite = params.limite
        analisis.maximo = params.maximo
        analisis.referencia = params.referencia
        analisis.resultado = params.resultado
        analisis.elemento = elemento
        try{
            analisis.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al guardar la fila " + analisis.errors)
        }
    }

    def eliminarTabla_ajax () {
        def tabla = TablaLiquidas.get(params.id)
        def analisis = AnalisisLiquidas.findAllByTablaLiquidas(tabla)

//        println("analisis " + analisis)

        if(analisis.size() > 0){
            render "no_No se puede eliminar esta tabla, ya contiene filas, <br> elimine las filas y trate de nuevo"
        }else{
            try{
                tabla.delete(flush: true)
                render "ok"
            }catch (e){
                render "no_Error al borrar la tabla de análisis"
            }
        }
    }

    def guardarTextoLiquidas_ajax () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def componente = ComponenteAmbiental.get(2)
        def situacionSocial = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)

        situacionSocial.descripcion = params.descripcion

        try{
            situacionSocial.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al guardar el texto de descargas liquidas" + situacionSocial.errors)
        }
    }

    def desechos_ajax () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def componente = ComponenteAmbiental.get(3)
        def situacionSocial = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)
        def listaDesechos = Desechos.list().id
        def existentes = DesechoComponente.findAllBySituacionAmbiental(situacionSocial)

//        println("existentes " + existentes)

        def comunes = listaDesechos.intersect(existentes.desechos.id)
        def diferentes = listaDesechos.plus(existentes.id)
        diferentes.removeAll(comunes)
        def elegibles = Desechos.findAllByIdInList(diferentes, [sort:'descripcion', order: 'asc'])

//        println("elegibles " + elegibles)

        return[elegibles: elegibles]
    }

    def tablaDesechos_ajax () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def componente = ComponenteAmbiental.get(3)
        def situacionSocial = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)
        def existentes = DesechoComponente.findAllBySituacionAmbiental(situacionSocial)

        return [existentes: existentes]
    }

    def borrar_ajax () {
        def desecho = DesechoComponente.get(params.id)

        try{
            desecho.delete(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al borrar la fila")
        }
    }

    def agregarDesecho_ajax () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def componente = ComponenteAmbiental.get(3)
        def situacionA = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)
        def desecho = Desechos.get(params.desecho)
        def dc = new DesechoComponente()
        dc.situacionAmbiental = situacionA
        dc.desechos = desecho

        try{
            dc.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al guardar desechoComponente")
        }
    }

    def cargarEditorDesechos_ajax (){
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def componente = ComponenteAmbiental.get(3)
        def situacionDesechos = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)
        def desechos =DesechoComponente.findAllBySituacionAmbiental(situacionDesechos)
        println("desechos " + desechos)
        def arr = ''
        def lis = desechos.each { p->
            arr += ('<li>' + p?.desechos?.descripcion + '</li>')
        }

        def texto
        if(situacionDesechos?.descripcion){
            texto = situacionDesechos?.descripcion
        }else{
            texto = "La Estación de Servicios ${pre?.estacion?.nombre} genera dos tipos de desechos. " +
                    "Los desechos comunes, y desechos especiales o peligrosos." +
                    "<br> En el caso de los desechos comunes, se recogen en recipientes que separan los desechos dependiendo de su naturaleza " +
                    "(orgánico o inorgánico)." +
                    "<br> Posteriormente se entregan al gestor municipal en los horarios y recorridos establecidos para " +
                    "la recolección de desechos." +
                    "<br> Los desechos especiales por otro lado, " +
                    "se entregan a gestores ambientales calificados en el Ministerio de Medio Ambiente. " +
                    "<br> Los desechos peligrosos generados en la Estación son:" +
                    "<br> <ul> ${arr} </ul>"
        }
        return[pre: pre, texto: texto]
    }

    def guardarTextoDesechos_ajax (){
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def detalleAuditoria = DetalleAuditoria.findByAuditoria(audi)
        def componente = ComponenteAmbiental.get(3)
        def situacionDesechos = SituacionAmbiental.findByDetalleAuditoriaAndComponenteAmbiental(detalleAuditoria, componente)
        situacionDesechos.descripcion = params.descripcion

        try{
            situacionDesechos.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al guardar el texto del editor desechos " + situacionDesechos.errors)
        }
    }

    def completar_ajax () {
        def pre = Preauditoria.get(params.id)
        def audi = Auditoria.findByPreauditoria(pre)
        def objetivo =  Objetivo.findByIdentificador('Situación Ambiental')
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
