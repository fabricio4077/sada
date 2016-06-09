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

    %{--<script src="${resource(dir: 'js/plugins/ckeditor4', file: 'ckeditor.js')}"></script>--}%
    <script src="${resource(dir: 'js/plugins/ckeditor-full', file: 'ckeditor.js')}"></script>


</head>

<body>

<div class="panel panel-success ">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-book"></i> Metodología </h3>
    </div>

    <form>
        <textarea name="editor1" id="editor1" rows="30" cols="80">
            ${met?.descripcion}
        </textarea>
        <script>
            // Replace the <textarea id="editor1"> with a CKEditor
            // instance, using default configuration.
            CKEDITOR.replace( 'editor1', {
               height: "500px"
            });
        </script>
    </form>

    <div class="row">
        <nav>
            <ul class="pager">
                <li>
                    <a href="#" id="btnRegresar" class="btn btn-primary" title="Retornar a parámetros">
                        <i class="fa fa-angle-double-left"></i> Regresar </a>
                </li>


                <a href="#" id="btnGuardarMet" class="btn btn-success" title="Guardar texto">
                    <i class="fa fa-save"></i> Guardar
                </a>

            </ul>
        </nav>
    </div>
</div>

<script>

//    window.onload = function() {
//        CKEDITOR.replace( 'editor1', {
////        language: 'es',
////        uiColor: '#9AB8F3'
//            customConfig: 'config.js'
//        });
//    };



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
//        alert( CKEDITOR.instances.editor1.getData());
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'metodologia', action: 'guardarMetodologia_ajax')}",
            data: {
                met: CKEDITOR.instances.editor1.getData(),
                id: '${met?.id}'
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


</script>


</body>
</html>