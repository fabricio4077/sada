<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 29/05/2016
  Time: 14:24
--%>

<table class="table table-condensed table-bordered table-striped">
<thead>
    <tr>
        <th style="width: 20%">Medida Propuesta</th>
        <th style="width: 15%">Indicadores</th>
        <th style="width: 15%">Medio de Verificación</th>
        <th style="width: 10%">Plazo</th>
        <th style="width: 5%">Costo</th>
    </tr>
</thead>
    <tbody>
    <tr>
        <td>${medida?.descripcion}</td>
        <td>${medida?.indicadores}</td>
        <td>${medida?.verificacion}</td>
        <td>${medida?.plazo}</td>
        <td>${medida?.costo}</td>
    </tr>
    </tbody>
</table>

<div class="col-md-3" style="float: right">
    <div class="btn-group">
        <a href="#" id="btnEscogerMedida" class="btn btn-success btn-sm ${ver == '1' ? 'hide' : ''}" title="Asignar medida">
            <i class="fa fa-check-square-o" ></i> Asignar Medida
        </a>
        <a href="#" id="btnCancelarAsig" class="btn btn-danger btn-sm ${ver == '1' ? 'hide' : ''}" title="Cancelar">
            <i class="fa fa-close"></i> Cancelar
        </a>
    </div>
</div>

<script type="text/javascript">
    $("#btnCancelarAsig").click(function () {
        $("#divTablaMedida").html('')
    });

    $("#btnEscogerMedida").click(function (){
        $.ajax({
            type:'POST',
            url: "${createLink(controller: 'planManejoAmbiental', action: 'asignarMedida_ajax')}",
            data:{
                id: ${medida?.id},
                aupm: '${aupm?.id}'
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Medida asignada correctamente","success");
//                    $("#dlgMedida").close();
                    bootbox.hideAll();
                    cargarTablaPlanes(${aupm?.detalleAuditoria?.auditoria?.preauditoria?.id}, ${(aupm.periodo == 'ANT') ? true : false});
                }else{
                    log("Error al asignar la medida","error");
                }
            }
        });
    });

</script>