<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 16/04/2016
  Time: 18:10
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada"/>
    <title>Creando una Auditoría - Paso 4</title>

    <style type="text/css">
    .alineacion {
        text-align: left;
    }
    .azul{
        color: #0000FF
    }
    .margen {
        margin-left: 70px;
    }

    </style>

</head>


<body>


<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-group"></i> Paso 4: Grupo de trabajo</h3>
    </div>

    <i class="fa fa-group fa-5x text-info" style="float: left; margin-left: 60px; margin-top: 10px"></i>

    <div style="margin-top: 30px; width: 750px; margin-left: 150px; height: 400px" class="vertical-container">
        <p class="css-vertical-text" style="margin-top: -10px;">Grupo de trabajo</p>
        <div class="linea"></div>

        <div class="well" style="text-align: center">
            <p>
                <strong>Seleccione los profesionales que trabajarán en el proceso de auditoría.</strong>
            </p>
        </div>
        <div class="row">
            <div class="col-md-6 alert alert-info">
                <h4>
                    Personal asignado
                </h4>

                <div class="" id="divCoordinador"></div>
                <div class="" id="divBiologo"></div>
                <div class="" id="divEspecialista"></div>
            </div>

            <div class="col-md-6 alert alert-success" style="height: 294px">
                <h4>
                    Personal disponible
                    <div id="listados">

                    </div>
                </h4>

                <div class="" id=""></div>
            </div>
        </div>
    </div>

    <div class="row" style="margin-bottom: 10px">
        <div class="col-md-2"></div>
        <a style="float: left" href="#" id="btnRegresar" class="btn btn-primary ${pre ? '' : 'disabled'}" title="Retornar al paso anterior">
            <i class="fa fa-angle-double-left"></i> Regresar
        </a>
        <div class="col-md-5"></div>
        <a href="#" id="btnContinuar" class="btn btn-success disabled" title="Continuar al siguiente paso">
            Continuar <i class="fa fa-angle-double-right"></i>
        </a>
    </div>

</div>
%{--</div>--}%
%{--</div>--}%
%{--</div>--}%

<script type="text/javascript">

    cargarCoordinador();
    cargarBiologo();
    cargarEspecialista();

    //función para cargar el coordinador de una auditoría
    function cargarCoordinador(){
        $.ajax({
            type:'POST',
            url: "${createLink(controller: 'asignados',action: 'cargarCoordinador_ajax')}",
            data: {
                id: '${pre?.id}'
            },
            success: function (msg) {
                $("#divCoordinador").html(msg).addClass('animated bounceInLeft');
                revisarAsignados();
            }
        })
    }

    //función para cargar el biólogo de una auditoría
    function cargarBiologo(){
        $.ajax({
            type:'POST',
            url: "${createLink(controller: 'asignados',action: 'cargarBiologo_ajax')}",
            data: {
                id: '${pre?.id}'
            },
            success: function (msg) {
                $("#divBiologo").html(msg).addClass('animated bounceInLeft');
                revisarAsignados();
            }
        })
    }

    //función para cargar el especialista de una auditoría
    function cargarEspecialista(){
        $.ajax({
            type:'POST',
            url: "${createLink(controller: 'asignados',action: 'cargarEspecialista_ajax')}",
            data: {
                id: '${pre?.id}'
            },
            success: function (msg) {
                $("#divEspecialista").html(msg).addClass('animated bounceInLeft');
                revisarAsignados();
            }
        })
    }

    //botón de regreso al paso anterior 3

    $("#btnRegresar").click(function () {
        location.href="${createLink(action: 'crearPaso3')}/" + ${pre?.id}
    });

    //verificacion para activar el botón de continuar
    <g:if test="${band == 1}">
    $("#btnContinuar").removeClass('disabled');
    </g:if>

    //boton avanzar al siguiente paso 5
    $("#btnContinuar").click(function () {
        %{--location.href="${createLink(controller: 'preauditoria', action: 'crearPaso5')}/" + ${pre?.id}--}%
        location.href="${createLink(controller: 'preauditoria', action: 'fichaTecnica')}/" + ${pre?.id}
    });

    //funcion para revisar la cantidad de asignados de una auditoria
    function revisarAsignados () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'asignados', action: 'revisar_ajax')}",
            data: {
                id: ${pre?.id}
            },
            success: function (msg) {
                if(msg == 'ok'){
                    $("#btnContinuar").removeClass('disabled');
                }
            }
        })
    }

</script>

</body>
</html>