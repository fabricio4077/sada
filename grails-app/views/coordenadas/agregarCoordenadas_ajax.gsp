<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 16/04/2016
  Time: 14:18
--%>

<%@ page import="estacion.Coordenadas" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>

    <g:form class="form-horizontal" name="frmCoordenadas" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${coordenada?.id}" />

        <div class="form-group ${hasErrors(bean: coordenada, field: 'coordenadasX', 'error')} ">
            <span class="grupo">
                <label for="coordenadasX" class="col-md-3 control-label text-info">
                    Posición en X
                </label>
                <div class="col-md-6">
                    <g:textField name="x_name" id="coordenadasX" value="${coordenada?.coordenadasX}" class="number form-control  required"/>
                </div>

            </span>
        </div>

        <div class="form-group ${hasErrors(bean: coordenada, field: 'coordenadasY', 'error')} ">
            <span class="grupo">
                <label for="coordenadasY" class="col-md-3 control-label text-info">
                    Posición en Y
                </label>
                <div class="col-md-6">
                    <g:textField name="y_name" id="coordenadasY" value="${coordenada?.coordenadasY}" class="number form-control  required"/>
                </div>

            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmCoordenadas").validate({
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
