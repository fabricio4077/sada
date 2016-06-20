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

<header class='masthead' style="margin-top: 120px; position: fixed">
    <nav>
        <div class='nav-container'>
            <div>
                <a class='slide' href='#' id="areasMenu">
                    <span class='element'>Ar</span>
                    <span class='name'>Áreas Estación</span>
                </a>

            </div>
            <div>
                <a class='slide' href='#' id="sitMenu">
                    <span class='element'>Sa</span>
                    <span class='name'>Situación Ambiental</span>
                </a>
            </div>
            <div>
                <a class='slide' href='#' id="evaMenu">
                    <span class='element'>Ev</span>
                    <span class='name'>Evaluación Ambiental</span>
                </a>
            </div>
            <div>
                <a class='slide' href='#' id="planMenu">
                    <span class='element'>Pa</span>
                    <span class='name'>Plan de acción</span>
                </a>
            </div>
            <div>
                <a class='slide' href='#' id="pmaMenu">
                    <span class='element'>Pm</span>
                    <span class='name'>PMA</span>
                </a>
            </div>
            <div>
                <a class='slide' href='#'>
                    <span class='element'>Cr</span>
                    <span class='name'>Cronograma</span>
                </a>
            </div>
            %{--<div>--}%
                %{--<a class='slide' href='#'>--}%
                    %{--<span class='element'>Rc</span>--}%
                    %{--<span class='name'>Recomendaciones</span>--}%
                %{--</a>--}%
            %{--</div>--}%
        </div>
    </nav>
</header>





<script type="text/javascript">

    //mini menu
    $("#areasMenu").click(function () {
        location.href="${createLink(controller: 'area', action: 'areas')}/" + ${pre?.id}
    });

    $("#evaMenu").click(function () {
        location.href="${createLink(controller: 'auditoria', action: 'leyes')}/" + ${pre?.id}
    });

    $("#planMenu").click(function () {
        location.href="${createLink(controller: 'planAccion', action: 'planAccionActual')}/" + ${pre?.id}
    });

    $("#pmaMenu").click(function () {
        location.href="${createLink(controller: 'planManejoAmbiental', action: 'cargarPlanActual')}/" + ${pre?.id}
    });

    $("#sitMenu").click(function () {
        location.href="${createLink(controller: 'situacionAmbiental', action: 'situacion')}/" + ${pre?.id}
    });




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