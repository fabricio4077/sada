<%@ page import="situacion.ComponenteAmbiental" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!componenteAmbientalInstance}">
    <elm:notFound elem="ComponenteAmbiental" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmComponenteAmbiental" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${componenteAmbientalInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: componenteAmbientalInstance, field: 'tipo', 'error')} ">
            <span class="grupo">
                <label for="tipo" class="col-md-4 control-label text-info">
                    Tipo de Componente Ambiental
                </label>
                <div class="col-md-6">
                    <g:select name="tipo"
                              from="${componenteAmbientalInstance.constraints.tipo.inList}"
                              class="form-control" value="${componenteAmbientalInstance?.tipo}"
                              valueMessagePrefix="componenteAmbiental.tipo"
                              />
                              %{--noSelection="[null: 'Seleccione...']"/>--}%
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: componenteAmbientalInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="nombre" class="col-md-4 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-6">
                    <g:textField name="nombre" class="form-control required" value="${componenteAmbientalInstance?.nombre}"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmComponenteAmbiental").validate({
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