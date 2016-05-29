<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 29/05/2016
  Time: 12:37
--%>

<style>
    .centrar {
        text-align: center;
    }
</style>

<div class="row-fluid"  style="width: 99.7%;height: 500px;overflow-y: auto;float: right;">
    <div class="span12">
        <div style="width: 1120px; height: 500px;">
            <table class="table table-condensed table-bordered table-striped">
                <tbody>
                <g:each in="${aupm}" var="a">
                    <tr>
                        <td style="width: 20%">${a?.aspectoAmbiental?.planManejoAmbiental?.nombre}</td>
                        <td style="width: 20%">${a?.aspectoAmbiental?.descripcion}</td>
                        <td style="width: 15%">${a?.aspectoAmbiental?.impacto}</td>
                        <td style="width: 29%">
                            <g:if test="${a?.medida}">

                            </g:if>
                            <g:else>
                                <div class="centrar">
                                    <a href="#" class="btn btn-primary btn-sm btnAgregarMedida" data-id="${a?.id}" title="">
                                        <i class="fa fa-plus"></i> Agregar medida
                                    </a>
                                </div>
                            </g:else>
                        </td>
                        %{--<td></td>--}%
                        %{--<td></td>--}%
                        %{--<td></td>--}%
                        <td style="width: 5%">
                        <div class="centrar">
                            %{--<a href="#" id="btnGuardarAupm" class="btn btn-success btn-sm" title="Guardar Aspecto Ambiental">--}%
                                %{--<i class="fa fa-save"></i>--}%
                            %{--</a>--}%
                            <a href="#" id="btnBorrarAupm" class="btn btn-danger btn-sm" title="Borrar Aspecto Ambiental">
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
   $(".btnAgregarMedida").click(function () {
       var idAup = $(this).data("id");
       $.ajax({
           type:'POST',
           url:"${createLink(controller: 'planManejoAmbiental', action: 'cargarMedida_ajax')}",
           data: {
               id: idAup
           },
           success: function (msg) {
               bootbox.dialog({
                   id: "dlgMedida",
                   title: "Medida",
                   class: "long",
                   message: msg,
                   buttons: {
                       cancelar :{
                           label     : 'Aceptar',
                           className : 'btn-primary',
                           callback  : function () {

                           }
                       }
                   }
               })
           }
       });
   });
</script>