<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 11/05/2016
  Time: 20:17
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Instalaciones de la estación de servicio</title>
</head>

<body>

<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-bank"></i> Instalaciones de la estación de servicio </h3>
    </div>

    <div style="margin-top: 40px; width: 750px; height: 50px; margin-left: 150px" class="vertical-container">
        <p class="css-vertical-text" style="margin-top: -10px;">Áreas</p>
        <div class="linea"></div>
        <div id="divArea"></div>
    </div>

</div>

<script type="text/javascript">

    //función para cargar el combo de selección de área

    cargarComboArea()

    function cargarComboArea () {
        $.ajax({
           type:'POST',
            url: '${createLink(controller: 'area', action: 'comboArea_ajax')}',
            data:{
                id: ${pre?.id}
            },
            success: function (msg){
                $("#divArea").html(msg)
            }
        });
    }

</script>

</body>
</html>