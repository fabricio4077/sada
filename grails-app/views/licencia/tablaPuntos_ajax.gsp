<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 05/06/2016
  Time: 18:28
--%>
<style>
    .centrar{
        text-align: center;
    }
</style>

<div class="row-fluid"  style="width: 99.7%;height: 500px;overflow-y: auto;float: right;">
    <div class="span12">
        <div style="width: 1120px; height: 300px;">
            <table class="table table-condensed table-bordered table-striped" id="tablaL">
                <tbody>
                <g:each in="${lista}" var="lis" status="i">
                    <tr>
                        <td style="width: 5%">${i+1}</td>
                        <td style="width: 61%">${lis?.descripcion}</td>
                        <td style="width: 10%">
                            <div class="centrar">
                            <a href="#" class="btn btn-danger btn-sm btnBorrarPunto" data-id="${lis?.id}" title="Borrar punto">
                                <i class="fa fa-trash"></i>
                            </a>
                        </div>
                        </td>
                    </tr>
                </g:each>
                </tbody>
        </table>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(".btnBorrarPunto").click(function () {
        var idPunto = $(this).data('id');
        $.ajax({
           type: 'POST',
            url: "${createLink(controller: 'licencia', action: 'borrarPunto_ajax')}",
            data: {
                id: idPunto
            },
            success: function(msg){
                var parts = msg.split("_");
                if(parts[0] == "ok"){
                log(parts[1],"success");
                    cargarTablaPuntos();
                }else{
                log(parts[1],"error")
                }
            }
        });
    });
</script>