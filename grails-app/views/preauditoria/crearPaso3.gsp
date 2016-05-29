<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 16/04/2016
  Time: 10:52
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada"/>
    <title>Creando una Auditoría - Paso 3</title>


    <style type="text/css">
        .alineacion {
            text-align: left;

        }

        .azul{
            color: #0000FF
        }


         /*html, body {*/
             /*height: 100%;*/
             /*margin: 0;*/
             /*padding: 0;*/
         /*}*/



        #map {
            height:30%;
            width: 80%;
        }
    </style>

</head>

<body>

%{--<div class="wizard-container">--}%
    %{--<div class="wizard-step wizard-next-step corner-left wizard-current">--}%
        %{--<i class="fa fa-area-chart"></i> Paso 3: Coordenadas geográficas--}%
        %{--<div class="wizard-form">--}%

        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title" style="text-align: center"> <i class="fa fa-area-chart"></i> Paso 3: Coordenadas geográficas (UTM)</h3>
            </div>

        <i class="fa fa-area-chart fa-5x text-info" style="float: left; margin-left: 60px"></i>

            <div style="margin-top: 30px; width: 750px; margin-left: 150px; height: 280px" class="vertical-container">
                <p class="css-vertical-text" style="margin-top: -10px;">Coordenadas</p>
                <div class="linea"></div>
                <div class="row">
                    <div class="col-md-3 negrilla alineacion control-label">Estación de servicio:</div>
                    <div class="col-md-8 negrilla alineacion azul"> ${pre?.estacion?.nombre}</div>
                </div>
                <div class="row">
                    <div class="col-md-3 negrilla alineacion control-label">Dirección:</div>
                    <div class="col-md-8 negrilla alineacion azul"> ${pre?.estacion?.direccion}</div>
                </div>
                <div class="row">
                    <div class="col-md-3 negrilla alineacion control-label">Provincia:</div>
                    <div class="col-md-7 negrilla alineacion azul"> ${pre?.estacion?.provincia?.nombre}</div>

                    <a href="#" id="btnCoordenadas" class="btn btn-primary" title="Agregar coordenadas">
                    <i class="fa fa-plus"> Agregar</i>
                    </a>
                </div>

                <table class="table table-bordered table-hover table-condensed" style="margin-top: 10px;">
                    <thead>
                    <tr>
                        <th style="width:15%;">Posición en X</th>
                        <th style="width:12%;">Posición en Y</th>
                        <th style="width:3%;">Acciones</th>
                    </tr>
                    </thead>
                    <tbody id="tablaCoordenadas">

                    </tbody>
                </table>
            </div>


        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <div id="map">


                </div>
            </div>
        </div>

    <div class="row" style="margin-bottom: 10px">
        <div class="col-md-2"></div>
        <a style="float: left" href="#" id="btnRegresar" class="btn btn-primary ${pre ? '' : 'disabled'}" title="Retornar al paso anterior">
            <i class="fa fa-angle-double-left"></i> Regresar
        </a>
        <div class="col-md-5"></div>
        <a href="#" id="btnContinuar" class="btn btn-success ${coor.size() > 0 ? '' : 'disabled'}" title="Continuar al siguiente paso">
            Continuar <i class="fa fa-angle-double-right"></i>
        </a>
    </div>


    </div>



<script>

    var map;

    function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: 36.964, lng: -122.015},
//                center: {lat: 818.649, lng:38.290 },
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            //roadmap, hybrid, terrain, satellite
            zoom: 16
        });
        map.setTilt(45);

        var marker = new google.maps.Marker({
            position: {lat: 36.964, lng: -122.015},
            map: map,
            title: 'Hello World!'
        });

    }

</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBpasnhIQUsHfgCvC3qeJpEgcB9_ppWQI0&callback=initMap"
        async defer></script>



<script type="text/javascript">

    //función cargar mapa


    //botón de regreso al paso anterior 2

    $("#btnRegresar").click(function () {
        location.href="${createLink(action: 'crearPaso2')}/" + ${pre?.id}
    });

    cargarTablaCoordenadas(${pre?.id});

    //funcion para cargar la tabla de coordenadas

    function cargarTablaCoordenadas (idPre) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'coordenadas',action: 'tablaCoordenadas_ajax')}",
            data: {
                id: idPre
            },
            success: function (msg) {
            $("#tablaCoordenadas").html(msg)
            }
        });
    }

    //botón para llamar al dialog de agregar coordenadas

    $("#btnCoordenadas").click(function () {
        cargarCoordenadas(${pre?.id},'')
    });

    function cargarCoordenadas (idP, idC) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'coordenadas', action:'agregarCoordenadas_ajax')}",
            data    : {
                id: idP,
                coordenada: idC
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCrearCoordenadas",
                    title   : "Coordenadas",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                var $form = $("#frmCoordenadas");

                                if ($form.valid()) {
                                    $("#btnSave").replaceWith(spinner);
                                    $.ajax({
                                        type    : "POST",
                                        url     : '${createLink(action:'guardarCoordenadas_ajax')}',
                                        data    : {
                                            id: ${pre?.id},
                                            idCor: idC,
                                            enX: $("#coordenadasX").val(),
                                            enY: $("#coordenadasY").val()
                                        },
                                        success : function (msg) {
                                            if (msg == "ok") {
                                                log("Datos de coordenadas guardados correctamente","success");
                                                cargarTablaCoordenadas(${pre?.id});
                                            } else {
                                                log("Error al guardar la información de las coordenadas","error");
                                            }
                                        }
                                    });
                                } else {
                                    return false;
                                }

                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    }

    //Botón continuar al siguiente paso
    $("#btnContinuar").click(function () {
        location.href="${createLink(controller: 'preauditoria', action: 'crearPaso4')}/" + ${pre?.id}
    });

</script>

</body>
</html>