<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 12/05/16
  Time: 12:11 PM
--%>
<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js/vendor', file: 'jquery.ui.widget.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js/imgResize', file: 'load-image.min.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js/imgResize', file: 'canvas-to-blob.min.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.iframe-transport.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.fileupload.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.fileupload-process.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.fileupload-image.js')}"></script>
<link href="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/css', file: 'jquery.fileupload.css')}" rel="stylesheet">


<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center">
            <i class="fa fa-bank"></i> Instalaciones pertenecientes a la estación de servicio: "${pre?.estacion?.nombre}" </h3>
    </div>

    <div class="panel-group" id="accordion">

        <g:each in="${areas}" var="a" status="n">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapse_${n}">
                            ${a?.area?.nombre}
                        </a>
                        <a href="#" class="btn btn-danger btnEliminarArea btn-xs" title="Eliminar instalación" data-id="${a?.id}" style="float: right">
                            <i class="fa fa-close"></i>
                        </a>
                    </h4>
                </div>
            </div>

            <div id="collapse_${n}" class="panel-collapse collapse ">
                <div class="panel-body">
                    <table class="table table-bordered table-hover table-condensed" style="margin-top: 10px;">
                        <thead>
                        <tr>
                            <th style="width:30%;">Descripción</th>
                            <th style="width:60%;">Fotografías</th>
                            <th style="width:5%;">Extintor</th>
                            <th style="width:5%;">Acciones</th>
                        </tr>
                        </thead>
                        <tbody id="tablaAreas">
                        <tr class="tabla" data-p="${a?.id}">
                            <td><g:textArea name="descripcion_name" id="descripcionInstalacion_${a?.id}"
                                            style="width: 375px; height: 170px; resize: none" maxlength="1023" value="${a?.descripcion}"/> </td>
                            <td>
                                <div class="col-md-6">
                                    <span class="btn btn-info fileinput-button" style="position: relative;height: 35px;margin-top: 10px; margin-bottom: 10px">
                                        <i class="glyphicon glyphicon-plus"></i>
                                        <span>Seleccionar imagen</span>
                                        <input type="file" name="file" multiple="" id="archi" class="archivo" idArea="${a?.id}" data-id="${a?.id}" data-pre="${pre?.id}">
                                    </span>
                                </div>

                                <div id="progress" class="progress progress-striped active col-md-4" style="width: 50%; margin-top: 10px">
                                    <div class="progress-bar progress-bar-info"></div>
                                </div>

                                <div id="divImagen" class="col-md-12">
                                    <g:if test="${a?.foto1}">
                                        <img id="foto" src="${resource(dir: 'images/areas/', file: a?.foto1)}" style="width: 150px; height: 110px"/>
                                        <a href="#" class="btn btn-danger btn-xs btnBorrarImagen" title="Borrar imagen" data-id="${a?.id}" data-f="${1}" >
                                            <i class="fa fa-trash"></i>
                                        </a>
                                    </g:if>
                                    <g:if test="${a?.foto2}">
                                        <img id="foto" src="${resource(dir: 'images/areas/', file: a?.foto2)}" style="width: 150px; height: 110px"/>
                                        <a href="#" class="btn btn-danger btn-xs btnBorrarImagen" title="Borrar imagen" data-id="${a?.id}" data-f="${2}" >
                                            <i class="fa fa-trash"></i>
                                        </a>
                                    </g:if>
                                    <g:if test="${a?.foto3}">
                                        <img id="foto" src="${resource(dir: 'images/areas/', file: a?.foto3)}" style="width: 150px; height: 110px"/>
                                        <a href="#" class="btn btn-danger btn-xs btnBorrarImagen" title="Borrar imagen" data-id="${a?.id}" data-f="${3}" >
                                            <i class="fa fa-trash"></i>
                                        </a>
                                    </g:if>
                                </div>
                            </td>
                            <td style="text-align: center">
                                <a href="#" class="btn btn-info btn-sm btnAddExtintor" title="Agregar extintores" data-id="${a?.id}" >
                                    <i class="fa fa-plus"></i>
                                </a>
                                <div id="divExtintor" style="margin-top: 10px; margin-bottom: 5px">
                                    ${estacion.Extintor.findAllByAres(a).size()} Extintor(es) en esta área
                                </div>
                                <i class="fa fa-fire-extinguisher fa-2x"></i>
                            </td>
                            <td style="text-align: center">
                                <div class="btn-group btn-group-sm" role="group">
                                    <a href="#" class="btn btn-success btnGuardarArea" title="Guardar cambios en la instalación" data-id="${a?.id}" >
                                        <i class="fa fa-save"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </g:each>
    </div>
</div>

