<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 06/04/2016
  Time: 22:11
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Leyes</title>

    <script src="${resource(dir: 'js/plugins/jstree-e22db21/dist', file: 'jstree.min.js')}"></script>
    <link href="${resource(dir: 'js/plugins/jstree-e22db21/dist/themes/default', file: 'style.min.css')}" rel="stylesheet">

    <style type="text/css">

    #list-cuenta {
        width : 950px;
    }

    #tree {
        background : #DEDEDE;
        overflow-y : auto;
        height     : 600px;
    }

    .jstree-search {
        color : #5F87B2 !important;
    }

    .leyenda {
        background    : #ddd;
        border        : solid 1px #aaa;
        padding-left  : 5px;
        padding-right : 5px;
    }

    .infoCambioEstado {
        font-size   : larger;
        font-weight : bold;
    }

    .entrada {
        color : #83C483;
    }

    .salida {
        color : #7676E2;
    }
    </style>

</head>

<body>


<div id="list-cuenta">

    <div id="loading" class="text-center">
        <p>Cargando... </p>
        <p><img src="${resource(dir: 'images/spinners', file: 'spinner.gif')}" alt='Cargando...'/></p>
        <p>Por favor espere</p>
    </div>

    <div id="tree" class="hide">

    </div>
</div>

<script type="text/javascript">


    function createMarcoLegal(id, tipo) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};

//        var data = tipo == "Crear" ? {padre : id} : {id : id};

        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " MarcoLegal",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitForm();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    function submitForm() {
        var $form = $("#frmMarcoLegal");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'marcoLegal', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                    if (parts[0] == "OK") {
                        location.reload(true);
                    } else {
                        spinner.replaceWith($btn);
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }








    function createContextMenu(node){
        var nodeStrId = node.id;
        var $node = $("#" + nodeStrId);
        var nodeId = nodeStrId.split("_")[1];
        var nodeType = $node.data("jstree").type;
        var nodeUsu = $node.data("usuario");
        var nodeHasChildren = $node.hasClass("hasChildren");

        if(nodeType == "root"){
            var items = {
                crear : {
                    label: "Crear Marco Legal",
                    icon:  "fa fa-bank text-success",
                    action: function (obj){
                        createMarcoLegal(nodeId, "Crear");
                    }
                }
            }
        }

        return items

    }


    $("#tree").on("loaded.jstree", function () {
        $("#loading").hide();
        $("#tree").removeClass("hide").show();
    }).on("select_node.jstree", function (node, selected, event) {

    }).jstree({
        plugins: ["type","contextmenu","wholerow","search"],
        core    : {
            multiple : false,
            check_callback: true,
            themes : {
                variant: "small",
                dots: true,
                stripes: true
            },
            data : {
                async: false,
                url: '${createLink(action: 'loadTreeNode')}',
                data: function (node) {
                    return {
                        id: node.id
                    };
                }
            }
        }
        ,
        contextmenu :{
            show_at_node : false,
            items    : createContextMenu
        }

    })


</script>


</body>
</html>