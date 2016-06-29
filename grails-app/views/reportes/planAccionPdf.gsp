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
    }

    </style>

</head>

<body>
<rep:headerFooterNuevo title="${"Síntesis de No conformidades y Plan de Acción"}" subtitulo="${''}" auditoria="${pre?.id}" especialista="${especialista?.id}" orden="${orden}"/>

<util:renderHTML html="${"<p style='text-align:justify'>" + "Una vez realizada la inspección de campo y documental se procede al desarrollo de la Síntesis de No Conformidades, misma que requiere del Plan de Acción respectivo para el cierre de No Conformidades." + "</p>"}"/>
<util:renderHTML html="${"<p style='text-align:justify'>" + "En la estación de servicios '${pre?.estacion?.nombre}', se han determinado ${total} puntos auditables, estipulados en ${pre?.tipo?.codigo != 'LCM1' ? 'la Legislación Ambiental vigente, Plan de Manejo Ambiental y Licencia' : 'la Legislación Ambiental vigente y Plan de Manejo Ambiental'}  " + "</p>"}"/>
<util:renderHTML html="${"<p style='text-align:justify'>" + "De este total de puntos auditables, se han inclumplido ${inclumplidas}, lo que infiere un ${porcentaje} % de cumplimiento en la gestión Ambiental de la estación de servicios" + "</p>"}"/>

<table class="table table-bordered table-condensed table-hover">
    <thead>
    <tr>
        <th style="width: 30%">HALLAZGO - EVIDENCIA DE CUMPLIMIENTO/INCUMPLIMIENTO </th>
        <th style="width: 5%">NC+</th>
        <th style="width: 5%">nc-</th>
        <th style="width: 5%">O</th>
        <th style="width: 30%">DESCRIPCIÓN DE LAS ACTIVIDADES DEL PLAN DE ACCIÓN (Tendientes a absolver las no conformidades encontradas en la AA)</th>
        <th style="width: 10%">RESPONSABLE</th>
        <th style="width: 8%">PLAZO</th>
        <th style="width: 8%">COSTO DE LA MEDIDA</th>
        <th style="width: 10%">MEDIO DE LA VERIFICACIÓN</th>
    </tr>
    </thead>
</table>


</body>
</html>

