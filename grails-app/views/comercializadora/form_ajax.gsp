<%@ page import="estacion.Comercializadora" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!comercializadoraInstance}">
    <elm:notFound elem="Comercializadora" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmComercializadora" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${comercializadoraInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: comercializadoraInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="nombre" class="col-md-4 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-6">
                    <g:textField name="nombre" maxlength="31" required="" class=" allCaps form-control required" value="${comercializadoraInstance?.nombre}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: comercializadoraInstance, field: 'direccion', 'error')} ">
            <span class="grupo">
                <label for="direccion" class="col-md-4 control-label text-info">
                    Dirección
                </label>
                <div class="col-md-6">
                    <g:textArea name="direccion" style="resize: none" cols="40" rows="5" maxlength="255" required="" class="form-control required" value="${comercializadoraInstance?.direccion}"/>
                </div>
                
            </span>
        </div>


        
        <div class="form-group ${hasErrors(bean: comercializadoraInstance, field: 'mail', 'error')} ">
            <span class="grupo">
                <label for="mail" class="col-md-4 control-label text-info">
                    Mail
                </label>
                <div class="col-md-6">
                    <g:textField name="mail" class="form-control" value="${comercializadoraInstance?.mail}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: comercializadoraInstance, field: 'telefono', 'error')} ">
            <span class="grupo">
                <label for="telefono" class="col-md-4 control-label text-info">
                    Teléfono
                </label>
                <div class="col-md-6">
                    %{--<g:field name="telefono" type="number" value="${comercializadoraInstance.telefono}" class="digits form-control required" required=""/>--}%
                    <g:textField name="telefono" class="form-control number required" value="${comercializadoraInstance?.telefono}"/>

                </div>
                
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: comercializadoraInstance, field: 'representante', 'error')} ">
            <span class="grupo">
                <label for="representante" class="col-md-4 control-label text-info">
                    Representante Legal
                </label>
                <div class="col-md-6">
                    <g:textField name="representante" maxlength="31" required="" class="form-control required" value="${comercializadoraInstance?.representante}"/>
                </div>

            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmComercializadora").validate({
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