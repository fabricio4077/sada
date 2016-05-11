<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 21/04/2016
  Time: 20:42
--%>
<div class="row">
    <div class="col-md-7 negrilla alineacion margen negrilla control-label">Coordinación del Proyecto:</div>
</div>
<div class="row">
    <div class="col-md-10 azul alineacion">
        <g:if test="${coordinador.size() > 0}">
            ${coordinador?.first()?.persona?.nombre + " " + coordinador?.first()?.persona?.apellido}
        </g:if>
        <g:else>
            <strong>No existe ningún coordinador asignado a esta auditoría</strong>
        </g:else>
    </div>
    <a href="#" id="btnSelCoor" class="btn btn-primary" title="Listar coordinadores">
        <i class="fa fa-chevron-circle-right"></i>
    </a>
</div>

<script type="text/javascript">


    function cargarTablaCoordinador() {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'asignados', action:  "tablaCoordinadores_ajax")}",
            data: {
                id: ${pre?.id}
            },
            success: function (msg) {
                $("#listados").html(msg).effect("drop", "slow").fadeIn();
            }
        })
    }

    $("#btnSelCoor").click(function () {
        cargarTablaCoordinador()
    });


</script>