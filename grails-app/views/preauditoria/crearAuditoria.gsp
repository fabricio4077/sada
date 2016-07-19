<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 10/04/2016
  Time: 14:45
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada"/>
    <title>Creando una Auditoría - Paso 1</title>
</head>

<body>


<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"><i class="fa fa-pencil-square"></i> Paso 1: Selección del tipo de auditoría y período</h3>
    </div>

    <i class="fa fa-pencil-square fa-5x text-info" style="float: left; margin-left: 60px;"></i>


    <div style="margin-top: 30px; width: 600px; margin-left: 150px" class="vertical-container">
        <p class="css-vertical-text" style="margin-top: -10px;">Tipo</p>
        <div class="linea"></div>
        <div class="row">
            <div class="col-xs-2 negrilla control-label">Tipo: </div>
            <div class="col-md-6" style="margin-bottom: 45px">
                <g:select id="tipo" name="tipo_name" from="${tipo.Tipo.list([sort: 'descripcion'])}" optionKey="id"
                          optionValue="descripcion" class="many-to-one form-control" noSelection="[0: 'Seleccione...']"
                          value="${pre?.tipo?.id}" disabled="${pre?.estacion ? true : false}"/>
            </div>

            <div class="descripcion hidden">
                <h4>Ayuda</h4>
                <p>Las auditorías pueden ser de tres tipos: <br>
                    Inicio<br>
                    Licenciammiento<br>
                    Cumplimiento<br>
            </div>

            <a href="#" id="btnAyudaTipo" class="btn btn-info over" title="Ayuda">
                <i class="fa fa-exclamation"></i>
            </a>
        </div>
    </div>

    <div class="col-md-4" style="float: right; margin-top: -80px">
        <div class="panel panel-info right hidden">
            <div class="panel-heading">
                <h3 class="panel-title" style="color: #000033"></h3>
            </div>

            <div class="panel-body"> </div>
        </div>
    </div>


    <div style="margin-top: 30px; width: 600px; margin-left: 150px" class="vertical-container">
        <p class="css-vertical-text" style="margin-top: -10px;">Período</p>
        <div class="linea"></div>
        <div class="row">
            <div class="col-md-2 negrilla control-label">Período: </div>
            <div class="col-md-6" style="margin-bottom: 45px">
                <g:select id="periodo" name="periodo_name" from="${tipo.Periodo.list([sort: 'inicio', order: 'asc' ])}" optionKey="id"
                          optionValue="${{it?.inicio?.format("yyyy") + '  -  '+ it?.fin?.format("yyyy") }}"
                          class="many-to-one form-control" noSelection="[0: 'Seleccione...']"
                          style="text-align: center" value="${pre?.periodo?.id}" disabled="${pre?.estacion ? true : false}"/>
            </div>

            <div class="descripcion hidden">
                <h4>Ayuda</h4>
                <p>Período en el que se va a realizar la auditoría
                </p>
            </div>
            <a href="#" id="btnPeriodo" class="btn btn-primary ${pre?.estacion ? 'disabled' : ''}" title="Agregar un período" >
                <i class="fa fa-plus"> Agregar</i>
            </a>
            <a href="#" id="btnAyudaPeriodo" class="btn btn-info over" title="Ayuda">
                <i class="fa fa-exclamation"></i>
            </a>
        </div>
    </div>

    <div style="margin-top: 30px; width: 600px; margin-left: 150px" class="vertical-container">
        <p class="css-vertical-text" style="margin-top: -10px;">Consultora</p>
        <div class="linea"></div>
        <div class="row">
            <div class="col-md-2 negrilla control-label">Consultora:</div>
            <div class="col-md-6" style="margin-bottom: 45px">

                <g:if test="${msn == 1}">
                    <g:select id="consultora" name="consultora_name" from="${consultor.Consultora.list()}" optionKey="id"
                              optionValue="nombre"
                              class="many-to-one form-control" noSelection="[0: 'Seleccione...']"
                              style="text-align: center" value="${pre?.consultora?.id}"/>
                </g:if>
                <g:else>
                    <g:select id="consultora" name="consultora_name" from="${consultor.Consultora.list()}" optionKey="id"
                              optionValue="nombre"
                              class="many-to-one form-control " noSelection="[0: 'Seleccione...']"
                              style="text-align: center" value="${session.usuario.consultora.id}" disabled="true"/>
                </g:else>
                %{--<g:elseif test="${session.usuario.consultora}">--}%
                %{--<g:select id="consultora" name="consultora_name" from="${consultor.Consultora.list()}" optionKey="id"--}%
                %{--optionValue="nombre"--}%
                %{--class="many-to-one form-control " noSelection="[0: 'Seleccione...']"--}%
                %{--style="text-align: center" value="${session.usuario.consultora.id}" disabled="true"/>--}%

                %{--</g:elseif><g:else>--}%
                %{--<g:select id="consultora" name="consultora_name" from="${consultor.Consultora.list()}" optionKey="id"--}%
                %{--optionValue="nombre"--}%
                %{--class="many-to-one form-control" noSelection="[0: 'Seleccione...']"--}%
                %{--style="text-align: center" value="${pre?.consultora?.id}"/>--}%
                %{--</g:else>--}%

            </div>
            <div class="descripcion hidden">
                <h4>Ayuda</h4>
                <p>Consultora que está realizando esta auditoría.
                </p>
            </div>

            <g:if test="${session.perfil.codigo == 'ADMI'}">
                <a href="#" id="btnConsultora" class="btn btn-primary" title="Agregar una consultora" >
                    <i class="fa fa-plus"> Agregar</i>
                </a>
            </g:if>
            <a href="#" id="btnAyudaConsultora" class="btn btn-info over" title="Ayuda">
                <i class="fa fa-exclamation"></i>
            </a>
        </div>
    </div>



    <nav>
        <ul class="pager">
            <li>
                <a href="#" id="btnContinuar" class="btn btn-success ${pre ? '' : 'disabled'}" title="Continuar">
                    Continuar <i class="fa fa-angle-double-right"></i>
                </a>
            </li>
        </ul>
    </nav>



