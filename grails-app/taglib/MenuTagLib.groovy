
class MenuTagLib {


    static namespace = 'mn'

    def stickyFooter = { attrs ->
        def html = ""
        html += "<footer class='footer3'>"
        html += "<div class='container text-center'>"
        html += "<strong>Desarrollado por: Fabricio Grijalva C.</strong>"
        html += "</div>"
        html += "</footer>"
        out << html
    }
    def stickyFooter2 = { attrs ->
        def html = ""
        html += "<footer class='footer2'>"
        html += "<div class='container text-center'>"
        html += "<div class='row'>"
        html += "<div class='col-md-5 col-md-offset-3'>"
        html += "<strong>Sistema de auditoría ambiental</strong>"
//        html += "<img src='${resource(dir: 'images/inicio', file: 'branch_1.png')}'/>"
        html += "<img src='${resource(dir: 'images/inicio', file: 'logo_sada3.png')}'/>"
//        html += "<img src='${resource(dir: 'images/inicio', file: 'branch_2.png')}'/>"
        html += "</div>"
        html += "</footer>"
        out << html
    }

    def bannerTop = { attrs ->

        def large = attrs.large ? "banner-top-lg" : ""

        def html = ""
//        html += "<div class='banner-top ${large}'>"
//        html += "<div class='banner-esquina'>"
//        html += "</div>"
//        html += "<div class='banner-title' style='margin-top:10px; margin-left: 20px; font-size: 22px'>" +
//                "Sistema de Auditoría y Monitoreo \n" +
//                "Medio ambiental para estaciones de servicio de \n" +
//                "comercialización de combustibles" +
//                "<img src='${resource(dir: 'images/inicio', file: 'logo_sada2.png')}'/></div>"
//        html += "<div class='banner-page-title' style='margin-top:12px; margin-bottom: 10px; text-align: center;'><strong>${attrs.title ?: '' }</strong></div>"

        if(large != ""){
            html += "<div class='banner-logo hidden-xs hidden-sm'>"
            html += "</div>"
            html += "<div class='banner-esquina der'>"
            html += "</div>"

            html += "<div class='banner-top ${large}'>"
            html += "<div class='banner-esquina'>"
            html += "</div>"
//            html += "<div class='banner-title' style='margin-top:15px; margin-left: 20px; font-size: 20px'>" +
//                    "Sistema de Auditoría y Monitoreo \n" +
//                    "Medio ambiental para estaciones de \n" +
//                    "comercialización de combustibles" +
//                    "</div>"
            html += "<div class='banner-page-title' style='margin-top:12px; margin-bottom: 10px; text-align: center;'><strong>${attrs.title ?: '' }</strong></div>"

        }else{

            html += "<div class='banner-top ${large}'>"
//            html += "<div class='banner-esquina'>"
//            html += "</div>"
            html += "<div class='col-md-3 banner-title' style='margin-top:10px; margin-left: 20px; font-size: 10px'>" +
                    "</div>"
//                    "<img src='${resource(dir: 'images/inicio', file: 'logo_sada2.png')}' style='float: right'/></div>"
            html += "<div class='col-md-6 banner-page-title' style='margin-top:12px; margin-bottom: 10px; text-align: center;'><strong>${attrs.title ?: '' }</strong></div>"

        }

//        if (large != "") {
//            html += "<div class='banner-logo hidden-xs hidden-sm'>"
//            html += "</div>"
//            html += "<div class='banner-esquina der'>"
//            html += "</div>"
//        } else {
//            html += "<div class='banner-search'>"
//            html += "<div class='input-group input-group-sm'>"
//            html += "</div><!-- /input-group -->"
//            html += "</div>"
//        }
        html += "</div>"

        out << html
    }

