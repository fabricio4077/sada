<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 12/06/2016
  Time: 13:36
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Situación Ambiental</title>
    <script src="${resource(dir: 'js/plugins/ckeditor-full', file: 'ckeditor.js')}"></script>
</head>

<body>

<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-eye"></i> Situación Ambiental</h3>
    </div>

    <div class="panel-group" style="height: 1100px">
        <div class="col-md-12" style="margin-top: 10px">
            <ul class="nav nav-pills nav-justified">
                <li class="active col-md-4"><a data-toggle="tab" href="#home"><h4>Físico</h4></a></li>
                <li class="col-md-4"><a data-toggle="tab" href="#menu1"><h4>Biótico</h4></a></li>
                <li class="col-md-4"><a data-toggle="tab" href="#menu2"><h4>Social</h4></a></li>
            </ul>
            <div class="tab-content">
                <div id="home" class="tab-pane fade in active">
                    <div class="col-md-12" style="margin-top: 10px">
                        <ul class="nav nav-pills nav-justified">
                            <li class="col-md-4"><a data-toggle="tab" href="#gaseosas" id="eg"><h5><i class=" glyphicon glyphicon-tree-deciduous"></i> Emisiones Gaseosas</h5></a></li>
                            <li class="active col-md-4"><a data-toggle="tab" href="#liquidas"><h5><i class=" glyphicon glyphicon-tint"></i> Descargas Líquidas</h5></a></li>
                            <li class="col-md-4"><a data-toggle="tab" href="#residuos"><h5><i class=" glyphicon glyphicon-filter"></i> Resíduos Sólidos y Líquidos</h5></a></li>
                        </ul>

                        <div class="tab-content">
                            %{--Emisiones gaseosas--}%
                            %{--------------------------------------------------------}%
                            <div id="gaseosas" class="tab-pane fade">
                                <div class="well" style="text-align: center; height: 100px; margin-top: 10px">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-2 negrilla control-label">Emisor </div>

                                            <div class="col-md-4" id="divEmisor">

                                            </div>

                                            <div class="col-md-5">
                                                <a href="#" id="btnAgregarEmisor" class="btn btn-success" title="">
                                                    <i class="fa fa-plus"></i> Agregar emisor
                                                </a>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="well" style="text-align: center; height: 250px; margin-top: 10px">

                                    <div class="row">
                                        <b> La estación '${pre?.estacion?.nombre}' tiene los siguientes emisores de gases: </b>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-3"></div>
                                        <div class="col-md-8" id="tablaEmisores">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-5"></div>
                                    <div class="col-md-4">
                                        <g:if test="${fisicoEmisor?.descripcion}">
                                            <a href="#" id="btnInformeEmisor" class="btn btn-info" title="Ver informe en el editor">
                                                <i class="fa fa-file-word-o"></i> Ver informe de emisores
                                            </a>
                                        </g:if>
                                        <g:else>
                                            <a href="#" id="btnInformeEmisor" class="btn btn-success" title="Generar informe en el editor">
                                                <i class="fa fa-file-word-o"></i> Generar informe de emisores
                                            </a>
                                        </g:else>
                                    </div>
                                </div>

                                <div class="alert alert-success" role="alert" style="text-align: center; margin-top: 20px">
                                    <h4> <i class=" glyphicon glyphicon-tree-deciduous"></i> Informe de Emisiones Gaseosas</h4>
                                </div>


                                <div id="divEditor">

                                </div>
                            </div>
                            %{--Descargas Liquidas--}%
                            %{--------------------------------------------------------------}%
                            <div id="liquidas" class="tab-pane fade in active">
                                <div class="well" style="text-align: center; height: 120px; margin-top: 10px">
                                    <div class="row">
                                        <b> Los resultados de los monitoreos  se muestran en las tablas de análisis de descargas líquidas</b>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-4">
                                        </div>
                                        <div class="col-md-4">
                                            <a href="#" id="btnAgregarTabla" class="btn btn-info" title="Agregar tabla">
                                                <i class="fa fa-plus"></i> Agregar tabla de análisis
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <div class="row-fluid"  style="width: 100%;height: 500px;overflow-y: auto;margin-top: -20px">
                                    <div class="span12">
                                        <div style="width: 1030px; height: 500px;">
                                            <div class="row" id="divTablaLiquidas" style="margin-top: 20px">

                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="alert alert-success" role="alert" style="text-align: center; margin-top: 20px">
                                    <h4> <i class="glyphicon glyphicon-tint"></i> Informe de Descargas Líquidas</h4>
                                </div>
                                <div class="row">
                                    <textarea name="editorL" id="editorL" rows="30" cols="80">
                                        ${fisicoDescargas?.descripcion}
                                    </textarea>
                                    <script>
                                        CKEDITOR.replace( 'editorL', {
                                            height: "450px"
                                        });
                                    </script>

                                    <div class="row">
                                        <nav>
                                            <ul class="pager">
                                                <a href="#" id="btnGuardarLiquidas" class="btn btn-success" title="Guardar texto">
                                                    <i class="fa fa-save"></i> Guardar
                                                </a>

                                            </ul>
                                        </nav>
                                    </div>
                                </div>

                            </div>
                            %{--Residuos Solidos y liquidos--}%
                            %{----------------------------------------------------------}%
                            <div id="residuos" class="tab-pane fade">

                                <div class="row">
                                    <div class="well col-md-6" style="height: 330px; margin-top: 10px">
                                        <div class="col-md-12 alert alert-success" style="height: 50px; text-align: center">
                                            <h4>
                                                Desechos Comunes
                                            </h4>
                                        </div>
                                        <div class="col-md-12">
                                            La estación de servicio "${pre?.estacion?.nombre}", genera los siguientes desechos comunes:
                                        </div>

                                        <div class="col-md-8" style="margin-top: 30px; float: right">
                                            <ul>
                                                <li><h4>Órganico</h4></li>
                                                <li><h4>Inorgánico</h4></li>
                                            </ul>
                                        </div>
                                    </div>

                                    <div class="well col-md-6" style="text-align: center; height: 330px; margin-top: 10px">
                                        <div class="col-md-12 alert alert-warning" style="height: 50px">
                                            <h4>
                                                Desechos Peligrosos
                                            </h4>
                                        </div>

                                        <div class="col-md-12" style="margin-bottom: 10px">
                                            La estación de servicio "${pre?.estacion?.nombre}", genera los siguientes desechos peligrosos:
                                        </div>

                                        <div class="col-md-10" id="divDesechos">

                                        </div>
                                        <div class="col-md-2">
                                            <a href="#" id="btnAgregarDesechos" class="btn btn-success" title="Agregar desechos">
                                                <i class="fa fa-plus"></i>
                                            </a>
                                        </div>

                                        <div class="col-md-12" id="divTablaDesechos" style="margin-top: 10px">

                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-5"></div>
                                    <div class="col-md-4">
                                        <g:if test="${fisicoDesechos?.descripcion}">
                                            <a href="#" id="btnInformeDesechos" class="btn btn-info" title="Generar informe en el editor">
                                                <i class="fa fa-file-word-o"></i> Ver informe de desechos
                                            </a>
                                        </g:if>
                                        <g:else>
                                            <a href="#" id="btnInformeDesechos" class="btn btn-success" title="Generar informe en el editor">
                                                <i class="fa fa-file-word-o"></i> Generar informe de desechos
                                            </a>
                                        </g:else>
                                    </div>
                                </div>
                                <div class="alert alert-success" role="alert" style="text-align: center; margin-top: 20px">
                                    <h4> <i class="glyphicon glyphicon-filter"></i> Informe de Residuos Sólidos y Líquidos</h4>
                                </div>

                                <div class="row" id="divEditorDescargas">

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                %{--Bioticos--}%
                %{------------------------------------------------------}%
                <div id="menu1" class="tab-pane fade" style="margin-top: 10px">

                    <div class="alert alert-success" role="alert" style="text-align: center; margin-top: 20px">
                        <h4> Informe de Componentes ambientales Bióticos</h4>
                    </div>

                    <textarea name="editor1" id="editor1" rows="30" cols="80">
                        ${biotico?.descripcion}
                    </textarea>
                    <script>
                        CKEDITOR.replace( 'editor1', {
                            height: "450px"
                        });
                    </script>

                    <div class="row">
                        <nav>
                            <ul class="pager">
                                <a href="#" id="btnGuardarBiotico" class="btn btn-success" title="Guardar texto">
                                    <i class="fa fa-save"></i> Guardar
                                </a>

                            </ul>
                        </nav>
                    </div>
                </div>
                %{--Social--}%
                %{------------------------------------------------------}%
                <div id="menu2" class="tab-pane fade">

                    <g:if test="${pre?.tipo?.codigo != 'LCM1'}">
                        <h4></h4>
                        <div class="alert alert-danger" role="alert" style="text-align: center">
                            ESTE COMPONENTE NO ESTÁ DISPONIBLE PARA ESTE TIPO DE AUDITORÍA
                        </div>
                    </g:if>
                    <g:else>

                        <div class="alert alert-success" role="alert" style="text-align: center; margin-top: 20px">
                            <h4> <i class="glyphicon glyphicon-user"></i> Informe de componente ambiental Social</h4>
                        </div>

                        <textarea name="editor2" id="editor2" rows="30" cols="80">
                            ${biotico?.descripcion}
                        </textarea>
                        <script>
                            CKEDITOR.replace( 'editor2', {
                                height: "500px"
                            });
                        </script>

                        <div class="row">
                            <nav>
                                <ul class="pager">
                                    <a href="#" id="btnGuardarSocial" class="btn btn-success" title="Guardar texto">
                                        <i class="fa fa-save"></i> Guardar
                                    </a>

                                </ul>
                            </nav>
                        </div>
                    </g:else>
                </div>
            </div>
        </div>
    </div>
