<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 08/06/16
  Time: 10:57 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Metodología</title>
</head>

<body>

<div class="panel panel-success ">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-book"></i> Metodología </h3>
    </div>

    <div class="panel-group well">
            <util:renderHTML html="${met?.descripcion}"/>
    </div>
</div>

</body>
</html>