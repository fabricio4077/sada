<%@ page import="tipo.Periodo" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<%@ page import="java.util.Calendar"%>
<g:if test="${!periodoInstance}">
    <elm:notFound elem="Periodo" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmPeriodo" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${periodoInstance?.id}" />

        <div style="margin-bottom: 20px"><strong>Entre los años: </strong></div>

        <div class="row col-4">

            <div class="form-group ${hasErrors(bean: periodoInstance, field: 'inicio', 'error')} ">
                <span class="grupo">
                    <label for="inicio" class="col-md-4 control-label text-info">
                        Inicio
                    </label>
                    <div class="col-md-2">
                        %{--<elm:datepicker name="inicio"  class="datepicker form-control required" value="${periodoInstance?.inicio}"  />--}%
                        <g:datePicker name="inicio" id="inicioDate" precision="year" years="${2050..2000}"/>
                    </div>

                </span>
            </div>

            <div class="form-group ${hasErrors(bean: periodoInstance, field: 'fin', 'error')} ">
                <span class="grupo">
                    <label for="fin" class="col-md-4 control-label text-info">
                        Fin
                    </label>
                    <div class="col-md-2">
                        %{--<elm:datepicker name="fin"  class="datepicker form-control required" value="${periodoInstance?.fin}" changeYear="true"/>--}%
                        %{--<g:datePicker name="fin" precision="year"  class="form-control required" years="${Calendar.instance.get(Calendar.YEAR)..1900}"/>--}%
                        <g:datePicker name="fin" precision="year"  class="form-control required" years="${2050..2000}"/>

                    </div>

                </span>
            </div>

        </div>

    </g:form>

    <script type="text/javascript">



//        $("#inicioDate").selected(function () {
//           console.log($(this).val())
//        });

        console.log("-->" +   $("#inicioDate").selected)


        var validator = $("#frmPeriodo").validate({
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