<%@ page import="consultor.Consultora" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!consultoraInstance}">
    <elm:notFound elem="Consultora" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmConsultora" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${consultoraInstance?.id}" />



        <div class="row col-lg-12">
            <div class="col-md-6 form-group ${hasErrors(bean: consultoraInstance, field: 'nombre', 'error')} ">
                <span class="grupo">
                    <label for="nombre" class="col-md-4 control-label text-info">
                        Nombre de la Consultora
                    </label>
                    <div class="col-md-8">
                        <g:textField name="nombre" maxlength="31" required="" class="form-control required" value="${consultoraInstance?.nombre}"/>
                    </div>

                </span>
            </div>


        </div>

        <div class="row col-lg-12">

            <div class="col-md-6 form-group ${hasErrors(bean: consultoraInstance, field: 'ruc', 'error')} ">
                <span class="grupo">
                    <label for="ruc" class="col-md-4 control-label text-info">
                        Ruc
                    </label>
                    <div class="col-md-8">
                        <g:textField name="ruc" value="${consultoraInstance?.ruc}" maxlength="13" class="form-control number required noEspacios" required=""/>
                    </div>

                </span>
            </div>


            <div class="col-md-6 form-group ${hasErrors(bean: consultoraInstance, field: 'registro', 'error')} ">
                <span class="grupo">
                    <label for="registro" class="col-md-4 control-label text-info">
                       Registro ambiental
                    </label>
                    <div class="col-md-8">
                        <g:textField name="registro" maxlength="63" required="" class="form-control required" value="${consultoraInstance?.registro}"/>
                    </div>

                </span>
            </div>
        </div>


       <div class="row col-md-12">
           <div class="col-md-6 form-group ${hasErrors(bean: consultoraInstance, field: 'administrador', 'error')} ">
                <span class="grupo">
                    <label for="administrador" class="col-md-4 control-label text-info">
                        Representante Legal
                    </label>
                    <div class="col-md-8">
                        <g:textField name="administrador" maxlength="63" required="" class="form-control required" value="${consultoraInstance?.administrador}"/>
                    </div>

                </span>
            </div>


            <div class="col-md-6 form-group ${hasErrors(bean: consultoraInstance, field: 'telefono', 'error')} ">
                <span class="grupo">
                    <label for="telefono" class="col-md-4 control-label text-info">
                        Teléfono
                    </label>
                    <div class="col-md-8">
                        <g:textField name="telefono" value="${consultoraInstance?.telefono}" maxlength="31" class="form-control number noEspacios required"/>
                    </div>

                </span>
            </div>
        </div>

        <div class="row col-lg-12">
            <div class="col-md-6 form-group ${hasErrors(bean: consultoraInstance, field: 'mail', 'error')} ">
                <span class="grupo">
                    <label for="mail" class="col-md-4 control-label text-info">
                        Mail
                    </label>
                    <div class="col-md-8">
                        <g:textField name="mail" class="form-control noEspacios" maxlength="63" value="${consultoraInstance?.mail}"/>
                    </div>

                </span>
            </div>

            <div class="col-md-6 form-group ${hasErrors(bean: consultoraInstance, field: 'pagina', 'error')} ">
                <span class="grupo">
                    <label for="pagina" class="col-md-4 control-label text-info">
                        Pagina Web
                    </label>
                    <div class="col-md-8">
                        <g:textField name="pagina" class="form-control noEspacios" maxlength="63" value="${consultoraInstance?.pagina}"/>
                    </div>

                </span>
            </div>
        </div>
        <div class="row col-lg-12">
            <div class="col-md-6 form-group ${hasErrors(bean: consultoraInstance, field: 'direccion', 'error')} ">
                <span class="grupo">
                    <label for="direccion" class="col-md-4 control-label text-info">
                        Dirección
                    </label>
                    <div class="col-md-6">
                        <g:textArea name="direccion" class="col-md-8 form-control required" maxlength="255" style="resize: none; width: 485px; height: 85px" value="${consultoraInstance?.direccion}"/>
                    </div>
                </span>
            </div>
        </div>

    </g:form>

    <script type="text/javascript">
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
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });
    </script>

</g:else>