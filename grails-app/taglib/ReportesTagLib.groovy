import Seguridad.Persona
import auditoria.Preauditoria
import consultor.Asignados

/**
 * Tags para facilitar la creación de reportes (HTML -> PDF)
 */
class ReportesTagLib {


    static namespace = 'rep'

//    static defaultEncodeAs = [taglib: 'html']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]

    /**
     * genera los estilos básicos para los reportes según la orientación deseada
     */
    def estilos = { attrs ->

        def pags = false
        if (attrs.pags == 1 || attrs.pags == "1" || attrs.pags == "true" || attrs.pags == true || attrs.pags == "si") {
            pags = true
        }
        if (!pags && attrs.pagTitle) {
            pags = true
        }

        if (!attrs.orientacion) {
            attrs.orientacion = "p"
        }
        def pOrientacion = attrs.orientacion.toString().toLowerCase()
        def orientacion = "portrait"
        def margenes = [
                top   : 1.8,
                right : 2,
                bottom: 2,
                left  : 2
        ]
        switch (pOrientacion) {
            case "l":
            case "landscape":
            case "horizontal":
            case "h":
                orientacion = "landscape"
                break;
        }

        def css = "<style type='text/css'>"
        css += "* {\n" +
                "    font-family   : 'PT Sans Narrow';\n" +
                "    font-size     : 10pt;\n" +
                "}"
        css += " @page {\n" +
                "    size          : A4 ${orientacion};\n" +
                "    margin-top    : ${margenes.top}cm;\n" +
                "    margin-right  : ${margenes.right}cm;\n" +
                "    margin-bottom : ${margenes.bottom}cm;\n" +
                "    margin-left   : ${margenes.left}cm;\n" +
                "}"
        css += "@page {\n" +
                "    @top-right {\n" +
                "        content : element(header);\n" +
                "    }\n" +
                "}"
        css += "@page {\n" +
                "    @bottom-right {\n" +
                "        content : element(footer);\n" +
                "    }\n" +
                "}"
        if (pags) {
            css += "@page {\n" +
                    "    @bottom-left { \n" +
                    "        content     : '${attrs.pagTitle ?: ''} pág.' counter(page) ' de ' counter(pages);\n" +
                    "        font-family : 'PT Sans Narrow';\n" +
                    "        font-size   : 8pt;" +
                    "        font-style  : italic\n" +
                    "    }\n" +
                    "}"
        }
        css += "#header{\n" +
                "    width      : 100%;\n" +
                "    text-align : right;\n" +
                "    position   : running(header);\n" +
                "}"

        css += "#footer{\n" +
                "    text-align : right;\n" +
                "    position   : running(footer);\n" +
                "    color      : #7D807F;\n" +
                "}"
        css += "@page{\n" +
                "    orphans    : 4;\n" +
                "    widows     : 2;\n" +
                "}"
        css += "table {\n" +
//                "    page-break-inside : avoid;\n" +
                "}"
        css += ".table tr {\n" +
                "    page-break-inside : avoid;\n" +
                "}"
        css += ".no-break {\n" +
                "    page-break-inside : avoid;\n" +
                "}"
        css += ".tituloReporte{\n" +
                "    text-align     : center;\n" +
                "    text-transform : uppercase;\n" +
//                "    font-family    : 'PT Sans';\n" +
                "    font-size      : 18pt;\n" +
//                "    font-weight    : bold;\n" +
                "    color          : #17365D;\n" +
                "    border-bottom  : solid 2px #4F81BD;\n" +
                "}"
        css += ".tituloReporteSinLinea{\n" +
                "    text-align     : center;\n" +
                "    text-transform : uppercase;\n" +
//                "    font-family    : 'PT Sans';\n" +
                "    font-size      : 18pt;\n" +
                "    top : -10px;\n" +
//                "    font-weight    : bold;\n" +
                "    color          : #17365D;\n" +
                "}"
        css += ".tituloRprt{\n" +
                "    text-align     : center;\n" +
                "    text-transform : uppercase;\n" +
                "    font-size      : 20pt;\n" +
                "    color          : #17365D;\n" +
                "}"
        css += ".numeracion {\n" +
                "    margin-top     : 0.5cm;\n" +
                "    margin-bottom  : 0.5cm;\n" +
                "    font-size      : 12.5pt;\n" +
                "    font-family    : 'PT Sans';\n" +
                "    color          : white;\n" +
                "    text-align     : center;\n" +
                "}"
        css += ".numeracion table {\n" +
                "    border-collapse : collapse;\n" +
                "    border          : solid 1px #C0C0C0;" +
                "    margin-left     : auto;\n" +
                "    margin-right    : auto;\n" +
                "}"
        css += ".numeracion table td {\n" +
                "    padding : 5px;\n" +
                "}"
        css += ".fechaReporte{\n" +
                "    color          : #000;\n" +
                "    margin-bottom  : 5px;\n" +
                "}"
        css += "thead {\n" +
                "    display:  table-header-group;\n" +
                "}"
        css += "tbody {\n" +
                "    display:  table-row-group;\n" +
                "}"
        css += "</style>"

        out << raw(css)
    }


