package legal


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
        return [params: params]
    }

    def loadTreeNode(params) {
        render(makeTreeNode(params))
    }

//    def makeTreeNode (params){
//        println("params arbol " + params)
//        def id = params.id
//        def padre
//        def hijos = []
//
//        String tree=""
//        String clase=""
//        String rel=""
//
//        if(id == "#"){
//            clase="hasChildren jstree-closed"
//
//            tree="<li id='root' class='root ${clase}' data-jstree='{\"type\":\"root\"}' level='0' >" +
//                    "<a href='#' class='label_arbol'>Estructura</a>" +
//                    "</li>"
//            if(clase == ""){
//                tree=""
//            }
//        } else if(id == "root"){
//            hijos = MarcoLegal.list()
//            println("hijos " + hijos.size())
//        }else{
//            hijos = []
//        }
//            return tree
//    }

//    private static String makeTreeNode(params) {
    def makeTreeNode(params) {
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

        if (id == "#") {
            // aún no hay nada en el árbol, se debe crear el primer nodo raíz (root)
//            def cantUnidadesHijas = UnidadEjecutora.countByPadreIsNull([sort: "nombre"])
            def cantUnidadesHijas = MarcoLegal.countByIdIsNotNull()
            if (cantUnidadesHijas > 0) {
                clase = "tieneHijos jstree-closed"
                type = "root"
                nodeId = "root"
                opened = true
                selected = false
                disabled = false
                children = true
                label = "Marco Legal"
            }else{
                label = ""
            }

            def dataJstree = "\"opened\": $opened, \"children\": $children, \"selected\": $selected, \"disabled\": $disabled, \"type\": \"$type\""
            html += "<li id='$nodeId' class='$clase' data-jstree='{$dataJstree}'>"
            html += label
            html += "</li>"
            if (clase == "") {
                html = ""
            }
        } else if (id == "root") {
            println("root")
            // se deben cargar las unidades sin padre (y 'sin unidad' de ser necesario)
//            hijos = UnidadEjecutora.findAllByPadreIsNull([sort: 'nombre'])
//            hijos = MarcoLegal.findAllByCodigoIsNotNull([sort: 'descripcion'])
            hijos = MarcoLegal.list([sort: 'descripcion'])
        } else {
            // se quiere abrir una unidad, se deben cargan las unidades hijas y los usuarios
            def parts = id.toString().split("_")
            def node_id = parts[1].toString().toLong()
//            def padre = UnidadEjecutora.get(node_id)
            def padre = MarcoLegal.get(node_id)
            if (padre) {
                hijos = []
//                hijos += UnidadEjecutora.findAllByPadre(padre, [sort: "nombre"])
                hijos += MarcoLegal.list([sort: "descripcion"])
//                hijos += Persona.findAllByUnidad(padre, [sort: "nombre"])
                hijos += MarcoNorma.findAllByMarcoLegal(padre)
            }
        }

        if (html == "" && hijos.size() > 0) {
            // solo se dibujan los hijos si la variable html está vacía (sino ya dibujó el root)
            // y si la cantidad de hijos es mayor a 0 (sino no hay nada que aumentar al árbol)

            def abiertos = ["343", "AI", "9999", "GGGGG"]
            def seleccionado = "343"

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
                    def cantHijos = MarcoLegal.countByCodigo(hijo)
//                    cantHijos += Persona.countByUnidad(hijo)
                    cantHijos += MarcoNorma.countByMarcoLegal(hijo)

//                    type = "u_" + hijo.tipoInstitucion.codigo
                    type = "u_" + hijo.codigo
//                    label = hijo.labelArbol
                    label = hijo.descripcion
                    nodeId = "ue_" + hijo.id
                    if (abiertos.contains(hijo.codigo)) {
                        opened = true
                    }
                    if (seleccionado == hijo.codigo) {
                        selected = true
                    }
                    if (cantHijos > 0) {
                        clase = " tieneHijos jstree-closed"
                        children = true
                    }
                } else if (hijo instanceof MarcoNorma) {
                    type = "usuario"
                    if (hijo.norma) {
                        type = "director"
//                    } else if (hijo.esJefe) {
//                        type = "jefe"
//                    }
                        nodeId = "usu_" + hijo.id
//                    label = hijo.labelArbol
                        label = hijo.norma.descripcion
                    }
                    def dataJstree = "\"opened\": $opened, \"children\": $children, \"selected\": $selected, \"disabled\": $disabled, \"type\": \"$type\""
                    html += "<li class='$clase' id='$nodeId' data-jstree='{$dataJstree}'>"
                    html += label
                    html += "</li>"
                }
                html += "</ul>"
            }

        }
            return html


    }
}