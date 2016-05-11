<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 21/04/2016
  Time: 21:59
--%>

    <g:each in="${listaBiologos}" var="lis">
        <tr>
            <td class="azul">${lis?.titulo + " " + lis?.nombre + " " + lis?.apellido}</td>
            <td style="float: right">
                <div class="btn-group btn-group-sm" role="group">
                    <a href="#" id="seleccionar" class="btn btn-success btnSel" title="Seleccionar biólogo" iden="${lis.id}"><i class="fa fa-check"></i>
                    </a>
                    %{--<a href="#" id="borrar" class="btn btn-danger btnBorrar" title="Borrar Coordenada" iden="${c.id}"><i class="fa fa-trash"></i>--}%
                    %{--</a>--}%
                </div>
            </td>
        </tr>
    </g:each>


<script type="text/javascript">

    $(".btnSel").click(function () {
        var idB = $(this).attr('iden');
        $.ajax({
           type: 'POST',
            url: "${createLink(controller: 'asignados', action: 'asignarBiologo_ajax')}",
            data: {
                id: ${pre?.id},
                biologo: idB
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Biólogo asignado a su auditoría correctamente","success")
                    cargarBiologo();
                }else{
                    log("Error al asignar el biólogo","error")
                }
            }

        });

    });

</script>
