<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 25/05/2016
  Time: 21:53
--%>

<div class="col-md-2" style="float: right; margin-bottom: 10px">
        <a href="#" class="btn btn-info btnAgregarPlan" data-id="${evam?.id}" title="">
            <i class="fa fa-plus"> Agregar Plan</i>
        </a>
</div>

<div id="divCrearPlan">

</div>

<div class="col-md-12">
    <table class="table table-condensed table-bordered table-striped">
        <thead>
            <tr>
                <th style="width: 40%">Actividad</th>
                <th style="width: 20%">Responsable</th>
                <th style="width: 7%">Plazo</th>
                <th style="width: 7%">Costo</th>
                <th style="width: 15%">Acciones</th>
            </tr>
        </thead>
    </table>
</div>

<div id="divBodyPlanes">

</div>

<script type="text/javascript">

    <g:if test="${lis.size() > 0}">
        cargarBodyPlanes();
    </g:if>

    function cargarBodyPlanes() {
        $.ajax({
           type: 'POST',
            url: '${createLink(controller: 'planAccion', action: 'bodyPlanes_ajax')}',
            data: {
                id: ${evam?.id}
            },
            success: function (msg){
                $("#divBodyPlanes").html(msg)
            }
        });
    }

    //función para agregar un plan

    $(".btnAgregarPlan").click(function () {
        var idE = $(this).data('id');
        $.ajax({
           type:'POST',
            url:'${createLink(controller: 'planAccion', action: 'crearActividad_ajax')}',
            data:{
                id: idE
            },
            success: function (msg) {
            $("#divCrearPlan").html(msg)
            }
        });
    });

</script>