</div>


<header class='masthead' style="margin-top: 120px; position: fixed">
    <nav>
        <div class='nav-container'>
            <div>
                <a class='slide' href='#' id="areasMenu">
                    <span class='element'>Ar</span>
                    <span class='name'>Áreas Estación</span>
                </a>

            </div>
            <div>
                <a class='slide' href='#' id="sitMenu">
                    <span class='element'>Sa</span>
                    <span class='name'>Situación Ambiental</span>
                </a>
            </div>
            <div>
                <a class='slide' href='#' id="evaMenu">
                    <span class='element'>Ev</span>
                    <span class='name'>Evaluación Ambiental</span>
                </a>
            </div>
            <div>
                <a class='slide' href='#' id="planMenu">
                    <span class='element'>Pa</span>
                    <span class='name'>Plan de acción</span>
                </a>
            </div>
            <div>
                <a class='slide' href='#' id="pmaMenu">
                    <span class='element'>Pm</span>
                    <span class='name'>PMA</span>
                </a>
            </div>
            <div>
                <a class='slide' href='#'>
                    <span class='element'>Cr</span>
                    <span class='name'>Cronograma</span>
                </a>
            </div>
            %{--<div>--}%
            %{--<a class='slide' href='#'>--}%
            %{--<span class='element'>Rc</span>--}%
            %{--<span class='name'>Recomendaciones</span>--}%
            %{--</a>--}%
            %{--</div>--}%
        </div>
    </nav>
