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

    .modal {
        text-align: center;
        padding: 0!important;
    }

    .modal:before {
        content: '';
        display: inline-block;
        height: 100%;
        vertical-align: middle;
        margin-right: -4px;

    }

    .modal-dialog {
        display: inline-block;
        text-align: left;
        vertical-align: middle;
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

            <div class="row">
                <div class="col-md-8" style="margin-top: 30px">
                    <a href="#" id="btnCambiarMarco" class="btn btn-warning" title="">
                        Cambiar Marco Legal <i class="fa fa-close"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>


    <table class="table table-condensed table-bordered table-striped">
        <thead>
        <tr>
            <th style="width: 3%">Orden</th>
            <th style="width: 10%">Obligación Ambiental</th>
            <th style="width: 31%">Descripción</th>
            <th style="width: 16%">Calificación</th>
            <th style="width: 15%">Hallazgo</th>
            <th style="width: 10%"><i class="fa fa-archive"></i> Evidencia/Anexo</th>
            <th style="width: 1%"></th>
        </tr>
        </thead>
    </table>

    %{--<div class="row-fluid"  style="width: 99.7%;height: 500px;overflow-y: auto;float: right;">--}%
        %{--<div class="span12">--}%
            %{--<div style="width: 1120px; height: 500px;">--}%
                %{--<table class="table table-condensed table-bordered table-striped" id="tablaH">--}%
                    %{--<tbody>--}%
                    %{--<g:each in="${leyes}" var="ley" status="j">--}%
                        %{--<tr>--}%
                            %{--<td style="width: 3%; color: #224aff"><b>${ley?.orden != 0 ? ley?.orden : ''}</b></br>--}%
                                %{--<a href="#" class="btn btn-xs btn-primary btnOrdenEva" data-id="${ley?.id}" title="Agregar orden" style="float: right">--}%
                                    %{--<i class="fa fa-plus"></i>--}%
                                %{--</a>--}%
                            %{--</td>--}%
                            %{--<td style="width: 10%; font-size: smaller">${ley?.marcoNorma?.norma?.nombre + " - Art. N° " + ley?.marcoNorma?.articulo?.numero}</td>--}%
                            %{--<td style="width: 30%; font-size: smaller">${ley?.marcoNorma?.literal ? (ley?.marcoNorma?.literal?.identificador + ")  " + ley?.marcoNorma?.literal?.descripcion) : ley?.marcoNorma?.articulo?.descripcion}</td>--}%
                            %{--<td style="width: 15%">--}%

                                %{--${ley?.calificacion?.sigla}--}%

                                %{--<table id="tabla_${pre?.id}">--}%
                                %{--<tbody>--}%
                                %{--<tr>--}%
                                %{--<td>--}%
                                %{--<div class="btn-group">--}%
                                %{--<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">--}%
                                %{--Calificar <span class="caret"></span>--}%
                                %{--</button>--}%
                                %{--<ul class="dropdown-menu">--}%
                                %{--<g:each in="${evaluacion.Calificacion.list([sort: 'nombre', order: 'asc'])}" var="cal">--}%
                                %{--<li style="background-color: ${cal?.tipo}"><a href="#" class="btnCalificacionEva" data-id="${cal?.id}" data-ley="${ley?.id}" title="${cal?.nombre}">${cal?.sigla}</a></li>--}%
                                %{--</g:each>--}%
                                %{--</ul>--}%
                                %{--</div>--}%
                                %{--</td>--}%
                                %{--<td style="background-color: ${ley?.calificacion?.tipo};" class="col-md-3">--}%
                                %{--<div class="divCalificacion_${ley?.id} col-md-4" title="${ley?.calificacion?.nombre}">--}%
                                %{--${ley?.calificacion?.sigla}--}%
                                %{--</div>--}%
                                %{--</td>--}%
                                %{--</tr>--}%
                                %{--</tbody>--}%
                                %{--</table>--}%
                            %{--</td>--}%
                            %{--<td style="width: 15%; font-size: smaller" title="${ley?.hallazgo?.descripcion ? ley?.hallazgo?.descripcion : 'Hallazgo no cargado'}">--}%
                                %{--<g:if test="${ley?.hallazgo?.descripcion}">--}%
                                    %{--<g:if test="${ley?.hallazgo?.descripcion?.size() > 100}">--}%
                                        %{--${ley?.hallazgo?.descripcion?.substring(0,100)}...--}%
                                    %{--</g:if>--}%
                                    %{--<g:else>--}%
                                        %{--${ley?.hallazgo?.descripcion}--}%
                                    %{--</g:else>--}%
                                %{--</g:if>--}%
                                %{--<g:else>--}%
                                    %{--NO--}%
                                %{--</g:else>--}%

                                %{--<a href="#" class="btn btn-xs btn-primary btnHallazgoEva" data-id="${ley?.id}" title="Agregar hallazgo" style="float: right">--}%
                                    %{--<i class="fa fa-plus"></i>--}%
                                %{--</a>--}%
                            %{--</td>--}%
                            %{--<td style="width: 10%">--}%

                                %{--<g:set value="${evaluacion.Anexo.findAllByEvaluacion(evaluacion.Evaluacion.get(ley?.id)).size()}" var="numero"/>--}%

                                %{--<i class="fa fa-folder-open"></i> Anexos : ${numero}--}%

                                %{--<a href="#" class="btn btn-xs btn-primary btnAnexoEva" data-id="${ley?.id}" title="Agregar anexo" style="float: right">--}%
                                    %{--<i class="fa fa-plus"></i>--}%
                                %{--</a>--}%
                            %{--</td>--}%
                        %{--</tr>--}%
                    %{--</g:each>--}%

                    %{--</tbody>--}%
                %{--</table>--}%

            %{--</div>--}%
        %{--</div>--}%
    %{--</div>--}%











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
            success: function (msgCom) {
                if(msgCom == 'ok'){
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
        bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x text-danger text-shadow'></i> Está seguro de cambiar el Marco Legal? </br>" +
        "</br><b style='color: #ec3120'>El marco legal solo puede ser cambiado cuando NO se encuentra en evaluacion!</b>", function (result) {
            if(result){
                $.ajax({
                    type: 'POST',
                    url: "${createLink(controller: 'evaluacion', action: 'verificarLegislacion_ajax')}",
                    data:{
                        id:${pre?.id}
                    },
                    success: function (msgLegal) {
                        var parts = msgLegal.split("_");
                        if(parts[0] == 'ok'){
                            log(parts[1],"error")
                        }else{
                            log(parts[1],"success");
                            setTimeout(function () {
                                location.href = "${createLink(controller:'auditoria',action:'leyes')}/" + ${pre?.id};
                            }, 1500);
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
            async: true,
            data: {
                id: ${pre?.id}
            },
            success: function (msgTabla) {
                $("#divTablaEvaluaciones").html(msgTabla).addClass('animated fadeInDown')
            }
        });
    }

</script>


</body>
</html>