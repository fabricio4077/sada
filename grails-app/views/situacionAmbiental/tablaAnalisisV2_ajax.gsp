<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 15/06/16
  Time: 11:40 AM
--%>
<g:each in="${tablas}" var="tabla">
    <table class="table table-bordered table-condensed table-hover" %{--style="width: 550px"--}% id="${tabla?.id}">
        <thead>
        <tr>
            <th style="width: 10%">Ensayo</th>
            <th style="width: 35%">Método de Referencia</th>
            <th style="width: 10%">Límites de detección</th>
            <th style="width: 10%">Unidades</th>
            <th style="width: 10%">Resultados</th>
            <th style="width: 10%">Límite máximo permisible</th>
            <th style="width: 10%">Acciones</th>
        </tr>
        </thead>
    </table>

    <div id="divBody_${tabla?.id}">

    </div>

    <div class="col-md-4">
        <a href="#" id="btnAgregar" class="btn btn-info btnAgregarFila" title="Agregar fila" data-id="${tabla?.id}">
            <i class="fa fa-plus"></i>
        </a>
    </div>

    <script>

        cargarDatos(${tabla?.id});

        function cargarDatos(id){
            $.ajax({
                type: 'POST',
                url: "${createLink(controller: 'situacionAmbiental', action: 'datosTablaLiquidas_ajax')}",
                data:{
                    id: id
                },
                success: function (msg){
                    $("#divBody_${tabla?.id}").html(msg)
                }
            })
        }

    </script>

</g:each>

<script>

    $(".btnAgregarFila").click(function () {
        var idT = $(this).data('id');
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'situacionAmbiental', action: 'agregarDatosTablaLiquidas_ajax')}",
            data:{
                id: idT
            },
            success: function (msg){
                $("#divBody_" + idT).append(msg)
            }
        })
    });




</script>





