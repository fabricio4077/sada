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
        font-size: 80%;
    }
    b{
        font-size: 80%;
    }

    @page{
        @bottom-right {
            content: 'Pág. ' counter(page);
        }
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

<table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%">
    <thead>
    <tr>
        <th class="back" colspan="6">LEGISLACIÓN</th>
    </tr>
    </thead>
</table>
<table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%">
    <thead>
    <tr>
        <th class="back" rowspan="2" style="width: 5%">N°</th>
        <th class="back" rowspan="2" style="width: 15%">OBLIGACIÓN AMBIENTAL</th>
        <th class="back" rowspan="2" style="width: 25%">DESCRIPCIÓN</th>
        <th class="back" colspan="5" rowspan="2" style="width: 25%">CALIFICACIÓN
    <tr>
        <th style="width: 45px; background-color: #92D050; color: #000000">C</th>
        <th style="width: 45px; background-color: #FF0000; color: #000000">NC+</th>
        <th style="width: 45px; background-color: #FFC000; color: #000000">nc-</th>
        <th style="width: 47px; background-color: #FFFF00; color: #000000">O</th>
        <th style="width: 40px; background-color: #FFFFFF; color: #000000">N/A</th>
    </tr>
    </th>
    <th class="back" rowspan="2" style="width: 15% ;">HALLAZGO </th>
    <th class="back" rowspan="2" style="width: 15%">EVIDENCIA /ANEXO </th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${leyes}" var="ley" status="j">
        <tr>
            %{--<td>${j+1}</td>--}%
            <td>${ley?.orden}</td>
            <td><util:renderHTML html="${ley?.marcoNorma?.norma?.nombre + " - Art. N° " + ley?.marcoNorma?.articulo?.numero}"/></td>
            <td style="text-align: left"><util:renderHTML html="${ley?.marcoNorma?.literal ? (ley?.marcoNorma?.literal?.identificador + ")  " + ley?.marcoNorma?.literal?.descripcion) : ley?.marcoNorma?.articulo?.descripcion}"/></td>
            <g:if test="${ley?.calificacion?.sigla == 'C'}">
                <td style="width: 45px; background-color: #92D050; color: #000000">${ley?.calificacion?.sigla}</td>
                <td style="width: 45px;"></td>
                <td style="width: 45px;"></td>
                <td style="width: 45px;"></td>
                <td style="width: 45px;"></td>
            </g:if>
            <g:if test="${ley?.calificacion?.sigla == 'NC+'}">
                <td style="width: 45px"></td>
                <td style="width: 45px; background-color: #FF0000; color: #000000">${ley?.calificacion?.sigla}</td>
                <td style="width: 45px;"></td>
                <td style="width: 45px;"></td>
                <td style="width: 45px;"></td>
            </g:if>
            <g:if test="${ley?.calificacion?.sigla == 'nc-'}">
                <td style="width: 45px"></td>
                <td style="width: 45px"></td>
                <td style="width: 45px; background-color: #FFC000; color: #000000">${ley?.calificacion?.sigla}</td>
                <td style="width: 45px;"></td>
                <td style="width: 45px;"></td>
            </g:if>
            <g:if test="${ley?.calificacion?.sigla == 'O'}">
                <td style="width: 45px"></td>
                <td style="width: 45px"></td>
                <td style="width: 45px;"></td>
                <td style="width: 47px; background-color: #FFFF00; color: #000000">${ley?.calificacion?.sigla}</td>
                <td style="width: 45px;"></td>
            </g:if>
            <g:if test="${ley?.calificacion?.sigla == 'N/A'}">
                <td style="width: 45px"></td>
                <td style="width: 45px;"></td>
                <td style="width: 45px;"></td>
                <td style="width: 45px;"></td>
                <td style="width: 40px; background-color: #FFFFFF; color: #000000">${ley?.calificacion?.sigla}</td>
            </g:if>
            <g:if test="${!ley?.calificacion}">
                <td style="width: 45px"></td>
                <td style="width: 45px"></td>
                <td style="width: 45px"></td>
                <td style="width: 45px"></td>
                <td style="width: 45px"></td>
            </g:if>

            <td style="text-align: left"><util:renderHTML html="${ley?.hallazgo?.descripcion}"/></td>
            <td><util:renderHTML html="${ley?.evidencia}"/></td>
        </tr>
    </g:each>
    </tbody>
