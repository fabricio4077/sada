<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 29/05/2016
  Time: 14:05
--%>

<script type="text/javascript" src="${resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/js', file: 'bootstrap-select.js')}"></script>
<link rel="stylesheet" href="${resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/css', file: 'bootstrap-select.css')}"/>

<div class="row">
    <div class="col-md-2">
        <strong> Medidas</strong>
    </div>
    <div class="col-md-4" id="divMedida">
        <g:select name="medida_name" id="medida" from="${medidasExistentes}"
                  class="form-control " optionValue="descripcion" optionKey="id" noSelection="[null: 'Seleccione...']"/>
    </div>

    <div class="col-md-3" style="margin-left: 12px">
        <div class="btn-group">
            <a href="#" id="btnCrearMedida" class="btn btn-info" title="Crear Medida">
                <i class="fa fa-plus"></i> Nueva Medida
            </a>
        </div>
    </div>
</div>

<div class="row">
    <div id="divCrearMedida">

    </div>
</div>


<div class="row">

    <div id="divTablaMedida" class="col-md-12">

    </div>
</div>




<script type="text/javascript">

    $('.selectpicker').selectpicker({
        width      : "350px",
        limitWidth : true,
        style      : "btn-sm"
    });

    function cargarTabla (id,au){
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'planManejoAmbiental', action: 'tablaMedida_ajax')}",
            data:{
                id: id,
                aupm: au
            },
            success: function (msg) {
                $("#divTablaMedida").html(msg)
            }
        })
    }


    $("#medida").change(function () {
        var idM = $(this).val();
        $("#divCrearMedida").html('')
        if(idM != 'null'){
            cargarTabla(idM, ${aupm?.id})
        }
    });

    $("#btnCrearMedida").click(function () {
        $("#divTablaMedida").html('')
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'planManejoAmbiental', action: 'crearMedida_ajax')}",
            data:{
                aupm: ${aupm?.id}
            },
            success: function (msg) {
                $("#divCrearMedida").html(msg)
            }
        })
    });
</script>