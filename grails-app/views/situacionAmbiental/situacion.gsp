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

    <div class="panel-group" style="height: 1000px">
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
                            <li class="col-md-4"><a data-toggle="tab" href="#gaseosas" id="eg"><h5>Emisiones Gaseosas</h5></a></li>
                            <li class="active col-md-4"><a data-toggle="tab" href="#liquidas"><h5>Descargas Líquidas</h5></a></li>
                            <li class="col-md-4"><a data-toggle="tab" href="#residuos"><h5>Resíduos Sólidos y Líquidos</h5></a></li>
                        </ul>

                        <div class="tab-content">
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

                                <div id="divEditor">
                                    %{--<textarea name="editor1" id="editorE" rows="30" cols="80">--}%
                                        %{--${texto}--}%
                                    %{--</textarea>--}%
                                    %{--<script>--}%
                                        %{--CKEDITOR.replace( 'editorE', {--}%
                                            %{--height: "300px",--}%
                                            %{--customConfig: 'config.js'--}%
                                        %{--});--}%
                                    %{--</script>--}%

                                    %{--<div class="row" style="margin-top: -10px">--}%
                                        %{--<nav>--}%
                                            %{--<ul class="pager">--}%
                                                %{--<a href="#" id="btnGuardarEmisiones" class="btn btn-success" title="Guardar texto">--}%
                                                    %{--<i class="fa fa-save"></i> Guardar--}%
                                                %{--</a>--}%

                                            %{--</ul>--}%
                                        %{--</nav>--}%
                                    %{--</div>--}%

                                </div>

                            </div>
                            <div id="liquidas" class="tab-pane fade in active">
                                <h4>Liquidos</h4>
                            </div>
                            <div id="residuos" class="tab-pane fade">
                                <h4>Residuos</h4>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="menu1" class="tab-pane fade" style="margin-top: 10px">
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
                <div id="menu2" class="tab-pane fade">
                    <g:if test="${pre?.tipo?.codigo != 'LCM1'}">
                        <h4></h4>
                        <div class="alert alert-danger" role="alert" style="text-align: center">
                            ESTE COMPONENTE NO ESTÁ DISPONIBLE PARA ESTE TIPO DE AUDITORÍA
                        </div>
                    </g:if>
                    <g:else>
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

<script type="text/javascript">

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

    cargarEditor();

    function cargarEditor () {
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
    }

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
                $.ajax({
                    type: 'POST',
                    url: "${createLink(controller: 'situacionAmbiental', action: 'agregarEmisor_ajax')}",
                    data:{
                        id: ${pre?.id},
                        emisor: seleccionado
                    },
                    success: function (msg) {
                        cargarComboEmisores();
                        cargarTablaEmisores();
                        cargarEditor();
                    }
                });
            }
        }
    });

</script>


</body>
</html>