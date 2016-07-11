<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 22/05/2016
  Time: 18:16
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Seleccionar el Marco Legal</title>
</head>

<body>


<div class="panel panel-success ">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-bank"></i> Seleccionar el Marco Legal </h3>
    </div>

    <div class="well" style="text-align: center">
        <p>
            <strong>
            Seleccione el conjunto de leyes a ser usadas en la evaluación ambiental de ${pre?.tipo?.descripcion}
            en la estación "${pre?.estacion?.nombre}", en el período
            ${pre?.periodo?.inicio?.format("yyyy") + "-" + pre?.periodo?.fin?.format("yyyy")}.
            </strong>

        </p>
        <p style="color: #ec3120">
            <i class='fa fa-exclamation-triangle fa-3x text-danger text-shadow'></i> ATENCIÓN: Una vez se encuentre en evaluación el marco legal no podrá ser cambiado!
        </p>

        <br>

        <div class="row">

            <div class="col-md-2"></div>
            <div class="col-md-2 negrilla control-label">Marco Legal: </div>
            <div class="col-md-4">
                <g:select name="marco_name" id="marco" class="form-control" from="${legal.MarcoLegal.list()}" optionKey="id" optionValue="descripcion" noSelection="[null: 'Predeterminado']"/>
            </div>

            <div class="col-md-2">
                <g:link controller="marcoLegal" action="arbolLegal" class="btn btn-info">
                    <i class="fa fa-star"></i> Crear Marco Legal
                </g:link>
            </div>

        </div>

        <br>

        <p>
            * Si no selecciona un Marco Legal se cargará el predeterminado.
        </p>

        <div class="list-group" style="text-align: center">
            <div class="btn-group">
                <a href="#" id="btnSeleccionarMarco" class="btn btn-success" title="">
                    Seleccionar <i class="fa fa-bank"></i>
                </a>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

   //asignación de marco legal

   $("#btnSeleccionarMarco").click(function () {
       var marco = $("#marco").val();
       $.ajax({
           type:'POST',
           url: "${createLink(controller: 'evaluacion', action: 'asignarMarco_ajax')}",
           data:{
            id: ${pre?.id},
            marco: marco
           },
           success: function (msg) {
            if(msg == 'ok'){
                log("Marco Legal asignado correctamente","success");
                setTimeout(function () {
                    location.href = "${createLink(controller:'evaluacion',action:'evaluacionAmbiental')}/" + ${pre?.id};
                }, 1500);
            }else{
                log("Error al asignar el Marco legal","error")
            }
           }
       })

   });

    verificar();

    //función de verificación de existencia de marco legal

    function verificar () {
        if('${auditoria?.marcoLegal}'){
         location.href="${createLink(controller: 'evaluacion', action: 'evaluacionAmbiental', id: pre?.id)}"
        }
    }

</script>


</body>
</html>