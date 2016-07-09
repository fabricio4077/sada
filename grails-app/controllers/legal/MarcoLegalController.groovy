package legal

import evaluacion.Evaluacion
import groovy.json.JsonBuilder


class MarcoLegalController extends Seguridad.Shield {

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
            def c = MarcoLegal.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = MarcoLegal.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def marcoLegalInstanceList = getLista(params, false)
        def marcoLegalInstanceCount = getLista(params, true).size()
        if (marcoLegalInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        marcoLegalInstanceList = getLista(params, false)
        return [marcoLegalInstanceList: marcoLegalInstanceList, marcoLegalInstanceCount: marcoLegalInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def marcoLegalInstance = MarcoLegal.get(params.id)
            if (!marcoLegalInstance) {
                notFound_ajax()
                return
            }
            return [marcoLegalInstance: marcoLegalInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def marcoLegalInstance = new MarcoLegal(params)
        if (params.id) {
            marcoLegalInstance = MarcoLegal.get(params.id)
            if (!marcoLegalInstance) {
                notFound_ajax()
                return
            }
        }
        return [marcoLegalInstance: marcoLegalInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def marcoLegalInstance = new MarcoLegal()
        if (params.id) {
            marcoLegalInstance = MarcoLegal.get(params.id)
            if (!marcoLegalInstance) {
                notFound_ajax()
                return
            }
        } //update
        marcoLegalInstance.properties = params
        marcoLegalInstance.creador = (session.usuario.apellido + "_" + session.usuario.login)
        if (!marcoLegalInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} MarcoLegal."
            msg += renderErrors(bean: marcoLegalInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de MarcoLegal exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def marcoLegalInstance = MarcoLegal.get(params.id)
            if (marcoLegalInstance) {
                try {
                    marcoLegalInstance.delete(flush: true)
                    render "OK_Eliminación de MarcoLegal exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar MarcoLegal."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró MarcoLegal."
    } //notFound para ajax

    def arbolLegal() {
    }


    def loadTreePart_ajax() {
        render(makeTreeNode(params))
    }



    private static String makeTreeNode(params) {
        def html = ""
        def id = params.id

        def hijos = []

        def type = ""
        def opened = false
        def selected = false
        def disabled = false
        def children = false
        def nodeId = ""
        def clase = ""
        def label = ""
        def valor

        if (id == "#") {
            // aún no hay nada en el árbol, se debe crear el primer nodo raíz (root)
//            def cantUnidadesHijas = UnidadEjecutora.countByPadreIsNull([sort: "nombre"])
            def cantUnidadesHijas = MarcoLegal.list().size()
            if (cantUnidadesHijas > 0) {
                clase = "tieneHijos jstree-closed"
                type = "root"
                nodeId = "root"
                opened = true
                selected = false
                disabled = false
                children = true
                label = "Raíz Marcos Legales"
            }

            def dataJstree = "\"opened\": $opened, \"children\": $children, \"selected\": $selected, \"disabled\": $disabled, \"type\": \"$type\""
            html += "<li id='$nodeId' class='$clase' data-jstree='{$dataJstree}'>"
            html += label
            html += "</li>"
            if (clase == "") {
                html = ""
            }
        } else if (id == "root") {
            // se deben cargar las unidades sin padre (y 'sin unidad' de ser necesario)
//            hijos = UnidadEjecutora.findAllByPadreIsNull([sort: 'nombre'])
            hijos = MarcoLegal.list([sort: 'descripcion'])
        } else {
            // se quiere abrir una unidad, se deben cargan las unidades hijas y los usuarios

//            println("else " + id)

            def parts = id.toString().split("_")
            def node_id = parts[1].toString().toLong()
            def padre

            if(parts[0] == 'ue'){
                padre = MarcoLegal.get(node_id)
                if (padre) {
                    hijos = []
//                hijos += UnidadEjecutora.findAllByPadre(padre, [sort: "nombre"])
//                hijos += Persona.findAllByUnidad(padre, [sort: "nombre"])
//                 hijos += MarcoNorma.findAllByMarcoLegal(padre)
                    hijos += MarcoNorma.findAllByMarcoLegalAndArticuloIsNull(padre, [sort: 'norma.tipoNorma.descripcion', order: 'asc'])
               }
            }else if (parts[0] == 'usu'){
                padre = MarcoNorma.get(node_id)
                valor = padre.marcoLegal.id
                if (padre) {
                    hijos = []
//                hijos += UnidadEjecutora.findAllByPadre(padre, [sort: "nombre"])
//                hijos += Persona.findAllByUnidad(padre, [sort: "nombre"])
//                 hijos += MarcoNorma.findAllByMarcoLegal(padre)
//                   hijos += Articulo.findAllByNorma(padre.norma)
//                   hijos += padre.articulo
//                   hijos += padre.norma
                   hijos += MarcoNorma.findAllByNormaAndArticuloIsNotNullAndLiteralIsNull(padre.norma, [sort: 'articulo.numero', order: 'desc']).articulo

//                    println("hijos " + hijos)
                }
            }else if (parts[0] == 'art') {
                def art = Articulo.get(node_id)
                padre = MarcoNorma.findByArticuloAndLiteralIsNull(art)
                valor = padre.marcoLegal.id

//                println("padre " + padre)

                if (padre) {
                    hijos = []
                    hijos += MarcoNorma.findAllByArticuloAndLiteralIsNotNull(padre.articulo).literal
//                    println("hijos -- literal" + hijos)
                }


            }


        }

        if (html == "" && hijos.size() > 0) {
            // solo se dibujan los hijos si la variable html está vacía (sino ya dibujó el root)
            // y si la cantidad de hijos es mayor a 0 (sino no hay nada que aumentar al árbol)
//
//            def abiertos = ["343", "AI", "9999", "GGGGG"]
//            def seleccionado = "343"

            def abiertos = ['1','2','3']
            def seleccionado = '1'

            html += "<ul>"

            hijos.each { hijo ->
                clase = ""
                opened = false
                selected = false
                disabled = false
                children = false
                // aquí iteramos en los hijos, que pueden ser de tipo UnidadEjecutora o Persona
//                if (hijo instanceof UnidadEjecutora) {
                if (hijo instanceof MarcoLegal) {
//                    def cantHijos = UnidadEjecutora.countByPadre(hijo)
//                    cantHijos += Persona.countByUnidad(hijo)

                   def cantHijos = MarcoNorma.countByMarcoLegal(hijo)


//                    type = "u_" + hijo.id
                    type = 'marco'
                    label = hijo.descripcion
                    nodeId = "ue_" + hijo.id
                    if (abiertos.contains(hijo.id.toString())) {
                        opened = true
                    }
                    if (seleccionado == hijo.id.toString()) {
                        selected = true
                    }
                    if (cantHijos > 0) {
                        clase = " tieneHijos jstree-closed"
                        children = true
                    }
                } else if (hijo instanceof MarcoNorma) {

//                    def cantHijosN = Articulo.countByNorma(hijo.norma)
                    def cantHijosN = MarcoNorma.findAllByNormaAndArticuloIsNotNullAndLiteralIsNull(hijo.norma).articulo.size()

//                    println("cant norma " + hijo.id + "- "+  cantHijosN)

                    type = "norma"
                    nodeId = "usu_" + hijo.id
                    label = hijo?.norma?.nombre
                    if (cantHijosN > 0) {
                        clase = " tieneHijos jstree-closed"
                        children = true
                    }
                }
                else if(hijo instanceof Articulo){
//                    println("entro art" + hijo)

                    def cantHijosN = MarcoNorma.findAllByArticuloAndLiteralIsNotNull(hijo).literal.size()

//                    println("hijos articulo " + cantHijosN)

                    type = "articulo"
                    nodeId = "art_" + hijo.id

                    if(hijo.descripcion.size() > 50){
                        label = "Art. n° " + hijo.numero + " - " + hijo.descripcion.substring(0,50) + "..."
                    }else{
                        label = "Art. n° " + hijo.numero + " - " + hijo.descripcion
                    }

                    if (cantHijosN > 0) {
                        clase = " tieneHijos jstree-closed"
                        children = true
                    }


                }else if(hijo instanceof  Literal){
                    type = "literal"
                    nodeId = "lit_" + hijo.id

                    if(hijo.descripcion.size() > 50){
                        label = "Literal " + hijo.identificador + " - " + hijo.descripcion.substring(0,50) + "..."
                    }else{
                        label = "Literal " + hijo.identificador + " - " + hijo.descripcion
                    }
                }
                def dataJstree = " \"valor\": $valor, \"opened\": $opened, \"children\": $children, \"selected\": $selected, \"disabled\": $disabled, \"type\": \"$type\""
                html += "<li class='$clase' id='$nodeId' data-jstree='{$dataJstree}'>"
                html += label
                html += "</li>"
            }
            html += "</ul>"
        }
        return html
    }

//búsquead en el árbol
    def arbolSearch_ajax() {
        def search = params.str.trim()
        def nodosAbrir = [:]
        // busco las unidades que coinciden con la búsqueda
        def unidadesMatch = UnidadEjecutora.withCriteria {
            or {
                ilike("nombre", "%$search%")
                ilike("codigo", "%$search%")
            }
        }
        // busco los usuarios que coinciden con la búsqueda
        def usuariosMatch = Persona.withCriteria {
            or {
                ilike("nombre", "%$search%")
                ilike("login", "%$search%")
            }
        }
        // para cada unidad voy recorriendo los padres y agregándolos a la lista de nodos que se tienen
        // que abrir, junto con la cantidad de iteraciones que tomó encontrar cada nodo
        // guardo solamente la mayor cantidad de iteraciones para cada nodo.
        // esto permite después ordenar los nodos en el orden que tienen que abrirse en el árbol
        // para mostrar los resultados encontrados
        unidadesMatch.each { ue ->
            def padre = ue.padre
            def c = 0
            while (padre) {
                def id = "#ue_" + padre.id
                if (!nodosAbrir[id] || nodosAbrir[id] < c) {
                    nodosAbrir[id] = c
                }
                c++
                padre = padre.padre
            }
        }
        // para cada usuario agrego la unidad correspondiente en la lista de nodos que se tienen que abrir
        // después de las unidades porque siempre los usuarios van a ser las últimas hojas del árbol
        usuariosMatch.each { usu ->
            def id = "#ue_" + usu.unidadId
            if (!nodosAbrir[id]) {
                nodosAbrir[id] = 0
            }
        }
        // los últimos nodos en abrirse son los que se encontraron primero (orden 0) por lo que el ordenamiento
        // es decendiente
        nodosAbrir = nodosAbrir.sort { -it.value }
        def json = new JsonBuilder(nodosAbrir.keySet())
        render json
    }

    def revisarArbol_ajax () {
        println("params revisar arbol legal " + params)
        def marcoLegal = MarcoLegal.get(params.marco)
        def marcoNorma = MarcoNorma.findAllByMarcoLegal(marcoLegal)
        def evaluaciones = Evaluacion.findAllByMarcoNormaInList(marcoNorma)

        if(marcoLegal.creador == (session.usuario.apellido + "_" + session.usuario.login) || session.perfil.codigo == 'ADMI'){
            if(evaluaciones){
                render "no_No se puede borrar este marco legal, ya se encuentra en evaluación!"
            }else{
                render "ok"
            }
        }else{
            render "no_Su usuario no puede borrar este marco legal, solo el usuario creador del mismo puede"
        }

    }

    def comprobarUsuario_ajax () {
//        println("comprobar params " + params)
        def marcoLegal = MarcoLegal.get(params.idMarco)
        if(marcoLegal.creador == (session.usuario.apellido + "_" + session.usuario.login) || session.perfil.codigo == 'ADMI'){
            render "ok"
        }else{
            render "no"
        }
    }

    def comprobarUsuario2_ajax () {
        println("comprobar params2 " + params)
        def marcoLegal = MarcoNorma.get(params.idMarco).marcoLegal
        if(marcoLegal.creador == (session.usuario.apellido + "_" + session.usuario.login) || session.perfil.codigo == 'ADMI'){
            render "ok"
        }else{
            render "no"
        }
    }

//    def comprobarUsuario3_ajax () {
//        println("comprobar params3 " + params)
//        def articulo =  Articulo.get(params.idMarco)
//
//        if(marcoLegal.creador == (session.usuario.apellido + "_" + session.usuario.login) || session.perfil.codigo == 'ADMI'){
//            render "ok"
//        }else{
//            render "no"
//        }
//    }



}