<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 07/07/16
  Time: 11:32 AM
--%>

<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 17/04/2016
  Time: 14:27
--%>


<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>No disponible</title>
</head>

<body>

<div class="alert alert-info text-shadow">
    <i class="fa fa-ban fa-4x pull-left"></i>

    <h1 class="text-info tituloError">Atención</h1>

    <g:if test="${msn}">
        <p style="font-size: 16px; margin-top: 25px;text-shadow: none"><b>${msn}</b></p>
    </g:if>
    <g:else>
        <p style="font-size: 16px; margin-top: 25px;text-shadow: none">La página solicitada no está disponible</p>
    </g:else>

</div>

</body>
</html>