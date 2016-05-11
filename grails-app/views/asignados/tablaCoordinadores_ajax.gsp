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
    <div class="col-md-7 centrado">Coordinadores</div>
    <div class="col-md-1">
        <a href="#" id="btnAddCoor" class="btn btn-primary" title="Agregar Coordinador">
            <i class="fa fa-plus"></i>
        </a>
    </div>
</div>
<div class="row" style="height: 200px !important; overflow-y: auto">
    <g:if test="${listaCoordinadores.size() > 0}">
        <table class="table table-bordered table-hover table-condensed">
            <thead>
            </thead>
            <tbody id="nombresCoordinadores">
            </tbody>
        </table>
    </g:if>
    <g:else>
        <div class="col-md-12 azul alineacion" style="margin-top: 20px; margin-bottom: 20px">
            <i class="fa fa-times text-danger"></i> No existe ningún coordinador registrado en el sistema
        </div>
    </g:else>
</div>


<script type="text/javascript">

    cargarNombresCoordinadores();

    //funcion para cargar una lsita de los biólogos registrados en el sistema
    function cargarNombresCoordinadores () {
        $.ajax({
            type: 'POST',
            url:'${createLink(controller: 'asignados', action: 'listaCoordinadores_ajax')}',
            data:{
                id: ${pre?.id}
            },
            success: function (msg){
                $("#nombresCoordinadores").html(msg).effect("drop", "slow").fadeIn();
            }
        });
    }

    //llamado por ajax a el form para crear una persona con cargo biologo

    $("#btnAddCoor").click(function () {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'persona', action:'formBiologo_ajax')}",
            data     :{
                    tipo: 'coordinador'
            },
            success : function (msg) {
                var b =  bootbox.dialog({
                    id      : "dlgAddCoor",
                    title   : "Registrar Coordinador",
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
                                                log("Coordinador registrado correctamente","success");
                                                cargarTablaCoordinador();
                                            }else{
                                                log("Error al registrar el coordinador","error");
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