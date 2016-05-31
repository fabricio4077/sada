package Seguridad

class LoginController {

    def index() {
        redirect(action: 'login')
    }

    def validarSesion() {
        println "sesion creada el:" + new Date(session.getCreationTime()) + " hora actual: " + new Date()
        println "último acceso:" + new Date(session.getLastAccessedTime()) + " hora actual: " + new Date()

        println session.usuario
        if (session.usuario) {
            render "OK"
        } else {
            flash.message = "Su sesión ha caducado, por favor ingrese nuevamente."
            render "NO"
        }
    }

    def login() {
        def usu = session.usuario
        def cn = "inicio"
        def an = "index"
        if (usu) {
            if (session.cn && session.an) {
                cn = session.cn
                an = session.an
            }
            redirect(controller: cn, action: an)
        }
    }

    def validar() {
        println("params " + params)

        if (!params.user || !params.pass) {
            redirect(controller: "login", action: "login")
            return
        }
        def user = Persona.withCriteria {
            ilike("login", params.user)
            eq("activo", 1)
        }

        if (user.size() == 0) {
            flash.message = "No se ha encontrado el usuario"
            flash.tipo = "error"
            redirect(controller: 'login', action: "login")
            return
        } else if (user.size() > 1) {
            flash.message = "Ha ocurrido un error grave"
            flash.tipo = "error"
            redirect(controller: 'login', action: "login")
            return
        } else {
            user = user.first()
            session.usuario = user
            session.time = new Date()

            def perfiles = Sesn.findAllByUsuario(user)
            println("perfiles " + perfiles)
            if (perfiles.size() == 0) {
                flash.message = "No puede ingresar porque no tiene ningun perfil asignado a su usuario. Comuníquese con el administrador."
                flash.tipo = "error"
                flash.icon = "icon-warning"
                session.usuario = null
                redirect(controller: 'login', action: "login")
                return
            } else {
                if (params.pass.encodeAsMD5() != user.password) {
                    flash.message = "Contraseña incorrecta"
                    flash.tipo = "error"
                    flash.icon = "icon-warning"
                    session.usuario = null
                    redirect(controller: 'login', action: "login")
                    return
                }
            }

            if (perfiles.size() == 1) {
                doLogin(perfiles.first().perfil)
            } else {
                redirect(action: "perfiles")
                return
            }
        }
    }

    def doLogin(perfil) {
        session.perfil = perfil
            if (session.an && session.cn) {
                redirect(controller: session.cn, action: session.an, params: session.pr)
            } else {
                redirect(controller: "inicio", action: "index")
            }
    }

    def perfiles() {
        def usuarioLog = session.usuario
        def perfiles = Sesn.withCriteria {
            eq("usuario", usuarioLog)
            perfil {
                order("nombre", "asc")
            }
        }.perfil

        return [perfiles: perfiles]
    }

    def savePerfil() {
        if (!params.perfil) {
            redirect(controller: "inicio", action: "perfiles")
        }
        def perfil = Prfl.get(params.perfil)
        doLogin(perfil)
    }


    def logout() {
        session.usuario = null
        session.perfil = null
        session.permisos = null
        session.menu = null
        session.an = null
        session.cn = null
        session.invalidate()
        redirect(controller: 'login', action: 'login')
    }

    def finDeSesion() {

    }

}
