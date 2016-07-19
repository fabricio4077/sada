<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 25/06/2016
  Time: 18:00
--%>

<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 25/06/2016
  Time: 17:21
--%>

<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 25/06/2016
  Time: 17:03
--%>



<%@ page import="situacion.AnalisisLiquidas" contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Antecedente</title>

    <rep:estilosNuevos orientacion="p" pagTitle="${"."}" pags="${numero}"/>

    <style type="text/css">
    .table {
        /*margin-top      : 0.5cm;*/
        width           : 100%;
        border-collapse : collapse;
    }

    .table, .table td, .table th {
        border : solid 1px #444;
    }

    /*.table td, .table th {*/
    /*padding : 3px;*/
    /*}*/

    .text-right {
        text-align : right;
    }

    h1.break {
        page-break-before : always;
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
        font-size: 70%;
    }
    th{
        font-size: 70%;
    }

    @page{
        @bottom-right {
            content: 'Pág. ' counter(page);
        }
    }


</style>

</head>

<body>
%{--<rep:headerFooterNuevo title="${"Situación Ambiental"}" subtitulo="${''}" auditoria="${pre?.id}" especialista="${especialista?.id}" orden="${orden}" mes="${mes}" anio="${anio}"/>--}%
<rep:headerFooterNuevo title="${"Situación Ambiental"}" subtitulo="${''}" auditoria="${pre?.id}" orden="${orden}" mes="${mes}" anio="${anio}"/>
<util:renderHTML html="${"<b>Componente Físico</b><br></br>"}"/>
<util:renderHTML html="${"<ul>"}"/>
<util:renderHTML html="${"<b>Emisiones Gaseosas</b><br></br>"}"/>
<util:renderHTML html="${"</ul>"}"/>
<util:renderHTML html="${"<p style='text-align:justify'>" + emi + "</p>"}"/>

<util:renderHTML html="${"<ul>"}"/>
<util:renderHTML html="${"<b>Descargas Líquidas</b><br></br>"}"/>
<util:renderHTML html="${"</ul>"}"/>
<util:renderHTML html="${"<p style='text-align:justify'>" + des + "</p>"}"/>

<g:each in="${tablas}" var="tabla">
    <div class="alert alert-info" role="alert" style="text-align: left; margin-top: 10px; font-size: 70%">
        Fecha de Análisis: <b style="font-size: 95%"><util:fechaConFormato fecha="${tabla?.fecha}"/></b>
    </div>
    <table class="table table-bordered table-condensed table-hover" id="${tabla?.id}">
        <thead>
        <tr>
            <th style="width: 20%">Ensayos</th>
            <th style="width: 30%">Método de Referencia</th>
            <th style="width: 10%">Límites de detección</th>
            <th style="width: 8%">Unidades</th>
            <th style="width: 10%">Resultados</th>
            <th style="width: 10%">Límite máximo permisible</th>
        </tr>
        </thead>
    </table>

    <g:each in="${situacion.AnalisisLiquidas.findAllByTablaLiquidas(tabla)}" var="analisis">
        <table class="table table-bordered table-condensed table-hover">
            <tbody>
            <tr>
                <td style="width: 20%">${analisis?.elemento?.nombre}</td>
                <td style="width: 30%">${analisis?.referencia}</td>
                <td style="width: 10%">${analisis?.limite}</td>
                <td style="width: 8%">${analisis?.elemento?.unidad}</td>
                <td style="width: 10%">${analisis?.resultado}</td>
                <td style="width: 10%">${analisis?.maximo}</td>
            </tr>
            </tbody>
        </table>
    </g:each>

</g:each>

<util:renderHTML html="${"<ul>"}"/>
<util:renderHTML html="${"<b>Residuos Sólidos y Líquidos</b><br></br>"}"/>
<util:renderHTML html="${"</ul>"}"/>
<util:renderHTML html="${"<p style='text-align:justify'>" + res + "</p>"}"/>

<g:if test="${bio.length() > 0}">
    <util:renderHTML html="${"<b>Componente Biótico</b><br></br>"}"/>
    <util:renderHTML html="${"<p style='text-align:justify'>" + bio + "</p>"}"/>
</g:if>

<g:if test="${soc.length() > 0}">
    <util:renderHTML html="${"<b>Componente Social</b><br></br>"}"/>
    <util:renderHTML html="${"<p style='text-align:justify'>" + soc + "</p>"}"/>
</g:if>




</body>
</html>

