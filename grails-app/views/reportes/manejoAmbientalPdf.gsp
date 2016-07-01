<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 30/06/2016
  Time: 20:01
--%>

<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 27/06/16
  Time: 02:00 PM
--%>



<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Síntesis de no conformidades y Plan de Acción</title>

    <rep:estilosNuevos orientacion="l" pagTitle="${"."}"/>

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
        font-size: 80%;
    }

    th{
        font-size: 80%;
    }

    .fuente {
        font-size: 110%;
        font-weight: bold;

    }

    </style>

</head>

<body>
<rep:headerFooterNuevo title="${"Actualización del Plan de Manejo Ambiental"}" subtitulo="${''}" auditoria="${pre?.id}" especialista="${especialista?.id}" orden="${orden}"/>

<g:each in="${unicos}" var="uni" status="j">

    <util:renderHTML html="${"<ul class='fuente'>"}"/>
    ${orden}.${j+1} <util:renderHTML html="${"<b class='fuente'>" + uni?.nombre + "</b>"}"/>
    <util:renderHTML html="${"</ul>"}"/>

    <util:renderHTML html="${"<p style='text-align:justify'>" + uni?.descripcion + "</p>"}"/>

    <table class="table table-bordered table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 100%"><util:renderHTML html="${uni?.nombre?.toUpperCase()}"/></th>
        </tr>
        </thead>
        <thead>
        <tr>
            <th style="width: 100%"><util:renderHTML html="${"PROGRAMA " + uni?.nombre?.split("Plan")[1].toUpperCase()}"/></th>
        </tr>
        </thead>
    </table>
    <table class="table table-bordered table-condensed table-hover">
        <tbody>
        <tr>
            <td style="width: 20%">Objetivos</td>
            <td style="width: 60%"><util:renderHTML html="${uni?.objetivo}"/></td>
            <td style="width: 20%">${uni?.codigo?.toUpperCase()}</td>
        </tr>
        </tbody>
    </table>

</g:each>

</body>
</html>

