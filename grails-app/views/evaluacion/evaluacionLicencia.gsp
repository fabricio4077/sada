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
    <title>Evaluación Ambiental: Licencia</title>

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
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-key"></i> Evaluación Ambiental: Licencia</h3>
    </div>
    <div class="well" style="text-align: center; height: 200px">

        <div class="row" style="margin-top: 60px">
            <div class="col-md-4 negrilla control-label">
                Cargar los puntos de la licencia ambiental a ser evaluados:
            </div>

            <div class="btn-group">
                <a href="#" id="btnLicencia" class="btn btn-success btn-sm" title="Cargar puntos de la licencia a ser evaluados">
                    <i class="fa fa-plus"></i> Cargar Licencia
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
            <th style="width: 10%"><i class="fa fa-archive"></i> Evidencia/Anexo</th>
            <th style="width: 1%"></th>
        </tr>
        </thead>
    </table>

    <div id="divTablaLicencia">

    </div>


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

    // licencia

    $("#btnLicencia").click(function () {
       location.href="${createLink(controller: 'licencia', action: 'licencia')}/" + ${pre?.id}
    });

    cargarTablaLicencia();

    //función para cargar la tabla con las evaluaciones
    function  cargarTablaLicencia () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'evaluacion', action: 'tablaEvaLicencia_ajax')}',
            data: {
                id: ${pre?.id}
            },
            success: function (msg) {
                $("#divTablaLicencia").html(msg).addClass('animated fadeInDown')
            }
        });
    }


</script>

</body>
</html>