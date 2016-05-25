<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 25/05/16
  Time: 12:22 PM
--%>

<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js/vendor', file: 'jquery.ui.widget.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js/imgResize', file: 'load-image.min.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js/imgResize', file: 'canvas-to-blob.min.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.iframe-transport.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.fileupload.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.fileupload-process.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.fileupload-image.js')}"></script>
<link href="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/css', file: 'jquery.fileupload.css')}" rel="stylesheet">

<span class="btn btn-success fileinput-button" style="position: relative;height: 40px;margin-top: 10px">
    <i class="glyphicon glyphicon-plus"></i>
    <span>Seleccionar archivos</span>
    <input type="file" name="file" id="file" class="file" multiple accept=".doc, .docx, .pdf, .odt, .xls, .xlsx, .jpeg, .jpg, .png">
</span>

<div id="progress" class="progress progress-striped active col-md-4 hide" style="width: 50%">
    <div class="progress-bar progress-bar-info"></div>
</div>



<script>
    $(function () {
        $('#file').fileupload({
            url              : '${createLink(controller: 'evaluacion', action:'uploadFile', id: evaluacion?.id)}',
            dataType         : 'json',
            maxNumberOfFiles : 1,
//            acceptFileTypes  : /(\.|\/)(jpe?g|png)$/i,
            maxFileSize      : 10000000 // 1 MB
        }).on('fileuploadadd', function (e, data) {
//                    console.log("fileuploadadd");

//            $('#progress .progress-bar').css(
//                    'width',
//                    progress + '%'
//            ).removeClass('hide');


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
            ).removeClass('hide');
        }).on('fileuploaddone', function (e, data) {
            %{--cargarImagen(${objetivoInstance?.id});--}%
//            setTimeout(function () {
                $('#progress .progress-bar').css(
                        'width',
                        0 + '%'
                ).addClass('hide');
//            }, 700);
            %{--setTimeout(function () {--}%
            %{--location.href = "${createLink(action: 'personal', params:[tipo:'foto'])}";--}%
            %{--}, 1000);--}%
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