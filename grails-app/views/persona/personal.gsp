<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 25/04/2016
  Time: 21:55
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Configuración personal - Usuario: ${session.usuario.nombre + " " + session.usuario.apellido}</title>
</head>

<body>

<div class="panel panel-info">
    <div class="panel-heading" role="tab" id="headerPass">
        <h4 class="panel-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                Cambiar password de ingreso al sistema
            </a>
        </h4>
    </div>

    <div id="collapseTwo" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headerPass">
        <div class="panel-body">
            <g:form class="form-inline" name="frmPass" action="updatePass">
                <div class="form-group">
                    <label for="input2">Password actual</label>

                    <div class="input-group">
                        <g:passwordField name="input2" class="form-control noEspacios"/>
                        <span class="input-group-addon"><i class="fa fa-unlock"></i></span>
                    </div>
                </div>

                <div class="form-group" style="margin-left: 40px;">
                    <label for="nuevoPass">Nuevo password</label>

                    <div class="input-group">
                        <g:passwordField name="nuevoPass" class="form-control required noEspacios"/>
                        <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                    </div>
                </div>

                <div class="form-group" style="margin-left: 40px;">
                    <label for="passConfirm">Confirme password</label>

                    <div class="input-group">
                        <g:passwordField name="passConfirm" class="form-control required noEspacios"/>
                        <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                    </div>
                </div>
                <a href="#" id="btnGuardarPass" class="btn btn-success" style="margin-left: 40px;">
                    <i class="fa fa-save"></i> Guardar
                </a>
            </g:form>
        </div>
    </div>
</div>

<script type="text/javascript">


    //validación de form - password
    $(function () {
        var $frmPass = $("#frmPass");

        $frmPass.validate({
            errorClass: "help-block",
            errorPlacement: function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success: function (label) {
                label.parents(".grupo").removeClass('has-error');
                label.remove();
            },
            rules: {
                input2: {
                    remote: {
                        url: "${createLink(action: 'validar_pass_ajax')}",
                        type: "post",
                        data: {
                            id: "${persona?.id}"
                        }
                    }
                }
            },
            messages: {
                input2: {
                    remote: "La clave no concuerda"
                }
            }
        });
    });


//botón para guardar password
    $("#btnGuardarPass").click(function () {
        var $frmPass = $("#frmPass");
        if ($frmPass.valid()) {
            $.ajax({
                type    : "POST",
                url     : $frmPass.attr("action"),
                data    : $frmPass.serialize(),
                success : function (msg) {
                    var parts = msg.split("*");
                    log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                    setTimeout(function () {
                        if (parts[0] == "SUCCESS") {
                            location.href = "${createLink(controller: "login", action: "logout" )}"
                        } else {
                        }
                    }, 1000);
                    closeLoader();
                }
            });
        }
        return false;
    });

</script>

</body>
</html>