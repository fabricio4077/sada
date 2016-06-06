<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 24/05/2016
  Time: 22:27
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
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
                <a class='slide' href='#'>
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
            <div>
                <a class='slide' href='#'>
                    <span class='element'>Rc</span>
                    <span class='name'>Recomendaciones</span>
                </a>
            </div>
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



    cargarAcciones();

    function cargarAcciones () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'planAccion', action: 'tablaPlan_ajax')}",
            data:{
                id: ${pre?.id}
            },
            success: function (msg){
                $("#divAcciones").html(msg).addClass('animated fadeInLeft')
            }
        });
    }


</script>


</body>
</html>