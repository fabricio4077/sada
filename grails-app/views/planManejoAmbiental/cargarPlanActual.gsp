<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 30/05/2016
  Time: 22:52
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Cargar Plan de Manejo Ambiental Actual</title>
</head>

<body>

<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-book"></i> Actualizar el Plan de Manejo Ambiental</h3>
    </div>
    <div class="well" style="text-align: center; height: 200px">

        <g:if test="${anteriores}">
            <div class="row">
                <div class="col-md-4 negrilla control-label">Seleccionar el Plan de Manejo Ambiental (anterior) :
                </div>

                <div class="col-md-4">
                    <g:select name="anteriores_name" class="form-control"
                              from="${anteriores}" id="anteriores"
                              optionValue="${{it?.tipo?.descripcion + " - Período: " + it?.periodo?.inicio?.format("yyyy") + " - " + it?.periodo?.fin?.format("yyyy")}}" optionKey="id"/>
                    <a href="#" id="btnSeleccionarPlan" class="btn btn-info" title="" style="margin-bottom: 20px; margin-top: 10px">
                        <i class="fa fa-check"></i> Seleccionar PMA
                    </a>
                </div>
            </div>
        </g:if>

        <div class="row">
            <div class="col-md-4 negrilla control-label">
                Crear un Plan de Manejo Ambiental:
            </div>

            <div class="col-md-4">
                <div class="btn-group">
                    <a href="#" id="btnCrearPlan" class="btn btn-success" title="">
                        <i class="fa fa-plus"></i> Crear PMA
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    $("#btnSeleccionarPlan").click(function () {
        var anterior = $("#anteriores").val();
        bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x text-warning text-shadow'></i> Está seguro que desea seleccionar este PMA(anterior) para la Evaluación Ambiental?", function (result){
            if(result){
                $.ajax({
                    type: 'POST',
                    url: '${createLink(controller: 'planManejoAmbiental', action: 'asociarPlanEvam_ajax')}',
                    data:{
                        id: anterior,
                        actual: ${pre?.id}
                    },
                    success: function (msg){
                        var parts = msg.split("_");
                        if(parts[0] == 'ok'){
                            log(parts[1],'success');
                        }else{
                            log(parts[1],'error');
                        }
                    }
                });
            }
        })
    });



    //función que asigna el PMA por defecto y redirecciona a dicha pantalla
    $("#btnCrearPlan").click(function () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'evaluacion', action:  'asignarPlanAnterior_Ajax')}',
            data:{
                id: ${pre?.id},
                band: 'false'
            },
            success: function(msg){
                if(msg == 'ok'){
                    location.href="${createLink(controller: 'planManejoAmbiental', action: 'planManejoAmbiental')}?id=" + ${pre?.id} + "&band=" + false
                }else{
                    log("Error al asignar el PMA ", "error")
                }
            }
        })
    });

    //función para verificar la existencia de al menos un registro de aspecto ambiental actual

    verificarExistente();

    function verificarExistente () {
        $.ajax({
           type: 'POST',
            url: "${createLink(controller: 'planManejoAmbiental', action: 'verificarExistente_ajax')}",
            data:{
            id: ${detalle?.id}
            },
            success: function (msg){
                if(msg == 'ok'){
                    location.href="${createLink(controller: 'planManejoAmbiental', action: 'planManejoAmbiental')}?id=" + ${pre?.id} + "&band=" + false
                }else{

                }
            }
        });
    }

</script>



</body>
</html>