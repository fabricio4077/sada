<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 24/05/16
  Time: 10:28 AM
--%>

<script type="text/javascript" src="${resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/js', file: 'bootstrap-select.js')}"></script>
<link rel="stylesheet" href="${resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/css', file: 'bootstrap-select.css')}"/>

<div class="row" style="margin-top: -20px">
    <div class="col-md-5">
        <strong>Nuevo Hallazgo</strong>
    </div>
</div>

<div class="row">
    <div class="col-md-11">
        <g:textArea name="hallazgo_name" id="hallazgoDescripcion" maxlength="500" class="form-control" style="height: 190px; resize: none"/>
    </div>
</div>

<div class="row">
    <div class="col-md-6">
        <g:select name="calificacion_name" id="calificacion"  from="${evaluacion.Calificacion.list()}" optionKey="id"
                  optionValue="${{it.sigla + " - " + it.nombre}}"    class="form-control" />
    </div>
    <div class="col-md-5">
        <div class="btn-group">
            <a href="#" id="btnGuardarHallazgo" class="btn btn-success" title="Guardar Hallazgo">
                <i class="fa fa-save"> Guardar</i>
            </a>
            <a href="#" id="btnCerrar" class="btn btn-danger" title="Cerrar">
                <i class="fa fa-close"> Cerrar</i>
            </a>
        </div>

    </div>

</div>

<script type="text/javascript">


    //cerrar div de crear hallazgo
    $("#btnCerrar").click(function () {
        $("#tablaCrearHallazgo").html('')
    });

    //guardar nuevo hallazgo

    $("#btnGuardarHallazgo").click(function () {
        $.ajax({
           type: 'POST',
            url: '${createLink(controller: 'evaluacion', action:  'guardarHallazgo_ajax')}',
            data:{
                id: ${evaluacion?.id},
                descripcion: $("#hallazgoDescripcion").val(),
                calificacion: $("#calificacion").val()
            },
            success: function (msg){
                if(msg == 'ok'){
                    $("#tablaCrearHallazgo").html('');
                    $('.selectpicker').selectpicker('refresh');
                    cargarComboHallazgo(${evaluacion?.id});
                    bootbox.hideAll();
                    cargarTablaEvaPlan();
                    cargarTablaEva();
                }else{
                    log("Error al crear el hallazgo","error")
                }

            }
        });
    });

</script>

