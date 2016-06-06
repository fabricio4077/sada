<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 05/06/2016
  Time: 12:45
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Puntos a evaluar de la Licencia Ambiental</title>

    <style>
    .table th {
        text-align: center;
    }
    </style>
</head>

<body>

<div class="panel panel-warning">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"><i class="fa fa-gear"></i> Acciones</h3>
    </div>
    <div class="panel-body" style="height: 100px">
        <div class="col-md-9">
            <p>
                <i class='fa fa-exclamation-triangle fa-3x text-info text-shadow'></i>
                <strong>Una vez terminado de ingresar los puntos de la Licencia ambiental a ser evaluados, click en en el botón "Aceptar"</strong>
            </p>
        </div>

        <div class="btn-group" style="float: right">

            <a href="#" id="btnAceptarLicencia" class="btn btn-success" title="Aceptar puntos">
                <i class="fa fa-check"></i> Aceptar
            </a>
            <a href="#" id="btnRegresarLicencia" class="btn btn-primary" title="Regresar a Evaluación Ambiental">
                <i class="fa fa-angle-double-left"></i> Regresar
            </a>
        </div>
    </div>
</div>
<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-gear"></i> Selección: Puntos de la licencia auditables</h3>
    </div>

    <div class="row">
        <div class="col-md-2 negrilla control-label">Plan: </div>
        <div class="col-md-7" id="divLicencia" style="margin-bottom: 10px">

        </div>
        <div class="btn-group">
            <a href="#" id="btnSeleccionarPunto" class="btn btn-info" title="Seleccionar puntos auditables">
                <i class="fa fa-check"></i>
            </a>
            <a href="#" id="btnCrearPunto" class="btn btn-success" title="Crear un punto auditable">
                <i class="fa fa-plus"></i>
            </a>
        </div>
    </div>
</div>


<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-leaf"></i> Puntos de la licencia a ser evaluados</h3>
    </div>

    <table class="table table-condensed table-bordered table-striped">
        <thead>
        <tr>
            <th style="width: 5%" >#</th>
            <th style="width: 60%" >Punto a evaluar</th>
            <th style="width: 10%">Acciones</th>
            <th style="width: 1%"></th>
        </tr>
        </thead>
    </table>

    <div id="tablaPuntos">

    </div>

</div>



<script type="text/javascript">

    cargarComboLicencia();

    function cargarComboLicencia () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'licencia', action: 'cargarComboLicencia_ajax')}",
            data:{
                id: ${pre?.id}
            },
            success: function (msg) {
                $("#divLicencia").html(msg)
            }
        });
    }

    $("#btnRegresarLicencia").click(function (){
        location.href="${createLink(controller: 'evaluacion', action: 'evaluacionLicencia')}/" + ${pre?.id};
    });

    $("#btnCrearPunto").click(function () {
        var idPre = ${pre?.id}
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(controller: 'licencia', action:'dialogLic_ajax')}",
                    data    : {
                        id: idPre
                    },
                    success : function (msg) {
                        var b = bootbox.dialog({
                            id      : "dlgLicencia",
                            title   : "Punto auditable",
                            class   : 'medium',
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
                                        var $form = $("#frmLicencia");
                                        if($form.valid()){
                                            $.ajax({
                                                type: 'POST',
                                                url: "${createLink(controller: 'licencia', action: 'guardarPunto_ajax')}",
                                                data: $form.serialize(),
                                                success: function (msg) {
                                                    if(msg == 'ok'){
                                                        log("Punto de la licencia guardado correctamente","success");
                                                        cargarTablaPuntos();
                                                        cargarComboLicencia();
                                                    }else{
                                                        log("Error al guardar el punto de la licencia","error")
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
                    } //success
                }); //ajax
    });

    cargarTablaPuntos();

    function cargarTablaPuntos (){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'licencia', action: 'tablaPuntos_ajax')}',
            data:{
                id: ${pre?.id}
            },
            success: function (msg){
                $("#tablaPuntos").html(msg)
            }
        });
    }

    $("#btnAceptarLicencia").click(function () {
        $.ajax({
           type: 'POST',
            url: "${createLink(controller: 'licencia', action: 'asignarPuntos_ajax')}",
            data:{
                id: ${pre?.id}
            },
            success: function (msg){
                if(msg=='ok'){
                    location.href="${createLink(controller: 'evaluacion', action: 'evaluacionLicencia')}/" + ${pre?.id}

                }else{
                   log("Error al asignar los puntos de la licencia para ser evaluados","error")
                }
            }
        });
    });

</script>
</body>
</html>