</table>
<table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%">
    <thead>
    <tr>
        <th class="back" colspan="6">PLAN DE MANEJO AMBIENTAL</th>
    </tr>
    </thead>
</table>
<table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%">
    <thead>
    <tr>
        <th class="back" rowspan="2" style="width: 5%">N°</th>
        <th class="back" rowspan="2" style="width: 15%">OBLIGACIÓN AMBIENTAL</th>
        <th class="back" rowspan="2" style="width: 25%">DESCRIPCIÓN</th>
        <th class="back" colspan="5" rowspan="2" style="width: 25%">CALIFICACIÓN
    <tr>
        <th style="width: 45px; background-color: #92D050; color: #000000">C</th>
        <th style="width: 45px; background-color: #FF0000; color: #000000">NC+</th>
        <th style="width: 45px; background-color: #FFC000; color: #000000">nc-</th>
        <th style="width: 47px; background-color: #FFFF00; color: #000000">O</th>
        <th style="width: 40px; background-color: #FFFFFF; color: #000000">N/A</th>
    </tr>
    </th>
    <th class="back" rowspan="2" style="width: 15% ;">HALLAZGO </th>
    <th class="back" rowspan="2" style="width: 15%">EVIDENCIA /ANEXO </th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${planes}" var="plan" status="j">
        <tr>
            %{--<td>${j+1}</td>--}%
            <td>${plan?.orden}</td>
            <td><util:renderHTML html="${plan?.planAuditoria?.aspectoAmbiental?.planManejoAmbiental?.nombre}"/></td>
            <td style="text-align: left"><util:renderHTML html="${plan?.planAuditoria?.aspectoAmbiental?.descripcion + " - " + plan?.planAuditoria?.medida?.descripcion}"/></td>
            <g:if test="${plan?.calificacion?.sigla == 'C'}">
                <td style="width: 45px; background-color: #92D050; color: #000000">${plan?.calificacion?.sigla}</td>
                <td style="width: 45px;"></td>
                <td style="width: 45px;"></td>
                <td style="width: 45px;"></td>
                <td style="width: 45px;"></td>
            </g:if>
            <g:if test="${plan?.calificacion?.sigla == 'NC+'}">
                <td style="width: 45px"></td>
                <td style="width: 45px; background-color: #FF0000; color: #000000">${plan?.calificacion?.sigla}</td>
                <td style="width: 45px;"></td>
                <td style="width: 45px;"></td>
                <td style="width: 45px;"></td>
            </g:if>
            <g:if test="${plan?.calificacion?.sigla == 'nc-'}">
                <td style="width: 45px"></td>
                <td style="width: 45px"></td>
                <td style="width: 45px; background-color: #FFC000; color: #000000">${plan?.calificacion?.sigla}</td>
                <td style="width: 45px;"></td>
                <td style="width: 45px;"></td>
            </g:if>
            <g:if test="${plan?.calificacion?.sigla == 'O'}">
                <td style="width: 45px"></td>
                <td style="width: 45px"></td>
                <td style="width: 45px;"></td>
                <td style="width: 47px; background-color: #FFFF00; color: #000000">${plan?.calificacion?.sigla}</td>
                <td style="width: 45px;"></td>
            </g:if>
            <g:if test="${plan?.calificacion?.sigla == 'N/A'}">
                <td style="width: 45px"></td>
                <td style="width: 45px;"></td>
                <td style="width: 45px;"></td>
                <td style="width: 45px;"></td>
                <td style="width: 40px; background-color: #FFFFFF; color: #000000">${plan?.calificacion?.sigla}</td>
            </g:if>
            <g:if test="${!plan?.calificacion}">
                <td style="width: 45px"></td>
                <td style="width: 45px"></td>
                <td style="width: 45px"></td>
                <td style="width: 45px"></td>
                <td style="width: 45px"></td>
            </g:if>
            <td style="text-align: left"><util:renderHTML html="${plan?.hallazgo?.descripcion}"/></td>
            <td><util:renderHTML html="${plan?.evidencia}"/></td>
        </tr>
    </g:each>
    </tbody>
