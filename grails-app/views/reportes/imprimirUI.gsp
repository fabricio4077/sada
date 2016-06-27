<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 20/06/16
  Time: 03:15 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Imprimir Auditoría</title>
</head>

<body>

<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"><i class="fa fa-print"></i> Impresión</h3>
    </div>
    <div class="panel-group" style="height: 180px">
        <div class="alert alert-info" role="alert" style="text-align: center">
            <i class='fa fa-exclamation-triangle fa-2x text-warning text-shadow'></i> Los logotipos que se muestran a continuación se imprimirán en la cabecera de sus documentos!
        </div>

        <div class="row">
            <div class="col-md-12">
                <label class="col-md-2 control-label text-info">
                    Consultora
                </label>

                <div class="col-md-4" id="divLogoConsultora">

                </div>

                <label class="col-md-2 control-label text-info">
                    Comercializadora
                </label>

                <div class="col-md-4" id="divLogoComercializadora">

                </div>
            </div>
        </div>

    </div>
</div>

<div class="row">
    <div class="col-md-1">
        <div class="list-group">
            <li class="list-group-item list-group-item-info"> Orden</li>
            <g:select name="orden_name" id="ordenFicha" from="${arr}" class="form-control"/>
            <g:select name="orden2_name" id="ordenArea" from="${arr}" class="form-control"/>
            <g:select name="orden3_name" id="ordenSit" from="${arr}" class="form-control"/>
            <g:select name="orden4_name" id="ordenEva" from="${arr}" class="form-control"/>
            <g:select name="orden4_name" id="ordenAccion" from="${arr}" class="form-control"/>
        </div>
    </div>
    <div class="col-md-3">
        <div class="list-group">
            <li class="list-group-item list-group-item-success"><i class="glyphicon glyphicon-print"></i>  <b>Auditoría</b></li>
            <a href="#" class="list-group-item" id="imprimirFicha"><i class="fa fa-print"></i> Ficha Técnica</a>
            <a href="#" class="list-group-item" id="imprimirArea"><i class="fa fa-print"></i> Áreas de la estación </a>
            <a href="#" class="list-group-item" id="imprimirSit"> <i class="fa fa-print"></i> Situación Ambiental </a>
            <a href="#" class="list-group-item" id="imprimirEva"><i class="fa fa-print"></i> Evaluación Ambiental</a>
            <a href="#" class="list-group-item" id="imprimirAccion"><i class="fa fa-print"></i> Plan de Acción</a>
        </div>
    </div>

    <div class="col-md-1">
        <div class="list-group">
            <li class="list-group-item list-group-item-info"> Orden</li>
            <g:select name="orden2_name" id="ordenMet" from="${arr}" class="form-control"/>
            <g:select name="orden3_name" id="ordenAlc" from="${arr}" class="form-control"/>
            <g:select name="orden4_name" id="ordenAnt" from="${arr}" class="form-control"/>
        </div>
    </div>
    <div class="col-md-3">
        <div class="list-group">
            <li class="list-group-item list-group-item-success"><i class="glyphicon glyphicon-print"></i>  <b>Complementos</b></li>
            <a href="#" class="list-group-item" id="imprimirMet"><i class="fa fa-print"></i> Metodología </a>
            <a href="#" class="list-group-item" id="imprimirAlc"> <i class="fa fa-print"></i> Alcance </a>
            <a href="#" class="list-group-item" id="imprimirAnt"><i class="fa fa-print"></i> Antecedentes</a>
        </div>
    </div>

</div>

<script>

    $("#imprimirFicha").click(function () {
        var orden = $("#ordenFicha").val();
        var url = "${createLink(controller: 'reportes', action: 'fichaTecnicaPdf', id: pre?.id)}?orden=" + orden;
        location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url + "&filename=fichaTecnica_${pre?.id}.pdf";
        return false
    });

    $("#imprimirMet").click(function () {
        var orden = $("#ordenMet").val();
        var url = "${createLink(controller: 'reportes', action: 'metodologiaPdf', id: pre?.id)}?orden=" + orden;
        location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url + "&filename=metodologia_${pre?.id}.pdf";
        return false
    });

    $("#imprimirObj").click(function () {
        var orden = $("#ordenObj").val();
        var url = "${createLink(controller: 'reportes', action: 'objetivosPdf', id: pre?.id)}?orden=" + orden;
        location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url + "&filename=objetivos_${pre?.id}.pdf";
        return false
    });

    $("#imprimirAnt").click(function () {
        var orden = $("#ordenAnt").val();
        var url = "${createLink(controller: 'reportes', action: 'antecedentePdf', id: pre?.id)}?orden=" + orden;
        location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url + "&filename=antecedentes_${pre?.id}.pdf";
        return false
    });

    $("#imprimirAlc").click(function () {
        var orden = $("#ordenAlc").val();
        var url = "${createLink(controller: 'reportes', action: 'alcancePdf', id: pre?.id)}?orden=" + orden;
        location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url + "&filename=alcance_${pre?.id}.pdf";
        return false
    });

    $("#imprimirSit").click(function () {
        var orden = $("#ordenSit").val();
        var url = "${createLink(controller: 'reportes', action: 'situacionPdf', id: pre?.id)}?orden=" + orden;
        location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url + "&filename=situacion_${pre?.id}.pdf";
        return false
    });

    $("#imprimirArea").click(function () {
        var orden = $("#ordenArea").val();
        var url = "${createLink(controller: 'reportes', action: 'areasPdf', id: pre?.id)}?orden=" + orden;
        location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url + "&filename=areas_${pre?.id}.pdf";
        return false
    });

    $("#imprimirEva").click(function () {
        var orden = $("#ordenEva").val();
        var url = "${createLink(controller: 'reportes', action: 'evaluacionPdf', id: pre?.id)}?orden=" + orden;
        location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url + "&filename=evaluacion_${pre?.id}.pdf";
        return false
    });

    $("#imprimirAccion").click(function () {
        var orden = $("#ordenAccion").val();
        var url = "${createLink(controller: 'reportes', action: 'planAccionPdf', id: pre?.id)}?orden=" + orden;
        location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url + "&filename=planAccion_${pre?.id}.pdf";
        return false
    });





    <g:if test="${especialista?.persona?.consultora?.logotipo}">
    cargarLogoConsultora(${especialista?.persona?.consultora?.id});
    </g:if>

    function cargarLogoConsultora (idO) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'consultora', action: 'consultoraLogo_ajax')}",
            data:{
                id: idO
            },
            success : function (msg) {
                $("#divLogoConsultora").html(msg);
            }
        });
    }

    <g:if test="${pre?.estacion?.comercializadora?.logotipo}">
    cargarLogoComercializadora(${pre?.estacion?.comercializadora?.id});
    </g:if>


    function cargarLogoComercializadora (idO) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'comercializadora' ,action: 'comercializadoraLogo_ajax')}",
            data:{
                id: idO
            },
            success : function (msg) {
                $("#divLogoComercializadora").html(msg);
            }
        });
    }
</script>

</body>
</html>