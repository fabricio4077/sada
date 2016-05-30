
<%@ page import="auditoria.Preauditoria" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Lista de Auditorías</title>
</head>

<style type="text/css">
.centrar {
    text-align: center;
    align-items: center;
    width: 100px;

}
</style>
<body>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<!-- botones -->
%{--<div class="btn-toolbar toolbar">--}%
%{--<div class="btn-group">--}%
%{--<g:link action="form" class="btn btn-default btnCrear">--}%
%{--<i class="fa fa-file-o"></i> Crear--}%
%{--</g:link>--}%
%{--</div>--}%
%{--<div class="btn-group pull-right col-md-3">--}%
%{--<div class="input-group">--}%
%{--<input type="text" class="form-control" placeholder="Buscar" value="${params.search}">--}%
%{--<span class="input-group-btn">--}%
%{--<g:link action="list" class="btn btn-default btn-search" type="button">--}%
%{--<i class="fa fa-search"></i>&nbsp;--}%
%{--</g:link>--}%
%{--</span>--}%
%{--</div><!-- /input-group -->--}%
%{--</div>--}%
%{--</div>--}%

<table class="table table-condensed table-bordered table-striped">
    <thead>
    <tr>
        <th>Tipo</th>
        <th>Periodo</th>
        <th>Estacion</th>
        <th>Fecha de creación</th>
        <th style="width: 90px">% de Avance</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${lista}" status="i" var="preauditoriaInstance" >
        <tr data-id="${preauditoriaInstance.id}">
            <td>${preauditoriaInstance?.tipo?.descripcion}</td>
            <td style="text-align: center">${preauditoriaInstance?.periodo?.inicio.format("yyyy") + " - " + preauditoriaInstance?.periodo?.fin.format("yyyy")}</td>
            <td>${preauditoriaInstance?.estacion?.nombre}</td>
            <td>${preauditoriaInstance?.fechaCreacion?.format("dd-MM-yyyy")}</td>
            <td id="porcentaje_${i}" style="margin-left: 20px"></td>
        </tr>
    </g:each>
    </tbody>
</table>

<elm:pagination total="${preauditoriaInstanceCount}" params="${params}"/>

<script type="text/javascript">
    //función para cargar el porcentaje de avance de la auditoría
    <g:each in="${lista}" status="i" var="preauditoriaInstance">
    cargarPorcentaje(${preauditoriaInstance?.id?.toInteger()},${i});
    </g:each>

    function cargarPorcentaje (porc, id){
        $("#porcentaje_"+id).radialProgress("init", {
            'size': 60,
            'fill': 4
        }).radialProgress("to", {'perc': porc, 'time': 1500});
    }

    var id = null;
    function submitForm() {
        var $form = $("#frmPreauditoria");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(action:'save_ajax')}',
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
    function deleteRow(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar el Preauditoria seleccionado? Esta acción no se puede deshacer.</p>",
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-trash-o'></i> Eliminar",
                    className : "btn-danger",
                    callback  : function () {
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                var parts = msg.split("_");
                                log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] == "OK") {
                                    location.reload(true);
                                }
                            }
                        });
                    }
                }
            }
        });
    }
    function createEditRow(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Preauditoria",
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

    $(function () {

        $(".btnCrear").click(function() {
            createEditRow();
            return false;
        });


        //contextMenu
        $("tbody tr").contextMenu({

            items  : {
                header   : {
                    label  : "Acciones",
                    header : true
                },
                %{--ver      : {--}%
                    %{--label  : "Ver",--}%
                    %{--icon   : "fa fa-search",--}%
                    %{--action : function ($element) {--}%
                        %{--var id = $element.data("id");--}%
                        %{--$.ajax({--}%
                            %{--type    : "POST",--}%
                            %{--url     : "${createLink(action:'show_ajax')}",--}%
                            %{--data    : {--}%
                                %{--id : id--}%
                            %{--},--}%
                            %{--success : function (msg) {--}%
                                %{--bootbox.dialog({--}%
                                    %{--title   : "Ver",--}%
                                    %{--message : msg,--}%
                                    %{--buttons : {--}%
                                        %{--ok : {--}%
                                            %{--label     : "Aceptar",--}%
                                            %{--className : "btn-primary",--}%
                                            %{--callback  : function () {--}%
                                            %{--}--}%
                                        %{--}--}%
                                    %{--}--}%
                                %{--});--}%
                            %{--}--}%
                        %{--});--}%
                    %{--}--}%
                %{--},--}%
                editar   : {
                    label  : "Continuar",
                    icon   : "fa fa-pencil",
                    submenu:{
                        configuracion:{
                            label: "Configuración",
                            icon: "fa fa-pencil-square",
                            submenu:{
                                paso1: {
                                    label: "Paso 1 - Tipo y Período",
                                    icon: "fa fa-pencil-square",
                                    action: function ($element) {
                                        var id = $element.data("id")
                                        location.href = "${createLink(controller: 'preauditoria', action: 'crearAuditoria')}/" + id
                                    }
                                } ,
                                paso2:{
                                    label: "Paso 2 - Estación",
                                    icon: "fa fa-automobile",
                                    action: function ($element) {
                                        var id = $element.data("id")
                                        location.href = "${createLink(controller: 'preauditoria', action: 'crearPaso2')}/" + id
                                    }
                                },
                                paso3:{
                                    label: "Paso 3 - Coordenadas",
                                    icon: "fa fa-area-chart",
                                    action: function ($element) {
                                        var id = $element.data("id")
                                        location.href = "${createLink(controller: 'preauditoria', action: 'crearPaso3')}/" + id
                                    }
                                },
                                paso4:{
                                    label: "Paso 4 - Grupo de Trabajo",
                                    icon: "fa fa-group",
                                    action: function ($element) {
                                        var id = $element.data("id")
                                        location.href = "${createLink(controller: 'preauditoria', action: 'crearPaso4')}/" + id
                                    }
                                },
                                paso5:{
                                    label: "Paso 5 - Actividades",
                                    icon: "fa fa-tasks",
                                    action: function ($element) {
                                        var id = $element.data("id")
                                        location.href = "${createLink(controller: 'preauditoria', action: 'crearPaso5')}/" + id
                                    }

                                },
                                separador: {
                                    separator2: { "type": "cm_seperator" }
                                },
                                ficha: {
                                    label: "Ficha Técnica",
                                    icon: "fa fa-file",
                                    action: function ($element) {
                                        var id = $element.data("id")
                                        location.href = "${createLink(controller: 'preauditoria', action: 'fichaTecnica')}/" + id
                                    }
                                }

                            }
                        },
//                        configuración2:{
//                            label: "Configuración 2",
//                            icon: "fa fa-pencil-square",
//                            submenu:{
                                objetivos: {
                                    label: "Objetivos",
                                    icon: "fa fa-check-circle-o",
                                    action: function ($element) {
                                        var id = $element.data("id");
                                        location.href = "${createLink(controller: 'auditoria', action: 'objetivos')}/" + id
                                    }
                                },
//                            }
//                        },
                        configuración3:{
                            label: "Imprimir",
                            icon: "fa fa-print",
                            submenu:{
                                1: {
                                    label: "1",
                                    icon: "fa fa-file",
                                    disabled: true
                                }
                            }
                        }
                    }
                }
            },
            onShow : function ($element) {
                $element.addClass("trHighlight");
            },
            onHide : function ($element) {
                $(".trHighlight").removeClass("trHighlight");
            }
        });

    });
</script>

</body>
</html>
