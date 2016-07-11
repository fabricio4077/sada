<%@ page import="Seguridad.Prfl; Seguridad.Persona" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!personaInstance}">
    <elm:notFound elem="Persona" genero="o" />
</g:if>
<g:else>
<g:form class="form-horizontal" name="frmPersona" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="id" value="${personaInstance?.id}" />

    <div class="row col-lg-12">
        <div class="col-md-6 form-group ${hasErrors(bean: personaInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="nombre" class="col-md-4 control-label text-info">
                    Nombres
                </label>
                <div class="col-md-8">
                    <g:textField name="nombre" maxlength="31" required="" class="form-control required" value="${personaInstance?.nombre}"/>
                </div>
            </span>
        </div>

        <div class=" col-md-6 form-group ${hasErrors(bean: personaInstance, field: 'apellido', 'error')} ">
            <span class="grupo">
                <label for="apellido" class="col-md-4 control-label text-info">
                    Apellidos
                </label>
                <div class="col-md-8">
                    <g:textField name="apellido" maxlength="31" required="" class="form-control required" value="${personaInstance?.apellido}"/>
                </div>
            </span>
        </div>
    </div>

    <div class="row col-lg-12">
        <div class="col-md-6 form-group ${hasErrors(bean: personaInstance, field: 'telefono', 'error')} ">
            <span class="grupo">
                <label for="telefono" class="col-md-4 control-label text-info" style="margin-right: 17px">
                    Teléfono
                </label>
                <div class="input-group col-md-7">
                    <span class="input-group-addon"><i class="fa fa-phone fa-fw"></i></span>
                    <g:textField name="telefono" class="form-control number noEspacios" maxlength="63" value="${personaInstance?.telefono}"/>
                </div>

            </span>
        </div>
        <div class="col-md-6 form-group ${hasErrors(bean: personaInstance, field: 'mail', 'error')} ">
            <span class="grupo">
                <label for="mail" class="col-md-4 control-label text-info" style="margin-right: 17px">
                    Mail
                </label>
                <div class="input-group margin-bottom-sm col-md-7">
                    <span class="input-group-addon"><i class="fa fa-envelope-o fa-fw"></i></span>
                    <g:textField name="mail" class="form-control email noEspacios" maxlength="63" value="${personaInstance?.mail}" placeholder="Email"/>
                </div>

            </span>
        </div>
    </div>
    <div class="row col-lg-12">
        <div class="col-md-6 form-group ${hasErrors(bean: personaInstance, field: 'login', 'error')} ">
            <span class="grupo">
                <label for="login" class="col-md-4 control-label text-info" style="margin-right: 17px">
                    Login
                </label>
                <div class="input-group col-md-7">
                    <span class="input-group-addon"><i class="fa fa-user fa-fw"></i></span>
                    <g:textField name="login" required="" maxlength="31" class="form-control required noEspacios" value="${personaInstance?.login}"/>
                </div>
            </span>
        </div>

        <g:if test="${!personaInstance?.password}">
            <div class="col-md-6 form-group ${hasErrors(bean: personaInstance, field: 'password', 'error')} ">
                <span class="grupo">
                    <label for="password" class="col-md-4 control-label text-info" style="margin-right: 17px">
                        Password
                    </label>
                    <div class="input-group col-md-7">
                        <span class="input-group-addon"><i class="fa fa-key fa-fw"></i></span>
                        <g:textField name="password" required="" maxlength="63" class="form-control required noEspacios" value="${personaInstance?.password}" placeholder="Password"/>
                    </div>
                </span>
            </div>
        </g:if>
        <g:else>
            <div class="col-md-2"></div>
            <div class="col-md-4">
                <a href="#" class="btn btn-info btnReseteaPass" title="Resetear Password" data-id="${personaInstance?.id}">
                    <i class="fa fa-eraser"></i> Resetear Password
                </a>
            </div>
        </g:else>
    </div>

    <div class="row col-lg-12">
        <div class="col-md-6 form-group ${hasErrors(bean: personaInstance, field: 'cargo', 'error')} ">
            <span class="grupo">
                <label for="cargo" class="col-md-4 control-label text-info" style="margin-right: 17px">
                    Cargo
                </label>
                <div class="input-group col-md-7">
                    <span class="input-group-addon"><i class="fa fa-child fa-fw"></i></span>
                    <g:select name="cargo" from="${['Biologo', 'Coordinador','Especialista']}" class="form-control"/>
                </div>
            </span>
        </div>
        <div class="col-md-6 form-group ${hasErrors(bean: personaInstance, field: 'titulo', 'error')} ">
            <span class="grupo">
                <label for="titulo" class="col-md-4 control-label text-info" style="margin-right: 17px">
                    Título
                </label>
                <div class="input-group col-md-7">
                    <span class="input-group-addon"><i class="fa fa-mortar-board fa-fw"></i></span>
                    <g:select name="titulo" from="${['Ingeniero', 'Doctor','Biólogo']}" class="form-control"/>
                </div>
            </span>
        </div>
    </div>

    <div class="row col-lg-12">
        <div class="col-md-6 form-group ${hasErrors(bean: personaInstance, field: 'cargo', 'error')} ">
            <span class="grupo">
                <label for="consultora" class="col-md-4 control-label text-info" style="margin-right: 17px">
                    Consultora
                </label>
                <div class="input-group col-md-7">
                    <span class="input-group-addon"><i class="fa fa-globe fa-fw"></i></span>
                    <g:select name="consultora" from="${consultor.Consultora.list([sort: 'nombre'])}"
                              optionKey="id" optionValue="nombre" class="form-control"
                              value="${personaInstance?.consultora?.id}" noSelection="['null': 'Seleccione...']"/>
                </div>
            </span>
        </div>

        <div class="col-md-6 form-group ${hasErrors(bean: personaInstance, field: 'activo', 'error')} ">
            <span class="grupo">
                <label for="activo" class="col-md-4 control-label text-info" >
                    Activo
                </label>
                <div class="col-md-8">
                    <g:select name="activo" from="[1: 'ACTIVO', 0: 'NO ACTIVO']" class="form-control required"
                              value="${personaInstance?.activo}" optionKey="key" optionValue="value" />
                </div>
            </span>
        </div>
    </div>
