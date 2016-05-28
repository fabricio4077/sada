<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 26/05/16
  Time: 02:45 PM
--%>


<table class="table table-bordered table-condensed table-hover">
  <tbody>
  <g:each in="${existentes}" var="an">
    <tr style="text-align: center">
      <td style="width: 60%">
        ${an?.path}
      </td>
      <td style="text-align: center; width: 20%">
        <a href="#" class="btn btn-success btn-sm btnDescargar" title="Descargar anexo" data-id="${an?.id}">
          <i class="fa fa-download"></i>
        </a>
      </td>
      <td style="text-align: center; width: 20%">
        <a href="#" class="btn btn-danger btn-sm btnBorrar" title="Borrar anexo" data-id="${an?.id}">
          <i class="fa fa-trash"></i>
        </a>
      </td>
    </tr>
  </g:each>
  </tbody>
</table>



<script type="text/javascript">


    //descargar el anexo

    $(".btnDescargar").click(function () {
        var idAn = $(this).data('id');
        location.href = "${g.createLink(controller: 'evaluacion', action: 'descargarDoc')}/" + idAn
    });


    %{--$(".bajar").click(function () {--}%
        %{--var id = $(this).attr("iden")--}%
        %{--openLoader()--}%
        %{--$.ajax({--}%
            %{--type    : "POST",--}%
            %{--url     : "${g.createLink(controller: 'documentoTramite',action: 'generateKey')}",--}%
            %{--data    : "id=" + id,--}%
            %{--success : function (msg) {--}%
                %{--closeLoader()--}%
                %{--if (msg == "ok") {--}%
                    %{--location.href = "${g.createLink(action: 'descargarDoc')}/" + id--}%
                %{--} else {--}%
                    %{--bootbox.confirm("El archivo solicitado no se encuentra en el servidor. Desea borrar el anexo?", function (result) {--}%
                        %{--if (result) {--}%
%{--//                    openLoader("Borrando")--}%
                            %{--$.ajax({--}%
                                %{--type    : "POST",--}%
                                %{--url     : "${g.createLink(controller: 'documentoTramite',action: 'borrarDocNoFile')}",--}%
                                %{--data    : "id=" + id,--}%
                                %{--success : function (msg) {--}%
                                    %{--if (msg == "ok") {--}%
                                        %{--cargaDocs();--}%
                                    %{--} else {--}%
                                        %{--bootbox.alert("No se pudo eliminar el archivo anexo")--}%
                                    %{--}--}%
                                %{--}--}%
                            %{--});--}%
                        %{--}--}%

                    %{--});--}%
                %{--}--}%
            %{--}--}%
        %{--});--}%
    %{--})--}%



    //borrar el anexo
  $(".btnBorrar").click(function () {
    var idE = $(this).data("id");
    bootbox.confirm("Está seguro que desea borrar este anexo?", function (result) {
      if (result) {
        $.ajax({
          type    : "POST",
          url     : "${g.createLink(controller: 'evaluacion',action: 'borrarAnexo_ajax')}",
          data    : {
            id: idE
          },
          success : function (msg) {
            if (msg == "ok") {
              log("Anexo borrado correctamente","success");
                cargarAnexosExistentes();
            } else {
              log("Error al borrar el anexo","error")
            }
          }
        });
      }

    })
  });
</script>