    def estilosNuevos = { attrs ->

        println("attrs " + attrs)

        def pags = true

        if (!attrs.orientacion) {
            attrs.orientacion = "p"
        }

        def pOrientacion = attrs.orientacion.toString().toLowerCase()
        def orientacion = "portrait"
        def margenes = [
                top   : 2.5,
                right : 2,
                bottom: 2.5,
                left  : 2
        ]
        switch (pOrientacion) {
            case "l":
            case "landscape":
            case "horizontal":
            case "h":
                orientacion = "landscape"
                break;
        }

        def css = "<style type='text/css'>"

        css += "* {\n" +
                "    font-family   : 'PT Sans Narrow';\n" +
                "    font-size     : 10pt;\n" +
                "}"
        css += " @page {\n" +
                "    size          : A4 ${orientacion};\n" +
                "    margin-top    : ${margenes.top}cm;\n" +
                "    margin-right  : ${margenes.right}cm;\n" +
                "    margin-bottom : ${margenes.bottom}cm;\n" +
                "    margin-left   : ${margenes.left}cm;\n" +
                "}"
        css += "@page {\n" +
                "    @top-right {\n" +
                "        content : element(header);\n" +
                "    }\n" +
                "}"
        css += "@page {\n" +
                "    @top-left {\n" +
                "        content : element(header2);\n" +
                "    }\n" +
                "}"
        css += "@page {\n" +
                "    @bottom-left {\n" +
                "        content : element(footer);\n" +
                "    }\n" +
                "}"

        if (pags) {
            css += "@page {\n" +
                    "counter-increment: page 3;\n" +
                    "    @bottom-right { \n" +
//                    "        content     : '${attrs.pagTitle ?: ''} Pág.' counter(page) ' de ' counter(pages);\n" +
//                    "        counter-increment: page;\n" +
//                    "        content     : 'Pág. ${attrs.pags} '  counter(page) ;\n" +
                    "        font-family : 'PT Sans Narrow';\n" +
                    "        font-size   : 8pt;" +
                    "        font-style  : italic\n" +
                    "    }\n" +
                    "        border-bottom  : solid 1px #4F81BD;\n" +
                    "}"
        }

        css += "#header{\n" +
                "    width      : 100%;\n" +
                "    text-align : right;\n" +
                "    position   : running(header);\n" +
                "}"

        css += "#header2{\n" +
                "    width      : 100%;\n" +
                "    text-align : left;\n" +
                "    position   : running(header2);\n" +
                "}"

        css += "#footer{\n" +
                "    text-align : left;\n" +
                "    position   : running(footer);\n" +
                "    color      : #7D807F;\n" +
                "}"
        css += "@page{\n" +
                "    orphans    : 4;\n" +
                "    widows     : 2;\n" +
                "}"

        css += "table {\n" +
                "    page-break-inside : avoid;\n" +
                "}"

        css += ".table tr {\n" +
                "    page-break-inside : avoid;\n" +
                "}"
        css += ".no-break {\n" +
                "    page-break-inside : avoid;\n" +
                "}"

        css += ".tituloReporte{\n" +
                "    text-align     : right;\n" +
                "    text-transform : uppercase;\n" +
                "    font-size      : 18pt;\n" +
                "    color          : #17365D;\n" +
                "    border-top  : solid 1px #4F81BD;\n" +
                "}"
        css += ".tituloReporteSinLinea{\n" +
                "    text-align     : center;\n" +
                "    text-transform : uppercase;\n" +
//                "    font-family    : 'PT Sans';\n" +
                "    font-size      : 18pt;\n" +
                "    top : -10px;\n" +
//                "    font-weight    : bold;\n" +
                "    color          : #17365D;\n" +
                "}"
        css += ".tituloRprt{\n" +
                "    text-align     : right;\n" +
                "    text-transform : uppercase;\n" +
                "    font-size      : 20pt;\n" +
                "    color          : #17365D;\n" +
                "}"
        css += ".numeracion {\n" +
                "    margin-top     : 0.5cm;\n" +
                "    margin-bottom  : 0.5cm;\n" +
                "    font-size      : 12.5pt;\n" +
                "    font-family    : 'PT Sans';\n" +
                "    color          : white;\n" +
                "    text-align     : center;\n" +
                "}"
        css += ".numeracion table {\n" +
                "    border-collapse : collapse;\n" +
                "    border          : solid 1px #C0C0C0;" +
                "    margin-left     : auto;\n" +
                "    margin-right    : auto;\n" +
                "}"
        css += ".numeracion table td {\n" +
                "    padding : 5px;\n" +
                "}"
        css += ".fechaReporte{\n" +
                "    color          : #000;\n" +
                "    margin-bottom  : 5px;\n" +
                "}"
        css += "thead {\n" +
                "    display:  table-header-group;\n" +
                "}"
        css += "tbody {\n" +
                "    display:  table-row-group;\n" +
                "}"

        css += "</style>"

        out << raw(css)
    }


