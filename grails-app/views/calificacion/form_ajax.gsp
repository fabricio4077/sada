<%@ page import="evaluacion.Calificacion" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!calificacionInstance}">
    <elm:notFound elem="Calificacion" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmCalificacion" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${calificacionInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: calificacionInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-6">
                    <g:textField name="nombre" class="form-control required" value="${calificacionInstance?.nombre}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: calificacionInstance, field: 'sigla', 'error')} ">
            <span class="grupo">
                <label for="sigla" class="col-md-2 control-label text-info">
                    Sigla
                </label>
                <div class="col-md-6">
                    <g:textField name="sigla" class="form-control required" value="${calificacionInstance?.sigla}"/>
                </div>
                
            </span>
        </div>
        
        %{--<div class="form-group ${hasErrors(bean: calificacionInstance, field: 'tipo', 'error')} ">--}%
            %{--<span class="grupo">--}%
                %{--<label for="tipo" class="col-md-2 control-label text-info">--}%
                    %{--Tipo--}%
                %{--</label>--}%
                %{--<div class="col-md-6">--}%
                    %{--<g:textField name="tipo" class="allCaps form-control" value="${calificacionInstance?.tipo}"/>--}%
                %{--</div>--}%
                %{----}%
            %{--</span>--}%
        %{--</div>--}%
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmCalificacion").validate({
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