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
            <table class="table table-condensed table-bordered table-striped" id="tablaM">
                <tbody>
                <g:each in="${aupm}" var="a">
                    <tr>
                        <td style="width: 20%"><strong>${a?.aspectoAmbiental?.planManejoAmbiental?.nombre}</strong></td>
                        <td style="width: 20%">${a?.aspectoAmbiental?.descripcion}</td>
                        <td style="width: 15%">${a?.aspectoAmbiental?.impacto}</td>
                        <td style="width: 29%">
                            <g:if test="${a?.medida}">
                            ${a?.medida?.descripcion}
                                <div class="btn-group">
                                    <a href="#" class="btn btn-info btn-xs btnVerMedida" data-id="${a?.id}" title="Ver datos de la Medida">
                                        <i class="fa fa-search"></i>
                                    </a>
                                    <a href="#" class="btn btn-danger btn-xs btnBorrarMedida" data-id="${a?.id}" title="Retirar Medida">
                                        <i class="fa fa-trash"></i>
                                    </a>
                                </div>
                            </g:if>
                            <g:else>
                                <div class="centrar">
                                    <a href="#" class="btn btn-primary btn-sm btnAgregarMedida" data-id="${a?.id}" title="">
                                        <i class="fa fa-plus"></i> Agregar medida
                                    </a>
                                </div>
                            </g:else>
                        </td>
                        <td style="width: 5%">
                        <div class="centrar">
                            <a href="#" class="btn btn-danger btn-sm btnBorrarAupm" data-id="${a?.id}" title="Borrar Aspecto Ambiental">
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

   //función para marcar una fila
   $("#tablaM tr").click(function () {
       $("#tablaM tr").removeClass("trHighlight");
       $(this).addClass("trHighlight");
   });

    //función para ver los datos de la medida
   $(".btnVerMedida").click(function () {
       var idA = $(this).data("id");
       $.ajax({
           type:'POST',
           url:"${createLink(controller: 'planManejoAmbiental', action: 'verMedida_ajax')}",
           data: {
               aupm: idA
           },
           success: function (msg) {
               bootbox.dialog({
                   id: "dlgVerMedida",
                   title: "Ver datos de la Medida",
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

   //función para borrar la medida del aspecto ambiental
   $(".btnBorrarMedida").click(function () {
       var idAspecto = $(this).data("id");
       bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x text-danger text-shadow'></i> Está seguro de remover esta medida?", function (result) {
           if(result){
               $.ajax({
                   type: 'POST',
                   url: '${createLink(controller: 'planManejoAmbiental', action: 'comprobarBorrarMedida_Ajax')}',
                   data:{
                        idAs: idAspecto
                   },
                   success: function (msg){
                       if(msg == 'ok'){
                           $.ajax({
                               type: 'POST',
                               url: '${createLink(controller: 'planManejoAmbiental', action: 'quitarMedida_Ajax')}',
                               data:{
                                   id: idAspecto
                               },
                               success: function (msg) {
                                   if(msg == 'ok'){
                                       log("Medida retirada correctamente","success");
                                       cargarTablaPlanes(${pre?.id}, ${band});
                                   }else{
                                       log("Error al retirar la medida","error")
                                   }
                               }
                           });
                       }else{
                            log("No es posible borrar la Medida, este Aspecto Ambiental ya está siendo evaluado!","error")
                       }
                   }

               });


           }
       })

   }) ;


    //función para borrar un aspecto ambiental que no se encuentre ya en evaluación
    $(".btnBorrarAupm").click(function () {
        var idAspe = $(this).data("id");
        bootbox.confirm("Está seguro de borrar este aspecto ambiental?", function (result) {
            if(result){
                $.ajax({
                   type: 'POST',
                    url: '${createLink(controller: 'planManejoAmbiental', action: 'borrarAspecto_ajax')}',
                    data:{
                        id: idAspe
                    },
                    success: function (msg){
                        if(msg == 'ok'){
                            log("Aspecto borrado correctamente","success");
                            cargarTablaPlanes(${pre?.id}, ${band});
                        }else{
                            log("Error al borrar el aspecto","error")
                        }
                    }
                });
            }
        });


    });


</script>