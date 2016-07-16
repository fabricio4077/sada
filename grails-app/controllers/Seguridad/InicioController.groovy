package Seguridad

import auditoria.Preauditoria

class InicioController extends Shield {

    def inicio() {
        redirect(action: "index")
    }

    def index() {
        def usuario = session.usuario.apellido + "_" + session.usuario.login + "_" + session.perfil.codigo
        def auditorias = Preauditoria.findAllByCreadorAndEstadoAndEstacionIsNotNullAndAvanceLessThan(usuario, 1,100, [sort: 'estacion.nombre', order: 'desc', max: 5])
        println("auditorias " + auditorias)
        return [auditorias: auditorias]
    }
}
