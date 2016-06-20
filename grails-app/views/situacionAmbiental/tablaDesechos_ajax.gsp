<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 18/06/2016
  Time: 17:54
--%>

<style>
.centrar {
    text-align: center;
}
</style>

<g:if test="${!existentes}">
    <div class="alert alert-info" role="alert" style="text-align: center">
        <i class='fa fa-exclamation-triangle fa-2x text-info text-shadow'></i> Ningún desecho peligroso asignado
    </div>
</g:if>
<g:else>
    <table class="table table-bordered table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 50%">Descripción</th>
            <th style="width: 10%">Acciones</th>
            <th style="width: 5%"></th>
        </tr>
        </thead>
    </table>
    <div class="row-fluid"  style="width: 100%;height: 110px;overflow-y: auto;margin-top: -20px">
        %{--<div class="span12">--}%
            <div style="width: 450px; height: 200px;">


                <table class="table table-bordered table-condensed table-hover">
                    <tbody>
                    <g:each in="${existentes}" var="e">
                        <tr>
                            <td style="width: 50%">${e?.desechos?.descripcion}</td>
                            <td class="centrar" style="width: 20%">
                                <a href="#" id="btnG" class="btn btn-danger btn-sm btnBorrarFila" title="Borrar" data-id="${e?.id}">
                                    <i class="fa fa-trash"></i>
                                </a></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>

            </div>
        %{--</div>--}%
    </div>




</g:else>

<script>
    $(".btnBorrarFila").click(function () {
        var idD = $(this).data("id");
        $.ajax({
            type: 'POST',
            url:"${createLink(controller: 'situacionAmbiental', action: 'borrar_ajax')}",
            data:{
                id: idD
            },
            success: function (msg) {
                if(msg=='ok'){
                    log("Fila borrada correctamente","success");
                    cargarTablaDesechos();
                    cargarComboDesechos();
                }else{
                    log("Error al borrar la fila","error")
                }
            }
        });
    });
</script>


