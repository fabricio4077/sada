<%@ page import="tipo.Tipo" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!tipoInstance}">
    <elm:notFound elem="Tipo" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmTipo" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${tipoInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: tipoInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-3 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-6">
                    %{--<g:textArea name="descripcion" cols="40" rows="5" maxlength="1023" required="" class="allCaps form-control required" value="${tipoInstance?.descripcion}"/>--}%
                    <g:textField name="descripcion"  maxlength="31" required="" class="form-control required" value="${tipoInstance?.descripcion}" />
                </div>
                
            </span>
        </div>
        
        %{--<div class="form-group ${hasErrors(bean: tipoInstance, field: 'codigo', 'error')} ">--}%
            %{--<span class="grupo">--}%
                %{--<label for="codigo" class="col-md-3 control-label text-info">--}%
                    %{--Código--}%
                %{--</label>--}%
                %{--<div class="col-md-6">--}%
                    %{--<g:textField name="codigo" maxlength="4" required="" class="allCaps form-control required" value="${tipoInstance?.codigo}"/>--}%
                %{--</div>--}%
                %{----}%
            %{--</span>--}%
        %{--</div>--}%
        
        <div class="form-group ${hasErrors(bean: tipoInstance, field: 'tiempo', 'error')} ">
            <span class="grupo">
                <label for="tiempo" class="col-md-3 control-label text-info">
                    Tiempo de Vigencia
                </label>
                <div class="col-md-2">
                    %{--<g:field name="tiempo" type="number" value="${tipoInstance.tiempo}" class="digits form-control required" required=""/>--}%
                    <g:textField name="tiempo" value="${tipoInstance?.tiempo}" class="number form-control required noEspacios" required="" maxlength="2"/> Año(s)
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmTipo").validate({
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