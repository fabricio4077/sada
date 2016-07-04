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

    <rep:estilosNuevos orientacion="l" pagTitle="${"."}" pags="${numero}"/>

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
        font-size: 90%;
    }

    th{
        font-size: 80%;
    }

    .fuente {
        font-size: 110%;
        font-weight: bold;
    }

    .negrita {
        font-weight: bold;
    }

    .izquierda{
        text-align: left;
    }

    @page{
        @bottom-right {
            content: 'Pág. ' counter(page);
        }
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
    <table class="table table-bordered table-condensed table-hover" style="margin-top: -1px">
        <tbody>
        <tr>
            <td style="width: 20%">OBJETVIVOS: </td>
            <td style="width: 70%" colspan="4">
                <g:set var="obj" value="${uni?.objetivo?.split("-")}"/>
                <ul>
                    <g:each in="${obj}" var="o" status="h">
                        <li style="text-align: left">
                            <util:renderHTML html="${o}"/>
                        </li>
                    </g:each>
                </ul>
            </td>
            <td style="width: 10%" rowspan="3">${uni?.codigo?.toUpperCase()}</td>
        </tr>
        <tr>
            <td>LUGAR DE APLICACIÓN: </td>
            <td colspan="4">ESTACIÓN DE SERVICIOS</td>
        </tr>
        <tr>
            <td>RESPONSABLE: </td>
            <td colspan="4">ADMINISTRADOR DE LA E/S</td>
        </tr>
        <tr>
            <td class="negrita" style="width: 10%">ASPECTO AMBIENTAL</td>
            <td class="negrita" style="width: 15%">IMPACTO IDENTIFICADO</td>
            <td class="negrita" style="width: 30%">MEDIDAS PROPUESTAS</td>
            <td class="negrita" style="width: 15%">INDICADORES</td>
            <td class="negrita" style="width: 15%">MEDIO DE VERIFICACIÓN</td>
            <td class="negrita" style="width: 20%">PLAZO</td>
        </tr>
        <g:each in="${planes}" var="planM">
            <g:if test="${planM?.aspectoAmbiental?.planManejoAmbiental?.nombre == uni?.nombre}">
                <tr>
                    <td><util:renderHTML html="${planM?.aspectoAmbiental?.descripcion}"/></td>
                    <td class="izquierda"><util:renderHTML html="${planM?.aspectoAmbiental?.impacto}"/></td>
                    <td class="izquierda"><util:renderHTML html="${planM?.medida ? planM?.medida?.descripcion : ''}"/></td>
                    <td class="izquierda"><util:renderHTML html="${planM?.medida?.indicadores ? planM?.medida?.indicadores : ''}"/></td>
                    <td class="izquierda"><util:renderHTML html="${planM?.medida?.verificacion ? planM?.medida?.verificacion : ''}"/></td>
                    <td><util:renderHTML html="${planM?.medida?.plazo ? planM?.medida?.plazo : ''}"/></td>
                </tr>
            </g:if>
        </g:each>
        </tbody>
    </table>

</g:each>

</body>
</html>