</div>

<script type="text/javascript">


    $("#btnConsultora").click(function() {
        createEditRow();
        return false;
    });


    function createEditRow(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'consultora', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : "Nueva Consultora",
                    class : "long",
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
                                return submitFormConsultora();
//                                location.reload(true);
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit



    //funcion hover para mostrar la ayuda
    $(function () {
        $(".over").hover(function () {
            var $h4 = $(this).siblings(".descripcion").find("h4");
            var $cont = $(this).siblings(".descripcion").find("p");
            $(".right").removeClass("hidden").find(".panel-title").text($h4.text()).end().find(".panel-body")
                    .html($cont.html());
        }, function () {
            $(".right").addClass("hidden");
        });
    });

    $("#btnTipo").click(function () {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'tipo', action:'form_ajax')}",
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCrearTipo",
                    title   : "Tipo de auditoría",
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


    function submitFormConsultora() {
        var $form = $("#frmConsultora");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'consultora', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
//                    log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                    if (parts[0] == "OK") {
                        log("Consultora creada correctamente","success");
                        setTimeout(function () {
                            location.reload(true);
                        }, 1000);

                    } else {
                        log("Error al crear la consultora","error");
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }


    function submitForm() {
        var $form = $("#frmTipo");
        var $btn = $("#dlgCrearTipo").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'tipo', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                    if (parts[0] == "OK") {
                        location.reload(true);
                    } else {
                        spinner.replaceWith($btn);
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }


    //    $("#btnAyudaTipo").click(function () {
    //       bootbox.alert("Las auditorías pueden ser de tres tipos: <br><br>" +
    //               "<li>Licenciamiento <br>" +
    //               "<li>Cumplimiento<br>" +
    //               "<li>............<br><br>" +
    //               "* Si necesita crear un tipo adicional de auditoría comuniquese con el administrador del sistema")
    //    });


    //funcion para guardar el periodo
    $("#btnPeriodo").click(function () {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'periodo', action:'form_ajax')}",
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCrearPeriodo",
                    title   : "Período de la auditoría",
                    class   : "modal-sm",
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
//                                var fecha1 = $("#inicioDate_year").val();
//                                console.log("fecha 1" + fecha1);
                                return submitFormPeriodo();

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

    function submitFormPeriodo() {
        var $form = $("#frmPeriodo");
        var $btn = $("#dlgCrearPeriodo").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'periodo', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0] == "OK") {
                        log("Período creado correctamente","success");
                        setTimeout(function () {
                            location.reload(true);
                        },1000);
                    } else {
                        log(parts[1],"error")
                    }
                }
            });
        } else {
            return false;
        } //else
    }


    //    $("#btnAyudaPeriodo").click(function () {
    //        bootbox.alert("Período en el que se va a realizar la Auditoría")
    //    });


    //activacion del botón continuar al seleccionar los combos
    revisarCombos($("#tipo").val(), $("#periodo").val(), $("#consultora").val());

    function revisarCombos (tipoVal, perVal, conVal){

        if(tipoVal != 0 && perVal != 0 && conVal != 0){
            $("#btnContinuar").removeClass("disabled")
        }else{
            $("#btnContinuar").addClass("disabled")
        }
    }

    $("#tipo").change(function () {
        revisarCombos($("#tipo").val(), $("#periodo").val(),  $("#consultora").val())
    });
    $("#periodo").change(function () {
        revisarCombos($("#tipo").val(), $("#periodo").val(),  $("#consultora").val())
    });


    $("#consultora").change(function () {
        revisarCombos($("#tipo").val(), $("#periodo").val(),  $("#consultora").val())
    });

    //guardar paso 1 de crear la auditoría
    $("#btnContinuar").click(function () {
        var tp = $("#tipo").val();
        var pr = $("#periodo").val();
        var cn = $("#consultora").val();
        $.ajax({
            type: 'POST',
            url: "${createLink(action: 'guardarPaso1_ajax')}",
            data: {
                tipo: tp,
                periodo: pr,
                id: '${pre?.id}',
                con: cn
            },
            success: function (msg){
                var parts = msg.split("_");
                if(parts[0] == "ok"){
                    log("Datos de tipo ,período y consultora guardados correctamente", "success");
                    setTimeout(function () {
                        location.href = "${createLink(controller:'preauditoria',action:'crearPaso2')}/" + parts[1];
                    }, 2000);
                }else{
                    log(parts[1], "error")
                }

            }
        })
    });


    var validator = $("#frmConsultora").validate({
        errorClass     : "help-block",
        errorPlacement : function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success        : function (label) {
            label.parents(".grupo").removeClass('has-error');
        }
    });
    //    $(".form-control").keydown(function (ev) {
    //        if (ev.keyCode == 13) {
    //            submitForm();
    //            return false;
    //        }
    //        return true;
    //    });

</script>

</body>
</html>