</table>

<g:if test="${pre?.tipo?.codigo != 'LCM1'}">
    <table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%">
        <thead>
        <tr>
            <th class="back" colspan="6">LICENCIA</th>
        </tr>
        </thead>
    </table>
    <table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%">
        <thead>
        <tr>
            <th class="back" rowspan="2" style="width: 5%">N°</th>
            <th class="back" rowspan="2" style="width: 15%">OBLIGACIÓN AMBIENTAL</th>
            <th class="back" rowspan="2" style="width: 25%">DESCRIPCIÓN</th>
            <th class="back" colspan="5" rowspan="2" style="width: 25%">CALIFICACIÓN
        <tr>
            <th style="width: 45px; background-color: #92D050; color: #000000">C</th>
            <th style="width: 45px; background-color: #FF0000; color: #000000">NC+</th>
            <th style="width: 45px; background-color: #FFC000; color: #000000">nc-</th>
            <th style="width: 47px; background-color: #FFFF00; color: #000000">O</th>
            <th style="width: 40px; background-color: #FFFFFF; color: #000000">N/A</th>
        </tr>
        </th>
        <th class="back" rowspan="2" style="width: 15% ;">HALLAZGO </th>
        <th class="back" rowspan="2" style="width: 15%">EVIDENCIA /ANEXO </th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${licencias}" var="lic" status="j">
            <tr>
                <td>${lic?.orden}</td>
                <td><util:renderHTML html="${"Licencia Ambiental"}"/></td>
                <td style="text-align: left"><util:renderHTML html="${lic?.licencia?.descripcion}"/></td>
                <g:if test="${lic?.calificacion?.sigla == 'C'}">
                    <td style="width: 45px; background-color: #92D050; color: #000000">${lic?.calificacion?.sigla}</td>
                    <td style="width: 45px;"></td>
                    <td style="width: 45px;"></td>
                    <td style="width: 45px;"></td>
                    <td style="width: 45px;"></td>
                </g:if>
                <g:if test="${lic?.calificacion?.sigla == 'NC+'}">
                    <td style="width: 45px"></td>
                    <td style="width: 45px; background-color: #FF0000; color: #000000">${lic?.calificacion?.sigla}</td>
                    <td style="width: 45px;"></td>
                    <td style="width: 45px;"></td>
                    <td style="width: 45px;"></td>
                </g:if>
                <g:if test="${lic?.calificacion?.sigla == 'nc-'}">
                    <td style="width: 45px"></td>
                    <td style="width: 45px"></td>
                    <td style="width: 45px; background-color: #FFC000; color: #000000">${lic?.calificacion?.sigla}</td>
                    <td style="width: 45px;"></td>
                    <td style="width: 45px;"></td>
                </g:if>
                <g:if test="${lic?.calificacion?.sigla == 'O'}">
                    <td style="width: 45px"></td>
                    <td style="width: 45px"></td>
                    <td style="width: 45px;"></td>
                    <td style="width: 47px; background-color: #FFFF00; color: #000000">${lic?.calificacion?.sigla}</td>
                    <td style="width: 45px;"></td>
                </g:if>
                <g:if test="${lic?.calificacion?.sigla == 'N/A'}">
                    <td style="width: 45px"></td>
                    <td style="width: 45px;"></td>
                    <td style="width: 45px;"></td>
                    <td style="width: 45px;"></td>
                    <td style="width: 40px; background-color: #FFFFFF; color: #000000">${lic?.calificacion?.sigla}</td>
                </g:if>
                <g:if test="${!lic?.calificacion}">
                    <td style="width: 45px"></td>
                    <td style="width: 45px"></td>
                    <td style="width: 45px"></td>
                    <td style="width: 45px"></td>
                    <td style="width: 45px"></td>
                </g:if>

                <td style="text-align: left"><util:renderHTML html="${lic?.hallazgo?.descripcion}"/></td>
                <td><util:renderHTML html="${lic?.evidencia}"/></td>
            </tr>
        </g:each>
        </tbody>
    </table>
</g:if>
</body>
</html>

