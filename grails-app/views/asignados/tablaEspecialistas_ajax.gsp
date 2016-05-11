<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 23/04/2016
  Time: 22:16
--%>

<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 23/04/2016
  Time: 19:26
--%>

<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 21/04/2016
  Time: 21:43
--%>

<style type="text/css">
.centrado{
    text-align: center;
}
</style>


<div class="row centrado">
    <div class="col-md-7 centrado">Especialistas</div>
    <div class="col-md-1">
        <a href="#" id="btnAddEspe" class="btn btn-primary" title="Agregar Especialista">
            <i class="fa fa-plus"></i>
        </a>
    </div>
</div>
<div class="row" style="height: 200px !important; overflow-y: auto">
    <g:if test="${listaEspe.size() > 0}">
        <table class="table table-bordered table-hover table-condensed">
            <thead>
            </thead>
            <tbody id="nombresEspecialistas">
            </tbody>
        </table>
    </g:if>
    <g:else>
        <div class="col-md-12 azul alineacion" style="margin-top: 20px; margin-bottom: 20px">
            <i class="fa fa-times text-danger"></i> No existe ningún especialista registrado en el sistema
        </div>
    </g:else>
</div>


<script type="text/javascript">

    cargarNombresEspecialistas();

    //funcion para cargar una lista de los especialistas registrados en el sistema
    function cargarNombresEspecialistas () {
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'asignados', action: 'listaEspecialistas_ajax')}',
            data:{
                id: ${pre?.id}
            },
            success: function (msg){
                $("#nombresEspecialistas").html(msg).effect("drop", "slow").fadeIn();
            }
        });
    }

    //llamado por ajax a el form para crear una persona con cargo especialista

    $("#btnAddEspe").click(function () {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'persona', action:'formBiologo_ajax')}",
            data     :{
                tipo: 'especialista'
            },
            success : function (msg) {
                var b =  bootbox.dialog({
                    id      : "dlgAddEspe",
                    title   : "Registrar Especialista",
                    class   : "long",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {

                                var nmbr = $("#nombre").val();
                                var apell = $("#apellido").val();
                                var tlfn = $("#telefono").val();
                                var mail = $("#mail").val();
                                var cargo = $("#cargo").val();
                                var titu = $("#titulo").val();

                                var $form = $("#frmBiologo");
                                if ($form.valid()) {
                                    $.ajax({
                                        type: 'POST',
                                        url: "${createLink(controller: 'persona',action: 'guardarPersonal_ajax')}",
                                        data: {
                                            nombre: nmbr,
                                            apellido: apell,
                                            telefono: tlfn,
                                            mail: mail,
                                            cargo: cargo,
                                            titulo: titu
                                        },
                                        success: function (msg){
                                            if(msg == 'ok'){
                                                log("Especialista registrado correctamente","success");
                                                cargarTablaEspecialista();
                                            }else{
                                                log("Error al registrar el especialista","error");
                                            }
                                        }
                                    });
                                }else{
                                    return false
                                }
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    });
</script>