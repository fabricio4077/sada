<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 13/06/16
  Time: 11:10 AM
--%>

<div class="row" style="margin-top: -10px">
    <div class="col-md-2"></div>
    <div class="col-md-8">
        <i class='fa fa-exclamation-triangle fa-3x text-info text-shadow'></i> <b>
        Actualmente su estación posee un generador eléctrico, <br> complete los datos para agregarlo como emisor de gases.</b>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <label class="col-md-3 control-label text-info">
            Emisor
        </label>
        <div class="col-md-4">
            <g:textField name="emisor_N" value="${'Generador eléctrico'}" class="form-control" readonly="true"/>
        </div>
    </div>
</div>
<g:form class="form-horizontal" name="frmGenerador" role="form" action="save" method="POST">
    <div class="row">
        <div class="col-md-12">
            <span class="grupo">
            <label class="col-md-3 control-label text-info">
                Horas uso por año
            </label>
            <div class="col-md-4">
                <g:textField name="horas_name" id="horas" maxlength="4" class="form-control number required"/>
            </div>
            </span>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <label class="col-md-8 control-label text-info">
                Se ha realizado mantenimiento al generador?
            </label>
            <div class="col-md-2">
                SI:  <g:checkBox name="mantenimientoSi_name" id="mantenimientoSi" class="form-control"/>
            </div>
            <div class="col-md-2">
                NO:  <g:checkBox name="mantenimientoNo_name" id="mantenimientoNo" class="form-control"/>
            </div>
        </div>
    </div>
</g:form>

<script type="text/javascript">


    $("#mantenimientoSi").click(function () {
        if($(this).prop('checked')){
            $("#mantenimientoNo").prop('checked', false)
        }
    });

    $("#mantenimientoNo").click(function () {
        if($(this).prop('checked')){
            $("#mantenimientoSi").prop('checked', false)
        }
    });


    var validator = $("#frmGenerador").validate({
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