    /**
     * Muestra el header para los reportes
     * @param title el título del reporte
     */
    def headerReporte = { attrs ->
        println("AQUI atributos headerReporte  " + attrs)
        def title = attrs.title ?: ""
        def titulo = attrs.titulo ?: ""
        def unidadEjecutora
        def unidadAutonoma

        if(!attrs.anio){
            attrs.anio = new Date().format("yyyy")
        }

//        println "attrs.title: ${attrs.title}, titulo: ${attrs.titulo}"

//        if(attrs.unidad){
//            unidadEjecutora= UnidadEjecutora.get(attrs.unidad.id)
//            unidadAutonoma = firmasService.requirentes(unidadEjecutora)
//        }

//        println "....3"

//        println("ue " + unidadEjecutora)
//        println("ua " + unidadAutonoma)
//        println("anio " + attrs.anio)




        def subtitulo = attrs.subtitulo ?: ""

        def estilo = attrs.estilo ?: "center"

        def form
//        if(attrs.title.contains("permanente")) {
//            form = attrs.form ?: 'GAF-001'
//        }  else {
//            form = attrs.form ?: 'GPE-DPI-01'
//        }

        def h = 55

        def logoPath = resource(dir: 'images/inicio', file: 'logo_sada2.png')
        def html = ""

        html += '<div id="header">' + "\n"
        html += "<img src='${logoPath}' style='height:${h}px;'/>" + "\n"
        html += '</div>' + "\n"

        html += "<div class='tituloRprt tituloReporteSinLinea'>"
        html += ""
        html += '</div>'

        if (titulo) {
            html += "<div class='tituloRprt'>"
            html += titulo
            html += '</div>'
        }
        if (title) {
            if (subtitulo == "") {
                html += "<div class='tituloReporte'>" + "\n"
            } else {
                html += "<div class='tituloReporteSinLinea'>" + "\n"
            }
            html += title + "\n"
            html += '</div>' + "\n"
            if (subtitulo != "") {
                html += "<div class='tituloRprt'>"
                html += subtitulo
                html += '</div>'
            }
        }
        if (titulo) {
            html += "<div class='tituloRprt'>"
            html += titulo
            html += '</div>'
        }

        if (attrs.unidad || attrs.numero != null) {
            html += "<div class='numeracion'>" + "\n"
            html += "<table border='1' ${estilo == 'right' ? 'style=\'float: right\'' : ''}>" + "\n"
            html += "<tr>" + "\n"
            html += "<td style='background: #0F243E;'>Form. ${form}</td>" + "\n"
            html += "<td style='background: #008080;'>Numeración:</td>" + "\n"
//            html += "<td style='background: #008080;'>${attrs.unidad ?: ''}</td>" + "\n"
            if(attrs.unidad.id)
            {
//                println "atrr: ${attrs.title.trim().toLowerCase()}"
                if(attrs.title.trim().toLowerCase() in ['aval de poa', 'reforma al poa']) {

                    html += "<td style='background: #008080;'></td>" + "\n"
                }
                if(attrs.title.trim().toLowerCase() in ['solicitud de reforma al poa', 'solicitud de aval de poa']) {
                    html += "<td style='background: #008080;'> </td>" + "\n"
                }

                if(attrs.title.trim().toLowerCase() in ['aval de poa de gasto permanente', 'ajuste al poa de gasto permanente', 'reforma al poa de gasto permanente']){
                    html += "<td style='background: #008080;'></td>" + "\n"
                }

                if(attrs.title.toLowerCase() in ['solicitud de aval de poa permanente', 'solicitud de reforma al poa de gasto permanente']) {
//                    if(direccionesGaf.contains(unidadEjecutora.codigo)){
                        html += "<td style='background: #008080;'></td>" + "\n"
//                    }else{
//                        html += "<td style='background: #008080;'>${attrs.anio}-${unidadAutonoma?.codigo}</td>" + "\n"
//                    }

                } else {
                }

            }else{
            }

            html += "<td style='background: #008080;'>No. ${attrs.numero != null ? attrs.numero.toString().padLeft(3, '0') : ''}</td>" + "\n"
            html += "</tr>" + "\n"
            html += "</table>" + "\n"
            html += "</div>" + "\n"
        }

        out << raw(html)
    }

