<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 28/05/2016
  Time: 19:56
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>PMA - Plan de Manejo Ambiental (${band ? 'Anterior' : 'Actual'})</title>

    <style>
        .table th{
            text-align: center;
        }
    </style>
</head>

<body>

<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-leaf"></i> Selección de Aspectos Ambientales</h3>
    </div>

    <div style="margin-top: 40px; width: 750px; height: 100px; margin-left: 150px" class="vertical-container">
        <p class="css-vertical-text" style="margin-top: -10px;">Aspectos A.</p>
        <div class="linea"></div>

        <div class="row">
            <div class="col-md-2 negrilla control-label">Plan: </div>
            <div class="col-md-7">
                <g:select name="pma_name" id="pma" optionKey="id" optionValue="nombre"
                          class="form-control" from="${plan.PlanManejoAmbiental.list([sort: 'nombre', order: 'asc'])}"/>
            </div>
        </div>


        <div class="row">
            <div class="col-md-4 negrilla control-label">Aspectos Ambientales: </div>
            <div class="col-md-6" id="divAspectos">

            </div>

            <div class="col-md-1">
                <a href="#" id="btnSeleccionarAspecto" class="btn btn-info" title="Seleccionar Aspecto Ambiental">
                    <i class="fa fa-check"></i>
                </a>
            </div>
            <div class="col-md-1">
                <a href="#" id="btnCrearAspecto" class="btn btn-success" title="Crear Aspecto Ambiental">
                    <i class="fa fa-plus"></i>
                </a>
            </div>

        </div>
    </div>
</div>

<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-leaf"></i> Planes Ambientales</h3>
    </div>

    <table class="table table-condensed table-bordered table-striped">
        <thead>
        <tr>
            <th style="width: 21%" >Plan</th>
            <th style="width: 22%" >Aspecto Ambiental</th>
            <th style="width: 16%" >Impacto Identificado</th>
            <th style="width: 30%">Medida Propuesta</th>
            %{--<th style="width: 15%">Indicadores</th>--}%
            %{--<th style="width: 10%">Medio de Verificación</th>--}%
            %{--<th style="width: 1%">Plazo</th>--}%
            <th style="width: 5%">Acciones</th>
            <th style="width: 1%"></th>
        </tr>
        </thead>
    </table>

    <div id="tablaP">

    </div>

</div>

<script type="text/javascript">

    cargarTablaPlanes(${pre?.id}, ${band});

    function cargarTablaPlanes (idP, b) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'planManejoAmbiental', action: 'tablaPlan_ajax')}",
            data:{
                id: idP,
                band: b
            },
            success: function(msg){
                $("#tablaP").html(msg)
            }
        });
    }


    cargarAspectos($("#pma").val());

    function cargarAspectos (idPlan) {
        $.ajax({
           type: 'POST',
            url: "${createLink(controller: 'planManejoAmbiental', action: 'cargarAspectos_ajax')}",
            data:{
                id: idPlan
            },
            success: function(msg){
                $("#divAspectos").html(msg)
            }
        });
    }


    $("#pma").change(function () {
        cargarAspectos($(this).val());
    });
</script>
</body>
</html>