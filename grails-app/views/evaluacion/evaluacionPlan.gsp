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

    .izquierda{
        text-align: left;
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
        </div>
    </div>
</div>

<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-leaf"></i> Evaluación Ambiental: Plan de Manejo Ambiental</h3>
    </div>
    <div class="well" style="text-align: center; height: 200px">

        %{--<g:if test="${anteriores}">--}%
        <g:if test="${planesAnteriores}">

            <div class="${plan.size() >0 ? 'hide' : ''}">
                <div class="col-md-3 negrilla control-label izquierda">Seleccione el Plan de Manejo Ambiental (anterior) del cual se realizará la Evaluación Ambiental:
                </div>

                <div class="col-md-4">
                    <g:select name="anteriores_name" class="form-control"
                              from="${planesAnteriores}" id="anteriores"
                              optionValue="${{it?.tipo?.descripcion + " - Período: " + it?.periodo?.inicio?.format("yyyy") + " - " + it?.periodo?.fin?.format("yyyy")}}" optionKey="id" disabled="${plan.size() > 0 ? 'true' : 'false'}"/>
                </div>
                <div class="col-md-2">
                    <a href="#" id="btnSeleccionarPlan" class="btn btn-info btn-sm ${plan.size() >0 ? 'disabled' : ''}" title="" style="margin-bottom: 20px; margin-top: 10px">
                        <i class="fa fa-check"></i> Seleccionar PMA
                    </a>
                </div>
            </div>

        </g:if>

        <g:if test="${plan.size() > 0}">
            <div class="col-md-3 negrilla control-label izquierda">
               Plan de Manejo Ambiental (anterior):
            </div>
        </g:if>
        <g:else>
            <div class="col-md-4 negrilla control-label izquierda">
                Opción 2: Crear un Plan de Manejo Ambiental (anterior) del cual se realizará la Evaluación Ambiental:
            </div>
        </g:else>


        <div class="btn-group col-md-5">
            <a href="#" id="btnCrearPlan" class="btn btn-success btn-sm ${plan.size() >0 ? 'hide' : ''}" title="">
                <i class="fa fa-plus"></i> Crear un PMA (anterior)
            </a>
            <a href="#" id="btnEditarPlan" class="btn btn-primary btn-sm ${plan.size() >0 ? '' : 'hide'}" title="">
                <i class="fa fa-pencil"></i> Editar PMA
            </a>
            <a href="#" id="btnBorrarPlan" class="btn btn-danger btn-sm ${plan.size() >0 ? '' : 'hide'}" title="">
                <i class="fa fa-trash"></i> Remover PMA
            </a>
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
        <th style="width: 10%"><i class="fa fa-folder-open-o"></i> Evidencia/Anexo</th>
        <th style="width: 1%"></th>
    </tr>
    </thead>
</table>

<div id="divTablaPlan">

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


<script type="text/javascript">

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


    $("#btnBorrarPlan").click(function () {
//        bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x text-danger text-shadow'></i> Está seguro de remover este PMA (anterior) de la Evaluación Ambiental, <br><br> toda la información asociada <b>(calificación, hallazgos, anexos)</b> se borrará también, desea continuar?", function (result){
        bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x text-danger text-shadow'></i> Está seguro de remover este PMA (anterior) de la Evaluación Ambiental?", function (result){
            if(result){
                $.ajax({
                    type: 'POST',
                    url: "${createLink(controller: 'planManejoAmbiental', action: 'removerPlanAnterior_ajax')}",
                    data:{
                        id: ${pre?.id}

                    },
                    success: function (msg){
                        if(msg == 'ok'){
                            log("PMA (anterior) removido correctamente","success");
                            setTimeout(function () {
                                location.reload(true)
                            }, 1500);
                        }else{
                            log("No se puede remover este PMA (anterior), ya se encuentra en proceso de evaluación!","error")
                        }
                    }
                });
            }
        });
    });

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
                            setTimeout(function () {
                                location.href="${createLink(controller: 'planManejoAmbiental', action: 'planManejoAmbiental')}?id=" + ${pre?.id} + "&band=" + true
                            }, 1500);
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
                id: ${pre?.id},
                band: 'true'
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
                $("#divTablaPlan").html(msg).addClass('animated fadeInDown')
            }
        });
    }


</script>

</body>
</html>