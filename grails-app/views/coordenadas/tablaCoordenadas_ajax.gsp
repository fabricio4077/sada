<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 16/04/2016
  Time: 16:59
--%>

<g:each in="${coordenadas}" var="c">
    <tr>
        <td>${c?.coordenadasX}</td>
        <td>${c?.coordenadasY}</td>
        <td>
            <div class="btn-group btn-group-sm" role="group">
                <a href="#" id="editar" class="btn btn-success btnEditar" title="Editar Coordenada" iden="${c.id}"><i class="fa fa-pencil"></i>
                </a>
                <a href="#" id="borrar" class="btn btn-danger btnBorrar" title="Borrar Coordenada" iden="${c.id}"><i class="fa fa-trash"></i>
                </a>
            </div>
        </td>
    </tr>
</g:each>

<script type="text/javascript">

    $(".btnEditar").click(function () {
        var idCoordenadas = $(this).attr("iden");
        cargarCoordenadas(${preauditoria?.id},idCoordenadas)
    });

    $(".btnBorrar").click(function () {
        var idCoordenadas = $(this).attr("iden");
        bootbox.confirm("Está seguro de querer borrar esta coordenada?", function (result){
            if(result){
                $.ajax({
                    type: 'POST',
                    url: "${createLink(controller: 'coordenadas', action: 'borrarCoordenadas_ajax')}",
                    data:{
                        id: idCoordenadas
                    },
                    success: function(msg){
                        if(msg == 'ok'){
                            log("Coordenada borrada correctamente","success")
                            cargarTablaCoordenadas(${preauditoria?.id});
                        }else{
                            log("Error al borrar las coordenadas","error")
                        }
                    }
                });
            }
        })
      });


</script>