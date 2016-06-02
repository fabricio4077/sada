<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 07/05/2016
  Time: 20:48
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Objetivos de la Auditoría</title>
</head>

<body>

<g:if test="${!auditoria}">

    <div class="panel panel-success ">
        <div class="panel-heading">
            <h3 class="panel-title" style="text-align: center"> <i class="fa fa-check-circle-o"></i> Cargar Objetivos </h3>
        </div>

        <div class="well" style="text-align: center">
            <p>
                <strong>Cargar los objetivos a realizarse en la auditoría de ${pre?.tipo?.descripcion}
                en la estación "${pre?.estacion?.nombre}", en el período
                ${pre?.periodo?.inicio?.format("yyyy") + "-" + pre?.periodo?.fin?.format("yyyy")}.</strong>
            </p>

            <div class="list-group" style="text-align: center">
                <a href="#" id="btnCargarObjetivos" class="btn btn-success" title="">
                    Cargar objetivos <i class="fa fa-check-circle-o"></i>
                </a>
            </div>
        </div>
    </div>


</g:if>
<g:else>

    <div class="panel panel-info">
        <div class="panel-heading">
            <h3 class="panel-title" style="text-align: center"> <i class="fa fa-check-circle-o"></i> Objetivos </h3>
        </div>
        <div id="tablaObjetivos">

        </div>
    </div>

</g:else>


<script type="text/javascript">



    //    asignarObjetivos();

    <g:if test="${auditoria}">
    cargarTabla();
    </g:if>



    //función para asignar objetivos a la auditoria

    function asignarObjetivos () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'auditoria', action: 'cargarObjetivos_ajax')}',
            data: {
                id: ${pre?.id},
                idA: '${auditoria?.id}'
            },
            success: function (msg){
                    if(msg == 'ok'){
                        log("Objetivos asignados correctamente","success");
                        setTimeout(function () {
                            location.href="${createLink(controller: 'auditoria', action: 'objetivos')}/" + ${pre?.id}
                        }, 2000);

                    }else{
                        log("Error al asignar los objetivos","error")
                    }
            }
        });
    }

    $("#btnCargarObjetivos").click(function () {
        asignarObjetivos();
    });

    function cargarTabla() {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'auditoria', action: 'cargarTablaObjetivos_ajax')}',
            data: {
                id: ${pre?.id},
                idA: '${auditoria?.id}'
            },
            success: function (msg){
                $("#tablaObjetivos").html(msg).addClass('animated bounceInLeft')
            }
        });
    }



</script>






</body>
</html>