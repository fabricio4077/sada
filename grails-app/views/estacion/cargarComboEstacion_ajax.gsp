<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 16/04/2016
  Time: 10:23
--%>


<g:select id="estacionServ" name="estacion_name" from="${estacion.Estacion.list([sort: 'nombre'])}" optionKey="id"
          optionValue="nombre" class="many-to-one form-control" noSelection="[0: 'Seleccione...']" value="${estacion?.id}"/>

<script type="text/javascript">

    //cargado con ajax de la estación seleccionada
    $("#estacionServ").change(function () {

        var idPre = '${preauditoria?.id}';
        var idEs = $(this).val();
        $("#tabla").removeClass("hide")
        if(idEs == '0'){
            $("#tabla").addClass("hide");
            $("#btnContinuar").addClass('disabled');
        }else{
            $("#tabla").removeClass("modificado").addClass("original");
            cargarEStacion(idPre, idEs)
            $("#btnContinuar").removeClass('disabled');
         }

    });

</script>