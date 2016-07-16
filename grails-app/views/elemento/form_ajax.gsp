<%@ page import="situacion.Elemento" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!elementoInstance}">
    <elm:notFound elem="Elemento" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmElemento" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${elementoInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: elementoInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-6">
                    <g:textField name="nombre" class="form-control required" maxlength="63" value="${elementoInstance?.nombre}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: elementoInstance, field: 'unidad', 'error')} ">
            <span class="grupo">
                <label for="unidad" class="col-md-2 control-label text-info">
                    Unidad
                </label>
                <div class="col-md-6">
                    <g:textField name="unidad" class="form-control required" maxlength="31" value="${elementoInstance?.unidad}"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmElemento").validate({
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