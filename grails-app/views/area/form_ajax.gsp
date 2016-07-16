<%@ page import="estacion.Area" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!areaInstance}">
    <elm:notFound elem="Area" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmArea" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${areaInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: areaInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-8">
                    <g:textField name="nombre" maxlength="63" required="" class="form-control required" value="${areaInstance?.nombre}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: areaInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-8">
                    <g:textArea name="descripcion" cols="40" rows="5" maxlength="2000" required="" style="resize: none" class="form-control required" value="${areaInstance?.descripcion}"/>
                </div>
                
            </span>
        </div>
        
        %{--<div class="form-group ${hasErrors(bean: areaInstance, field: 'codigo', 'error')} ">--}%
            %{--<span class="grupo">--}%
                %{--<label for="codigo" class="col-md-2 control-label text-info">--}%
                    %{--Codigo--}%
                %{--</label>--}%
                %{--<div class="col-md-6">--}%
                    %{--<g:textField name="codigo" class="allCaps form-control" value="${areaInstance?.codigo}"/>--}%
                %{--</div>--}%
                %{----}%
            %{--</span>--}%
        %{--</div>--}%
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmArea").validate({
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