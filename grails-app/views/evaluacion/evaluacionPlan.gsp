<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 27/05/2016
  Time: 13:40
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Evaluación Ambiental: Plan de Manejo Ambiental</title>

    <style>
    .bgOpcion:hover {
        background : #395B81 !important;
        width: 200px;
        color: #fffff9;
    }
    .bgOpcion{
        width: 200px;
    }
    .margen {
        margin-left: 180px;
    }

    .bg-oscuro{
        background-color: #B0C879;
    }

    .bg-claro {
        background-color: #22ADE1;
    }

    .bg-otro{
        background-color: #5B8A5A;
    }

    .table th{
        text-align: center;
    }

    </style>

</head>



<body>

<div class="panel panel-success col-md-3" >
    <div class="panel-heading">
        <h3 class="panel-title">Evaluación Ambiental</h3>
    </div>
    <div class="panel-body" style="height: 200px">
        <div class="list-group" style="text-align: center">
            <g:link controller="evaluacion" action="evaluacionAmbiental" id="${pre?.id}" class="list-group-item bgOpcion bg-claro">
                <h4 class="list-group-item-heading"><span class="icon"></span>
                    <i class="fa fa-book"></i>
                </h4>
                <p class="list-group-item-text">
                    <strong>Legislación</strong>
                </p>
            </g:link>

            <g:link controller="evaluacion" action="evaluacionPlan" id="${pre?.id}" class="list-group-item bgOpcion bg-oscuro">
                <h4 class="list-group-item-heading"><span class="icon"></span>
                    <i class="fa fa-leaf"></i>
                </h4>
                <p class="list-group-item-text">
                    <strong>Plan de Manejo Ambiental</strong>
                </p>
            </g:link>

            <g:link controller="evaluacion" action="evaluacionLicencia" id="${pre?.id}" class="list-group-item bgOpcion bg-otro">
                <h4 class="list-group-item-heading"><span class="icon"></span>
                    <i class="fa fa-key"></i>
                </h4>
                <p class="list-group-item-text">
                    <strong>Licencia</strong>
                </p>
            </g:link>
        </div>
    </div>
</div>

<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-leaf"></i> Evaluación Ambiental: Plan de Manejo Ambiental</h3>
    </div>
    <div class="well" style="text-align: center; height: 200px">

        <g:if test="${anteriores}">
            <div class="col-md-4 negrilla control-label">Seleccione el Plan de Manejo Ambiental (anterior) del cual se realizará la Evaluación Ambiental:
            </div>

            <div class="col-md-4">
                <g:select name="anteriores_name" class="form-control"
                          from="${anteriores}" id="anteriores"
                          optionValue="${{it?.tipo?.descripcion + " - Período: " + it?.periodo?.inicio?.format("yyyy") + " - " + it?.periodo?.fin?.format("yyyy")}}" optionKey="id" disabled="${plan.size() > 0 ? 'true' : 'false'}"/>
                <a href="#" id="btnSeleccionarPlan" class="btn btn-info ${plan.size() >0 ? 'disabled' : ''}" title="" style="margin-bottom: 20px; margin-top: 10px">
                    <i class="fa fa-check"></i> Seleccionar PMA
                </a>
            </div>
        </g:if>

        <div class="col-md-4 negrilla control-label">
            Opción 2: Crear un Plan de Manejo Ambiental (anterior) del cual se realizará la Evaluación Ambiental:
        </div>

            <div class="btn-group">
                <a href="#" id="btnCrearPlan" class="btn btn-success btn-sm ${plan.size() >0 ? 'disabled' : ''}" title="">
                    <i class="fa fa-plus"></i> Crear PMA
                </a>
                <a href="#" id="btnEditarPlan" class="btn btn-primary btn-sm ${plan.size() >0 ? '' : 'disabled'}" title="">
                    <i class="fa fa-pencil"></i> Editar PMA
                </a>
                %{--<a href="#" id="btnBorrarPlan" class="btn btn-danger btn-sm ${plan.size() >0 ? '' : 'disabled'}" title="">--}%
                <a href="#" id="btnBorrarPlan" class="btn btn-danger btn-sm" title="">
                    <i class="fa fa-trash"></i> Borrar PMA
                </a>
            </div>
    </div>
</div>

<table class="table table-condensed table-bordered table-striped">
    <thead>
    <tr>
        <th style="width: 3%">#</th>
        <th style="width: 10%">Obligación Ambiental</th>
        <th style="width: 31%">Descripción</th>
        <th style="width: 16%">Calificación</th>
        <th style="width: 15%">Hallazgo</th>
        <th style="width: 10%"><i class="fa fa-folder-open-o"></i> Evidencia/Anexo</th>
        <th style="width: 1%"></th>
    </tr>
    </thead>
</table>

<div id="divTablaPlan">

</div>


<script type="text/javascript">

    $("#btnSeleccionarPlan").click(function () {
        var anterior = $("#anteriores").val();
        bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x text-warning text-shadow'></i> Está seguro que desea seleccionar este PMA(anterior) para la Evaluación Ambiental?", function (result){
         if(result){
             $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'planManejoAmbiental', action: 'asociarPlanEvam_ajax')}',
                data:{
                    id: anterior,
                    actual: ${pre?.id}
                },
                 success: function (msg){
                     var parts = msg.split("_");
                     if(parts[0] == 'ok'){
                         log(parts[1],'success');
                        cargarTablaEvaPlan();
                         $("#btnCrearPlan").addClass('disabled');
                         $("#btnEditarPlan").addClass('disabled');
                         $("#btnSeleccionarPlan").addClass('disabled');
                     }else{
                         log(parts[1],'error');
                     }
                 }
             });
         }
        })
    });



    //función que asigna el PMA por defecto y redirecciona a dicha pantalla
    $("#btnCrearPlan").click(function () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'evaluacion', action:  'asignarPlanAnterior_Ajax')}',
            data:{
                id: ${pre?.id}
            },
            success: function(msg){
                if(msg == 'ok'){
                    location.href="${createLink(controller: 'planManejoAmbiental', action: 'planManejoAmbiental')}?id=" + ${pre?.id} + "&band=" + true
                }else{
                log("Error al asignar el PMA anterior", "error")
                }
            }
        })
    });

    $("#btnEditarPlan").click(function () {
        location.href="${createLink(controller: 'planManejoAmbiental', action: 'planManejoAmbiental')}?id=" + ${pre?.id} + "&band=" + true
    })



    cargarTablaEvaPlan();

    //función para cargar la tabla con los items a ser evaluados (PMA)
    function  cargarTablaEvaPlan () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'evaluacion', action: 'tablaEvaPlan_ajax')}',
            data: {
                id: ${pre?.id}
            },
            success: function (msg) {
                $("#divTablaPlan").html(msg)
            }
        });
    }


</script>

</body>
</html>