    def headerReporteNuevo = { attrs ->
        println("AQUI atributos headerReporte  " + attrs)
        def title = attrs.title ?: ""
        def titulo = attrs.titulo ?: ""
        def logoConsultora
        def pre = Preauditoria.get(attrs.auditoria)
        def orden
        if(!attrs.anio){
            attrs.anio = new Date().format("yyyy")
        }

//        if(attrs.especialista){
//            logoConsultora = Persona.get(attrs.especialista).consultora.logotipo
//        }

        if(pre?.consultora?.logotipo){
            logoConsultora = pre?.consultora?.logotipo
        }


        if(attrs.orden){
           orden = attrs.orden
        }

//        println "attrs.title: ${attrs.title}, titulo: ${attrs.titulo}"

        def subtitulo = attrs.subtitulo ?: ""
        def estilo = attrs.estilo ?: "center"
        def form
        def h = 55
        def wi = 170

        def logoComer = Preauditoria.get(attrs.auditoria).estacion.comercializadora.logotipo

        def logoPath = resource(dir: 'images/logos', file: logoComer)
        def logoPathCon = resource(dir: 'images/logos', file: logoConsultora)
        def html = ""

        html += '<div id="header">' + "\n"
        html += "<img src='${logoPath}' style='height:${h}px; width:${wi}px'/>" + "\n"
        html += '</div>' + "\n"

        html += '<div id="header2">' + "\n"
        html += "<img src='${logoPathCon}' style='height:${h}px; width:${wi}px'/>" + "\n"
        html += '</div>' + "\n"

        html += "<div class='tituloRprt tituloReporteSinLinea'>"
        html += ''
        html += '</div>'

        if (titulo) {
            html += "<div class='tituloRprt'>"
            html += titulo
            html += '</div>'
        }
        if (title) {
            if (subtitulo == "") {
                html += "<div class='tituloReporte'>" + "\n"
            } else {
                html += "<div class='tituloReporteSinLinea'>" + "\n"
            }
            html += orden + ". " + title + "\n"
            html += '</div>' + "\n"
            if (subtitulo != "") {
                html += "<div class='tituloRprt'>"
                html += subtitulo
                html += '</div>'
            }
        }

        out << raw(html)
    }

