<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 22/05/2016
  Time: 18:56
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <meta name="layout" content="mainSada">
    <title>Evaluación Ambiental</title>
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

            <g:if test="${pre?.tipo?.codigo != 'LCM1'}">
                <g:link controller="evaluacion" action="evaluacionPlan" id="${pre?.id}" class="list-group-item bgOpcion bg-oscuro">
                    <h4 class="list-group-item-heading"><span class="icon"></span>
                        <i class="fa fa-leaf"></i>
                    </h4>
                    <p class="list-group-item-text">
                        <strong>Plan de Manejo Ambiental</strong>
                    </p>
                </g:link>
                <g:if test="${pre?.tipo?.codigo != 'LCM1'}">
                    <g:link controller="evaluacion" action="evaluacionLicencia" id="${pre?.id}" class="list-group-item bgOpcion bg-otro">
                        <h4 class="list-group-item-heading"><span class="icon"></span>
                            <i class="fa fa-key"></i>
                        </h4>
                        <p class="list-group-item-text">
                            <strong>Licencia</strong>
                        </p>
                    </g:link>
                </g:if>
            </g:if>
        </div>
    </div>
</div>




<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-book"></i> Evaluación Ambiental: Legislación</h3>
        <g:if test="${obau?.completado != 1}">
            <a href="#" id="btnCumplirEva" class="btn btn-success" title="Cumplir objetivo" style="float: right; margin-top: -25px">
                <i class="fa fa-check-circle-o"></i>
            </a>
        </g:if>
    </div>
    <div class="well" style="text-align: center; height: 200px">
        <div class="row">
            <div class="col-md-3 negrilla control-label">Para esta evaluación ambiental se está usando la legislación en el Marco Legal:
            </div>

            <div class="col-md-4">
                <g:textField name="marco_usado" value="${auditoria?.marcoLegal?.descripcion}" readonly="true" class="form-control"/>
            </div>

            %{--<div class="row">--}%
                %{--<div class="col-md-8" style="margin-top: 30px">--}%
                    %{--<a href="#" id="btnCambiarMarco" class="btn btn-warning" title="">--}%
                        %{--Cambiar Marco Legal <i class="fa fa-close"></i>--}%
                    %{--</a>--}%
                %{--</div>--}%
            %{--</div>--}%
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
            <th style="width: 10%"><i class="fa fa-archive"></i> Evidencia/Anexo</th>
            <th style="width: 1%"></th>
        </tr>
        </thead>
    </table>

    <div id="divTablaEvaluaciones">

    </div>

    <header class='masthead' style="margin-top: 120px; position: fixed">
        <nav>
            <div class='nav-container'>
                <div>
                    <a class='slide' href='#' id="areasMenu">
                        <span class='element'>Ar</span>
                        <span class='name'>Áreas Estación</span>
                    </a>
                </div>
                <div>
                    <a class='slide' href='#' id="sitMenu">
                        <span class='element'>Sa</span>
                        <span class='name'>Situación Ambiental</span>
                    </a>
                </div>
                <div>
                    <a class='slide' href='#' id="evaMenu">
                        <span class='element'>Ev</span>
                        <span class='name'>Evaluación Ambiental</span>
                    </a>
                </div>
                <div>
                    <a class='slide' href='#' id="planMenu">
                        <span class='element'>Pa</span>
                        <span class='name'>Plan de acción</span>
                    </a>
                </div>
                <div>
                    <a class='slide' href='#' id="pmaMenu">
                        <span class='element'>Pm</span>
                        <span class='name'>PMA</span>
                    </a>
                </div>
                <div>
                    <a class='slide' href='#' id="cronoMenu">
                        <span class='element'>Cr</span>
                        <span class='name'>Cronograma</span>
                    </a>
                </div>
                %{--<div>--}%
                    %{--<a class='slide' href='#'>--}%
                        %{--<span class='element'>Rc</span>--}%
                        %{--<span class='name'>Recomendaciones</span>--}%
                    %{--</a>--}%
                %{--</div>--}%
            </div>
        </nav>
    </header>




</div>

<script type="text/javascript">

    $("#btnCumplirEva").click(function () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'evaluacion', action: 'completar_ajax')}",
            data:{
                id: ${pre?.id}
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Objetivo registrado como completado!", "success");
                    setTimeout(function () {
                        location.reload(true)
                    }, 1500);
                }else{
                    log("Error al registar el objetivo como completado","error")
                }
            }
        })
    });


    //mini menu
    $("#areasMenu").click(function () {
        location.href="${createLink(controller: 'area', action: 'areas')}/" + ${pre?.id}
    });

    $("#evaMenu").click(function () {
        location.href="${createLink(controller: 'auditoria', action: 'leyes')}/" + ${pre?.id}
    });

    $("#planMenu").click(function () {
        location.href="${createLink(controller: 'planAccion', action: 'planAccionActual')}/" + ${pre?.id}
    });

    $("#pmaMenu").click(function () {
        location.href="${createLink(controller: 'planManejoAmbiental', action: 'cargarPlanActual')}/" + ${pre?.id}
    });

    $("#sitMenu").click(function () {
        location.href="${createLink(controller: 'situacionAmbiental', action: 'situacion')}/" + ${pre?.id}
    });

    $("#cronoMenu").click(function () {
        location.href="${createLink(controller: 'auditoria', action: 'cronograma')}/" + ${pre?.id}
    });




    //función cambiar marco legal
    $("#btnCambiarMarco").click(function () {
        bootbox.confirm("Está seguro de cambiar el Marco Legal?", function (result) {
            if(result){
                $.ajax({
                    type: 'POST',
                    url: "${createLink(controller: 'evaluacion', action: 'verificarLegislacion_ajax')}",
                    data:{
                        id:${pre?.id}
                    },
                    success: function (msg) {
                        if(msg == 'ok'){
                            log("No se puede cambiar el Marco Legal, ya se encuentra en Evaluación","error")
                        }else{
                            /*TODO hacer el cambio de marco legal en evaluacion de legislacion*/
                        }
                    }
                });
            }
        })
    });

    cargarTablaEva();

    //función para cargar la tabla con las evaluaciones
    function  cargarTablaEva () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'evaluacion', action: 'tablaEvaluacion_ajax')}',
            data: {
                id: ${pre?.id}
            },
            success: function (msg) {
                $("#divTablaEvaluaciones").html(msg).addClass('animated fadeInDown')
            }
        });
    }

</script>


</body>
</html>