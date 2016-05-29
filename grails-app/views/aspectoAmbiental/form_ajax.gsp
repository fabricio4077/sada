<%@ page import="plan.AspectoAmbiental" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!aspectoAmbientalInstance}">
    <elm:notFound elem="AspectoAmbiental" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmAspectoAmbiental" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${aspectoAmbientalInstance?.id}" />

        <div class="form-group ${hasErrors(bean: aspectoAmbientalInstance, field: 'planManejoAmbiental', 'error')} ">
            <span class="grupo">
                <label for="planManejoAmbiental" class="col-md-3 control-label text-info">
                    Plan de Manejo Ambiental
                </label>
                <div class="col-md-7">
                    <g:select id="planManejoAmbiental" name="planManejoAmbiental.id" optionValue="nombre" from="${plan.PlanManejoAmbiental.list([sort: 'nombre', order: 'asc'])}" optionKey="id" required="" value="${aspectoAmbientalInstance?.planManejoAmbiental?.id}" class="many-to-one form-control"/>
                </div>

            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: aspectoAmbientalInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-3 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-7">
                    %{--<g:textField name="descripcion" class="allCaps form-control" value="${aspectoAmbientalInstance?.descripcion}"/>--}%
                    <g:textArea name="descripcion" maxlength="255" class="form-control required" style="resize: none" value="${aspectoAmbientalInstance?.descripcion}"/>
                </div>
                
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: aspectoAmbientalInstance, field: 'impacto', 'error')} ">
            <span class="grupo">
                <label for="impacto" class="col-md-3 control-label text-info">
                    Impacto
                </label>
                <div class="col-md-7">
                    %{--<g:textField name="impacto" class="allCaps form-control" value="${aspectoAmbientalInstance?.impacto}"/>--}%
                    <g:textArea name="impacto" maxlength="255" class="form-control required" style="resize: none" value="${aspectoAmbientalInstance?.impacto}"/>
                </div>
                
            </span>
        </div>
        

        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmAspectoAmbiental").validate({
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