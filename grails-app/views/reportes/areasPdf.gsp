<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 25/06/2016
  Time: 21:54
--%>



<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Objetivos</title>

    <rep:estilosNuevos orientacion="p" pagTitle="${"."}" pags="${numero}"/>

    <style type="text/css">
    .table {
        margin-top      : 0.5cm;
        width           : 100%;
        border-collapse : collapse;
    }

    .table, .table td, .table th {
        border : solid 1px #444;
    }

    .table td, .table th {
        padding : 3px;
    }

    .text-right {
        text-align : right;
    }

    h1.break {
        page-break-before : always;
    }

    small {
        font-size : 70%;
        color     : #777;
    }

    .table th {
        background     : #326090;
        color          : #fff;
        text-align     : center;
        /*text-transform : uppercase;*/
    }

    .actual {
        background : #c7daed;
    }

    .info {
        background : #6fa9ed;
    }

    .text-right {
        text-align : right !important;
    }

    .text-center {
        text-align : center;
    }

    td {
        text-align: center;
    }

    .centrar {
        text-align: center;
    }

    @page{
        @bottom-right {
            content: 'Pág. ' counter(page);
        }
    }


</style>

</head>

<body>
%{--<rep:headerFooterNuevo title="${"Descripción de las actividades de la estación de servicios"}" subtitulo="${''}" auditoria="${pre?.id}" especialista="${especialista?.id}" orden="${orden}" mes="${mes}" anio="${anio}"/>--}%
<rep:headerFooterNuevo title="${"Descripción de las actividades de la estación de servicios"}" subtitulo="${''}" auditoria="${pre?.id}" orden="${orden}" mes="${mes}" anio="${anio}"/>

<util:renderHTML html="${"La estación de servicios '${pre?.estacion?.nombre}', cuenta con las siguientes áreas: <br></br>"}"/>

<util:renderHTML html="${"<ul>"}"/>
<g:each in="${ares}" var="ar">
    <util:renderHTML html="${"<li>" + ar?.area?.nombre + "</li>"}"/>
</g:each>
<util:renderHTML html="${"</ul>"}"/>

<table class="table table-bordered table-condensed table-hover">
    <thead>
    <tr>
        <th style="width: 30%">Infraestructura</th>
        <th style="width: 30%">Descripción</th>
        <th style="width: 40%">Fotografía</th>
    </tr>
    </thead>
</table>
<g:each in="${ares}" var="are">
    <table class="table table-bordered table-condensed table-hover" style="margin-top: 0px">
        <tbody>
        <tr>
            <td style="width: 30%"><util:renderHTML html="${are?.area?.nombre}"/></td>
            <td style="width: 30%; text-align: left"><util:renderHTML html="${are?.descripcion}"/></td>
        <td style="width: 40%">
            <g:if test="${are?.foto1}">
                <img src="${resource(dir: 'images/areas/', file: are?.foto1)}" style="width: 150px; height: 100px"/>
            </g:if>
            <g:if test="${are?.foto2}">
                <img src="${resource(dir: 'images/areas/', file: are?.foto2)}" style="width: 150px; height: 100px"/>
            </g:if>
            <g:if test="${are?.foto3}">
                <img src="${resource(dir: 'images/areas/', file: are?.foto3)}" style="width: 150px; height: 100px"/>
            </g:if>
            </td>
        </tr>
        </tbody>
    </table>
</g:each>

<util:renderHTML html="${"<p style='text-align:justify'> Asimismo, la Estación de Servicios cuenta con ${extintores.size()} extintores localizados en las diferentes áreas de la estación. La distribución corresponde a: </p>"}"/>

<div style="margin-left: 100px">
    <table class="table table-bordered table-condensed table-hover" style="width: 70%">
        <thead>
        <tr>
            <th style="width: 30%">Extintor </th>
            <th style="width: 30%">Capacidad</th>
            <th style="width: 40%">Área</th>
        </tr>
        </thead>
    </table>

    <g:each in="${extintores}" var="ext">
        <table class="table table-bordered table-condensed table-hover" style="width: 70%; margin-top: 0px">
            <tbody>
            <tr>
                <td style="width: 30%"><util:renderHTML html="${ext?.tipo}"/></td>
                <td style="width: 30%"><util:renderHTML html="${ext?.capacidad + " lbs"}"/></td>
                <td style="width: 40%; text-align:left"><util:renderHTML html="${ext?.ares?.area?.nombre}"/></td>
            </tr>
            </tbody>
        </table>
    </g:each>
</div>



</body>
</html>

