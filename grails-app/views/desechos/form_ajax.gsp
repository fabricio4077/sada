<%@ page import="situacion.Desechos" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!desechosInstance}">
    <elm:notFound elem="Desechos" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmDesechos" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${desechosInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: desechosInstance, field: 'tipo', 'error')} ">
            <span class="grupo">
                <label for="tipo" class="col-md-3 control-label text-info">
                    Tipo de desecho
                </label>
                <div class="col-md-6">
                    <g:select name="tipo" from="${desechosInstance.constraints.tipo.inList}"
                              class="form-control" value="${desechosInstance?.tipo}"
                              valueMessagePrefix="desechos.tipo" noSelection="[null: 'Seleccione...']"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: desechosInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-3 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-6">
                    <g:textField name="descripcion"
                                 class="form-control required" value="${desechosInstance?.descripcion}" maxlength="1023"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmDesechos").validate({
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