package Seguridad

import auditoria.Preauditoria
import evaluacion.Anexo

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


    def descargarManual() {
        session.key = null
        def path = servletContext.getRealPath("/") + "anexos/Manual de Usuario-Sada.pdf"
        def nombre = 'Manual de Usuario-Sada.pdf'
        def tipo = nombre.split("\\.")
//        println("tipo " + tipo)
        tipo = tipo[1]
        switch (tipo) {
            case "jpeg":
            case "gif":
            case "jpg":
            case "bmp":
            case "png":
                tipo = "application/image"
                break;
            case "pdf":
                tipo = "application/pdf"
                break;
            case "doc":
            case "docx":
            case "odt":
                tipo = "application/msword"
                break;
            case "xls":
            case "xlsx":
                tipo = "application/vnd.ms-excel"
                break;
            default:
                tipo = "application/pdf"
                break;
        }
        try {
            def file = new File(path)
            def b = file.getBytes()
            response.setContentType(tipo)
            response.setHeader("Content-disposition", "attachment; filename=" + (nombre))
            response.setContentLength(b.length)
            response.getOutputStream().write(b)
        } catch (e) {
            response.sendError(404)
        }
    }


}
