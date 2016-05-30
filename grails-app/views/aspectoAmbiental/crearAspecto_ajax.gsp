<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 30/05/16
  Time: 03:13 PM
--%>

<%@ page import="plan.AspectoAmbiental" %>

    <g:form class="form-horizontal" name="frmAspectoAmbiental" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${aspectoAmbientalInstance?.id}" />

        <div class="form-group ${hasErrors(bean: aspectoAmbientalInstance, field: 'planManejoAmbiental', 'error')} ">
            <span class="grupo">
                <label for="planManejoAmbiental" class="col-md-3 control-label text-info">
                    Plan de Manejo Ambiental
                </label>
                <div class="col-md-7">
                    <g:select id="planManejoAmbiental" name="planManejoAmbiental.id" optionValue="nombre"
                              from="${plan.PlanManejoAmbiental.list([sort: 'nombre', order: 'asc'])}" optionKey="id" required="" value="${plan?.id}"
                              class="many-to-one form-control " />

                </div>

            </span>
        </div>

        <div class="form-group ${hasErrors(bean: aspectoAmbientalInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-3 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-7">
                    <g:textArea name="descripcion" maxlength="255" class="form-control required" style="resize: none"/>
                </div>

            </span>
        </div>

        <div class="form-group ${hasErrors(bean: aspectoAmbientalInstance, field: 'impacto', 'error')} ">
            <span class="grupo">
                <label for="impacto" class="col-md-3 control-label text-info">
                    Impacto
                </label>
                <div class="col-md-7">
                    <g:textArea name="impacto" maxlength="255" class="form-control required" style="resize: none"/>
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

