<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 15/06/16
  Time: 11:40 AM
--%>
<g:each in="${tablas}" var="tabla">
    <div class="alert alert-info" role="alert" style="text-align: center; margin-top: 60px">
      Fecha de Análisis: <b><util:fechaConFormato fecha="${tabla?.fecha}"/></b>
      %{--Fecha de Análisis: <b>${tabla?.fecha?.format("dd-MM-yyyy")}</b>--}%
    </div>
    <table class="table table-bordered table-condensed table-hover" %{--style="width: 550px"--}% id="${tabla?.id}">
        <thead>
        <tr>
            <th style="width: 10%">Ensayo</th>
            <th style="width: 35%">Método de Referencia</th>
            <th style="width: 10%">Límites de detección</th>
            <th style="width: 10%">Unidades</th>
            <th style="width: 10%">Resultados</th>
            <th style="width: 10%">Límite máximo permisible</th>
            <th style="width: 10%">Acciones
                <a href="#" class="btn btn-danger btnEliminarTabla btn-xs" title="Eliminar tabla" data-id="${tabla?.id}" style="float: right">
                <i class="fa fa-close"></i>
            </a>
            </th>
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

    $(".btnEliminarTabla").click(function () {
        var idTabla = $(this).data('id');
        console.log("--> " + idTabla);
        bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x text-danger text-shadow'></i> Está seguro de eliminar esta tabla de análisis?", function (result){
          if(result){
              $.ajax({
                  type: 'POST',
                  url: "${createLink(controller: 'situacionAmbiental', action: 'eliminarTabla_ajax')}",
                  data:{
                      id: idTabla
                  },
                  success: function (msg){
                      var parts = msg.split("_");
                      if(parts[0] == 'ok'){
                          log("Tabla eliminada correctamente","success");
                          cargarTablas();
                      }else{
                          log(parts[1],"error")
                      }
                  }
              })
          }
        });
    });




</script>





