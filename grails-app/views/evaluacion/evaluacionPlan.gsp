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
        <th style="width: 10%">Evidencia/Anexo</th>
        <th style="width: 1%"></th>
    </tr>
    </thead>
</table>

<div id="divTablaPlan">

</div>



</body>
</html>