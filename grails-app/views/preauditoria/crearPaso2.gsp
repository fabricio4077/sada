<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 11/04/2016
  Time: 21:41
--%>

<%@ page import="estacion.Estacion" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada"/>
    <title>Creando una Auditoría - Paso 2</title>

    <style type="text/css">
        .modificado{
            height: 770px;
        }

        .original{
            height: 610px;
        }
    </style>
</head>

<body>

<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-automobile"></i> Paso 2: Selección de la estación de servicio</h3>
      </div>

%{--<div class="wizard-container">--}%
    %{--<div class="wizard-step wizard-next-step corner-left wizard-current">--}%

        %{--<div class="wizard-form">--}%

        <i class="fa fa-automobile fa-5x text-info" style="float: left; margin-left: 60px"></i>

            <div style="margin-top: 40px; width: 750px; margin-left: 150px" class="vertical-container">
                <p class="css-vertical-text" style="margin-top: -10px;">Estación</p>
                <div class="linea"></div>
                <div class="row">
                    <div class="col-md-3 negrilla control-label">Estación de Servicio: </div>
                    <div class="col-md-6" style="margin-bottom: 20px;" id="divComboEstacion">
                    %{--<g:select id="estacionServ" name="estacion_name" from="${Estacion.list([sort: 'nombre'])}" optionKey="id"--}%
                         %{--optionValue="nombre" class="many-to-one form-control" noSelection="[0: 'Seleccione...']" value="${pre?.estacion?.id}"/>--}%
                    </div>

                    <div class="descripcion hidden">
                        <h4>Ayuda</h4>
                        <p> Seleccione la estación de servicio de la cual se realizará la auditoría de <strong>
                            ${pre?.tipo?.descripcion} </strong> en el período <strong> ${pre?.periodo?.inicio?.format("yyyy") + " - " + pre?.periodo?.fin?.format("yyyy")}</strong>
                        </p>
                    </div>

                        <a href="#" id="btnAgregarEsta" class="btn btn-primary" title="Agregar una estación de servicio">
                            <i class="fa fa-plus"> Agregar</i>
                        </a>

                    <a href="#" id="btnAyudaEstacion" class="btn btn-info over" title="Ayuda">
                        <i class="fa fa-exclamation"></i>
                    </a>
                </div>
            </div>

    <div class="col-md-3" style="float: right; margin-top: -80px">
        <div class="panel panel-info right hidden">
            <div class="panel-heading">
                <h3 class="panel-title" style="color: #000033"></h3>
            </div>

            <div class="panel-body"> </div>
        </div>
    </div>


        <div style="margin-top: 30px; width: 750px; margin-left: 150px" class="vertical-container hide original" id="tabla">
            <p class="css-vertical-text" style="margin-top: -10px;">Datos de la Estación</p>
            <div class="linea"></div>

            <div id="tablaEstacion" class="original"></div>
        </div>

            <div class="row" style="margin-bottom: 10px">
                <div class="col-md-2"></div>
                <a style="float: left" href="#" id="btnRegresar" class="btn btn-primary ${pre ? '' : 'disabled'}" title="Retornar al paso anterior">
                    <i class="fa fa-angle-double-left"></i> Regresar
                </a>
                <div class="col-md-4"></div>
                <a href="#" id="btnContinuar" class="btn btn-success disabled" title="Continuar al siguiente paso">
                    Continuar <i class="fa fa-angle-double-right"></i>
                </a>
           </div>


    </div>

        %{--</div>--}%
    %{--</div>--}%
%{--</div>--}%

<script type="application/javascript">

    //funcion hover para mostrar la ayuda
    $(function () {
        $(".over").hover(function () {
            var $h4 = $(this).siblings(".descripcion").find("h4");
            var $cont = $(this).siblings(".descripcion").find("p");
            $(".right").removeClass("hidden").find(".panel-title").text($h4.text()).end().find(".panel-body").html($cont.html());
        }, function () {
            $(".right").addClass("hidden");
        });
    });


    cargarEstacionMain('${idEstacion}');

    //funcion para cargar el combo de la estación
    function cargarEstacionMain(idEsta) {
        $.ajax({
           type: 'POST',
            url: "${createLink(controller: 'estacion', action: 'cargarComboEstacion_ajax')}",
            data: {
                id: idEsta,
                pre: ${pre?.id}
            },
            success: function (msg){
                $("#divComboEstacion").html(msg)
                if(idEsta != 0){
                    $("#btnContinuar").removeClass('disabled');


                }
            }
        });

    }


    %{--$("#btnAyudaEstacion").click(function () {--}%
        %{--bootbox.alert("Seleccione la estación de servicio de la cual se realizará la auditoría " +--}%
                %{--"de <strong>${pre?.tipo?.descripcion} </strong> en el período <strong>${pre?.periodo?.inicio?.format("yyyy") + " - " + pre?.periodo?.fin?.format("yyyy")} </strong> ")--}%
    %{--});--}%

    $("#btnAgregarEsta").click(function () {
        var idPre = '${pre?.id}';
        var idE = $(estacionServ).val();
        $("#tabla").removeClass("hide");
        cargarEStacion(idPre)
        $("#estacionServ").val('0')
        $("#btnContinuar").addClass('disabled');
    });

//función para llamar la tabla con la info de la estación de servicio
    function cargarEStacion (idP, idE){
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'estacion', action: 'tablaEstacion_ajax' )}",
            data: {
                id: idP,
                estacion: idE
            },
            success: function(msg){
                $("#tablaEstacion").html(msg).effect('blind').show('clip');
            }
        });
    }


//cargado con ajax de la estación seleccionada

    %{--$("#estacionServ").change(function () {--}%
        %{--var idPre = '${pre?.id}';--}%
        %{--var idEs = $(this).val();--}%
        %{--$("#tabla").removeClass("hide");--}%
        %{--if(idEs == '0'){--}%
            %{--$("#tabla").addClass("hide");--}%
        %{--}else{--}%
            %{--cargarEStacion(idPre, idEs)--}%
        %{--}--}%

    %{--});--}%

//botón de regreso al paso anterior 1

    $("#btnRegresar").click(function () {
    location.href="${createLink(action: 'crearAuditoria')}/" + ${pre?.id}
    });

//botón continuar al paso siguiente 3

    $("#btnContinuar").click(function () {
        %{--location.href="${createLink(action: 'crearPaso3')}/" + ${pre?.id}--}%
        var idEstacion = $(estacionServ).val();
        $.ajax({
            type:'POST',
            url: "${createLink(controller: 'preauditoria', action: 'guardarPaso2_ajax')}",
            data:{
                id: '${pre?.id}',
                estacion: idEstacion
            },
            success: function (msg) {
                var parts = msg.split("_");
                if(parts[0] == "ok"){
                    log("Datos de la estación guardados correctamente", "success");
                    setTimeout(function () {
                        location.href = "${createLink(controller:'preauditoria',action:'crearPaso3')}/" + parts[1];
                    }, 1500);
                }else{
                    log("Error al guardar los datos de la estación", "error")
                }
            }

        })
    });



</script>



</body>
</html>