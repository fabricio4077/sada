<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 04/04/2016
  Time: 18:30
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada"/>
    <title>Inicio</title>
    <style type="text/css">

    body {

    }

    .color1 {
        background : #e7f5f1;
        border: thin;
    }

    .color2 {
        background : #FFF;
    }

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

    .panel{
        border-top-width: 4px;
        boder-color: #cfdbe2;
    }




    .easy-pie {
        display: inline-block;
        padding: 0 5px 10px;
        position: relative;
    }
    .easy-pie .percent {
        font-weight: 300;
        left: 0;
        line-height: 100%;
        position: absolute;
        width: 100%;
    }
    .easy-pie .percent::after {
        content: "%";
    }
    .easy-pie.main-pie .percent {
        font-size: 50px;
        margin-top: 49px;
        text-align: center;
    }
    .easy-pie.main-pie .percent:not([class*="c-"]) {
        color: rgba(255, 255, 255, 0.7);
    }
    .easy-pie.main-pie .percent::after {
        font-size: 30px;
    }
    .easy-pie.main-pie .pie-title {
        color: #fff;
    }
    .easy-pie:not(.main-pie) .percent {
        font-size: 26px;
        margin-top: 37px;
    }
    .easy-pie:not(.main-pie) .percent::after {
        font-size: 20px;
    }
    .easy-pie .pie-title {
        bottom: -3px;
        left: 0;
        position: absolute;
        text-align: center;
        width: 100%;
    }

    </style>
</head>

<body>

%{--<div style="margin-bottom: 100px">--}%
%{--<div class="list-group col-md-4" style="text-align: center">--}%
%{--<g:link controller="preauditoria" action="crearAuditoria" class="list-group-item bgOpcion bg-claro">--}%
%{--<h4 class="list-group-item-heading"><span class="icon"></span>--}%
%{--<i class="fa fa-plus"></i>--}%
%{--</h4>--}%
%{--<p class="list-group-item-text">--}%
%{--<strong>Iniciar Auditoría</strong>--}%
%{--</p>--}%
%{--</g:link>--}%
%{--</div>--}%

%{--<div class="list-group col-md-4" style="text-align: center">--}%
%{--<g:link controller="preauditoria" action="list" class="list-group-item bgOpcion bg-oscuro">--}%
%{--<h4 class="list-group-item-heading"><span class="icon"></span>--}%
%{--<i class="fa fa-history"></i>--}%
%{--</h4>--}%
%{--<p class="list-group-item-text">--}%
%{--<strong>Continuar una Auditoría</strong>--}%
%{--</p>--}%
%{--</g:link>--}%
%{--</div>--}%

%{--<g:if test="${session.perfil.codigo == 'ADMI'}">--}%
%{--<div class="list-group col-md-4" style="text-align: center;">--}%
%{--<g:link controller="persona" action="list" class="list-group-item bgOpcion bg-otro">--}%
%{--<h4 class="list-group-item-heading"><span class="icon"></span>--}%
%{--<i class="fa fa-navicon"></i>--}%
%{--</h4>--}%
%{--<p class="list-group-item-text">--}%
%{--<strong>Listar Auditorías</strong>--}%
%{--</p>--}%
%{--</g:link>--}%
%{--</div>--}%
%{--</g:if>--}%
%{--</div>--}%




<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title">Bienvenido a SADA!</h3>
    </div>
    <div class="panel-body">

        SISTEMA  WEB  DE  AUDITORÍA  Y  MONITOREO MEDIO  AMBIENTAL  PARA  ESTACIONES  DE COMERCIALIZACIÓN DE COMBUSTIBLES

        <br>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur aliquet commodo urna,
    vel semper eros placerat quis. Sed gravida nisi vel placerat iaculis. Etiam ac ante iaculis,
    consequat odio sed, rutrum mauris. Quisque nec eros non nibh convallis aliquam. Nullam mauris diam,
    dictum nec eros eu, pretium vestibulum purus. Nunc ornare auctor dictum. Suspendisse quis nisl arcu.
    </div>
</div>

<div class="panel panel-success col-md-3" >
    <div class="panel-heading">
        <h3 class="panel-title">Auditoría</h3>
    </div>
    <div class="panel-body">

        %{--<div>--}%
        <div class="list-group" style="text-align: center">
            <g:link controller="preauditoria" action="crearAuditoria" class="list-group-item bgOpcion bg-claro">
                <h4 class="list-group-item-heading"><span class="icon"></span>
                    <i class="fa fa-plus"></i>
                </h4>
                <p class="list-group-item-text">
                    <strong>Iniciar Auditoría</strong>
                </p>
            </g:link>
        </div>

        <div class="list-group" style="text-align: center">
            <g:link controller="preauditoria" action="list" class="list-group-item bgOpcion bg-oscuro">
                <h4 class="list-group-item-heading"><span class="icon"></span>
                    <i class="fa fa-history"></i>
                </h4>
                <p class="list-group-item-text">
                    <strong>Continuar una Auditoría</strong>
                </p>
            </g:link>
        </div>

        <g:if test="${session.perfil.codigo == 'ADMI'}">
            <div class="list-group" style="text-align: center;">
                <g:link controller="persona" action="list" class="list-group-item bgOpcion bg-otro">
                    <h4 class="list-group-item-heading"><span class="icon"></span>
                        <i class="fa fa-navicon"></i>
                    </h4>
                    <p class="list-group-item-text">
                        <strong>Listar Auditorías</strong>
                    </p>
                </g:link>
            </div>
        </g:if>
    %{--</div>--}%


    </div>
