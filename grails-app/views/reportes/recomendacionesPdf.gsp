<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 10/07/2016
  Time: 14:12
--%>

<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 22/06/16
  Time: 12:58 PM
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
    <title>Conclusiones y Recomendaciones</title>

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

    @page{
        @bottom-right {
            content: 'Pág. ' counter(page);
        }
    }


    </style>

</head>

<body>
%{--<rep:headerFooterNuevo title="${"Conclusiones y Recomendaciones"}" subtitulo="${''}" auditoria="${pre?.id}" especialista="${especialista?.id}" orden="${orden}" mes="${mes}" anio="${anio}"/>--}%
<rep:headerFooterNuevo title="${"Conclusiones y Recomendaciones"}" subtitulo="${''}" auditoria="${pre?.id}" orden="${orden}" mes="${mes}" anio="${anio}"/>

<util:renderHTML html="${det}"/>


</body>
</html>

