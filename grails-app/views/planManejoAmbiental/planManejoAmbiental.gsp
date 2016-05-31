<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 28/05/2016
  Time: 19:56
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>PMA - Plan de Manejo Ambiental (${band == 'true' ? 'Anterior' : 'Actual'})</title>

    <style>
    .table th{
        text-align: center;
    }
    </style>
</head>

<body>

<g:if test="${band == 'true'}">
    <div class="panel panel-warning">
        <div class="panel-heading">
            <h3 class="panel-title" style="text-align: center"><i class="fa fa-gear"></i> Acciones</h3>
        </div>
        <div class="panel-body" style="height: 100px">
            <div class="col-md-8">
                <p>
                    <i class='fa fa-exclamation-triangle fa-3x text-info text-shadow'></i>
                    <strong>Una vez ha seleccionado todos los aspectos ambientales de los que consta su PMA, click en en el botón "Aceptar"</strong>
                </p>
                <p>
                    <i class='fa fa-exclamation-triangle fa-3x text-danger text-shadow'></i>
                    <strong>Todos los aspectos ambientales deben teber asignada una "Medida Propuesta"</strong>
                </p>
            </div>

            <div class="btn-group" style="float: right">

                <a href="#" id="btnAceptarPlan" class="btn btn-success" title="Aceptar PMA">
                    <i class="fa fa-check"></i> Aceptar
                </a>

                <a href="#" id="btnRegresarEvaluacion" class="btn btn-primary" title="Regresar a Evaluación Ambiental">
                    <i class="fa fa-angle-double-left"></i> Regresar
                </a>

            </div>
        </div>
    </div>
</g:if>




<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-gear"></i>Selección: Aspectos Ambientales</h3>
    </div>

    <div class="row">
        <div class="col-md-2 negrilla control-label">Plan: </div>
        <div class="col-md-7">
            <g:select name="pma_name" id="pma" optionKey="id" optionValue="nombre"
                      class="form-control" from="${plan.PlanManejoAmbiental.list([sort: 'nombre', order: 'asc'])}"/>
        </div>
    </div>


    <div class="row">
        <div class="col-md-4 negrilla control-label">Aspectos Ambientales: </div>
        <div class="col-md-6" id="divAspectos">

        </div>


        <div class="btn-group">

            <a href="#" id="btnSeleccionarAspecto" class="btn btn-info" title="Seleccionar Aspecto Ambiental">
                <i class="fa fa-check"></i>
            </a>

            <a href="#" id="btnCrearAspecto" class="btn btn-success" title="Crear Aspecto Ambiental">
                <i class="fa fa-plus"></i>
            </a>

        </div>
    </div>
</div>

<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-leaf"></i> PMA (${band == 'true' ? 'Anterior' : 'Actual'})</h3>
    </div>

    <table class="table table-condensed table-bordered table-striped">
        <thead>
        <tr>
            <th style="width: 21%" >Plan</th>
            <th style="width: 22%" >Aspecto Ambiental</th>
            <th style="width: 16%" >Impacto Identificado</th>
            <th style="width: 30%">Medida Propuesta</th>
            <th style="width: 5%">Acciones</th>
            <th style="width: 1%"></th>
        </tr>
        </thead>
    </table>

    <div id="tablaP">

    </div>

</div>

<script type="text/javascript">

    $("#btnCrearAspecto").click(function () {
        var idPlan = $("#pma").val();
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'aspectoAmbiental', action:'crearAspecto_ajax')}",
            data    : {
                id: idPlan
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgAspectoAmbiental",
                    title   : "Aspecto Ambiental",
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
                                return submitForm();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    });


    function submitForm() {
        var $form = $("#frmAspectoAmbiental");
        if ($form.valid()) {
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'aspectoAmbiental', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0] == "OK") {
                        log("Aspecto ambiental creado correctamente","success");
                        cargarAspectos($("#pma").val());
                    } else {
                        log("Error al crear el aspecto ambiental","error");
//                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }

    $("#btnRegresarEvaluacion").click(function (){
       location.href="${createLink(controller: 'evaluacion', action: 'evaluacionPlan')}/" + ${pre?.id};
    });

    $("#btnAceptarPlan").click(function () {
        $.ajax({
           type: 'POST',
            url: "${createLink(controller: 'planManejoAmbiental', action: 'comprobarPlan_ajax')}",
            data: {
                id: ${pre?.id},
                band: ${band}
            },
            success: function (msg) {
                if(msg == 'ok'){
                    $.ajax({
                        type: 'POST',
                        url: "${createLink(controller: 'planManejoAmbiental', action: 'guardarPlan_Ajax')}",
                        data: {
                            id: ${pre?.id},
                            band: ${band}
                        },
                        success: function (msg) {
                            location.href="${createLink(controller: 'evaluacion', action: 'evaluacionPlan')}/" + ${pre?.id};
                        }
                    })
                }else{
                    bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x text-danger text-shadow'></i> En su PMA consta un aspecto ambiental el cual NO TIENE asignado una Medida!")
                }
            }
        });
    });

    cargarTablaPlanes(${pre?.id}, ${band});

    function cargarTablaPlanes (idP, b) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'planManejoAmbiental', action: 'tablaPlan_ajax')}",
            data:{
                id: idP,
                band: b
            },
            success: function(msg){
                $("#tablaP").html(msg)
            }
        });
    }


    cargarAspectos($("#pma").val());

    function cargarAspectos (idPlan) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'planManejoAmbiental', action: 'cargarAspectos_ajax')}",
            data:{
                id: idPlan
            },
            success: function(msg){
                $("#divAspectos").html(msg)
            }
        });
    }

    $("#pma").change(function () {
        cargarAspectos($(this).val());
    });

    $("#btnSeleccionarAspecto").click(function () {
        var idAspecto = $("#aspecto").val();
        if(idAspecto != 'null'){
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'planManejoAmbiental', action: 'asignarAspecto_ajax')}',
                data:{
                    id: ${pre?.id},
                    band: ${band},
                    aspecto: idAspecto
                },
                success: function (msg) {
                    if(msg == 'ok'){
                        log("Aspecto ambiental agregado correctamente","success");
                        cargarTablaPlanes(${pre?.id}, ${band});
                    }else{
                        log("Error al agregar el Aspecto ambiental","success")
                    }
                }
            })
        }
    });

</script>
</body>
</html>