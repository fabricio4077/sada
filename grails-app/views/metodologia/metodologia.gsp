<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 08/06/16
  Time: 11:01 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Metodologia</title>
    %{--<script src="${resource(dir: 'js/jquery/js', file: 'jquery-1.9.1.js')}"></script>--}%
    <script src="${resource(dir: 'js/plugins/ckeditor-new', file: 'ckeditor.js')}"></script>
    %{--<script src="${resource(dir: 'js/plugins/ckeditor-new/adapters', file: 'jquery.js')}"></script>--}%
    %{--<script src="//cdn.ckeditor.com/4.5.9/standard/ckeditor.js"></script>--}%

</head>

<body>

<div class="panel panel-success ">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-book"></i> Metodología </h3>
    </div>

    <g:form name="formMet" id="meto" method="POST" action="guardarMetodologia_ajax">
        <div class="row">
            <div class="col-md-12">
                %{--<g:textArea name="editor_name" id="editor" />--}%
                %{--<textarea id="editorTexto" name="editorTexto" class="editor editorTexto" rows="100" cols="80"></textarea>--}%
                <textarea name="editor1" id="texto"></textarea>
            </div>

        </div>
    </g:form>

    <div class="row">
        <nav>
            <ul class="pager">
                <li>
                    <a href="#" id="btnRegresar" class="btn btn-primary" title="Retornar a parámetros">
                        <i class="fa fa-angle-double-left"></i> Regresar </a>
                </li>


                <a href="#" id="btnGuardarMet" class="btn btn-success" title="Guardar la metodología">
                    <i class="fa fa-save"></i> Guardar
                </a>

            </ul>
        </nav>
    </div>
</div>

<script>

    window.onload = function() {
        CKEDITOR.replace( 'editor1', {
//        language: 'es',
//        uiColor: '#9AB8F3'
            customConfig: 'config.js'
        });
    };



//
//    CKEDITOR.on('instanceReady', function (ev) {
//        // Prevent drag-and-drop.
//        ev.editor.document.on('drop', function (ev) {
//            ev.data.preventDefault(true);
//        });
//    });

    //botón de regresar a parámetros

    $("#btnRegresar").click(function () {
        location.href="${createLink(controller: 'tipo', action: 'parametros')}"
    });

    //botón guardar metodologia

    $("#btnGuardarMet").click(function () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'metodologia', action: 'guardarMetodologia_ajax')}",
            data: {
                met: $("#texto").val()
            },
            success: function (msg) {

            }
        })
    });


</script>


</body>
</html>