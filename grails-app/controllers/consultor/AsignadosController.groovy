package consultor

import Seguridad.Persona
import auditoria.Preauditoria


class AsignadosController extends Seguridad.Shield {

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
            def c = Asignados.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Asignados.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def asignadosInstanceList = getLista(params, false)
        def asignadosInstanceCount = getLista(params, true).size()
        if (asignadosInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        asignadosInstanceList = getLista(params, false)
        return [asignadosInstanceList: asignadosInstanceList, asignadosInstanceCount: asignadosInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def asignadosInstance = Asignados.get(params.id)
            if (!asignadosInstance) {
                notFound_ajax()
                return
            }
            return [asignadosInstance: asignadosInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def asignadosInstance = new Asignados(params)
        if (params.id) {
            asignadosInstance = Asignados.get(params.id)
            if (!asignadosInstance) {
                notFound_ajax()
                return
            }
        }
        return [asignadosInstance: asignadosInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def asignadosInstance = new Asignados()
        if (params.id) {
            asignadosInstance = Asignados.get(params.id)
            if (!asignadosInstance) {
                notFound_ajax()
                return
            }
        } //update
        asignadosInstance.properties = params
        if (!asignadosInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Asignados."
            msg += renderErrors(bean: asignadosInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Asignados exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def asignadosInstance = Asignados.get(params.id)
            if (asignadosInstance) {
                try {
                    asignadosInstance.delete(flush: true)
                    render "OK_Eliminación de Asignados exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Asignados."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Asignados."
    } //notFound para ajax

    def cargarCoordinador_ajax() {

        def pre = Preauditoria.get(params.id)

        def coordinador = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona {
                eq("cargo", "Coordinador")
            }
        }

        return[coordinador: coordinador, pre: pre]
    }

    def cargarBiologo_ajax () {

        def pre = Preauditoria.get(params.id)

        def biologo = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona {
                eq("cargo", "Biologo")
            }

        }

        return [biologo: biologo, pre: pre]
    }

    def tablaBiologos_ajax () {

        def pre = Preauditoria.get(params.id)

        def listaBiologos = Persona.findAllByCargo("Biologo")

        return [listaBio: listaBiologos, pre: pre]

    }

    def listaBiologos_ajax () {

        def pre = Preauditoria.get(params.id)

        def listaBiologos = Persona.findAllByCargo("Biologo")

        return [listaBiologos: listaBiologos, pre: pre]
    }

    def cargarEspecialista_ajax () {

        def pre = Preauditoria.get(params.id)

        def especialista = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona {
                eq("cargo", "Especialista")
            }
        }

       return [especialista: especialista, pre: pre]
    }



    def asignarBiologo_ajax () {

//        println("params asignar b " + params)

        def pre = Preauditoria.get(params.id)
        def bio = Persona.get(params.biologo)

        def biologo = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona {
                eq("cargo", "Biologo")
            }
        }

        if(biologo.size() > 0){
            biologo.last().delete(flush: true)
        }

        def asignado = new Asignados()

        asignado.preauditoria = pre
        asignado.persona = bio
        try{
            asignado.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al asignar biologo " + asignado.errors)
        }
    }

    //Coordinador

    def tablaCoordinadores_ajax (){
        def pre = Preauditoria.get(params.id)
        def listaCoordinadores = Persona.findAllByCargo("Coordinador")
        return [listaCoordinadores: listaCoordinadores, pre: pre]
    }

    def listaCoordinadores_ajax(){
        def pre = Preauditoria.get(params.id)
        def listaCoordinadores = Persona.findAllByCargo("Coordinador")
        return [listaCoordinadores: listaCoordinadores, pre: pre]
    }

    def asignarCoordinador_ajax() {

//        println("params asignar c " + params)

        def pre = Preauditoria.get(params.id)
        def coor = Persona.get(params.coordinador)

        def coordinador = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona {
                eq("cargo", "Coordinador")
            }
        }

        if(coordinador.size() > 0){
            coordinador.last().delete(flush: true)
        }

        def asignado = new Asignados()

        asignado.preauditoria = pre
        asignado.persona = coor
        try{
            asignado.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al asignar coordinador " + asignado.errors)
        }
    }

    //Especialista

    def tablaEspecialistas_ajax() {

        def pre = Preauditoria.get(params.id)
        def listaEspecialistas = Persona.findAllByCargo("Especialista")

        return [listaEspe: listaEspecialistas, pre: pre]
    }

    def listaEspecialistas_ajax () {

        def pre = Preauditoria.get(params.id)
        def listaEspecialistas = Persona.findAllByCargo("Especialista")

        return [listaEspe: listaEspecialistas, pre: pre]
    }

    def asignarEspecialista_ajax () {

//        println("params asignar e " + params)

        def pre = Preauditoria.get(params.id)
        def espe = Persona.get(params.especialista)

        def especialista = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona {
                eq("cargo", "Especialista")
            }
        }

        if(especialista.size() > 0){
            especialista.last().delete(flush: true)
        }

        def asignado = new Asignados()

        asignado.preauditoria = pre
        asignado.persona = espe
        try{
            asignado.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al asignar especialista " + asignado.errors)
        }
    }

    def guardarEspe_ajax () {

//        println("parmas guardar espe " + params)

        def pre = Preauditoria.get(params.id)
        def usuario = Persona.get(session.usuario.id)

        def asignado
        def especialista = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona {
                eq("cargo", "Especialista")
            }
        }

        if(especialista.size() > 0){
            render "no"
        }else{
            asignado = new Asignados()
            asignado.preauditoria = pre
            asignado.persona = usuario

            try{
                asignado.save(flush: true)
                println("guardado especialista auditor")
            }catch (e){
                println("error al guardar el especialista auditor")
            }

            render "ok"

        }

   }

    def revisar_ajax () {

        def pre = Preauditoria.get(params.id)
        def asignados = Asignados.findAllByPreauditoria(pre)

        if(asignados.size() == 3){
            render "ok"
        }else{
            render "no"
        }
    }


}
