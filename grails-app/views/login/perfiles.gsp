
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="noMenu">
    <title>Perfiles</title>
    <link href="${resource(dir: 'css', file: 'login.css')}" rel="stylesheet"/>

    <style type="text/css">
    .bbody {
        %{--background              : url("${resource(dir:'images/inicio', file:'medio-ambiente.jpg')}") no-repeat;--}%
        %{---webkit-background-size : cover;--}%
        %{---moz-background-size    : cover;--}%
        %{---o-background-size      : cover;--}%
        %{--background-size         : cover;--}%
        margin-top: 150px;
    }

    </style>

</head>

<body>
<div class="row bbody">
    <div class="col-md-3 col-md-offset-9 col-sm-4 col-sm-offset-8 col-xs-6" style="background: none">
        <div class="tdn-tab tdn-tab-left tdn-tab-primary" style="background: none">
            <div class="tdn-tab-body" style="background: border-box">
                <img class="img-login" src="${resource(dir: 'images/inicio', file: 'login_temp.jpg')}"/>
                <g:form name="frmLogin" action="savePerfil">
                    <g:select from="${perfiles}" name="perfil" class="form-control input-login" optionKey="id" optionValue="nombre"/>

                    <div class="text-center">
                        <a href="#" id="btn-login" class="btn btn-primary">Ingresar <i class="fa fa-unlock"></i>
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
        $("#btn-login").click(function () {
            doLogin();
        });
    });

</script>

</body>
</html>