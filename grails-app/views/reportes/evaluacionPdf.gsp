<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 26/06/2016
  Time: 14:52
--%>

<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 20/06/16
  Time: 10:57 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title></title>

    <rep:estilosNuevos orientacion="p" pagTitle="${"."}"/>

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
    b{
        font-size: 80%;
    }

    </style>

</head>

<body>
<rep:headerFooterNuevo title="${"Evaluación Ambiental"}" subtitulo="${''}" auditoria="${pre?.id}" especialista="${especialista?.id}" orden="${orden}"/>


<table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%">
    <thead>
    <tr>
        <th class="back" colspan="4"> MATRIZ DE OBLIGACIONES AMBIENTALES DE LA ESTACIÓN: '<util:renderHTML html="${pre?.estacion?.nombre?.toUpperCase()}"/>' </th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td style="width: 25%"><b>EMPRESA</b></td>
        <td style="width: 25%"><util:renderHTML html="${pre?.estacion?.comercializadora?.nombre?.toUpperCase()}"/></td>
        <td style="width: 25%"><b>RAZÓN SOCIAL AUDITOR</b></td>
        <td style="width: 25%"><util:renderHTML html="${especialista?.consultora?.nombre?.toUpperCase() ?: ' '}"/></td>
    </tr>
    <tr>
        <td style="width: 25%"><b>INSTALACIÓN</b></td>
        <td style="width: 25%"><util:renderHTML html="${pre?.estacion?.nombre?.toUpperCase()}"/></td>
        <td style="width: 25%"><b>TÉCNICO RESPONSABLE DE LA AUDITORÍA</b></td>
        <td style="width: 25%"></td>
    </tr>
    <tr>
        <td style="width: 25%"><b>PROCESO</b></td>
        <td style="width: 25%">REVISIÓN DEL CUMPLIMIENTO DE OBLIGACIONES AMBIENTALES</td>
        <td style="width: 25%"><b>FECHA DE ANÁLISIS</b></td>
        <td style="width: 25%"></td>
    </tr>
    <tr>
        <td style="width: 25%"><b>TÉCNICO RESPONSABLE DE LA EMPRESA</b></td>
        <td style="width: 25%"><util:renderHTML html="${ especialista?.titulo + " " + especialista?.nombre + " " + especialista?.apellido}"/></td>
        <td colspan="2"></td>
    </tr>
    </tbody>
</table>


</body>
</html>

