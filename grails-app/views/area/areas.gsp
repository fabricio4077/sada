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
    <title>Instalaciones de la estación de servicio: '${pre?.estacion?.nombre}'</title>
</head>

<body>

<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-bank"></i> Áreas</h3>
    </div>

    <div style="margin-top: 40px; width: 750px; height: 50px; margin-left: 150px" class="vertical-container">
        <p class="css-vertical-text" style="margin-top: -10px;">Áreas</p>
        <div class="linea"></div>
        <div class="row">
            <div class="col-md-8" id="divArea"></div>

            <div class="col-md-4">
                <a href="#" id="btnAgregarArea" class="btn btn-primary" title="Agregar un área">
                    <i class="fa fa-plus">Agregar un área</i>
                </a>

            </div>
        </div>
    </div>
</div>



<div id="divAcordeon"></div>



<script type="text/javascript">

    //función para cargar el combo de selección de área

    cargarComboArea();

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

    cargarAcordeon();

    //función para cargar el acordeon de areas de la estación

    function cargarAcordeon () {
        $.ajax({
            type:'POST',
            url:"${createLink(controller: 'area', action: 'acordeonAreas_ajax')}",
            data:{
                id: ${pre?.id}
            },
            success: function (msg){
                $("#divAcordeon").html(msg)
            }
        })
    }

    //asignar área a la estación

    $("#btnAgregarArea").click(function () {
        var are = $("#areas").val();
        $.ajax({
            type:'POST',
            url: "${createLink(controller: 'area', action: 'asignarArea_ajax')}",
            data:{
                id: ${pre?.id},
                area: are
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Área asignada correctamente","success");
                    cargarAcordeon();
                    cargarComboArea();
                }else{
                    log("Error al asignar el área","error")
                }
            }
        })

    });


</script>

</body>
</html>