</div>


<div class="panel panel-danger col-md-5" style="margin-left: 20px; height: 315px">
    <div class="panel-heading">
        <h3 class="panel-title">Alertas</h3>
    </div>
    <div class="panel-body">


        %{--<div class="media-box">--}%
            %{--<div class="pull-left">--}%
                %{--<span class="fa-stack">--}%
                    %{--<em class="fa fa-circle fa-stack-2x text-purple"></em>--}%
                    %{--<em class="fa fa-cloud-upload fa-stack-1x fa-inverse text-white"></em>--}%
                %{--</span>--}%
            %{--</div>--}%
            %{--<div class="media-box-body clearfix">--}%
                %{--<small class="text-muted pull-right ml">15m</small>--}%
                %{--<div class="media-box-heading">--}%
                    %{--<a class="text-purple m0" href="#">NEW FILE</a>--}%
                %{--</div>--}%
                %{--<p class="m0">--}%
            %{--</div>--}%
        %{--</div>--}%


        <table class="table table-inner table-vmiddle">
            <thead>
            <tbody>
            <tr>
                <td class="">
                    <div class="pull-left">
                        <span class="fa-stack">
                            <em class="fa fa-circle fa-stack-2x text-danger"></em>
                            <em class="fa fa-exclamation fa-stack-1x fa-inverse text-danger"></em>
                        </span>
                    </div>
                </td>
                <td>Alerta 1</td>
                <td class="f-500 c-cyan"></td>
            </tr>
            <tr>
                <td class="">
                    <div class="pull-left">
                        <span class="fa-stack">
                            <em class="fa fa-circle fa-stack-2x text-info"></em>
                            <em class="fa fa-cloud-upload fa-stack-1x fa-inverse text-white"></em>
                        </span>
                    </div>
                </td>
                <td>Alerta 2</td>
                <td class="f-500 c-cyan"></td>
            </tr>
            <tr>
                <td class="">
                    <div class="pull-left">
                        <span class="fa-stack">
                            <em class="fa fa-circle fa-stack-2x text-success"></em>
                            <em class="fa fa-clock-o fa-stack-1x fa-inverse text-white"></em>
                        </span>
                    </div>
                </td>
                <td>Ultima auditoría </td>
                <td class="">
                    <div class="easy-pie sub-pie-1" data-percent="56">
                        %{--<div class="percent">56</div>--}%
                        <div id="example1" style="float: right"></div>

                        <div class="pie-title">Avance de la auditoría %</div>
                        <canvas height="95" width="95"></canvas>
                    </div>

                </td>
            </tr>
            <tr>



            </tr>

            </tbody>
        </table>


    </div>
</div>


<div class="row">
    <div class="col-sm-3 col-md-3">
        <div class="thumbnail">
            <img class="img-responsive pull-right" src="${resource(dir: 'images/inicio', file: 'manual_usuario_3.png')}"/>
            <div class="caption">
                <h3>Nuevo en SADA?</h3>
                <p>Revise nuestro manual de usuario!</p>
                <p><a href="#" class="btn btn-default" role="button">Manual</a></p>
            </div>
        </div>
    </div>
</div>


<div class="row">
    <div class="col-md-2 col-md-offset-10 text-right">
        Versión ${message(code: 'version', default: '1.1.0x')}
    </div>
</div>

<script type="text/javascript">

    %{--cargarBienvenida();--}%

    %{--function cargarBienvenida () {--}%
        %{--log("Bienvenido ${session.usuario.nombre + " " + session.usuario.apellido}", "success");--}%
    %{--}--}%

    $("#example1").radialProgress("init", {
                'size': 70,
                'fill': 5
    }).radialProgress("to", {'perc': 56, 'time': 3000});


    %{--$("#btnInicio").click(function () {--}%
    %{--$.ajax({--}%
    %{--type: 'POST',--}%
    %{--url: "${createLink(controller: 'preauditoria', action:'opciones_ajax')}",--}%
    %{--success: function (msg){--}%
    %{--bootbox.dialog({--}%
    %{--id      : "dlgInicioAudt",--}%
    %{--title   : '<i class="fa fa-pencil-square"></i> Opciones de Auditoría',--}%
    %{--class   : "",--}%
    %{--message : msg,--}%
    %{--buttons : {--}%
    %{--cancelar : {--}%
    %{--label     : '<i class="fa fa-times"></i> Cancelar',--}%
    %{--className : 'btn-primary',--}%
    %{--callback  : function () {--}%
    %{--}--}%
    %{--}--}%
    %{--}--}%
    %{--})--}%
    %{--}--}%

    %{--})--}%

    %{--});--}%

</script>


</body>
</html>