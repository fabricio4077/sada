<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 21/06/16
  Time: 10:19 AM
--%>

<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 20/06/2016
  Time: 22:33
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

<div class="form-group" style="height: 80px">
    <label class="col-md-2 control-label text-info">
        Logotipo
    </label>
    <div class="col-md-10">
        <div class="col-md-6">
            <span class="btn btn-info fileinput-button" style="position: relative;height: 40px">
                <i class="glyphicon glyphicon-plus"></i>
                <span>Seleccionar imagen</span>
                <input type="file" name="file" id="file">
            </span>
        </div>
        <div id="divImagen" class="col-md-6">

        </div>
    </div>

</div>

<div class="col-md-2"></div>
<div id="progress" class="progress progress-striped active col-md-3" style="width: 40%">
    <div class="progress-bar progress-bar-info"></div>
</div>

<script>


    <g:if test="${comercializadora?.logotipo}">
    cargarImagen(${comercializadora?.id});
    </g:if>


    //funcion para cargar la imagen desde la carpeta webapp

    function cargarImagen (idO) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(action: 'comercializadoraLogo_ajax')}",
            data:{
                id: idO
            },
            success : function (msg) {
                $("#divImagen").html(msg);
            }
        });
    }

    //subir imagen

    $(function () {
        $('#file').fileupload({
            url              : '${createLink(controller: 'comercializadora', action:'uploadFile', id: comercializadora?.id)}',
            dataType         : 'json',
            maxNumberOfFiles : 1,
            acceptFileTypes  : /(\.|\/)(jpe?g|png)$/i,
            maxFileSize      : 1000000 // 1 MB
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
            ).show();
        }).on('fileuploaddone', function (e, data) {
            cargarImagen(${comercializadora?.id});
            setTimeout(function () {
                $('#progress .progress-bar').css(
                        'width',
                        0 + '%'
                ).hide();
            }, 700);
            var exito = $('<span class="text-success"/>').text('Archivo cargado exitosamente!');
            $.each(data.files, function (index, file) {
                $(data.context.children()[index])
                        .append('<br>')
                        .append(exito);
//                $("#mensaje").append(exito).toggle(3500);
            });
        }).on('fileuploadfail', function (e, data) {
            closeLoader();
            $.each(data.files, function (index, file) {
                var error = $('<span class="text-danger"/>').text('File upload failed.');
                $(data.context.children()[index])
                        .append('<br>')
                        .append(error);
            });
        });
    })






</script>
