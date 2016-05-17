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

    <script src="${resource(dir: 'js/plugins/jstree-3.2.0/dist', file: 'jstree.min.js')}"></script>
    <link href="${resource(dir: 'js/plugins/jstree-3.2.0/dist/themes/default', file: 'style.min.css')}" rel="stylesheet">

    <style type="text/css">

    #list-cuenta {
        width : 650px;
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


    <div id="jstree" class="hidden">

    </div>

</div>

<script type="text/javascript">

    var $treeContainer = $('#jstree');

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

    //función para borrar el marco legal
    function borrarMarcoLegal (id) {
        bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x text-danger text-shadow'></i> Está seguro de borrar este Marco Legal?", function (result) {
            if(result){
                $.ajax({
                    type: 'POST',
                    url: '${createLink(controller: 'marcoLegal', action: 'delete_ajax')}',
                    data:{
                        id: id
                    },
                    success: function(msg){
                        var parts = msg.split("_");
                        if(parts[0] == 'OK'){
                            log("Marco legal borrado correctamente","success");
                            setTimeout(function () {
                                location.reload(true)
                            }, 1500);
                        }else{
                            log('Error al borrar el marco legal',"error");
                        }
                    }
                });
            }
        });
    }

    //función para crear un nuevo artículo


    function createArticulo (idNorma) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'articulo', action:'form_ajax')}",
            data    : {
                norma: idNorma
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCrearArticulo",
                    title   : "Artículo",
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
                                return submitFormArticulo();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax

    }

    function submitFormArticulo() {
        var $form = $("#frmArticulo");
        var $btn = $("#dlgCrearArticulo").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'articulo', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
//                    log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
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

    //función para borrar artículos

    function deleteArticulo (id) {
        bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x text-danger text-shadow'></i> Está seguro de borrar este artículo?", function (result) {
          if(result){
              $.ajax({
                  type: 'POST',
                  url: '${createLink(controller: 'articulo', action: 'delete_ajax')}',
                  data:{
                      id: id
                  },
                  success: function(msg){
                      var parts = msg.split("_");
                      if(parts[0] == 'OK'){
                          log("Artículo borrado correctamente","success");
                          setTimeout(function () {
                              location.reload(true)
                          }, 1500);
                      }else{
                          log('Error al borrar el artículo',"error");
                      }
                  }
              });
          }
        });
    }

    //función para crear una nueva norma

    function crearNorma (idMarco) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'norma', action:'form_ajax')}",
            data    : {
                idMarco: idMarco
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCrearNorma",
                    title   : "Norma Legal",
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
                                return submitFormNorma();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    }

    function submitFormNorma() {
        var $form = $("#frmNorma");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'norma', action:'guardarNorma_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0] == "OK") {
                        log("Norma Legal guardada correctamente","success");
                        setTimeout(function () {
                            location.reload(true);
                        }, 1500);
                    } else {
                        log("Error al guardar la Norma Legal","error");
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    //función para borrar una norma

    function deleteNorma (id){
        bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x text-danger text-shadow'></i> Está seguro de borrar este artículo?", function (result) {
           if(result){
               $.ajax({
                   type: 'POST',
                   url: '${createLink(controller: 'norma', action: 'delete_ajax')}',
                   data:{
                       id: id
                   },
                   success: function(msg){
                       var parts = msg.split("_");
                       if(parts[0] == 'OK'){
                           log("Norma borrada correctamente","success");
                           setTimeout(function () {
                               location.reload(true)
                           }, 1500);
                       }else{
                           log('Error al borrar la norma',"error");
                       }
                   }
               });
           }
        });
    }


    function createContextMenu(node){
        var nodeStrId = node.id;
        var $node = $("#" + nodeStrId);
        var nodeId = nodeStrId.split("_")[1];
        var nodeType = $node.data("jstree").type;
        var nodeUsu = $node.data("usuario");
        var nodeHasChildren = $node.hasClass("hasChildren");

        var items = {};

        var root = {
                label: "Crear Marco Legal",
                icon:  "fa fa-link text-danger",
                action: function (obj){
                    createMarcoLegal(nodeId, "Crear");
                }
        };

        var norma = {
                label: "Nueva norma legal",
                icon:  "fa fa-legal text-success",
                action: function (obj){
                    crearNorma(nodeId);
                }
        };

        var articulo = {
            label: "Nuevo artículo",
            icon:  "fa fa-file-text text-info",
            action: function (obj){
               createArticulo(nodeId);
            }
        };

        var borrarMarco = {
            label: "Borrar marco legal",
            icon:  "fa fa-trash text-danger",
            action: function (obj){
                borrarMarcoLegal (nodeId);
            }
        };

        var borrarNorma = {
            label: "Borrar norma legal",
            icon:  "fa fa-trash text-danger",
            action: function (obj){
                createMarcoLegal(nodeId, "Crear");
            }
        };

        var borrarArticulo = {
            label: "Borrar articulo",
            icon:  "fa fa-trash text-danger",
            action: function (obj){
                deleteArticulo(nodeId);
            }
        };

        if(nodeType == "root"){
            items.root = root
        }

        if(nodeType == "marco"){
            items.norma = norma;
            items.borrarMarco = borrarMarco

        }

        if(nodeType == "norma"){
            items.articulo = articulo;
            items.borrarNorma = borrarNorma
        }

        if(nodeType == "articulo"){
            items.borrarArticulo = borrarArticulo
        }







        return items

    }

    //función para buscar en el árbol

    function searchArbol() {
        var v = $.trim($('#txtSearchArbol').val());
        openLoader("Buscando");
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'arbolSearch_ajax')}",
            data    : {
                str : v
            },
            success : function (msg) {
                var json = $.parseJSON(msg);
                var i = 0;
                var total = json.length;
                var interval = setInterval(function () {
                    $treeContainer.jstree("open_node", json[i]);
                    i++;
                    if (i == total) {
                        clearInterval(interval);
                    }
                }, 300);

                setTimeout(function () {
                    $treeContainer.jstree(true).search(v);
                    searchRes = $(".jstree-search");
                    var cantRes = searchRes.length;
                    posSearchShow = 0;
                    $("#divSearchRes").removeClass("hidden");
                    $("#spanSearchRes").text("Resultado " + (posSearchShow + 1) + " de " + cantRes);
                    scrollToSearchRes();
                    closeLoader();
                }, (total + 1) * 300);
            }
        });
    }


    function scrollToNode($scrollTo) {
        $treeContainer.jstree("deselect_all").jstree("select_node", $scrollTo).animate({
            scrollTop : $scrollTo.offset().top - $treeContainer.offset().top + $treeContainer.scrollTop() - 50
        });
    }

    function scrollToRoot() {
        var $scrollTo = $("#root");
        scrollToNode($scrollTo);
    }

    function scrollToSearchRes() {
        var $scrollTo = $(searchRes[posSearchShow]);
        $("#spanSearchRes").text("Resultado " + (posSearchShow + 1) + " de " + searchRes.length);
        scrollToNode($scrollTo);
    }

    //función para cargar el árbol


    $(function () {
        $treeContainer.on("loaded.jstree", function () {
            $("#loading").hide();
            $treeContainer.removeClass("hidden");
        }).jstree({
            plugins     : ["state", "types", "contextmenu", "search"],
            core        : {
                multiple : false,
                themes   : {
                    variant : "small",
                    dots    : true,
                    stripes : true
                },
                data     : {
                    url  : '${createLink(action:"loadTreePart_ajax")}',
                    data : function (node) {
                        return {
                            id : node.id
                        }
                    }
                }
            },
            state       : {
                key : "arbol1"
            },
            contextmenu : {
                show_at_node : false,
                items        : createContextMenu
            },
            search      : {},
            types       : {
                'default'   : {
                    icon : "fa fa-folder-open"
                },
                'marco'   : {
                    icon : "fa fa-link text-danger"
                },
                'norma'      : {
                    icon : "fa fa-legal text-success"
                },
                'articulo'  : {
                    icon : "fa fa-file-text text-info"
                },
                'sinUnidad' : {
                    icon : "fa fa-folder"
                },
                'u_1'       : {
                    icon : 'fa fa-hospital-o'
                },
                'u_2'       : {
                    icon : 'fa fa-building'
                },
                'u_3'       : {
                    icon : 'fa fa-building-o'
                },
                'u_4'       : {
                    icon : 'fa fa-home'
                }
            }
        });

        $("#btnExpandAll").click(function () {
            $treeContainer.jstree("open_all");
            scrollToRoot();
            return false;

        });

        $("#btnCollapseAll").click(function () {
            $treeContainer.jstree("close_all");
            scrollToRoot();
            return false;
        });

        $("#btnSearchArbol").click(function () {
            searchArbol();
            return false;
        });

        $("#txtSearchArbol").keyup(function (ev) {
            if (ev.keyCode == 13) {
                searchArbol();
            }
        });

        $("#btnPrevSearch").click(function () {
            if (posSearchShow > 0) {
                posSearchShow--;
            } else {
                posSearchShow = searchRes.length - 1;
            }
            scrollToSearchRes();
            return false;
        });

        $("#btnNextSearch").click(function () {
            if (posSearchShow < searchRes.length - 1) {
                posSearchShow++;
            } else {
                posSearchShow = 0;
            }
            scrollToSearchRes();
            return false;
        });

        $("#btnClearSearch").click(function () {
            $treeContainer.jstree("clear_search");
            $("#txtSearchArbol").val("");
            posSearchShow = 0;
            searchRes = [];
            scrollToRoot();
            $("#divSearchRes").addClass("hidden");
            $("#spanSearchRes").text("");
        });
    });



</script>


</body>
</html>