    //menu original que funciona con permisos y perfiles

//    def menu = { attrs ->
//
//        def items = [:]
//        def usuario, perfil, dpto
//        if (session.usuario) {
//            usuario = session.usuario
//            perfil = session.perfil
//            dpto = session.departamento
//        }
//        def strItems = ""
//        if (!attrs.title) {
//            attrs.title = "Vesta"
//        }
////        attrs.title = attrs.title.toUpperCase()
//        if (usuario) {
//            def acciones = Prms.findAllByPerfil(perfil).accion.sort { it.modulo.orden }
//
//            acciones.each { ac ->
//                if(ac.modulo.nombre != "noAsignado"){
//                    if (ac.tipo.id == 1) {
//                        if (!items[ac.modulo.nombre]) {
//                            items.put(ac.modulo.nombre, [ac.descripcion, g.createLink(controller: ac.control.nombre, action: ac.nombre)])
//                        } else {
//                            items[ac.modulo.nombre].add(ac.descripcion)
//                            items[ac.modulo.nombre].add(g.createLink(controller: ac.control.nombre, action: ac.nombre))
//                        }
//                    }
//                }
//            }
//            items.each { item ->
//                for (int i = 0; i < item.value.size(); i += 2) {
//                    for (int j = 2; j < item.value.size() - 1; j += 2) {
//                        def val = item.value[i].trim().compareTo(item.value[j].trim())
//                        if (val > 0 && i < j) {
//                            def tmp = [item.value[j], item.value[j + 1]]
//                            item.value[j] = item.value[i]
//                            item.value[j + 1] = item.value[i + 1]
//                            item.value[i] = tmp[0]
//                            item.value[i + 1] = tmp[1]
//                        }
//                    }
//                }
//            }
//        } else {
//            items = ["Inicio": ["Prueba", "linkPrueba", "Test", "linkTest"]]
//        }
//
//        items.each { item ->
//            strItems += '<li class="dropdown">'
//            strItems += '<a href="#" class="dropdown-toggle" data-toggle="dropdown">' + item.key + '<b class="caret"></b></a>'
//            strItems += '<ul class="dropdown-menu">'
//
//            (item.value.size() / 2).toInteger().times {
//                strItems += '<li><a href="' + item.value[it * 2 + 1] + '">' + item.value[it * 2] + '</a></li>'
//            }
//            strItems += '</ul>'
//            strItems += '</li>'
//        }
//
////        def alertas = "("
////        def count = Alerta.countByPersonaAndFechaRecibidoIsNull(usuario)
////        alertas += count
////        alertas += ")"
//
//        def html = "<nav class=\"navbar navbar-default navbar-fixed-top\" role=\"navigation\">"
//
//        html += "<div class=\"container-fluid\">"
//
//        // Brand and toggle get grouped for better mobile display
//        html += '<div class="navbar-header">'
//        html += '<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">'
//        html += '<span class="sr-only">Toggle navigation</span>'
//        html += '<span class="icon-bar"></span>'
//        html += '<span class="icon-bar"></span>'
//        html += '<span class="icon-bar"></span>'
//        html += '</button>'
//        html += '<a class="navbar-brand navbar-logo" href="#"><img src="' + resource(dir: 'images/barras', file: 'logo-menu.png') + '" /></a>'
//        html += '</div>'
//
//        // Collect the nav links, forms, and other content for toggling
//        html += '<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">'
//        html += '<ul class="nav navbar-nav">'
//        html += strItems
//        html += '</ul>'
//
//        html += '<ul class="nav navbar-nav navbar-right">'
////        html += '<li><a href="' + g.createLink(controller: 'alerta', action: 'list') + '" ' + ((count > 0) ? ' style="color:#ab623a" class="annoying"' : "") + '><i class="fa fa-exclamation-triangle"></i> Alertas ' + alertas + '</a></li>'
//        html += '<li class="dropdown">'
//        html += '<a href="#" class="dropdown-toggle" data-toggle="dropdown">' + usuario?.login + ' (' + session?.perfil + ')' + ' <b class="caret"></b></a>'
//        html += '<ul class="dropdown-menu">'
//        html += '<li><a href="' + g.createLink(controller: 'persona', action: 'personal') + '"><i class="fa fa-cogs"></i> Configuración</a></li>'
//        html += '<li class="divider"></li>'
//        html += '<li><a href="' + g.createLink(controller: 'login', action: 'logout') + '"><i class="fa fa-power-off"></i> Salir</a></li>'
//        html += '</ul>'
//        html += '</li>'
//        html += '</ul>'
//
//        html += '</div><!-- /.navbar-collapse -->'
//
//        html += "</div>"
//
//        html += "</nav>"
//
//        out << html
//    }


