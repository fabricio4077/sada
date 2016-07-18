<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 04/04/2016
  Time: 18:52
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="noMenu">
    <title>Ingreso Sada</title>
    <link href="${resource(dir: 'css', file: 'login.css')}" rel="stylesheet"/>

    <style>
    .tamano {
        font-size: 170%;
    }
    </style>

</head>



<body>


%{--<div style="text-align: center; margin-top: 20px; height: ${(flash.message) ? '680' : '530'}px;" class="well">--}%
<div style="text-align: center; margin-top: 20px; height:530px;" class="well">
    <div class="panel panel-success" style="height: 500px">
        <div class="panel-heading tamano">
            <h1 class="panel-title tamano">Sistema de auditoría ambiental para estaciones de servicio de combustible</h1>
        </div>
        <div class="panel-body">
            <elm:flashMessage tipo="${flash.tipo}" icon="${flash.icon}"
                              clase="${flash.clase}">${flash.message}</elm:flashMessage>

            <div id="carousel-example-generic" class="carousel slide col-md-6" data-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                </ol>
                <div class="carousel-inner" role="listbox">
                    <div class="item active">
                        <img src="${resource(dir: 'images/inicio', file: 'estacion.jpg')}" style="padding: 10px; height: 330px"/>
                    </div>
                    <div class="item">
                        <img src="${resource(dir: 'images/inicio', file: 'ambienteEdificios.jpg')}" style="padding: 10px; height: 330px"/>
                    </div>
                    <div class="item">
                        <img src="${resource(dir: 'images/inicio', file: 'estacionPetro.jpg')}" style="padding: 10px; height: 330px"/>
                    </div>
                </div>

                <!-- Controls -->
                <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>


            <div class="col-md-3 col-md-offset-2">
                <div class="tdn-tab tdn-tab-left tdn-tab-primary " style="background: none">
                    <div class="tdn-tab-body" style="background: border-box">
                        <img class="img-login" src="${resource(dir: 'images/inicio', file: 'logo_sada3.png')}"/>
                        <g:form name="frmLogin" action="validar">
                            <div class="input-group input-login">
                                <g:textField name="user" class="form-control required noEspacios" placeholder="Usuario"/>
                                <span class="input-group-addon"><i class="fa fa-user"></i></span>
                            </div>

                            <div class="input-group input-login">
                                <g:passwordField name="pass" class="form-control required noEspacios" placeholder="Contraseña"/>
                                <span class="input-group-addon"><i class="fa fa-unlock-alt"></i></span>
                            </div>

                            <div class="text-center">
                                <a href="#" id="btn-login" class="btn btn-primary">Validar <i class="fa fa-unlock"></i>
                                </a>
                            </div>
                        </g:form>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>






<p class="text-info pull-right" style="font-size: 10px; margin-top: 20px">
    Versión ${message(code: 'version', default: '3.0.0x')}
</p>

<script type="text/javascript">
    var $frm = $("#frmLogin");
    function doLogin() {
        if ($frm.valid()) {
            $("#btn-login").replaceWith(spinner);
            $frm.submit();
        }
    }

    $(function () {
        $("#user").focus();

        $frm.validate({
//                    validClass    : "text-success",
            errorClass     : "text-danger",
            errorPlacement : function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                console.log("error ", error, element, element.parents(".input-group"));
                element.parents(".input-group").addClass('has-error');
            }
        });
        $("#btn-login").click(function () {
            doLogin();
        });
        $frm.find("input").keyup(function (ev) {
            if (ev.keyCode == 13) {
                doLogin();
            }
        })
    });

</script>

</body>
</html>