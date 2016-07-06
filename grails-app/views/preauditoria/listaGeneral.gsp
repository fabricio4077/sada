<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 17/04/2016
  Time: 14:11
--%>


<%@ page import="auditoria.Preauditoria" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Lista general de Auditorías</title>

    <style type="text/css">
    .centrar {
        text-align: center;
    }

    td{
        font-weight: bold;
    }
    </style>
</head>
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

%{--<table class="table table-condensed table-bordered table-striped">--}%
    %{--<thead>--}%
    %{--<tr>--}%
        %{--<th>Tipo</th>--}%
        %{--<th>Periodo</th>--}%
        %{--<th>Estacion</th>--}%
        %{--<th>Fecha de creación</th>--}%
        %{--<th>Auditor</th>--}%
        %{--<th>% de Avance</th>--}%

    %{--</tr>--}%
    %{--</thead>--}%
    %{--<tbody>--}%
    %{--<g:each in="${preauditoriaInstanceList}" status="i" var="preauditoriaInstance">--}%
        %{--<tr data-id="${preauditoriaInstance.id}">--}%
            %{--<td>${preauditoriaInstance?.tipo?.descripcion}</td>--}%
            %{--<td style="text-align: center">${preauditoriaInstance?.periodo?.inicio.format("yyyy") + " - " + preauditoriaInstance?.periodo?.fin.format("yyyy")}</td>--}%
            %{--<td>${preauditoriaInstance?.estacion?.nombre}</td>--}%
            %{--<td>${preauditoriaInstance?.fechaCreacion?.format("dd-MM-yyyy")}</td>--}%
            %{--<td>${preauditoriaInstance?.creador}</td>--}%
            %{--<td id="porcentaje_${i}" style="margin-left: 20px"></td>--}%
        %{--</tr>--}%
    %{--</g:each>--}%
    %{--</tbody>--}%
%{--</table>--}%
<div class="panel panel-info ">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-check-circle-o"></i> Lista general de Auditorías </h3>
    </div>
</div>

<table class="table table-condensed table-bordered table-striped">
    <thead>
    <tr>
        <th class="centrar" style="width: 10%"><i class='fa fa-list'></i> Tipo</th>
        <th class="centrar" style="width: 10%"><i class='fa fa-calendar'></i> Período</th>
        <th class="centrar" style="width: 30%"><i class='fa fa-automobile'></i> Estación</th>
        <th class="centrar" style="width: 10%"><i class='fa fa-clock-o'></i> Fecha de creación</th>
        <th class="centrar" style="width: 15%"><i class='fa fa-user'></i> Creador/Usuario</th>
        <th class="centrar" style="width: 7%"> % de Avance</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${preauditoriaInstanceList}" status="i" var="preauditoriaInstance" >
        <tr data-id="${preauditoriaInstance.id}">
            <g:if test="${preauditoriaInstance?.tipo?.codigo == 'INIC'}">
                <td style="background-color: #85c5ff">${preauditoriaInstance?.tipo?.descripcion}</td>
            </g:if>
            <g:elseif test="${preauditoriaInstance?.tipo?.codigo == 'LCM1'}">
                <td style="background-color: #77ff6b">${preauditoriaInstance?.tipo?.descripcion}</td>
            </g:elseif>
            <g:else>
                <td style="background-color: #fdff78">${preauditoriaInstance?.tipo?.descripcion}</td>
            </g:else>
            <td style="text-align: center">${preauditoriaInstance?.periodo?.inicio?.format("yyyy") + " - " + preauditoriaInstance?.periodo?.fin?.format("yyyy")}</td>
            <td>${preauditoriaInstance?.estacion?.nombre}</td>
            <td><util:fechaConFormato fecha="${preauditoriaInstance?.fechaCreacion}"/></td>
            <td>${preauditoriaInstance?.creador?.split("_")[0] + " (" + preauditoriaInstance?.creador?.split("_")[1] + ")"}</td>
            <td id="porcentaje_${i}" style="margin-left: 20px"></td>
        </tr>
    </g:each>
    </tbody>
</table>


<elm:pagination total="${preauditoriaInstanceCount}" params="${params}"/>