    def footerReporteNuevo = { attrs ->
        def html = ""
        def auditoria = Preauditoria.get(attrs.auditoria)
        def mes = ''

        println("attrs " + attrs.mes + attrs.anio)

        if(attrs.mes == '1'){
            mes = 'Enero'
        }
        if(attrs.mes == '2'){
            mes = 'Febrero'
        }
        if(attrs.mes == '3'){
            mes = 'Marzo'
        }
        if(attrs.mes == '4'){
            mes = 'Abril'
        }
        if(attrs.mes == '5'){
            mes = 'Mayo'
        }
        if(attrs.mes == '6'){
            mes = 'Junio'
        }
        if(attrs.mes == '7'){
            mes = 'Julio'
        }
        if(attrs.mes == '8'){
            mes = 'Agosto'
        }
        if(attrs.mes == '9'){
            mes = 'Septiembre'
        }
        if(attrs.mes == '10'){
            mes = 'Octubre'
        }
        if(attrs.mes == '11'){
            mes = 'Noviembre'
        }
        if(attrs.mes == '12'){
            mes = 'Diciembre'
        }

        html += '<div id="footer">'
//        html += "<div class='fechaReporte' style='font-size: 8.5pt; margin-bottom: 15px;'>${new Date().format('MM-yyyy')}</div>"
        html += "<div style='font-size: 8pt;'>${mes + "-" + attrs.anio}</div>"
        html += "<div style='float:left; font-size:8pt;'>"
        html += "Auditoría Ambiental de ${auditoria?.tipo?.descripcion}<br/>"
        html += "E/S '${auditoria?.estacion?.nombre}' "
        html += "</div>"
        html += "</div>"

        out << raw(html)
    }

    /**
     * Muestra header y footer para los reportes
     */

    def headerFooterNuevo = { attrs ->
        println("header footer attr " + attrs)
        attrs.title = attrs.title ?: ""
        def header = headerReporteNuevo(attrs)
        def footer = footerReporteNuevo(attrs)

        out << header << footer
    }

