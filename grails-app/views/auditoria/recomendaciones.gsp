<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 10/07/2016
  Time: 11:43
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Conclusiones y Recomendaciones</title>
</head>

<body>

<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-comment-o"></i> Conclusiones y Recomendaciones</h3>
        <g:if test="${obau?.completado != 1}">
            <a href="#" id="btnCumplirSit" class="btn btn-success" title="Cumplir objetivo" style="float: right; margin-top: -25px">
                <i class="fa fa-check-circle-o"></i>
            </a>
        </g:if>
    </div>
    %{--<div class="panel-group" style="height: 1100px">--}%
        %{--<div class="col-md-12" style="margin-top: 10px">--}%
        %{--</div>--}%
    %{--</div>--}%

    <div class="panel-group well">
        <util:renderHTML html="${texto}"/>
    </div>

    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-4" style="margin-bottom: 10px">
            <g:if test="${det?.recomendaciones}">
                <a href="#" id="btnInformeRe" class="btn btn-info" title="Ver informe en el editor">
                    <i class="fa fa-file-word-o"></i> Ver conclusiones y recomendaciones
                </a>
            </g:if>
            <g:else>
                <a href="#" id="btnInformeRe" class="btn btn-success" title="Generar informe en el editor">
                    <i class="fa fa-file-word-o"></i> Generar conclusiones y recomendaciones
                </a>
            </g:else>
        </div>
    </div>
    <div id="divEditor">

    </div>

</div>

<script>
    $("#btnInformeRe").click(function () {
        $.ajax({
            type: 'POST',
            url:"${createLink(controller: 'auditoria', action: 'editorRecomendaciones_ajax')}",
            data:{
                id: ${pre?.id},
                texto: '${texto}'
            },
            success: function (msg){
                $("#divEditor").html(msg)
            }
        })
    });

    $("#btnCumplirSit").click(function () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'auditoria', action: 'completar_ajax')}",
            data:{
                id: ${pre?.id}
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Objetivo registrado como completado!", "success");
                    setTimeout(function () {
                        location.reload(true)
                    }, 1000);
                }else{
                    log("Error al registar el objetivo como completado","error")
                }
            }
        })
    });
</script>


</body>
</html>