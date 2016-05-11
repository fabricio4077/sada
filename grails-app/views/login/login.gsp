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

    <style type="text/css">

    .bbody {
        margin-top: 100px;
    }

    </style>
</head>

<body>

<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

<div class="row bbody">
    <div class="col-md-3 col-md-offset-9 col-sm-4 col-sm-offset-8 col-xs-6" style="background: none">
        <div class="tdn-tab tdn-tab-left tdn-tab-primary " style="background: none">
            <div class="tdn-tab-body" style="background: border-box">
                <img class="img-login" src="${resource(dir: 'images/inicio', file: 'login_temp.jpg')}"/>
                <g:form name="frmLogin" action="validar">
                    <div class="input-group input-login">
                        <g:textField name="user" class="form-control required noEspacios" placeholder="Usuario"/>
                        <span class="input-group-addon"><i class="fa fa-user"></i></span>
                    </div>

                    <div class="input-group input-login">
                        <g:passwordField name="pass" class="form-control required" placeholder="Contraseña"/>
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