</header>

<script type="text/javascript">

    $("#areasMenu").click(function () {
        location.href="${createLink(controller: 'area', action: 'areas')}/" + ${pre?.id}
    });

    $("#evaMenu").click(function () {
        location.href="${createLink(controller: 'auditoria', action: 'leyes')}/" + ${pre?.id}
    });

    $("#planMenu").click(function () {
        location.href="${createLink(controller: 'planAccion', action: 'planAccionActual')}/" + ${pre?.id}
    });

    $("#pmaMenu").click(function () {
        location.href="${createLink(controller: 'planManejoAmbiental', action: 'cargarPlanActual')}/" + ${pre?.id}
    });

    $("#sitMenu").click(function () {
        location.href="${createLink(controller: 'situacionAmbiental', action: 'situacion')}/" + ${pre?.id}
    });



    cargarComboEmisores();

    function cargarComboEmisores () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'situacionAmbiental', action: 'emisor_ajax')}',
            data:{
                id: ${pre?.id}
            },
            success: function (msg) {
                $("#divEmisor").html(msg)
            }
        });
    }

    $("#eg").click(function () {
        $.ajax({
            type:'POST',
            url:"${createLink(controller: 'situacionAmbiental', action: 'revisarGenerador_ajax')}",
            data:{
                id: ${pre?.id}
            },
            success: function (msg){
                if(msg == 'ok'){
                    $.ajax({
                        type: 'POST',
                        url: '${createLink(controller: 'situacionAmbiental', action: 'generador_ajax')}',
                        data:{

                        },
                        success: function (msg) {
                            var b = bootbox.dialog({
                                id      : "dlgGenerador",
                                title   : "Emisor - Generador Eléctrico",
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
                                            var si = $("#mantenimientoSi").prop('checked');
                                            var no = $("#mantenimientoNo").prop("checked");
                                            if(!si && !no){
//                                               console.log("ninguno marcado")
                                                bootbox.alert("  <i class='fa fa-exclamation-triangle fa-3x text-danger text-shadow'></i> Debe marcar una de las dos opciones de mantenimiento");
                                                return false
                                            }else{
                                                var $form = $("#frmGenerador");
                                                if($form.valid()){
                                                    $.ajax({
                                                        type: 'POST',
                                                        url:"${createLink(controller: 'situacionAmbiental', action: 'guardarGenerador_ajax')}",
                                                        data:{
                                                            id: ${pre?.id},
                                                            hora: $("#horas").val(),
                                                            si: si,
                                                            no: no
                                                        },
                                                        success: function (msg){
                                                            if(msg == 'ok'){
                                                                log("Emisor guardado correctamente","success");
                                                                cargarComboEmisores();
                                                                cargarTablaEmisores();
                                                                cargarEditor();
                                                            }else{
                                                                log("Error al guardar el emisor","error");
                                                            }
                                                        }
                                                    })
                                                }else{
                                                    return false
                                                }
                                            }
                                        } //callback
                                    } //guardar
                                } //buttons
                            }); //dialog
                        }
                    });
                }else{
                }
            }
        })
    });
    //    }



    $("#btnGuardarBiotico").click(function () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'situacionAmbiental', action: 'guardarBiotico_ajax')}",
            data: {
                descripcion: CKEDITOR.instances.editor1.getData(),
                id: '${pre?.id}'
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Texto guardado correctamente","success")
                }else{
                    log("Error al guardar el texto","error")
                }

            }
        })
    });

    $("#btnGuardarSocial").click(function () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'situacionAmbiental', action: 'guardarSocial_ajax')}",
            data: {
                descripcion: CKEDITOR.instances.editor2.getData(),
                id: '${pre?.id}'
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Texto guardado correctamente","success")
                }else{
                    log("Error al guardar el texto","error")
                }

            }
        })
    });

    cargarTablaEmisores();

    function cargarTablaEmisores () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'situacionAmbiental', action: 'tablaEmisores_ajax')}",
            data:{
                id: ${pre?.id}
            },
            success: function (msg) {
                $("#tablaEmisores").html(msg)
            }
        })
    }

    //    cargarEditor();
    //
    //    function cargarEditor () {
    //
    //    }

    $("#btnInformeEmisor").click(function () {
        $.ajax({
            type: 'POST',
            url:"${createLink(controller: 'situacionAmbiental', action: 'editorE_ajax')}",
            data:{
                id: ${pre?.id}
            },
            success: function (msg){
                $("#divEditor").html(msg)
            }
        })
    });

    %{--$("#btnGuardarEmisiones").click(function () {--}%
    %{--$.ajax({--}%
    %{--type: 'POST',--}%
    %{--url: "${createLink(controller: 'situacionAmbiental', action: 'guardarEmisiones_ajax')}",--}%
    %{--data: {--}%
    %{--descripcion: CKEDITOR.instances.editorE.getData(),--}%
    %{--id: '${pre?.id}'--}%
    %{--},--}%
    %{--success: function (msg) {--}%
    %{--if(msg == 'ok'){--}%
    %{--log("Texto guardado correctamente","success")--}%
    %{--}else{--}%
    %{--log("Error al guardar el texto","error")--}%
    %{--}--}%

    %{--}--}%
    %{--})--}%
    %{--});--}%


    $("#btnAgregarEmisor").click(function () {
        var seleccionado = $("#emisorSituacion").val();
        if(seleccionado != 'null'){
            if(seleccionado == 1){
                $.ajax({
                    type: 'POST',
                    url: '${createLink(controller: 'situacionAmbiental', action: 'generador_ajax')}',
                    data:{
                        mensaje: 'no'
                    },
                    success: function (msg) {
                        var b = bootbox.dialog({
                            id      : "dlgGenerador",
                            title   : "Emisor - Generador Eléctrico",
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
                                        var si = $("#mantenimientoSi").prop('checked');
                                        var no = $("#mantenimientoNo").prop("checked");
                                        if(!si && !no){
//                                               console.log("ninguno marcado")
                                            bootbox.alert("  <i class='fa fa-exclamation-triangle fa-3x text-danger text-shadow'></i> Debe marcar una de las dos opciones de mantenimiento");
                                            return false
                                        }else{
                                            var $form = $("#frmGenerador");
                                            if($form.valid()){
                                                $.ajax({
                                                    type: 'POST',
                                                    url:"${createLink(controller: 'situacionAmbiental', action: 'guardarGenerador_ajax')}",
                                                    data:{
                                                        id: ${pre?.id},
                                                        hora: $("#horas").val(),
                                                        si: si,
                                                        no: no
                                                    },
                                                    success: function (msg){
                                                        if(msg == 'ok'){
                                                            log("Emisor guardado correctamente","success");
                                                            cargarComboEmisores();
                                                            cargarTablaEmisores();
//                                                            cargarEditor();
                                                        }else{
                                                            log("Error al guardar el emisor","error");
                                                        }
                                                    }
                                                })
                                            }else{
                                                return false
                                            }
                                        }
                                    } //callback
                                } //guardar
                            } //buttons
                        }); //dialog
                    }
                });
            }else{
                $.ajax({
                    type: 'POST',
                    url: "${createLink(controller: 'situacionAmbiental', action: 'agregarEmisor_ajax')}",
                    data:{
                        id: ${pre?.id},
                        emisor: seleccionado
                    },
                    success: function (msg) {
                        if(msg == 'ok'){
                            log("Emisor agregado correctamente","success");
                            cargarComboEmisores();
                            cargarTablaEmisores();
                        }else{
                            log("Error al agregar emisor","error")
                        }
                    }
                });
            }
        }
    });

    $("#btnAgregarTabla").click(function () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'situacionAmbiental', action: 'agregarTablaLiquidas_ajax')}',
            data:{
                id: ${pre?.id}
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgTabla",
                    title   : "Tabla de análisis",
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
                                var fecha = $("#fechaTabla").val();
                                $.ajax({
                                    type: 'POST',
                                    url: "${createLink(controller: 'situacionAmbiental', action: 'crearTabla_ajax')}",
                                    data:{
                                        id: ${pre?.id},
                                        fecha: fecha
                                    },
                                    success: function (msg) {
                                        var partes = msg.split("_");
                                        if(partes[0] == 'ok'){
//                                            cargarTablaAnalisis(partes[1])
                                            cargarTablas();
                                        }else{

                                        }
                                    }
                                })
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            }
        });
    });


    cargarTablas();

    function cargarTablas(){
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'situacionAmbiental', action: 'tablaAnalisisV2_ajax')}",
            data:{
                id: ${pre?.id}
            },
            success: function (msg){
                $("#divTablaLiquidas").html(msg)
            }
        });
    }


    function cargarTablaAnalisis (id) {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'situacionAmbiental', action: 'tablaAnalisis_ajax')}",
            data:{
                id: id
            },
            success: function (msg){
                $("#divTablaLiquidas").append(msg)
            }
        });
    }

    $("#btnGuardarLiquidas").click(function () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'situacionAmbiental', action: 'guardarTextoLiquidas_ajax')}",
            data: {
                descripcion: CKEDITOR.instances.editorL.getData(),
                id: '${pre?.id}'
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Texto guardado correctamente","success")
                }else{
                    log("Error al guardar el texto","error")
                }

            }
        })
    });

    cargarComboDesechos();

    function cargarComboDesechos () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'situacionAmbiental', action: 'desechos_ajax')}",
            data:{
                id:${pre?.id}
            },
            success: function (msg) {
                $("#divDesechos").html(msg)
            }
        });
    }
    cargarTablaDesechos();

    function cargarTablaDesechos () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'situacionAmbiental', action: 'tablaDesechos_ajax')}",
            data:{
                id:${pre?.id}
            },
            success: function (msg) {
                $("#divTablaDesechos").html(msg)
            }
        });
    }

    $("#btnAgregarDesechos").click(function () {
        var desecho = $("#desechosCombo").val();
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'situacionAmbiental', action: 'agregarDesecho_ajax')}",
            data:{
                id:${pre?.id},
                desecho: desecho
            },
            success: function (msg) {
                if(msg =='ok'){
                    log("Desecho agregado correctamente","success");
                    cargarTablaDesechos();
                    cargarComboDesechos();
                }else{
                    log("Error al agregar el desecho","errror")
                }
            }
        });
    });

    $("#btnInformeDesechos").click(function () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'situacionAmbiental', action: 'cargarEditorDesechos_ajax')}",
            data:{
                id: ${pre?.id}
            },
            success: function (msg){
                $("#divEditorDescargas").html(msg)
            }
        })
    });

</script>


</body>
</html>