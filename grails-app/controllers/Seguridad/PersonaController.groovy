package Seguridad

import auditoria.Preauditoria


class PersonaController extends Shield {

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
            def c = Persona.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Persona.list(params)
        }
        return lista
    }

    def list() {

        if (session.perfil.codigo == 'ADMI') {

            params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
            def personaInstanceList = getLista(params, false)
            def personaInstanceCount = getLista(params, true).size()
            if (personaInstanceList.size() == 0 && params.offset && params.max) {
                params.offset = params.offset - params.max
            }
            personaInstanceList = getLista(params, false)
            return [personaInstanceList: personaInstanceList, personaInstanceCount: personaInstanceCount, params: params]

        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su perfil."
            response.sendError(403)
        }

    } //list

    def show_ajax() {
        if (params.id) {
            def personaInstance = Persona.get(params.id)
            if (!personaInstance) {
                notFound_ajax()
                return
            }
            return [personaInstance: personaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def personaInstance = new Persona(params)
        def perfiles =[]
        if (params.id) {
            personaInstance = Persona.get(params.id)
            if (!personaInstance) {
                notFound_ajax()
                return
            }

            perfiles = Sesn.withCriteria {
                eq("usuario", personaInstance)
                perfil {
                    order("nombre", "asc")
                }
            }
        }

        return [personaInstance: personaInstance, perfiles: perfiles]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        println("params save persona " + params)


        def personaInstance = new Persona()
        if (params.id) {
            personaInstance = Persona.get(params.id)
            if (!personaInstance) {
                notFound_ajax()
                return
            }
        } //update
        personaInstance.properties = params
        personaInstance.password = params.password.encodeAsMD5()

        if (!personaInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Persona."
            msg += renderErrors(bean: personaInstance)
            render msg
            return
        }

        //perfiles

        def perfiles = params.perfiles
//        println params
//        println "PERFILES: " + perfiles
        if (perfiles) {
            def perfilesOld = Sesn.findAllByUsuario(personaInstance)
            def perfilesSelected = []
            def perfilesInsertar = []
            (perfiles.split("_")).each { perfId ->
                def perf = Prfl.get(perfId.toLong())
                if (!perfilesOld.perfil.id.contains(perf.id)) {
                    perfilesInsertar += perf
                } else {
                    perfilesSelected += perf
                }
            }
            def commons = perfilesOld.perfil.intersect(perfilesSelected)
            def perfilesDelete = perfilesOld.perfil.plus(perfilesSelected)
            perfilesDelete.removeAll(commons)

//            println "perfiles old      : " + perfilesOld
//            println "perfiles selected : " + perfilesSelected
//            println "perfiles insertar : " + perfilesInsertar
//            println "perfiles delete   : " + perfilesDelete

            def errores = ""

            perfilesInsertar.each { perfil ->
                def sesion = new Sesn()
                sesion.usuario = personaInstance
                sesion.perfil = perfil
                if (!sesion.save(flush: true)) {
                    errores += renderErrors(bean: sesion)
                    println "error al guardar sesion: " + sesion.errors
                }
            }
            perfilesDelete.each { perfil ->
                def sesion = Sesn.findAllByPerfilAndUsuario(perfil, personaInstance)
                try {
                    if (sesion.size() == 1) {
                        sesion.first().delete(flush: true)
                    } else {
                        errores += "Existen ${sesion.size()} registros del permiso " + perfil.nombre
                    }
                } catch (Exception e) {
                    errores += "Ha ocurrido un error al eliminar el perfil " + perfil.nombre
                    println "error al eliminar perfil: " + e
                }
            }
        }

        render "OK_${params.id ? 'Actualización' : 'Creación'} de usuario exitosa."
    } //save para grabar desde ajax







    def delete_ajax() {
        if (params.id) {
            def personaInstance = Persona.get(params.id)
            if (personaInstance) {
                def creador = personaInstance.apellido + "_" + personaInstance.login
                def auditorias = Preauditoria.findAllByCreadorAndEstado(creador,1)

                try {
                    if(auditorias){
                        render "NO_No se pudo eliminar al usuario."
                    }else{
                        def sesion = Sesn.findAllByUsuario(personaInstance)
                        sesion.each {s->
                            s.delete(flush: true)
                        }

                        personaInstance.delete(flush: true)
                        render "OK_Usuario eliminado correctamente."
                    }
                } catch (e) {
                    render "NO_No se pudo eliminar al usuario."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Persona."
    } //notFound para ajax

    def formBiologo_ajax() {

        def tipo

        if(params.tipo){
            tipo = params.tipo
        }

        return [tipo: tipo]
    }

    def guardarPersonal_ajax () {
//        println("params guardar personal " + params)

        def persona = new Persona()
        persona.nombre = params.nombre
        persona.apellido = params.apellido
        persona.telefono = params.telefono
        persona.mail = params.mail
        persona.activo = 1
        persona.cargo = params.cargo
        persona.titulo = params.titulo
        persona.password = null
        persona.login = null
        persona.consultora = null

        try {
            persona.save(flush: true)
            render "ok"
        }catch (e){
            println("Error al guardar personal" + persona.errors)
            render "no"
        }
    }

    //validación de login único

    def validar_unique_login_ajax() {
        params.login = params.login.toString().trim()
        if (params.id) {
            def obj = Persona.get(params.id)
            if (obj.login.toLowerCase() == params.login.toLowerCase()) {
                render true
                return
            } else {
                render Persona.countByLoginIlike(params.login) == 0
                return
            }
        } else {
            render Persona.countByLoginIlike(params.login) == 0
            return
        }
    }

    //validacion correo unico

    def validar_unique_mail_ajax() {
        params.mail = params.mail.toString().trim()
        if (params.id) {
            def obj = Persona.get(params.id)
            if (obj.mail.toLowerCase() == params.mail.toLowerCase()) {
                render true
                return
            } else {
                render Persona.countByMailIlike(params.mail) == 0
                return
            }
        } else {
            render Persona.countByMailIlike(params.mail) == 0
            return
        }
    }

    //asignacion de perfiles a las personas

    def perfiles_ajax() {

        def usuario =  Persona.get(params.id)
        def perfiles = Sesn.findAllByUsuario(usuario).perfil.id

        return[usuario: usuario, perfiles: perfiles]
    }

    //guardar perfiles

    def savePerfiles_ajax () {
//        println("params save perfiles" + params)

        def usuario = Persona.get(params.id)
        def perfilesUsuario = Sesn.findAllByUsuario(usuario).perfil.id
        def arrRemover = perfilesUsuario
        def arrAgregar = []
        def errores = ''

        params.perfil.each{ pid->
            if(perfilesUsuario.contains(pid)){
                arrRemover.remove(pid)
            }else{
                arrAgregar.add(pid)
            }
        }

//        println("agregar " + arrAgregar)
//        println("remover " + arrRemover)

            arrRemover.each { pid ->
            def perf = Prfl.get(pid)
            def sesn = Sesn.findByUsuarioAndPerfil(usuario, perf)
            try {
                sesn.delete(flush: true)
            } catch (e) {
               println("no se pudo borrar el perfil " + sesn.errors)
                errores += sesn.errors
            }
            }

            arrAgregar.each { pid ->
            def perf = Prfl.get(pid)
            def sesn = new Sesn([usuario: usuario, perfil: perf])
                    try{
                    sesn.save(flush: true)
                        println("perfil guardado correctamente ")
                    }catch (e){
                        println("no se pudo guardar el perfil " + sesn.errors)
                        errores += sesn.errors
                    }
                }

        if(errores == ''){
            render "ok"
        }else{
            render "no"
            println("errores " + errores)
        }
    }

    def personal () {

        def usuario = Persona.get(session.usuario.id)
        return [persona: usuario]
    }

    def validar_pass_ajax () {
            params.input2 = params.input2.trim()
            def obj = Persona.get(params.id)
            if (obj.password == params.input2.encodeAsMD5()) {
                render true
            } else {
                render false
            }
    }

    def updatePass() {
        def usu = Persona.get(session.usuario.id)

        def input = params.input2.toString().trim()
        if (input != "") {
            input = input.encodeAsMD5()
        }
        def valida = usu.password
        if (valida == null || valida.trim() == "") {
            valida = ""
        }

        if (input == valida) {
            if (params.nuevoPass.toString().trim() == params.passConfirm.toString().trim()) {
                usu.password = params.nuevoPass.toString().trim().encodeAsMD5()
                if (usu.save(flush: true)) {
                    render "SUCCESS*Password de ingreso al sistema modificado exitosamente"
                } else {
                    render "ERROR*" + renderErrors(bean: usu)
                }
            } else {
                render "ERROR*Password no concuerda"
            }
        } else {
            render "ERROR*Password de ingreso es incorrecto"
        }
    }

    def resetearPass_ajax () {
        println("params resetear " + params)
        def nuevoPass = '123'
        def usuario = Persona.get(params.id)
        usuario.password = nuevoPass.encodeAsMD5()
        try{
            usuario.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
        }
    }

}
