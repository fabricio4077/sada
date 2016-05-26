<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 25/05/2016
  Time: 21:53
--%>

<div class="col-md-2" style="float: right; margin-bottom: 10px">
        <a href="#" class="btn btn-info btnAgregarPlan" title="">
            <i class="fa fa-plus"> Agregar Plan</i>
        </a>
</div>

<div class="col-md-12">
    <table class="table table-condensed table-bordered table-striped">
        <thead>
            <tr>
                <th>Actividad</th>
                <th>Responsable</th>
                <th>Plazo</th>
                <th>Costo de la Medida</th>
                <th>Acciones</th>
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

</script>