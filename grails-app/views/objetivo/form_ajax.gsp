<%@ page import="objetivo.Objetivo" %>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>

<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js/vendor', file: 'jquery.ui.widget.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js/imgResize', file: 'load-image.min.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js/imgResize', file: 'canvas-to-blob.min.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.iframe-transport.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.fileupload.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.fileupload-process.js')}"></script>
<script src="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/js', file: 'jquery.fileupload-image.js')}"></script>
<link href="${resource(dir: 'js/plugins/jQuery-File-Upload-9.5.6/css', file: 'jquery.fileupload.css')}" rel="stylesheet">



<g:if test="${!objetivoInstance}">
    <elm:notFound elem="Objetivo" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmObjetivo" role="form" action="save" method="POST">
        <g:hiddenField name="id" value="${objetivoInstance?.id}" />

        <div class="form-group ${hasErrors(bean: objetivoInstance, field: 'tipo', 'error')} ">
            <span class="grupo">
                <label for="tipo" class="col-md-3 control-label text-info">
                    Tipo de Objetivo
                </label>
                <div class="col-md-6">
                    <g:select name="tipo" from="${objetivoInstance.constraints.tipo.inList}"
                              class="form-control required" value="${objetivoInstance?.tipo}"
                              valueMessagePrefix="objetivo.tipo" noSelection="[null: 'Seleccione...']"/>
                </div>

            </span>
        </div>
        <div class="form-group ${hasErrors(bean: objetivoInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-6">
                    %{--<g:textField name="descripcion" class="form-control" value="${objetivoInstance?.descripcion}"/>--}%
                    <g:textArea name="descripcion" class="form-control required" value="${objetivoInstance?.descripcion}"
                                maxlength="1023" style="width: 425px; height: 240px; resize: none; align-content: inherit"/>
                </div>
            </span>
        </div>


        <g:if test="${objetivoInstance?.id}">
            <div class="form-group">
                <span class="grupo">
                    <label class="col-md-2 control-label text-info">
                        Imagen
                    </label>
                    <div class="col-md-10">
                        <div class="col-md-5">
                            <span class="btn btn-info fileinput-button" style="position: relative;height: 40px;margin-top: 10px">
                                <i class="glyphicon glyphicon-plus"></i>
                                <span>Seleccionar imagen</span>
                                <input type="file" name="file" id="file">
                            </span>
                        </div>

                        <g:if test="${objetivoInstance?.imagen && objetivoInstance?.imagen != ''}">
                            <div id="divImagen" class="col-md-3">

                            </div>
                        </g:if>
                        <g:else>
                            <i class='fa fa-exclamation-triangle fa-2x text-danger text-shadow'></i> Sin imagen
                        </g:else>


                    %{--<img class="img-responsive pull-right"--}%
                    %{--src="${resource(dir: 'images/inicio', file: 'login_temp.jpg')}" style="width: 100px; height: 100px"/>--}%
                    </div>
                </span>
            </div>

            <div class="col-md-3"></div>
            <div id="progress" class="progress progress-striped active col-md-4" style="width: 50%">
                <div class="progress-bar progress-bar-info"></div>
            </div>

            %{--<div id="files"></div>--}%
        </g:if>




        <div class="form-group ${hasErrors(bean: objetivoInstance, field: 'defecto', 'error')} ">
            <span class="grupo">
                <label for="defecto" class="col-md-7 control-label text-info">
                    Es este un objetivo predeterminado?
                </label>
                <div class="col-md-2">
                    %{--<g:textField name="defecto" class="allCaps form-control" value="${objetivoInstance?.defecto}"/>--}%
                    <g:checkBox name="defecto" class="form-control" checked="${objetivoInstance?.defecto == '1' ? 'true' : 'false'}"/>
                </div>
            </span>
        </div>

        <div class="well" style="text-align: center">
            <p>
                <i class='fa fa-exclamation-triangle fa-3x pull-left text-info text-shadow'></i>
                <strong>Los objetivos marcados como predeterminados<br></strong>
                <strong>serán los objetivos que se muestren por defecto en las auditorías.</strong>
            </p>
        </div>
    </g:form>

    <script type="text/javascript">


        //validación de objetivo general predeterminado duplicado

        $("#defecto").click(function () {
            var idObj= $("#id").val();
            var tp= $("#tipo").val();
//            console.log("defecto " + $(this).prop('checked'))
            if($(this).prop('checked') && tp == 'General'){
                $.ajax({
                    type: 'POST',
                    url: "${createLink(controller: 'objetivo', action: 'validarPredeterGeneral_ajax')}",
                    data: {
                        id: idObj
                    },
                    success: function (msg) {
                        if(msg == 'ok'){
                            bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i> Ya existe un objetivo general marcado como predeterminado! <br>" +
                            " * Necesita desmarcar el otro objetivo general antes de marcar este como predeterminado")

                            $("#defecto").prop('checked', false)
                        }
                    }
                });
            }
        });

        $("#tipo").change(function () {
            var idObj= $("#id").val();
            if(!idObj){
                $("#defecto").prop('checked', false)
            }
        });

        //validación de los campos a llenar
        var validator = $("#frmObjetivo").validate({
            errorClass     : "help-block",
            errorPlacement : function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success        : function (label) {
                label.parents(".grupo").removeClass('has-error');
            },
            rules:{
                tipo:{
                    remote:{
                        url: "${createLink(controller: 'objetivo', action: 'validarTipo_ajax')}",
                        type: 'POST',
                        data:{
                            tipo: $(".tipo").val()
                        }
                    }
                }
            },
            messages :{
                tipo:{
                    remote : "Seleccione un tipo de objetivo"
                }
            }
        });
        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitForm();
                return false;
            }
            return true;
        });


        <g:if test="${objetivoInstance?.id}">
        cargarImagen(${objetivoInstance?.id});
        </g:if>


        //funcion para cargar la imagen desde webapp

        function cargarImagen (idO) {
            $.ajax({
                type    : "POST",
                url     : "${createLink(action: 'cargarImagen_ajax')}",
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
                url              : '${createLink(action:'uploadFile')}',
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
                );
            }).on('fileuploaddone', function (e, data) {
               cargarImagen(${objetivoInstance?.id});
                setTimeout(function () {
                    $('#progress .progress-bar').css(
                            'width',
                            0 + '%'
                    );
                }, 700);
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

</g:else>