    /**
     * genera los estilos alternos básicos para los reportes según la orientación deseada
     */
    def estilosAlt = { attrs ->

        def pags = false
        if (attrs.pags == 1 || attrs.pags == "1" || attrs.pags == "true" || attrs.pags == true || attrs.pags == "si") {
            pags = true
        }
        if (!pags && attrs.pagTitle) {
            pags = true
        }

        if (!attrs.orientacion) {
            attrs.orientacion = "p"
        }
        def pOrientacion = attrs.orientacion.toString().toLowerCase()
        def orientacion = "portrait"
        def margenes = [
                top   : 2.5,
                right : 2,
                bottom: 3,
                left  : 2
        ]
        switch (pOrientacion) {
            case "l":
            case "landscape":
            case "horizontal":
            case "h":
                orientacion = "landscape"
                break;
        }

        def css = "<style type='text/css'>"
        css += "* {\n" +
                "    font-family   : 'PT Sans Narrow';\n" +
                "    font-size     : 11pt;\n" +
                "}"
        css += " @page {\n" +
                "    size          : A4 ${orientacion};\n" +
                "    margin-top    : ${margenes.top}cm;\n" +
                "    margin-right  : ${margenes.right}cm;\n" +
                "    margin-bottom : ${margenes.bottom}cm;\n" +
                "    margin-left   : ${margenes.left}cm;\n" +
                "}"
        css += "@page {\n" +
                "    @top-left {\n" +
                "        content : element(header);\n" +
                "    }\n" +
                "    @top-center {\n" +
                "        content : element(headerInst);\n" +
                "    }\n" +
                "    @top-right {\n" +
                "        content : element(headerForm);\n" +
                "    }\n" +
                "}"
        css += "@page {\n" +
                "    @bottom-right {\n" +
                "        content : element(footer);\n" +
                "    }\n" +
                "}"
        if (pags) {
            css += "@page {\n" +
                    "    @bottom-left { \n" +
                    "        content     : '${attrs.pagTitle ?: ''} pág.' counter(page) ' de ' counter(pages);\n" +
                    "        font-family : 'PT Sans Narrow';\n" +
                    "        font-size   : 8pt;" +
                    "        font-style  : italic\n" +
                    "    }\n" +
                    "}"
        }
        css += "#header{\n" +
                "    position   : running(header);\n" +
                "}"
        css += "#headerInst{\n" +
                "    color       : #17375E;\n" +
                "    font-weight : bold;\n" +
                "    text-align  : center;\n" +
                "    position    : running(headerInst);\n" +
                "}"
        css += "#headerForm{\n" +
                "    color       : #4BACC6;\n" +
                "    font-weight : bold;\n" +
                "    text-align  : right;\n" +
                "    font-size   : 12pt;\n" +
                "    position    : running(headerForm);\n" +
                "}"
        css += "#footer{\n" +
                "    text-align : right;\n" +
                "    position   : running(footer);\n" +
                "    color      : #7D807F;\n" +
                "}"
        css += "@page{\n" +
                "    orphans    : 4;\n" +
                "    widows     : 2;\n" +
                "}"
        css += "table {\n" +
                "    page-break-inside : avoid;\n" +
                "}"
        css += ".no-break {\n" +
                "    page-break-inside : avoid;\n" +
                "}"
        css += ".tituloReporte{\n" +
                "    text-align     : center;\n" +
                "    text-transform : uppercase;\n" +
                "    font-size      : 13pt;\n" +
                "    font-weight    : bold;\n" +
                "    border         : solid 1px #000000;\n" +
                "    margin-top     : 5px;" +
                "    margin-bottom  : 5px;" +
                "}"
        css += ".tituloReporteSinLinea{\n" +
                "    text-align     : center;\n" +
                "    text-transform : uppercase;\n" +
                "    font-size      : 13pt;\n" +
                "    font-weight    : bold;\n" +
                "    margin-top     : 5px;" +
                "    margin-bottom  : 5px;" +
                "}"
        css += ".numeracion {\n" +
                "    margin-top     : 0px;\n" +
                "    margin-bottom  : 0px;\n" +
                "    font-family    : 'PT Sans';\n" +
                "    font-weight    : bold;\n" +
                "    color          : white;\n" +
                "    height         : 25px;\n" +
                "}"
        css += ".numeracion span {\n" +
                "    background : #17375E;" +
                "    padding    : 3px 5px 3px 5px;\n" +
                "    float      : right;\n" +
                "    color      : white;\n" +
                "    text-align : right;\n" +
                "}"

        css += "</style>"

        out << raw(css)
    }


}
