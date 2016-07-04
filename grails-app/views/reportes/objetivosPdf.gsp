

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

  </style>

</head>

<body>
<rep:headerFooterNuevo title="${"Objetivos"}" subtitulo="${''}" auditoria="${pre?.id}" especialista="${especialista?.id}" orden="${orden}"/>

<util:renderHTML html="${"<b>Objetivo General</b><br></br>"}"/>
<util:renderHTML
        html="${"<p style='text-align:justify'>" + general + " para la estación de servicios " + "'" + pre?.estacion?.nombre + "'" + " en el período auditable " + pre?.periodo?.inicio?.format("yyyy") + " - " + pre?.periodo?.fin?.format("yyyy")+ "." +"</p>"}"/>

<util:renderHTML html="${"<b>Objetivos Específicos</b><br></br>"}"/>
<util:renderHTML html="${"<ul>"}"/>
<util:renderHTML html="${espe}"/>
<util:renderHTML html="${"</ul>"}"/>

</body>
</html>

