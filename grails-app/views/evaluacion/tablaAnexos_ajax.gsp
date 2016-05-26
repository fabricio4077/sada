<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 26/05/16
  Time: 02:45 PM
--%>


<table class="table table-bordered table-condensed table-hover" style="width: 140px">
  <tbody>
  <g:each in="${existentes}" var="an">
    <tr>
      <td>
        ${an?.path}
      </td>
      <td style="text-align: center">
        <a href="#" class="btn btn-success btn-sm btnDescargar" title="Descargar anexo" data-id="${an?.id}">
          <i class="fa fa-download"></i>
        </a>
      </td>
      <td style="text-align: center">
        <a href="#" class="btn btn-danger btn-sm btnBorrar" title="Borrar anexo" data-id="${an?.id}">
          <i class="fa fa-trash"></i>
        </a>
      </td>
    </tr>
  </g:each>
  </tbody>
</table>


<script type="text/javascript">

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
              cargaTablaAnexos();
            } else {
              log("Error al borrar el anexo","error")
            }
          }
        });
      }

    })
  });
</script>