<script type="text/javascript">

    //función para cargar el porcentaje de avance de la auditoría
    <g:each in="${preauditoriaInstanceList}" status="i" var="preauditoriaInstance">
    cargarPorcentaje(${preauditoriaInstance?.avance?.toInteger()},${i});
    </g:each>

    function cargarPorcentaje (porc, id){
        $("#porcentaje_"+id).radialProgress("init", {
            'size': 60,
            'fill': 4
        }).radialProgress("to", {'perc': porc, 'time': 1500});
    }



    function revisarEstacion (id) {
        var res
        $.ajax({
            type: 'POST',
            async: false,
            url: '${createLink(controller: 'preauditoria', action: 'revisarEstacion_ajax')}',
            data: {
                id: id
            },
            success: function (msg){
                res = msg
            }
        });

        if(res == 'true'){
            return true
        }else{
            return false
        }

    }

    function revisarGrupo (id) {
        return false
    }

    function revisarObjetivos(id){
        var res
        $.ajax({
            type: 'POST',
            async: false,
            url: '${createLink(controller: 'preauditoria', action: 'revisarObjetivos_ajax')}',
            data: {
                id: id
            },
            success: function (msg){
                res = msg
            }
        });

        if(res == 'true'){
            return true
        }else{
            return false
        }
    }


    function createContextMenu(node) {
        var $tr = $(node);
        var idF = $tr.data("id");

        var items = {
            header: {
                label: "Acciones",
                header: true
            },
            ver      : {
                label  : "Información",
                icon   : "fa fa-search text-info",
                action : function ($element) {
                    var id = $element.data("id");
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action:'show_ajax')}",
                        data    : {
                            id : id
                        },
                        success : function (msg) {
                            bootbox.dialog({
                                title   : "Información",
                                message : msg,
                                buttons : {
                                    ok : {
                                        label     : "Aceptar",
                                        className : "btn-primary",
                                        callback  : function () {
                                        }
                                    }
                                }
                            });
                        }
                    });
                }
            },
            editar   : {
                label  : "Continuar",
                icon   : "fa fa-pencil text-success",
                submenu:{
                    configuracion:{
                        label: "Configuración",
                        icon: "fa fa-pencil-square text-success",
                        submenu:{
                            paso1: {
                                label: "Paso 1 - Tipo y Período",
                                icon: "fa fa-pencil-square",
                                action: function ($element) {
                                    var id = $element.data("id")
                                    location.href = "${createLink(controller: 'preauditoria', action: 'crearAuditoria')}/" + id
                                }
                            }

                            ,
                            paso2:{
                                label: "Paso 2 - Estación",
                                icon: "fa fa-automobile",
                                action: function ($element) {
                                    var id = $element.data("id");
                                    location.href = "${createLink(controller: 'preauditoria', action: 'crearPaso2')}/" + id
                                }
                                ,
                                disabled: revisarEstacion(idF)
                            }
                            ,
                            paso3:{
                                label: "Paso 3 - Coordenadas",
                                icon: "fa fa-area-chart",
                                action: function ($element) {
                                    var id = $element.data("id")
                                    location.href = "${createLink(controller: 'preauditoria', action: 'crearPaso3')}/" + id
                                }
                                ,
                                disabled: revisarEstacion(idF)

                            },
                            paso4:{
                                label: "Paso 4 - Grupo de Trabajo",
                                icon: "fa fa-group",
                                action: function ($element) {
                                    var id = $element.data("id");
                                    location.href = "${createLink(controller: 'preauditoria', action: 'crearPaso4')}/" + id
                                },
                                disabled: revisarEstacion(idF)
                            },
                            %{--paso5:{--}%
                            %{--label: "Paso 5 - Actividades",--}%
                            %{--icon: "fa fa-tasks",--}%
                            %{--action: function ($element) {--}%
                            %{--var id = $element.data("id");--}%
                            %{--location.href = "${createLink(controller: 'preauditoria', action: 'crearPaso5')}/" + id--}%
                            %{--},--}%
                            %{--disabled: revisarEstacion(idF)--}%

                            %{--},--}%
                            separador: {
                                separator2: { "type": "cm_seperator" }
                            },
                            ficha: {
                                label: "Ficha Técnica",
                                icon: "fa fa-file-text text-info",
                                action: function ($element) {
                                    var id = $element.data("id");
                                    location.href = "${createLink(controller: 'preauditoria', action: 'fichaTecnica')}/" + id
                                }
                                ,
                                disabled: revisarEstacion(idF)
                            }


                        }
                    },

                    objetivos: {
                        label: "Objetivos",
                        icon: "fa fa-check-circle-o text-success",
                        action: function ($element) {
                            var id = $element.data("id");
                            location.href = "${createLink(controller: 'auditoria', action: 'objetivos')}/" + id
                        },
                        disabled: revisarObjetivos(idF)
                    },
                    complemento:{
                        label: "Complementos",
                        icon: "fa fa-file-text-o text-warning",
                        submenu:{
                            paso1: {
                                label: "Antecedentes",
                                icon: "fa fa-paste text-warning",
                                action: function ($element) {
                                    var id = $element.data("id");
                                    location.href = "${createLink(controller: 'antecedente', action: 'antecedente')}/" + id
                                }
                            } ,
                            paso2:{
                                label: "Alcance",
                                icon: "fa fa-file-o text-warning",
                                action: function ($element) {
                                    var id = $element.data("id");
                                    location.href = "${createLink(controller: 'alcance', action: 'alcance')}/" + id
                                }
                            },
                            paso3:{
                                label: "Metodología",
                                icon: "fa fa-files-o text-warning",
                                action: function ($element) {
                                    var id = $element.data("id");
                                    location.href = "${createLink(controller: 'metodologia', action: 'verMetodologia')}/" + id
                                }
                            }
                        }
                    },
                    impresion:{
                        label: "Imprimir",
                        icon: "fa fa-print text-info",
                        action: function ($element) {
                            var id = $element.data("id");
                            location.href = "${createLink(controller: 'reportes', action: 'imprimirUI')}/" + id
                        },
                        disabled: revisarObjetivos(idF)
                    }
                }
            }
            <g:if test="${session.perfil.codigo == 'ADMI'}">
            ,
            eliminar : {
                label            : "Eliminar",
                icon             : "fa fa-trash-o text-danger",
                separator_before : true,
                action           : function ($element) {
                    var id = $element.data("id");
                    deleteRow(id);
                }
            }
            </g:if>

        };

        return items
    }

    $(function () {
        $("tr").contextMenu({
            items  : createContextMenu,
            onShow : function ($element) {
                $element.addClass("trHighlight");
            },
            onHide : function ($element) {
                $(".trHighlight").removeClass("trHighlight");
            }
        });




    });

    function deleteRow(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>¿Está seguro que desea eliminar la auditoría seleccionada? </br> <b>Esta acción no se puede deshacer.</b></p>",
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
                            url     : '${createLink(action:'borrarAuditoria_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                if(msg == 'ok'){
                                    log("Auditoría borrada correctamente","success");
                                    setTimeout(function () {
                                        location.href = "${createLink(controller: "preauditoria", action: "list" )}"
                                    }, 1500);
                                }else{
                                    log("Error al borrar la auditoría","error")
                                }
                            }
                        });
                    }
                }
            }
        });
    }



</script>

</body>
</html>
