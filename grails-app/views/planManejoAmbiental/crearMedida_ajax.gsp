<%@ page import="plan.Medida" %>
<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 29/05/2016
  Time: 14:54
--%>

<g:form class="form-horizontal" name="frmMedida" role="form" action="guardarMedida" method="POST">
%{--<div class="form-group ${hasErrors(bean: medidaInstance, field: 'descripcion', 'error')} ">--}%
  <div class="row">
      <span class="grupo">
          <label for="descripcion" class="col-md-2 control-label text-info">
              Descripción:
          </label>
          <div class="col-md-4">
              <g:textArea name="descripcion" maxlength="500" class="form-control required" style="height: 130px; resize: none"/>
          </div>
      </span>

      <span class="grupo">
          <label for="indicadores" class="col-md-1 control-label text-info">
              Indicadores:
          </label>
          <div class="col-md-4">
              <g:textArea name="indicadores" maxlength="255" class="form-control required" style="height: 130px; resize: none"/>
          </div>

      </span>
  </div>
    <div class="row">
        <span class="grupo">
            <label for="verificacion" class="col-md-2 control-label text-info">
                Verificacion:
            </label>
            <div class="col-md-4">
                <g:textField name="verificacion" maxlength="255" class="form-control required"/>
            </div>
        </span>

        <span class="grupo">
            <label for="plazo" class="col-md-1 control-label text-info">
                Plazo:
            </label>
            <div class="col-md-4">
                <g:select name="plazo" from="${plan.Medida.constraints.plazo.inList}" class="form-control"  valueMessagePrefix="medida.plazo"/>
            </div>

        </span>

    </div>

%{--</div>--}%

%{--<div class="form-group ${hasErrors(bean: medidaInstance, field: 'indicadores', 'error')} ">--}%

%{--</div>--}%

%{--<div class="form-group ${hasErrors(bean: medidaInstance, field: 'verificacion', 'error')} ">--}%

%{--</div>--}%

%{--<div class="form-group ${hasErrors(bean: medidaInstance, field: 'plazo', 'error')} ">--}%

%{--</div>--}%

</g:form>

<div class="row">
    <div class="col-md-5"></div>
    <div class="col-md-3">
        <a href="#" id="btnGuardarMedida" class="btn btn-success btn-sm" title="Guardar Medida">
            <i class="fa fa-save"></i> Guardar Medida
        </a>
        <a href="#" id="btnCancelarMedida" class="btn btn-danger btn-sm" title="Cancelar">
            <i class="fa fa-close"></i> Cancelar
        </a>
    </div>
</div>

<script type="text/javascript">

    $("#btnCancelarMedida").click(function () {
        $("#divCrearMedida").html('')
    });

    $("#btnGuardarMedida").click(function () {
        var $form = $("#frmMedida");
        if ($form.valid()) {
            $.ajax({
                type: "POST",
                url: '${createLink(controller: 'medida', action:'guardarMedida_ajax')}',
                data: $form.serialize(),
                success: function (msg) {
                    var parts = msg.split("_");
                    if (parts[0] == "ok") {
                        log("Medida guardada correctamente","success");
                        $("#divCrearMedida").html('');
                        cargarTabla(parts[1],${aupm?.id})
                    } else {
                      log("Error al guardar la medida","error")
                    }
                }
            });
        }
    });


    var validator = $("#frmMedida").validate({
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
</script>