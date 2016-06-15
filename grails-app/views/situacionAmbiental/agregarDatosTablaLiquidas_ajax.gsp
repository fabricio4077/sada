<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 15/06/16
  Time: 12:34 PM
--%>

<table class="table table-bordered table-condensed table-hover" id="tabla_${analisis?.id}">
    <tbody>
    <tr>
        <td><g:select name="elemento_name" from="${situacion.Elemento.list()}" id="elemento_${analisis?.id}" optionKey="id" optionValue="nombre"/> </td>
        <td><g:textField name="metodo_name" id="metodo" class="form-control"/></td>
        <td><g:textField name="limite_name" id="limite" class="form-control number"/></td>
        <td id="unidad_${analisis?.id}"></td>
        <td><g:textField name="resultado_name" id="resultado" class="form-control"/></td>
        <td><g:textField name="maximo_name" id="maximo" class="form-control"/></td>
        <td>
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



</script>