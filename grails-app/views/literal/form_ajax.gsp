<%@ page import="legal.Literal" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!literalInstance}">
    <elm:notFound elem="Literal" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmLiteral" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${literalInstance?.id}" />
        <g:hiddenField name="articulo" value="${articulo?.id}"/>
        <g:hiddenField name="norma" value="${norma?.id}"/>
        <g:hiddenField name="marco" value="${marco?.id}"/>

        <div class="form-group ">
            <span class="grupo">
                <label for="articulo_name" class="col-md-2 control-label text-info">
                    Artículo
                </label>
                <div class="col-md-3">
                    <g:textField name="articulo_name" class="form-control" readonly="true" value="${articulo?.numero}"/>
                </div>

            </span>
        </div>

        <div class="form-group ${hasErrors(bean: literalInstance, field: 'identificador', 'error')} ">
            <span class="grupo">
                <label for="identificador" class="col-md-2 control-label text-info">
                    Identificador
                </label>
                <div class="col-md-3">
                    <g:textField name="identificador" maxlength="4" class="allCaps form-control required noEspacios" value="${literalInstance?.identificador}"/>
                </div>

                <label for="seleccionado" class="col-md-5 control-label text-info">
                    Se usará este literal en la evaluación ambiental?
                </label>
                <div class="col-md-1">
                    <g:checkBox name="seleccionado" checked="${(mctp?.seleccionado == 1) ? 'true' : 'false'}"/>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: literalInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-6">
                    <g:textArea name="descripcion" maxlength="2050" class="form-control required" value="${literalInstance?.descripcion}" style="width: 420px; height: 280px; resize: none;"/>
                </div>
                
            </span>
        </div>
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmLiteral").validate({
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