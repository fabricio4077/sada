<%@ page import="plan.PlanManejoAmbiental" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!planManejoAmbientalInstance}">
    <elm:notFound elem="PlanManejoAmbiental" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmPlanManejoAmbiental" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${planManejoAmbientalInstance?.id}" />




        <div class="form-group ${hasErrors(bean: planManejoAmbientalInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-9">
                    <g:textField name="nombre" class="form-control required" maxlength="63" value="${planManejoAmbientalInstance?.nombre}"/>
                </div>

            </span>
        </div>

        <div class="form-group ${hasErrors(bean: planManejoAmbientalInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-9">
                    <g:textArea name="descripcion" class="form-control required" maxlength="1023"
                                value="${planManejoAmbientalInstance?.descripcion}" style="height: 150px; resize: none"/>
                </div>

            </span>
        </div>

        <div class="form-group ${hasErrors(bean: planManejoAmbientalInstance, field: 'objetivo', 'error')} ">
            <span class="grupo">
                <label for="objetivo" class="col-md-2 control-label text-info">
                    Objetivo
                </label>
                <div class="col-md-9">
                    <g:textArea name="objetivo" class="form-control required" maxlength="1023"
                                value="${planManejoAmbientalInstance?.objetivo}" style="height: 150px; resize: none"/>
                </div>

            </span>
        </div>


        <div class="form-group ${hasErrors(bean: planManejoAmbientalInstance, field: 'codigo', 'error')} ">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Código
                </label>
                <div class="col-md-6">
                    <g:textField name="codigo" class="allCaps form-control required" maxlength="10" value="${planManejoAmbientalInstance?.codigo}"/>
                </div>

            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmPlanManejoAmbiental").validate({
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