    //menu individual solo con perfiles

    def menu = { attrs ->

        def items = [:]
        def usuario, perfil
        if (session.usuario) {
            usuario = session.usuario
            perfil = session.perfil
        }

        def strItems = ""
        if (!attrs.title) {
            attrs.title = "SADA"
        }
        if (usuario) {

                if(perfil?.codigo ==  'ADMI'){

                items = ["<i class=\"fa fa-info\"></i> Inicio": ["Inicio", "${createLink(controller: 'inicio', action: 'index')}", "Manual de usuario", "${createLink(controller: 'inicio', action: 'descargarManual')}"],
                         "<i class=\"fa fa-gear\"></i> Administración": ["<i class=\"fa fa-group\"></i> Usuarios", "${createLink(controller: 'persona', action: 'list')}",
                                            "<i class=\"fa fa-gears\"></i> Parámetros", "${createLink(controller: 'tipo', action: 'parametros')}"],
                         "<i class=\"fa fa-bank\"></i> Marco Legal": ["<i class=\"fa fa-legal\"></i> Leyes","${createLink(controller: 'marcoLegal', action: 'arbolLegal')}"],
//                         "<i class=\"fa fa-book\"></i> Metodología": ["Metodología","${createLink(controller: 'metodologia', action: 'list')}"],
                         "<i class=\"fa fa-leaf\"></i> Auditoría": ["<i class=\"fa fa-plus\"></i> Iniciar una Auditoría","${createLink(controller: 'preauditoria', action: 'crearAuditoria')}", " <i class=\"fa fa-history\"></i> Continuar una Auditoría", "${createLink(controller: 'preauditoria', action: 'list')}",
                                       "<i class=\"fa fa-navicon\"></i> Listar Auditorías", "${createLink(controller: 'preauditoria', action: 'listaGeneral')}"]]

                }
                if(perfil?.codigo == 'AUDI'){

                    items = ["<i class=\"fa fa-info\"></i> Inicio": ["Inicio", "${createLink(controller: 'inicio', action: 'index')}", "Manual de usuario", "${createLink(controller: 'inicio', action: 'descargarManual')}"],
                             "<i class=\"fa fa-bank\"></i> Marco Legal": ["<i class=\"fa fa-legal\"></i> Leyes","${createLink(controller: 'marcoLegal', action: 'arbolLegal')}"],
//                             "<i class=\"fa fa-book\"></i> Metodología": ["Metodología","${createLink(controller: 'metodologia', action: 'list')}"],
                             "<i class=\"fa fa-leaf\"></i> Auditoría": ["<i class=\"fa fa-plus\"></i> Iniciar una Auditoría","${createLink(controller: 'preauditoria', action: 'crearAuditoria')}", " <i class=\"fa fa-history\"></i> Continuar una Auditoría", "${createLink(controller: 'preauditoria', action: 'list')}"
                                           ]]

                }
                if(perfil?.codigo == 'ESTA'){

                }

        } else {
            items = ["Inicio": ["Prueba", "linkPrueba", "Test", "linkTest"]]

        }

        items.each { item ->
            strItems += '<li class="dropdown">'
            strItems += '<a href="#" class="dropdown-toggle" data-toggle="dropdown">' + item.key + '<b class="caret"></b></a>'
            strItems += '<ul class="dropdown-menu">'

            (item.value.size() / 2).toInteger().times {
                strItems += '<li><a href="' + item.value[it * 2 + 1] + '">' + item.value[it * 2] + '</a></li>'
            }
            strItems += '</ul>'
            strItems += '</li>'
        }

        def html = "<nav class=\"navbar navbar-default navbar-prb affix\" role=\"navigation\" >"

        html += "<div class=\"container-fluid\">"

        // Brand and toggle get grouped for better mobile display
        html += '<div class="navbar-header affix">'
        html += '<button type="button" class="navbar-toggle" data-toggle="collapse" id="bs-example-navbar-collapse-1">'
//        html += '<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">'
        html += '<span class="sr-only">Toggle navigation</span>'
        html += '<span class="icon-bar"></span>'
        html += '<span class="icon-bar"></span>'
        html += '<span class="icon-bar"></span>'
        html += '</button>'
//        html += '<a class="navbar-brand navbar-logo" href="#"><img src="' + resource(dir: 'images/inicio', file: 'log_menu_s.png') + '" /></a>'
        html += '</div>'

        // Collect the nav links, forms, and other content for toggling
        html += '<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">'
//        html += '<div class="collapse navbar-collapse navbar-ex1-collapse">'
        html += '<ul class="nav navbar-nav">'
//        html += '<ul class="nav navbar-nav navbar-right">'
        html += strItems
        html += '</ul>'

        html += '<ul class="nav navbar-nav navbar-right">'
        html += '<li class="dropdown">'
        html += '<a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user text-success"></i> ' + usuario?.login + ' (' + session?.perfil?.nombre + ')' + ' <b class="caret"></b></a>'
        html += '<ul class="dropdown-menu">'
        html += '<li><a href="' + g.createLink(controller: 'persona', action: 'personal') + '"><i class="fa fa-cogs"></i> Configuración</a></li>'
        html += '<li class="divider"></li>'
        html += '<li><a href="' + g.createLink(controller: 'login', action: 'logout') + '"><i class="fa fa-power-off"></i> Salir</a></li>'
        html += '</ul>'
        html += '</li>'
        html += '</ul>'

        html += '</div><!-- /.navbar-collapse -->'

        html += "</div>"

        html += "</nav>"


        out << html
    }


