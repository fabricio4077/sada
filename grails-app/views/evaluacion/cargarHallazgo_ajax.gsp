<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 23/05/2016
  Time: 21:39
--%>


<div class="row">
    <div class="col-md-2">
        <strong> Hallazgo</strong>
    </div>
    <div class="col-md-7" id="divHallazgo">

    </div>

    <div class="col-md-1" style="margin-left: 10px">
        <div class="btn-group">
            <a href="#" id="btnSeleccionarHallazgo" class="btn btn-info" title="Seleccionar Hallazgo">
                <i class="fa fa-check"></i>
            </a>

        </div>
    </div>
</div>

<div class="row" style="margin-left: 50px">

    <div id="divSeleccionado">


    </div>

</div>

<div class="row">
    <div class="col-md-3" style="float: right">
        <a href="#" id="btnAgregarHallazgo" class="btn btn-info" title="Agregar Hallazgo">
            <i class="fa fa-plus"> Nuevo</i>
        </a>
    </div>
</div>




<div class="row" style="margin-left: 50px">

    <div id="tablaCrearHallazgo" >


    </div>

</div>

<script type="text/javascript">

      cargarComboHallazgo(${evaluacion?.id});

     //función para cargar el combo de hallazgo

    function cargarComboHallazgo (idEvaluacion) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'evaluacion', action: 'comboHallazgo_ajax')}',
            data: {
                id: idEvaluacion
            },
            success: function (msg) {
                $("#divHallazgo").html(msg)
            }
        });
    }

    //funcion para cargar los campos de creación de hallazgos

  $("#btnAgregarHallazgo").click(function () {
      $.ajax({
          type: 'POST',
          url: '${createLink(controller: 'evaluacion', action: 'crearHallazgo_ajax')}',
          data: {
              id: ${evaluacion?.id}
          },
          success: function (msg) {
              $("#tablaCrearHallazgo").html(msg)
          }
      });
  });

    //función para seleccionar el hallazgo

    $("#btnSeleccionarHallazgo").click(function () {
        if($("#hallazgoCombo").val() == 'null'){
            bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x text-info text-shadow'></i> Debe seleccionar un hallazgo!");
            cargarComboHallazgo(${evaluacion?.id});
        }else{
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'evaluacion', action: 'guardarSeleccionado_ajax')}',
                data: {
                    id: ${evaluacion?.id},
                    combo: $("#hallazgoCombo").val()
                },
                success: function (msg) {
                    if(msg == 'ok'){
                        cargarExistente(${evaluacion?.id})
                        cargarTablaEva();
                    }else{
                        log("Error al seleccionar el hallazgo","error")
                    }

                }
            });
        }
    });

    //función cargar hallazgo SELECCIONADO


    <g:if test="${evaluacion?.hallazgo}">
      cargarExistente(${evaluacion?.id});
    </g:if>

    function cargarExistente(idEva) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'evaluacion', action: 'tablaHallazgo_ajax')}',
            data: {
                id: idEva
            },
            success: function (msg) {
                $("#divSeleccionado").html(msg)
            }
        });
    }



</script>