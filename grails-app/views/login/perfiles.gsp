
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="noMenu">
    <title>Perfiles</title>
    <link href="${resource(dir: 'css', file: 'login.css')}" rel="stylesheet"/>


    <style>
    .tamano {
        font-size: 170%;
    }
    </style>
</head>

<body>

<div style="text-align: center; margin-top: 20px; height:530px;" class="well">
    <div class="panel panel-success" style="height: 500px">
        <div class="panel-heading tamano">
            <h1 class="panel-title tamano">Sistema de auditoría ambiental para estaciones de servicio de combustible</h1>
        </div>
        <div class="panel-body">
            <elm:flashMessage tipo="${flash.tipo}" icon="${flash.icon}"
                              clase="${flash.clase}">${flash.message}</elm:flashMessage>

            <div class="col-md-4">
                <img src="${resource(dir: 'images/inicio', file: 'estacion.jpg')}" style="padding: 10px; height: 330px"/>
            </div>
            <div class="col-md-3 col-md-offset-4">
                <div class="tdn-tab tdn-tab-left tdn-tab-primary " style="background: none">
                    <div class="tdn-tab tdn-tab-left tdn-tab-primary" style="background: none">
                        <div class="tdn-tab-body" style="background: border-box">
                            <img class="img-login" src="${resource(dir: 'images/inicio', file: 'logo_sada3.png')}"/>
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

        </div>
    </div>
</div>

<p class="text-info pull-right" style="font-size: 10px; margin-top: 20px">
    Versión ${message(code: 'version', default: '2.1.0x')}
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
        $("#btn-login").click(function () {
            doLogin();
        });
    });

</script>

</body>
</html>