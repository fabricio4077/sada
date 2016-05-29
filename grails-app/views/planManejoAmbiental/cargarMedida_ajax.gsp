<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 29/05/2016
  Time: 14:05
--%>

<div class="row">
    <div class="col-md-2">
        <strong> Medidas</strong>
    </div>
    <div class="col-md-4" id="divMedida">
        <g:select name="medida_name" id="medida" from="${medidasExistentes}" class="form-control" optionValue="medida" optionKey="id" noSelection="[null: 'Seleccione...']"/>
    </div>

    <div class="col-md-3" style="margin-left: 10px">
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
    <div id="divTablaMedida">

    </div>
</div>




<script type="text/javascript">
    $("#medida").change(function () {
        var idM = $(this).val();
        if(idM != 'null'){
            $.ajax({
                type: 'POST',
                url: "${createLink(controller: 'planManejoAmbiental', action: 'tablaMedida_ajax')}",
                data:{
                    id:idM
                },
                success: function (msg) {
                    $("#divTablaMedida").html(msg)
                }
            })
        }
    });

    $("#btnCrearMedida").click(function () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'planManejoAmbiental', action: 'crearMedida_ajax')}",
            data:{

            },
            success: function (msg) {
                $("#divCrearMedida").html(msg)
            }
        })
    });
</script>