</g:form>

<script type="text/javascript">

    $(".btnReseteaPass").click(function () {
        var idP = $(".btnReseteaPass").data('id');
        bootbox.confirm("<i class='fa fa-danger fa-3x pull-left text-warning text-shadow'></i> Está seguro que desea resetear el password de este usuario?", function (result) {
            if (result) {
                $.ajax({
                   type: 'POST',
                    url: "${createLink(controller: 'persona', action: 'resetearPass_ajax')}",
                    data:{
                        id: idP
                    },
                    success: function (msg){
                        if(msg == 'ok'){
                            log("Password reseteado correctamente","success")
                        }else{
                            log("Error al resetear el password","error")
                        }
                    }
                });
            }
        })
    });


    var validator = $("#frmPersona").validate({
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
        },
        rules         : {
            mail : {
                remote: {
                    url : "${createLink(action: 'validar_unique_mail_ajax')}",
                    type: "post",
                    data: {
                        id: "${personaInstance?.id}"
                    }
                }
            },
            login: {
                remote: {
                    url : "${createLink(action: 'validar_unique_login_ajax')}",
                    type: "post",
                    data: {
                        id: "${personaInstance?.id}"
                    }
                }
            }
        },
        messages      : {
            mail : {
                remote: "Ya existe este Mail"
            },
            login: {
                remote: "Ya existe este Login"
            }
        }
    });
    $(".form-control").keydown(function (ev) {
        if (ev.keyCode == 13) {
            submitForm();
            return false;
        }
        return true;
    });

</script>

</g:else>