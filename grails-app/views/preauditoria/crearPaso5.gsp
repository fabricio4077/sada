<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 23/04/2016
  Time: 22:33
--%>

<%@ page import="complemento.Actividad" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada"/>
    <title>Creando una auditoría - Paso 5 </title>
</head>

<body>

<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-tasks"></i> Paso 5: Actividades</h3>
    </div>

    <i class="fa fa-tasks fa-5x text-info" style="float: left; margin-left: 60px; margin-top: 10px"></i>

    <div style="margin-top: 30px; width: 750px; margin-left: 150px; height: 400px" class="vertical-container">
        <p class="css-vertical-text" style="margin-top: -10px;">Actividades</p>
        <div class="linea"></div>

        <div class="well" style="text-align: center">
            <p>
                <strong>Seleccione las actividades que se desarrollarán en el transcurso de la auditoría.</strong>
            </p>
        </div>

        <div id="divActividades">

        </div>

        <div class="col-md-3"></div>
        <div class="col-md-3">
            <g:if test="${session.perfil.codigo == 'ADMI'}">
                <a href="#" id="btnAddActi" class="btn btn-default" title="Agregar una actividad">
                    <i class="fa fa-tasks"></i> Agregar actividad
                </a>
            </g:if>
        </div>
        <div class="col-md-2">
            <a href="#" id="btnGuardar" class="btn btn-success" title="Asignar actividades a la auditoría">
                <i class="fa fa-save"></i> Guardar
            </a>
        </div>
    </div>

    <div class="row" style="margin-bottom: 10px">
        <div class="col-md-2"></div>
        <a style="float: left" href="#" id="btnRegresar" class="btn btn-primary ${pre ? '' : 'disabled'}" title="Retornar al paso anterior">
            <i class="fa fa-angle-double-left"></i> Regresar
        </a>
        <div class="col-md-5"></div>

        <a href="#" id="btnContinuar" class="btn btn-success disabled" title="Continuar a la ficha ténica">
            Continuar <i class="fa fa-angle-double-right"></i>
        </a>
    </div>
</div>


<script type="text/javascript">


    cargarActividades();

    //función para cargar las activades

    function  cargarActividades () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'actividad',action: 'actividades_ajax')}",
            data:{
                id: '${pre?.id}'
            },
            success: function (msg) {
                $("#divActividades").html(msg).effect("clip", "slow").fadeIn();
                if(${actividades.size() > 0}){
                    $("#btnContinuar").removeClass('disabled')
                }
            }
        });
    }

    //botón para agregar una actividad

    $("#btnAddActi").click(function () {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'actividad', action:'form_ajax')}",

            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgActividad",
                    title   : "Crear Actividad",
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
                                return submitForm();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    });


    function submitForm() {
        var $form = $("#frmActividad");
        var $btn = $("#dlgActividad").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'actividad', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0] == "OK") {
                        log("Actividad guardada correctamente","success");
                        cargarActividades();
                    } else {
                        log("Error al guardar la actividad","error");
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }



    //botón para guardar actividades

    $("#btnGuardar").click(function () {
        var $frm = $("#frmActividades");
        var url = $frm.attr("action");
        var data = "id="+${pre?.id};
        var band = false;
        $(".acti .fa-li").each(function () {
            var ico = $(this);
            if (ico.hasClass("fa-check-square")) {
                data += "&acti=" + ico.data("id");
                band = true;
            }
        });
        if (!band) {
            bootbox.alert("<i class='fa fa-warning fa-3x pull-left text-danger text-shadow'></i><p>No ha seleccionado ninguna actividad.</p>");
        } else {
            guardarActividades(url, data);
        }
    });


    //función para guardar las actividades

    function guardarActividades (url,data) {
        openLoader("Grabando");
        $.ajax({
            type    : "POST",
            url     : url,
            data    : data,
            success : function (msg) {
                closeLoader();
                if(msg == 'ok'){
                    log("Actividades asignadas correctamente","success")
                    cargarActividades();
                    $("#btnContinuar").removeClass('disabled')
                }else{
                    log("Error al asignar las actividades","error")
                }
            }
        });

    }



    //botón continuar al siguiente paso
    $("#btnContinuar").click(function (){
        location.href="${createLink(action: 'fichaTecnica')}/" + ${pre?.id};
    });

    //botón de regreso al paso anterior 3

    $("#btnRegresar").click(function () {
        location.href="${createLink(action: 'crearPaso4')}/" + ${pre?.id};
    });

</script>
</body>
</html>