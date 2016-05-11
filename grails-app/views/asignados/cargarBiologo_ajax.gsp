<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 21/04/2016
  Time: 20:48
--%>
<div class="row">
    <div class="col-md-7 negrilla negrilla margen control-label">Técnico Biólogo:</div>
</div>
<div class="row">
    <div class="col-md-10 azul alineacion">
        <g:if test="${biologo.size() > 0}">
            ${biologo?.first()?.persona?.nombre + " " + biologo?.first()?.persona?.apellido}
        </g:if>
        <g:else>
            <strong>No existe ningún biólogo asignado a esta auditoría</strong>
        </g:else>
    </div>
    <a href="#" id="btnSelBio" class="btn btn-primary" title="Listar biólogos">
        <i class="fa fa-chevron-circle-right"></i>
    </a>
</div>

<script type="text/javascript">


     function cargarTablaBiologos() {
         $.ajax({
             type: 'POST',
             url: "${createLink(controller: 'asignados', action:  "tablaBiologos_ajax")}",
             data: {
                id: ${pre?.id}
             },
             success: function (msg) {
                 $("#listados").html(msg).effect("drop", "slow").fadeIn();
             }
         })
     }

    $("#btnSelBio").click(function () {
        cargarTablaBiologos()
    });


</script>