    def menuObjetivos = { attrs ->

        def items = [:]
        def usuario, perfil
        if (session.usuario) {
            usuario = session.usuario
            perfil = session.perfil
        }

        def strItems = ""
        if (!attrs.title) {
            attrs.title = "SADA"
        }
        if (usuario) {

            if(perfil?.codigo ==  'ADMI'){

                items = ["<i class=\"fa fa-info\"></i> Inicio": ["Inicio", "${createLink(controller: 'inicio', action: 'index')}", "Manual de usuario", "linkTest"],
                         "<i class=\"fa fa-gear\"></i> Administración": ["<i class=\"fa fa-group\"></i> Usuarios", "${createLink(controller: 'persona', action: 'list')}",
                                                                         "<i class=\"fa fa-gears\"></i> Parámetros", "${createLink(controller: 'tipo', action: 'parametros')}"],
                         "<i class=\"fa fa-bank\"></i> Marco Legal": ["<i class=\"fa fa-legal\"></i> Leyes","${createLink(controller: 'marcoLegal', action: 'arbolLegal')}"],
//                         "<i class=\"fa fa-book\"></i> Metodología": ["Metodología","${createLink(controller: 'metodologia', action: 'list')}"],
                         "<i class=\"fa fa-leaf\"></i> Auditoría": ["<i class=\"fa fa-plus\"></i> Iniciar una Auditoría","${createLink(controller: 'preauditoria', action: 'crearAuditoria')}", " <i class=\"fa fa-history\"></i> Continuar una Auditoría", "${createLink(controller: 'preauditoria', action: 'list')}",
                                                                    "<i class=\"fa fa-navicon\"></i> Listar Auditorías", "${createLink(controller: 'preauditoria', action: 'listaGeneral')}"],
                "<i class=\"fa fa-check\"></i> Objetivos": ["<i class=\"fa fa-plus\"></i> Áreas de la Estación","${createLink(controller: 'preauditoria', action: 'crearAuditoria')}", " <i class=\"fa fa-history\"></i> Continuar una Auditoría", "${createLink(controller: 'preauditoria', action: 'list')}",
                                                           "<i class=\"fa fa-navicon\"></i> Listar Auditorías", "${createLink(controller: 'preauditoria', action: 'listaGeneral')}"]]

            }
            if(perfil?.codigo == 'AUDI'){

                items = ["<i class=\"fa fa-info\"></i> Inicio": ["Inicio", "${createLink(controller: 'inicio', action: 'index')}", "Manual de usuario", "linkTest"],
                         "<i class=\"fa fa-bank\"></i> Marco Legal": ["<i class=\"fa fa-legal\"></i> Leyes","${createLink(controller: 'marcoLegal', action: 'arbolLegal')}"],
//                             "<i class=\"fa fa-book\"></i> Metodología": ["Metodología","${createLink(controller: 'metodologia', action: 'list')}"],
                         "<i class=\"fa fa-leaf\"></i> Auditoría": ["<i class=\"fa fa-plus\"></i> Iniciar una Auditoría","${createLink(controller: 'preauditoria', action: 'crearAuditoria')}", " <i class=\"fa fa-history\"></i> Continuar una Auditoría", "${createLink(controller: 'preauditoria', action: 'list')}"
                         ]]

            }
            if(perfil?.codigo == 'ESTA'){

            }

        } else {
            items = ["Inicio": ["Prueba", "linkPrueba", "Test", "linkTest"]]

        }

        items.each { item ->
            strItems += '<li class="dropdown">'
            strItems += '<a href="#" class="dropdown-toggle" data-toggle="dropdown">' + item.key + '<b class="caret"></b></a>'
            strItems += '<ul class="dropdown-menu">'

            (item.value.size() / 2).toInteger().times {
                strItems += '<li><a href="' + item.value[it * 2 + 1] + '">' + item.value[it * 2] + '</a></li>'
            }
            strItems += '</ul>'
            strItems += '</li>'
        }

        def html = "<nav class=\"navbar navbar-default navbar-prb affix\" role=\"navigation\" >"

        html += "<div class=\"container-fluid\">"

        // Brand and toggle get grouped for better mobile display
        html += '<div class="navbar-header affix">'
        html += '<button type="button" class="navbar-toggle" data-toggle="collapse" id="bs-example-navbar-collapse-1">'
//        html += '<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">'
        html += '<span class="sr-only">Toggle navigation</span>'
        html += '<span class="icon-bar"></span>'
        html += '<span class="icon-bar"></span>'
        html += '<span class="icon-bar"></span>'
        html += '</button>'
//        html += '<a class="navbar-brand navbar-logo" href="#"><img src="' + resource(dir: 'images/inicio', file: 'log_menu_s.png') + '" /></a>'
        html += '</div>'

        // Collect the nav links, forms, and other content for toggling
        html += '<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">'
//        html += '<div class="collapse navbar-collapse navbar-ex1-collapse">'
        html += '<ul class="nav navbar-nav">'
//        html += '<ul class="nav navbar-nav navbar-right">'
        html += strItems
        html += '</ul>'

        html += '<ul class="nav navbar-nav navbar-right">'
        html += '<li class="dropdown">'
        html += '<a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user text-success"></i> ' + usuario?.login + ' (' + session?.perfil?.nombre + ')' + ' <b class="caret"></b></a>'
        html += '<ul class="dropdown-menu">'
        html += '<li><a href="' + g.createLink(controller: 'persona', action: 'personal') + '"><i class="fa fa-cogs"></i> Configuración</a></li>'
        html += '<li class="divider"></li>'
        html += '<li><a href="' + g.createLink(controller: 'login', action: 'logout') + '"><i class="fa fa-power-off"></i> Salir</a></li>'
        html += '</ul>'
        html += '</li>'
        html += '</ul>'

        html += '</div><!-- /.navbar-collapse -->'

        html += "</div>"

        html += "</nav>"


        out << html
    }


}
