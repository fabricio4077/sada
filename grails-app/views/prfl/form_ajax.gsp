<%@ page import="Seguridad.Prfl" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<g:if test="${!prflInstance}">
    <elm:notFound elem="Prfl" genero="o"/>
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmPrfl" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${prflInstance?.id}"/>

        <div class="form-group ${hasErrors(bean: prflInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>

                <div class="col-md-6">
                    <g:textField name="nombre" maxlength="63" required="" class="form-control required"
                                 value="${prflInstance?.nombre}"/>
                </div>

            </span>
        </div>

        <div class="form-group ${hasErrors(bean: prflInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>

                <div class="col-md-6">
                    <g:textField name="descripcion" maxlength="63" class="form-control"
                                 value="${prflInstance?.descripcion}"/>
                </div>

            </span>
        </div>

        %{--<div class="form-group ${hasErrors(bean: prflInstance, field: 'codigo', 'error')} ">--}%
            %{--<span class="grupo">--}%
                %{--<label for="codigo" class="col-md-2 control-label text-info">--}%
                    %{--Codigo--}%
                %{--</label>--}%

                %{--<div class="col-md-6">--}%
                    %{--<g:textField name="codigo" maxlength="63" class="allCaps form-control"--}%
                                 %{--value="${prflInstance?.codigo}"/>--}%
                %{--</div>--}%

            %{--</span>--}%
        %{--</div>--}%

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmPrfl").validate({
            errorClass: "help-block",
            errorPlacement: function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success: function (label) {
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