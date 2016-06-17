<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 15/06/16
  Time: 12:13 PM
--%>

<style>
    .centrar {
        text-align: center;
    }
</style>

<g:each in="${datos}" var="d">

    <table class="table table-bordered table-condensed table-hover" id="tabla_${d?.id}">
        <tbody>
        <tr>
            <td style="width: 10%"><g:select name="elemento_name" class="form-control"
                          from="${situacion.Elemento.list()}" id="elemento_${d?.id}"
                          optionKey="id" optionValue="nombre" value="${d?.elemento?.id}"/></td>
            <td style="width: 27%"><g:textField name="metodo_name" id="metodo_${d?.id}" class="form-control" value="${d?.referencia}"/></td>
            <td style="width: 10%"><g:textField name="limite_name" id="limite_${d?.id}" class="form-control" value="${d?.limite}"/></td>
            <td id="unidad_${d?.id}" style="width: 7%"></td>
            <td style="width: 10%"><g:textField name="resultado_name" id="resultado_${d?.id}" class="form-control" value="${d?.resultado}"/></td>
            <td style="width: 10%"><g:textField name="maximo_name" id="maximo_${d?.id}" class="form-control" value="${d?.maximo}"/></td>
            <td style="width: 8%" class="centrar">
                <div class="btn-group">
                    <a href="#" id="btnG_${d?.id}" class="btn btn-success btn-sm btnGuardarFila1" title="Guardar" data-id="${d?.id}">
                        <i class="fa fa-save"></i>
                    </a>
                    <a href="#" id="btnB_${d?.id}" class="btn btn-danger btn-sm btnBorrarFila1" title="Borrar" data-id="${d?.id}">
                        <i class="fa fa-trash"></i>
                    </a>
                </div>
            </td>
        </tr>
        </tbody>
    </table>


    <script>

        cargarUnidad($("#elemento_${d?.id}").val());

        function cargarUnidad (id) {
            $.ajax({
                type: 'POST',
                url: "${createLink(controller: 'situacionAmbiental', action: 'cargarUnidad_ajax')}",
                data:{
                    id: id

                },
                success: function (msg) {
                    $("#unidad_${d?.id}").html(msg)
                }
            })
        }


        $("#elemento_${d?.id}").change(function () {
            var ele = $(this).val();
            cargarUnidad(ele)
        });

        $("#btnG_${d?.id}").click(function () {
            var idG = $(this).data('id');
            $.ajax({
               type: 'POST',
                url: "${createLink(controller: 'situacionAmbiental', action: 'guardarFila_ajax')}",
                data:{
                      id: idG,
                      elemento: $("#elemento_${d?.id}").val(),
                      referencia: $("#metodo_${d?.id}").val(),
                      limite: $("#limite_${d?.id}").val(),
                      resultado: $("#resultado_${d?.id}").val(),
                      maximo: $("#maximo_${d?.id}").val(),
                      tabla: ${tabla?.id}
                },
                success: function (msg) {

                }
            });
        });

        $("#btnB_${d?.id}").click(function () {

            var idF = $(this).data('id');
//            console.log("-->" + idF);
            $.ajax({
                type: 'POST',
                url: "${createLink(controller: 'situacionAmbiental', action: 'borrarFila_ajax')}",
                data:{
                    id: idF
                },
                success: function (msg){
                    if(msg == 'ok'){
                        log("Fila borrada correctamente","success");
                        $("#tabla_"+idF).toggle(600);
                    }else{
                        log("Error al borrar la fila","error")
                    }
                }
            });
        });


    </script>
</g:each>



