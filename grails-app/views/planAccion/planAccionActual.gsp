<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 24/05/2016
  Time: 22:27
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainObjetivos">
    <title>Síntesis de No Conformidades y Plan de Acción para la estación:
        '${pre?.estacion?.nombre}' en el período ${pre?.periodo?.inicio?.format("yyyy") + " - " + pre?.periodo?.fin?.format("yyyy")}</title>
</head>

<body>

<div class="panel panel-warning">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-asterisk"></i> Plan de Acción</h3>
    </div>

    <div id="divAcciones">

    </div>
</div>







<script type="text/javascript">




    cargarAcciones();

    function cargarAcciones () {
        $.ajax({
           type: 'POST',
            url: "${createLink(controller: 'planAccion', action: 'tablaPlan_ajax')}",
            data:{
                id: ${pre?.id}
            },
            success: function (msg){
                $("#divAcciones").html(msg)
            }
        });
    }

</script>


</body>
</html>