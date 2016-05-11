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

%{--<div class="wizard-container">--}%
%{--<div class="wizard-step wizard-next-step corner-left wizard-current">--}%
    %{--<i class="fa fa-pencil-square"></i> Paso 1: Selección del tipo de auditoría y período--}%
    %{--<div class="wizard-form">--}%

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
                              optionValue="descripcion" class="many-to-one form-control" noSelection="[0: 'Seleccione...']" value="${pre?.tipo?.id}"/>
                </div>

                <div class="descripcion hidden">
                    <h4>Ayuda</h4>
                    <p>Las auditorías pueden ser de tres tipos: <br>
                        Licenciamiento<br>
                        Inicio<br>
                        Cumplimiento<br>
                    * Si necesita crear un tipo adicional de auditoría comuniquese con el administrador del sistema</p>
                </div>

                <g:if test="${session.perfil.codigo == 'ADMI'}">
                    <a href="#" id="btnTipo" class="btn btn-primary" title="Agregar un tipo">
                        <i class="fa fa-plus"> Agregar</i>
                    </a>
                </g:if>

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
                <div class="col-xs-2 negrilla control-label">Período: </div>
                <div class="col-md-6" style="margin-bottom: 45px">
                    <g:select id="periodo" name="periodo_name" from="${tipo.Periodo.list()}" optionKey="id"
                              optionValue="${{it?.inicio?.format("yyyy") + '  -  '+ it?.fin?.format("yyyy") }}"
                              class="many-to-one form-control" noSelection="[0: 'Seleccione...']" style="text-align: center" value="${pre?.periodo?.id}"/>
                </div>

                <div class="descripcion hidden">
                    <h4>Ayuda</h4>
                    <p>Período en el que se va a realizar la auditoría
                    </p>
                </div>
                <a href="#" id="btnPeriodo" class="btn btn-primary" title="Agregar un período">
                    <i class="fa fa-plus"> Agregar</i>
                </a>
                <a href="#" id="btnAyudaPeriodo" class="btn btn-info over" title="Ayuda">
                    <i class="fa fa-exclamation"></i>
                </a>
            </div>
        </div>


        <div class="row"  style="margin-bottom: 10px">
            <div class="col-md-5"></div>
            <a href="#" id="btnContinuar" class="btn btn-success ${pre ? '' : 'disabled'}" title="Continuar">
                Continuar <i class="fa fa-angle-double-right"></i>
            </a>
        </div>
</div>

    %{--</div>--}%

%{--</div>--}%
%{--</div>--}%


<script type="text/javascript">

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


//    $("#btnAyudaPeriodo").click(function () {
//        bootbox.alert("Período en el que se va a realizar la Auditoría")
//    });


    //activacion del botón continuar al seleccionar los combos
    revisarCombos($("#tipo").val(), $("#periodo").val())

    function revisarCombos (tipoVal, perVal){

        if(tipoVal != 0 && perVal != 0){
            $("#btnContinuar").removeClass("disabled")
        }else{
            $("#btnContinuar").addClass("disabled")
        }
    }

    $("#tipo").change(function () {
        revisarCombos($("#tipo").val(), $("#periodo").val())
    });
    $("#periodo").change(function () {
        revisarCombos($("#tipo").val(), $("#periodo").val())
    });

    //guardar paso 1 de crear la auditoría
    $("#btnContinuar").click(function () {
        var tp = $("#tipo").val();
        var pr = $("#periodo").val();
        $.ajax({
            type: 'POST',
            url: "${createLink(action: 'guardarPaso1_ajax')}",
            data: {
                tipo: tp,
                periodo: pr,
                id: '${pre?.id}'
            },
            success: function (msg){
                var parts = msg.split("_");
                if(parts[0] == "ok"){
                    log("Datos de tipo y período guardados correctamente", "success");
                    setTimeout(function () {
                        location.href = "${createLink(controller:'preauditoria',action:'crearPaso2')}/" + parts[1];
                    }, 2000);
                }else{
                    log("Error al guardar los datos", "error")
                }

            }
        })
    });

</script>

</body>
</html>