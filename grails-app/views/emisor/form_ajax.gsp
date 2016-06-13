<%@ page import="situacion.Emisor" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!emisorInstance}">
    <elm:notFound elem="Emisor" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmEmisor" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${emisorInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: emisorInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="nombre" class="col-md-4 control-label text-info">
                    Nombre del emisor de gases
                </label>
                <div class="col-md-8">
                    <g:textField name="nombre" maxlength="63" class="form-control required" value="${emisorInstance?.nombre}"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmEmisor").validate({
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