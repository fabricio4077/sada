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
        <h3 class="panel-title" style="text-align: center"><i class="fa fa-toggle-up"></i> Logotipos para impresión</h3>
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
            <g:select name="pp" from="${arr}" class="form-control"/>
            <g:select name="pp" from="${arr}" class="form-control"/>
            <g:select name="pp" from="${arr}" class="form-control"/>
        </div>
    </div>
    <div class="col-md-3">
        <div class="list-group">
            <li class="list-group-item list-group-item-success"><i class="glyphicon glyphicon-print"></i>  <b>Auditoría</b></li>
            <a href="#" class="list-group-item" id="imprimirFicha"><i class="fa fa-print"></i> Ficha Técnica</a>
            <a href="#" class="list-group-item">Morbi leo risus</a>
            <a href="#" class="list-group-item">Porta ac consectetur ac</a>
            <a href="#" class="list-group-item">Vestibulum at eros</a>
        </div>
    </div>
</div>

<script>

    $("#imprimirFicha").click(function () {
        var orden = $("#ordenFicha").val()
        var url = "${createLink(controller: 'reportes', action: 'fichaTecnicaPdf', id: pre?.id)}?orden=" + orden;
        location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url + "&filename=fichaTecnica.pdf";
        return false
    });


    cargarLogoConsultora(${especialista?.persona?.consultora?.id});

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

    cargarLogoComercializadora(${pre?.estacion?.comercializadora?.id});

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