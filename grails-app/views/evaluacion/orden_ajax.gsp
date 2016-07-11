<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 11/07/2016
  Time: 15:31
--%>

<div class="row">
    <div class="col-md-3 text-info">
        Orden de evaluación
    </div>
    <div class="col-md-4">
        <g:textField name="orden_name" id="ordenEva" value="${evaluacion?.orden}" class="form-control number" maxlength="3"/>
    </div>
    <div class="col-md-2">
        <a href="#" class="btn btn-success " id="btnGuardarOrden" title="Guardar Orden">
            <i class="fa fa-save"> Guardar</i>
        </a>
    </div>
</div>

<script>
    $("#btnGuardarOrden").click(function () {
        var orden = $("#ordenEva").val();
        $.ajax({
           type: 'POST',
            url: "${createLink(controller: 'evaluacion', action: 'guardarOrden_ajax')}",
            data:{
                id: ${evaluacion?.id},
                orden: orden
            },
            success: function (msg){
                var parts = msg.split("_");
                if(msg == 'ok'){
                    log("Orden de evaluación guardado correctamente","success")
                    cargarTablaEva();
                    bootbox.hideAll()
                }else{
                    log(parts[1],"error")
                }
            }
        });
    });
</script>