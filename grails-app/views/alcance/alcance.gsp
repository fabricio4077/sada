<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Alcance</title>
    <script src="${resource(dir: 'js/plugins/ckeditor-full', file: 'ckeditor.js')}"></script>
</head>

<body>

<div class="panel panel-success ">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-book"></i> Alcance </h3>
    </div>

    <form>
        <textarea name="editor1" id="editor1" rows="30" cols="80">
            ${alc?.descripcion}
        </textarea>
        <script>
            CKEDITOR.replace( 'editor1', {
                height: "500px"
            });
        </script>
    </form>

    <div class="row">
        <nav>
            <ul class="pager">
                <a href="#" id="btnGuardarMet" class="btn btn-success" title="Guardar texto">
                    <i class="fa fa-save"></i> Guardar
                </a>

            </ul>
        </nav>
    </div>
</div>

<script>
    //botón guardar metodologia

    $("#btnGuardarMet").click(function () {
//        alert( CKEDITOR.instances.editor1.getData());
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'alcance', action: 'guardarAlcance_ajax')}",
            data: {
                descripcion: CKEDITOR.instances.editor1.getData(),
                id: '${alc?.id}',
                audi: '${audi?.id}'
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