<script type="text/javascript">


    //función para cargar los extintores

    function cargarCantidadEx () {

    }


    //función para guardar los datos del área en la tabla ares

    $(".btnGuardarArea").click(function () {
        var idAr = $(this).data('id');
        $.ajax({
           type: 'POST',
            url: '${createLink(controller: 'area', action:  'guardarDatosArea_ajax')}',
            data:{
            id: idAr,
            descripcion: $("#descripcionInstalacion_"+idAr).val(),
            extintor: $("#extintor_"+idAr).val(),
            capacidad: $("#capacidad_"+idAr).val()
            },
            success: function (msg){
                if(msg == 'ok'){
                    log("Datos del área guardados correctamente","success")
                }else{
                    log("Error al guardar los datos del área","error");
                    cargarAcordeon();
                }
            }
        });
    });

    //función para agregar extintores a las áreas


    $(".btnAddExtintor").click(function () {
        var idAre = $(this).data('id');
        $.ajax({
           type:'POST',
            url:"${createLink(controller: 'area', action: 'cargarExtintor_ajax')}",
            data: {
            id: idAre
            },
            success: function (msg) {
                bootbox.dialog({
                    id: "dlgExtintor",
                    title: "Extintores",
                    message: msg,
                    buttons: {
                        cancelar :{
                            label     : '<i class="fa fa-times"></i> Cancelar',
                            className : 'btn-danger',
                            callback  : function () {

                            }
                        }
                    }
                })
            }
        });
    });


    //función para eliminar areas(ares) de la estación

    $(".btnEliminarArea").click(function () {
        var idA = $(this).data("id");
        bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x text-danger text-shadow'>" +
        "</i> Está seguro de remover esta área de la estación?", function (result){
            if(result){
                $.ajax({
                    type:'POST',
                    url:"${createLink(controller: 'area', action: 'eliminarArea_ajax')}",
                    data:{
                        id: idA
                    },
                    success: function (msg) {
                        if(msg == 'ok'){
                            log("Área removida correctamente","success");
                            cargarAcordeon();
                            cargarComboArea();
                        }else{
                            log("Error al eliminar el área","error");
                        }
                    }
                })

            }
        })
    });

    //subir imagen

    $(".archivo").click(function () {
        var idA = $(this).data('id');
        var prea = $(this).data('pre');
        //        $('#file').fileupload({
        $('.archivo').fileupload({

            url              : '${createLink(action:'uploadFile')}?id=' + idA + "&pre=" + prea,
            dataType         : 'json',
            maxNumberOfFiles : 3,
            ida: $(this).data("id"),
            acceptFileTypes  : /(\.|\/)(jpe?g|png)$/i
//            ,
//            maxFileSize      : 10000000 // 1 MB
        }).on('fileuploadadd', function (e, data) {
//                    console.log("fileuploadadd");
            openLoader("Cargando");
            data.context = $('<div/>').appendTo('#files');
            $.each(data.files, function (index, file) {
                var node = $('<p/>')
                        .append($('<span/>').text(file.name));
                if (!index) {
                    node
                            .append('<br>');
                }
                node.appendTo(data.context);
            });
        }).on('fileuploadprocessalways', function (e, data) {
//                    console.log("fileuploadprocessalways");
            var index = data.index,
                    file = data.files[index],
                    node = $(data.context.children()[index]);
            if (file.preview) {
                node
                        .prepend('<br>')
                        .prepend(file.preview);
            }
            if (file.error) {
                node
                        .append('<br>')
                        .append($('<span class="text-danger"/>').text(file.error));
            }
            if (index + 1 === data.files.length) {
                data.context.find('button')
                        .text('Upload')
                        .prop('disabled', !!data.files.error);
            }
        }).on('fileuploadprogressall', function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .progress-bar').css(
                    'width',
                    progress + '%'
            );
        }).on('fileuploaddone', function (e, data) {
            %{--cargarImagen(${objetivoInstance?.id});--}%

//        setTimeout(function () {
//            $('#progress .progress-bar').css(
//                    'width',
//                    0 + '%'
//            );
//        }, 700);
            setTimeout(function () {
                cargarAcordeon();
            }, 1000);
        }).on('fileuploadfail', function (e, data) {
            closeLoader();
            $.each(data.files, function (index, file) {
                var error = $('<span class="text-danger"/>').text('File upload failed.');
                $(data.context.children()[index])
                        .append('<br>')
                        .append(error);
            });
        });


    });

    //función para eliminar una imagen

    $(".btnBorrarImagen").click(function () {
        var idArea = $(this).data('id');
        var foto = $(this).data('f');
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'area', action: 'borrarImagen_ajax')}',
            data:{
                id: idArea,
                foto: foto
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log('Imagen borrada correctamente',"success");
                    cargarAcordeon();
                }else{
                    log("Error al borrar la imagen","error")
                }

            }
        })
    });



</script>