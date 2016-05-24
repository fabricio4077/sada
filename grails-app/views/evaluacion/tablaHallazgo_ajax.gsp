<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 24/05/16
  Time: 12:58 PM
--%>


<table class="table table-bordered table-condensed table-hover" style="width: 440px">
    <thead>
    <tr>
        <th style="width: 80%">Descripción</th>
        <th style="width: 3%">Acciones</th>
    </tr>
    </thead>
    <tbody>
        <tr>
            %{--<g:if test="${evaluacion?.hallazgo?.descripcion?.size() > 100}">--}%
                %{--<td>${evaluacion?.hallazgo?.descripcion?.substring(0,100)}...</td>--}%
            %{--</g:if>--}%
            %{--<g:else>--}%
                <td>${evaluacion?.hallazgo?.descripcion}</td>
            %{--</g:else>--}%
            <td style="text-align: center">
                <a href="#" class="btn btn-danger btn-sm btnBorrar" title="Quitar hallazgo" data-id="${evaluacion?.id}">
                    <i class="fa fa-trash"></i>
                </a>
            </td>
        </tr>
    </tbody>
</table>

<script type="text/javascript">

    //quitar el hallazgo
    $(".btnBorrar").click(function () {
        var idE = $(this).data('id');
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'evaluacion', action: 'borrarHallazgo_ajax')}',
            data:{
                id: idE
            },
            success: function(msg){
                if(msg == 'ok'){
                    $("#divSeleccionado").html('')
                    cargarTablaEva();
                }else{
                    log("No se puede quitar el hallazgo seleccionado","error")
                }

            }
        });
    });
</script>