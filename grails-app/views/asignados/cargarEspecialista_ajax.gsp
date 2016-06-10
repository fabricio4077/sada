<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 23/04/2016
  Time: 11:27
--%>

<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 21/04/2016
  Time: 20:48
--%>
<div class="row">
    <div class="col-xs-6 negrilla negrilla margen control-label">Especialista Ambiental:</div>
</div>
<div class="row">
    <div class="col-md-10 azul alineacion">
        <g:if test="${especialista.size() > 0}">
            ${especialista?.first()?.persona?.nombre + " " + especialista?.first()?.persona?.apellido}
        </g:if>
        <g:elseif test="${session.perfil.codigo == 'AUDI' && session.usuario.cargo == 'Especialista'}">
            ${session.usuario.nombre + " " + session.usuario.apellido}

        </g:elseif>
        <g:else>
            <strong>No existe ningún especialista asignado a esta auditoría</strong>
        </g:else>
    </div>
    <a href="#" id="btnSelEsp" class="btn btn-primary" title="Listar especialistas ambientales">
        <i class="fa fa-chevron-circle-right"></i>
    </a>
</div>

<script type="text/javascript">

    function cargarTablaEspecialista() {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'asignados', action:  "tablaEspecialistas_ajax")}",
            data: {
                id: ${pre?.id}
            },
            success: function (msg) {
                $("#listados").html(msg).addClass('animated fadeInDown');
            }
        })
    }

    $("#btnSelEsp").click(function () {
        cargarTablaEspecialista()
    });

    //funcion para guardar el especialista si el perfil es de auditor

    <g:if test="${session.perfil.codigo == 'AUDI' && session.usuario.cargo == 'Especialista'}">
    guardaEspe();
    </g:if>


    function guardaEspe () {
        $.ajax({
           type: 'POST',
            url: "${createLink(controller: 'asignados', action: 'guardarEspe_ajax')}",
            data: {
                id: ${pre?.id}
            },
            success: function (msg) {
                return false
            }
        });
    }

</script>