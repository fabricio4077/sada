<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 23/04/2016
  Time: 22:15
--%>

<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 23/04/2016
  Time: 19:31
--%>

<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 21/04/2016
  Time: 21:59
--%>

<g:each in="${listaEspe}" var="lis">
    <tr>
        <td class="azul">${lis?.titulo + " " + lis?.nombre + " " + lis?.apellido}</td>
        <td style="float: right">
            <div class="btn-group btn-group-sm" role="group">
                <a href="#" id="seleccionarEspe" class="btn btn-success btnSelEs" title="Seleccionar especialista" iden="${lis.id}"><i class="fa fa-check"></i>
                </a>
                %{--<a href="#" id="borrar" class="btn btn-danger btnBorrar" title="Borrar Coordenada" iden="${c.id}"><i class="fa fa-trash"></i>--}%
                %{--</a>--}%
            </div>
        </td>
    </tr>
</g:each>


<script type="text/javascript">

    $(".btnSelEs").click(function () {
        var idE = $(this).attr('iden');
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'asignados', action: 'asignarEspecialista_ajax')}",
            data: {
                id: ${pre?.id},
                especialista: idE
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Especialista asignado a su auditoría correctamente","success");
                    cargarEspecialista();
                }else{
                    log("Error al asignar el especialista","error")
                }
            }

        });

    });

</script>
