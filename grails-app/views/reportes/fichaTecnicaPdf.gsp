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

    </style>

</head>

<body>





<rep:headerFooterNuevo title="${"Ficha Técnica"}" subtitulo="${''}" auditoria="${pre?.id}" especialista="${especialista?.id}" orden="${orden}"/>


<table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%">
    <thead>
    <tr>
        <th class="back" width="100px"> Proyecto </th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><b>Auditoría Ambiental de <util:clean str="${pre?.tipo?.descripcion}"/> ${pre?.periodo?.inicio?.format("yyyy") + " - " + pre?.periodo?.fin?.format("yyyy")} de la estación de servicios "<util:clean str="${pre?.estacion?.nombre}"/>" </b></td>

    </tr>
    </tbody>
</table>



<table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%; margin-top: -1px">
    <thead >
    <tr>
        <th class="back" width="109px">Razón Social de la estación de servicios</th>
        <th class="back" width="148px">Representante Legal</th>
        <th class="back" width="50px">Dirección</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><util:clean str="${pre?.estacion?.nombre}"/></td>
        <td><util:clean str="${pre?.estacion?.representante}"/></td>
        <td rowspan="3"><util:clean str="${pre?.estacion?.direccion}"/><br/>Provincia de <util:clean str="${pre?.estacion?.provincia?.nombre?.toLowerCase()}"/></td>
    </tr>
    <tr>
        <td>Teléfono</td>
        <td>${pre?.estacion?.telefono}</td>
    </tr>
    <tr>
        <td>Correo electrónico</td>
        <td>${pre?.estacion?.mail}</td>
    </tr>
    </tbody>
</table>

<table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%; margin-top: -1px">
    <thead >
    <tr>
        <th class="back" width="142px">Razón Social de la compañia</th>
        <th class="back" width="68px">Representante Legal de la Comercializadora</th>
        <th class="back" width="80px">Dirección</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><util:clean str="${pre?.estacion?.comercializadora?.nombre}"/></td>
        <td><util:clean str="${pre?.estacion?.comercializadora?.representante}"/></td>
        <td rowspan="3"><util:clean str="${pre?.estacion?.comercializadora?.direccion}"/></td>
    </tr>
    <tr>
        <td>Teléfono</td>
        <td>${pre?.estacion?.comercializadora?.telefono}</td>
    </tr>
    <tr>
        <td>Correo electrónico</td>
        <td>${pre?.estacion?.comercializadora?.mail}</td>
    </tr>
    </tbody>
</table>

<table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%; margin-top: -1px">
    <thead >
    <tr>
        <th class="back" width="200px">Facilidades</th>
        <th class="back" colspan="3" width="100px">Localización Geográfica del proyecto <br/> (Coordenadas Planas UTM WGS84)</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td rowspan="${coordenadas?.size()?.toInteger() + 1}"><br/><br/>Estación de Servicios</td>
        <td width="110px"> X </td>
        <td width="110px"> Y</td>
        <td rowspan="${coordenadas?.size()?.toInteger() + 1}"><br/> Cantón: <util:clean str="${canton?.nombre}"/>
            <br/> Provincia: <util:clean str="${pre?.estacion?.provincia?.nombre}"/> </td>
    </tr>
    <g:each in="${coordenadas}" var="coor">
        <tr>
            <td>${coor?.coordenadasX}</td>
            <td>${coor?.coordenadasY}</td>
        </tr>
    </g:each>
    </tbody>
</table>

<table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%; margin-top: -1px">
    <thead >
    <tr>
        <th class="back" width="59px">Nombre de la Compañia Consultora Ambiental</th>
        <th class="back" width="106px">Representante Legal</th>
        <th class="back" width="80px">Registro de la Compañia Consultora Ambiental</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><util:clean str="${especialista?.consultora?.nombre}"/></td>
        <td><util:clean str="${especialista?.consultora?.administrador}"/></td>
        <g:set var="reg" value="${especialista?.consultora?.registro}"/>
        <td>MAE: ${reg?.split("_")[0]} <br/> DPA: ${reg?.split("_")[1]}</td>
    </tr>
    <tr>
        <td>Dirección</td>
        <td colspan="2"><util:clean str="${especialista?.consultora?.direccion}"/></td>
    </tr>
    <tr>
        <td>RUC</td>
        <td colspan="2">${especialista?.consultora?.ruc}</td>
    </tr>
    <tr>
        <td>Teléfono</td>
        <td colspan="2">${especialista?.consultora?.telefono}</td>
    </tr>
    <tr>
        <td>Correo electrónico</td>
        <td colspan="2">${especialista?.consultora?.mail}</td>
    </tr>
    <tr>
        <td>Página web</td>
        <td colspan="2">${especialista?.consultora?.pagina}</td>
    </tr>
    </tbody>
</table>

<table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%; margin-top: -1px">
    <thead >
    <tr>
        <th class="back" width="115px">Cargo</th>
        <th class="back" width="100px">Equipo Técnico</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>Coordinación del Proyecto</td>
        <td><util:clean str="${coordinador?.titulo ?: ''}"/> <util:clean str="${coordinador?.nombre ?: ''}"/> <util:clean str="${coordinador?.apellido ?: ''}"/> </td>
    </tr>
    <tr>
        <td>Especialista Ambiental</td>
        <td><util:clean str="${especialista?.titulo ?: ''}"/> <util:clean str="${especialista?.nombre ?: ''}"/> <util:clean str="${especialista?.apellido ?: ''}"/></td>
    </tr>
    <tr>
        <td>Técnico Biólogo</td>
        <td><util:clean str="${biologo?.titulo ?: ''}"/> <util:clean str="${biologo?.nombre ?: ''}"/> <util:clean str="${biologo?.apellido ?: ''}"/></td>
    </tr>
    </tbody>
</table>
<table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%; margin-top: -1px">
    <thead>
    <tr>
        <th class="back" width="100px">Plazo de ejecución del estudio </th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>60 días</td>
    </tr>
    </tbody>
</table>

</body>
</html>

