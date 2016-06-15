<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 15/06/16
  Time: 12:13 PM
--%>
<g:each in="${datos}" var="d">

    <table class="table table-bordered table-condensed table-hover" id="tabla_${d?.id}">
        <tbody>
        <tr>
            <td><g:select name="elemento_name" from="${situacion.Elemento.list()}" id="elemento_${d?.id}" optionKey="id" optionValue="nombre"/> </td>
            <td><g:textField name="metodo_name" id="metodo" class="form-control"/></td>
            <td><g:textField name="limite_name" id="limite" class="form-control number"/></td>
            <td id="unidad_${d?.id}"></td>
            <td><g:textField name="resultado_name" id="resultado" class="form-control"/></td>
            <td><g:textField name="maximo_name" id="maximo" class="form-control"/></td>
            <td>
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
            console.log("-->" + idG);
        });


    </script>
</g:each>

<script>
    $(".btnBorrarFila1").click(function () {

        var idF = $(this).data('id');
        console.log("-->" + idF);
                %{--$.ajax({--}%
                    %{--type: 'POST',--}%
                    %{--url: "${createLink(controller: 'situacionAmbiental', action: 'borrarFila_ajax')}",--}%
                    %{--data:{--}%
                        %{--id: idF--}%
                    %{--},--}%
                    %{--success: function (msg){--}%
                        %{--if(msg == 'ok'){--}%
                            %{--log("Fila borrada correctamente","success");--}%
                            %{--$("#tabla_"+idF).toggle(600);--}%
                        %{--}else{--}%
                            %{--log("Error al borrar la fila","error")--}%
                        %{--}--}%
                    %{--}--}%
                %{--});--}%
    });

//    $(".btnGuardarFila1").click(function () {
//        var idG = $(this).data('id');
//        console.log("-->" + idG);
//    });

</script>



