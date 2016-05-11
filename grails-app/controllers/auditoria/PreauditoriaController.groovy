package auditoria

import Seguridad.Persona
import complemento.ActiAudi
import consultor.Asignados
import estacion.Coordenadas
import estacion.Estacion
import tipo.Periodo
import tipo.Tipo


class PreauditoriaController extends Seguridad.Shield {

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
            def c = Preauditoria.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Preauditoria.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def preauditoriaInstanceList = getLista(params, false)
        def preauditoriaInstanceCount = getLista(params, true).size()
        if(preauditoriaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        preauditoriaInstanceList = getLista(params, false)

        def creador = session.usuario.apellido + "_" + session.usuario.login
        def listaAuditorias = Preauditoria.findAllByCreador(creador)

        return [preauditoriaInstanceList: preauditoriaInstanceList, preauditoriaInstanceCount: preauditoriaInstanceCount, params: params,
        lista: listaAuditorias]
    } //list


    def listaGeneral () {

            params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
            def preauditoriaInstanceList = getLista(params, false)
            def preauditoriaInstanceCount = getLista(params, true).size()
            if(preauditoriaInstanceList.size() == 0 && params.offset && params.max) {
                params.offset = params.offset - params.max
            }
            preauditoriaInstanceList = getLista(params, false)

            return [preauditoriaInstanceList: preauditoriaInstanceList, preauditoriaInstanceCount: preauditoriaInstanceCount, params: params]
           }

    def show_ajax() {
        if(params.id) {
            def preauditoriaInstance = Preauditoria.get(params.id)
            if(!preauditoriaInstance) {
                notFound_ajax()
                return
            }
            return [preauditoriaInstance: preauditoriaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def preauditoriaInstance = new Preauditoria(params)
        if(params.id) {
            preauditoriaInstance = Preauditoria.get(params.id)
            if(!preauditoriaInstance) {
                notFound_ajax()
                return
            }
        }
        return [preauditoriaInstance: preauditoriaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def preauditoriaInstance = new Preauditoria()
        if(params.id) {
            preauditoriaInstance = Preauditoria.get(params.id)
            if(!preauditoriaInstance) {
                notFound_ajax()
                return
            }
        } //update
        preauditoriaInstance.properties = params
        if(!preauditoriaInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Preauditoria."
            msg += renderErrors(bean: preauditoriaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Preauditoria exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def preauditoriaInstance = Preauditoria.get(params.id)
            if(preauditoriaInstance) {
                try {
                    preauditoriaInstance.delete(flush:true)
                    render "OK_Eliminación de Preauditoria exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Preauditoria."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Preauditoria."
    } //notFound para ajax

    def opciones_ajax () {

    }

    def crearAuditoria () {

//        println("parmas audi "  + params)

        def paso1 = Preauditoria.get(params.id)

        return [pre: paso1]

    }

    def guardarPaso1_ajax () {

        println("params paso 1 " + params)

        def creador = session.usuario.apellido + "_" + session.usuario.login
        def tipo = Tipo.get(params.tipo)
        def periodo = Periodo.get(params.periodo)

        def paso

        if(params.id){
            paso = Preauditoria.get(params.id)
            paso.tipo = tipo
            paso.periodo = periodo
            try{
                paso.save(flush: true)
                render "ok_${paso?.id}"
            }catch(e){
                render "no"
                println("error al guardar el paso 1 - crearAuditoria");
            }
        }else{
            paso = new Preauditoria()
            paso.tipo = tipo
            paso.periodo = periodo
            paso.fechaCreacion = new Date()
            paso.creador = creador
            try{
                paso.save(flush: true)
                render "ok_${paso?.id}"
            }catch(e){
                render "no"
                println("error al guardar el paso 1 - crearAuditoria");
            }
        }
    }

    def crearPaso2 () {

        def paso2 = Preauditoria.get(params.id)
        def estacion
        if(paso2?.estacion){
            estacion = paso2.estacion?.id
        }else{
            estacion = '0'
        }

        return [pre: paso2, idEstacion: estacion]
    }

    def crearPaso3 () {
//        println("params cp3" + params)

        def pre = Preauditoria.get(params.id)
        def estacion = params.estacion
        def coordenadas = Coordenadas.findAllByEstacion(pre?.estacion)

//        println("cc" + coordenadas)
        return [pre: pre, estacion: estacion, coor: coordenadas]
    }

    def guardarPaso2_ajax () {

        println("params paso 2 " + params)

        def  paso = Preauditoria.get(params.id)
        def estacion = Estacion.get(params.estacion)
        paso.estacion = estacion
            try{
                paso.save(flush: true)
                render "ok_${paso?.id}"
            }catch(e){
                render "no"
                println("error al guardar el paso 2 - crearAuditoria");
            }
    }

    def guardarCoordenadas_ajax () {

        println("params coordenadas " + params)

        def estacion = Preauditoria.get(params.id).estacion
        def coordenada

        if(params.idCor){
            coordenada = Coordenadas.get(params.idCor)
            coordenada.coordenadasX = params.enX.toDouble()
            coordenada.coordenadasY = params.enY.toDouble()
            try{
                coordenada.save(flush: true)
                render "ok"
            }catch(e){
                render "no"
                println("error al actualizar las coordenadas " + coordenada.errors)
            }

        }else{

            coordenada = new Coordenadas()
            coordenada.estacion = estacion
            coordenada.coordenadasX = params.enX.toDouble()
            coordenada.coordenadasY = params.enY.toDouble()
            try{
                coordenada.save(flush: true)
                render "ok"
            }catch(e){
                render "no"
                println("error al guardar las coordenadas " + coordenada.errors)
            }
        }
    }

    def crearPaso4 () {

        def pre = Preauditoria.get(params.id)
        def asignados = Asignados.findAllByPreauditoria(pre)

        def coordinador = Asignados.withCriteria {
                          eq("preauditoria",pre)
                            persona {
                           eq("cargo", "Coordinador")
                            }
        }

        def biologo = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona {
                eq("cargo", "Biologo")
            }
        }

        def especialista = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona {
                eq("cargo", "Especialista")
            }
        }

        def band = 0

        if(asignados.size() == 3){
            band = 1
        }

        def listaCoordinadores = Persona.findAllByCargo("Coordinador")
        def listaEspecialistas = Persona.findAllByCargo("Especialista")
        def listaBiologos = Persona.findAllByCargo("Biologo")

        return[pre: pre, asignados: asignados, coordinador: coordinador, biologo: biologo, band: band]

    }

    def crearPaso5 () {

        def pre = Preauditoria.get(params.id)
        def actividades = ActiAudi.findAllByPreauditoria(pre)

        return [pre: pre, actividades: actividades]
    }

    def fichaTecnica () {

        def pre = Preauditoria.get(params.id)
        def coordenadas = Coordenadas.findAllByEstacion(pre?.estacion)
        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def coordinador = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Coordinador"));
        def biologo = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Biologo"));

        return [pre: pre, coordenadas: coordenadas, especialista: especialista?.persona, coordinador: coordinador?.persona, biologo: biologo?.persona]

    }



}
