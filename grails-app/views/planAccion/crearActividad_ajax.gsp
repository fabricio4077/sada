<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 31/05/2016
  Time: 23:38
--%>

<g:form class="form-horizontal" name="frmPlan" role="form" action="guardarActividad" method="POST">
    <g:hiddenField name="eva" value="${evam?.id}"/>
    <div class="row">
        <span class="grupo">
            <label for="actividad" class="col-md-2 control-label text-info">
                Actividad:
            </label>
            <div class="col-md-4">
                <g:textArea name="actividad" maxlength="1024" class="form-control required" style="height: 130px; resize: none"/>
            </div>
        </span>
        <span class="grupo">
            <label for="plazo" class="col-md-1 control-label text-info">
                Plazo:
            </label>
            <div class="col-md-2 input-group">
                <g:textField name="plazo" maxlength="4" class="form-control required noEspacios number" aria-describedby="dias"/>
                <span class="input-group-addon" id="dias">Días</span>
            </div>
        </span>
    </div>
    <div class="row">
        <span class="grupo">
            <label for="responsable" class="col-md-2 control-label text-info">
                Responsable:
            </label>
            <div class="col-md-4">
                <g:select name="responsable" from="${['Administrador de la E/S', 'Personal de la E/S', 'Dueño de la E/S']}" class="form-control"/>
            </div>
        </span>
        <span class="grupo">
            <label for="costo" class="col-md-1 control-label text-info">
                Costo:
            </label>
            <div class="col-md-3 input-group">
                <span class="input-group-addon" id="dinero">$</span>
                <g:textField name="costo" maxlength="10" class="form-control required noEspacios number" aria-describedby="dinero"/>
            </div>
            <div class="col-md-7"></div>
            <div class="col-md-5">* Coloque el valor en 0, si la actividad no tiene un costo monetario.</div>
        </span>
    </div>
    <div class="row">
        <span class="grupo">
            <label for="verificacion" class="col-md-2 control-label text-info">
                Verificacion:
            </label>
            <div class="col-md-6">
                <g:textField name="verificacion" maxlength="255" class="form-control required"/>
            </div>
        </span>
    </div>
 </g:form>

<div class="row" style="margin-bottom: 20px">
    <div class="col-md-5"></div>
    <div class="col-md-3">
        <a href="#" id="btnGuardaActividad" class="btn btn-success btn-sm" title="Guardar Actividad">
            <i class="fa fa-save"></i> Guardar Actividad
        </a>
        <a href="#" id="btnCancelarActividad" class="btn btn-danger btn-sm" title="Cancelar">
            <i class="fa fa-close"></i> Cancelar
        </a>
    </div>
</div>

<script type="text/javascript">

    $("#btnCancelarActividad").click(function () {
        $("#divCrearPlan").html('')
    });

    $("#btnGuardaActividad").click(function () {
        var $form = $("#frmPlan");
        if ($form.valid()) {
            $.ajax({
                type: "POST",
                url: '${createLink(controller: 'planAccion', action:'guardarPlan_ajax')}',
                data: $form.serialize(),
                success: function (msg) {
//                    var parts = msg.split("_");
                    if (msg == "ok") {
                        log("Actividad guardada correctamente","success");
                        $("#divCrearPlan").html('');
                        bootbox.hideAll();
                        cargarAcciones();
                    } else {
                        log("Error al guardar la actividad","error")
                    }
                }
            });
        }
    });


    var validator = $("#frmPlan").validate({
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