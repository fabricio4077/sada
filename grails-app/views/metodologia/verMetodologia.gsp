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

<div id="metodologia" class="col-md-12" contenteditable="true">
    <g:textArea name="te" value="${met?.descripcion?.decodeHTML()}" class="form-control" style="height: 380px; resize: none" readonly=""/>
</div>

<script>

//    cargarMetodologia();


    %{--function cargarMetodologia () {--}%
        %{--var container = $('#metodologia');--}%
        %{--container.html(${met?.descripcion?.encodeAsHTML()});--}%
        %{--container.html(container.text());--}%
    %{--}--}%

</script>


</body>
</html>