<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 15/06/16
  Time: 12:34 PM
--%>

<style>
.centrar {
    text-align: center;
}
</style>

<table class="table table-bordered table-condensed table-hover" id="tabla_${analisis?.id}">
    <tbody>
    <tr>
        <td style="width: 10%"><g:select name="elemento_name"
                      from="${situacion.Elemento.list()}"
                      id="elemento_${analisis?.id}"
                      optionKey="id" optionValue="nombre" value="${analisis?.elemento?.id}" class="form-control"/></td>
        <td style="width: 27%"><g:textField name="metodo_name" id="metodo_${analisis?.id}" class="form-control" value="${analisis?.referencia}"/></td>
        <td style="width: 10%"><g:textField name="limite_name" id="limite_${analisis?.id}" class="form-control" value="${analisis?.limite}"/></td>
        <td id="unidad_${analisis?.id}" style="width: 7%"></td>
        <td style="width: 10%"><g:textField name="resultado_name" id="resultado_${analisis?.id}" value="${analisis?.resultado}" class="form-control"/></td>
        <td style="width: 10%"><g:textField name="maximo_name" id="maximo_${analisis?.id}" value="${analisis?.resultado}" class="form-control"/></td>
        <td style="width: 8%" class="centrar">
            <div class="btn-group">
                <a href="#" id="btnGuardarFila_${analisis?.id}" class="btn btn-success btn-sm" title="Guardar">
                    <i class="fa fa-save"></i>
                </a>
                <a href="#" id="btnBorrarFila_${analisis?.id}" class="btn btn-danger btn-sm" title="Borrar">
                    <i class="fa fa-trash"></i>
                </a>
            </div>
        </td>
    </tr>
    </tbody>
</table>

<script>

    cargarUnidad($("#elemento_${analisis?.id}").val());

    function cargarUnidad (id) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'situacionAmbiental', action: 'cargarUnidad_ajax')}",
            data:{
                id: id
            },
            success: function (msg) {
                $("#unidad_${analisis?.id}").html(msg)
            }
        })
    }


    $("#elemento_${analisis?.id}").change(function () {
        var ele = $(this).val();
        cargarUnidad(ele)
    });


    $("#btnBorrarFila_${analisis?.id}").click(function () {
        var idF = ${analisis?.id}
        $.ajax({
           type: 'POST',
            url: "${createLink(controller: 'situacionAmbiental', action: 'borrarFila_ajax')}",
            data:{
                id: idF
            },
            success: function (msg){
                if(msg == 'ok'){
                    log("Fila borrada correctamente","success");
                    $("#tabla_${analisis?.id}").toggle(600);
                }else{
                    log("Error al borrar la fila","error")
                }
            }
        });
    })

    $("#btnGuardarFila_${analisis?.id}").click(function () {
        var idG = ${analisis?.id}
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'situacionAmbiental', action: 'guardarFila_ajax')}",
            data:{
                id: idG,
                elemento: $("#elemento_${analisis?.id}").val(),
                referencia: $("#metodo_${analisis?.id}").val(),
                limite: $("#limite_${analisis?.id}").val(),
                resultado: $("#resultado_${analisis?.id}").val(),
                maximo: $("#maximo_${analisis?.id}").val(),
                tabla: ${tabla?.id}
            },
            success: function (msg) {

            }
        });
    });



</script>