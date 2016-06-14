<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 14/06/16
  Time: 03:45 PM
--%>

<script src="${resource(dir: 'js/plugins/ckeditor-full', file: 'ckeditor.js')}"></script>



<textarea name="editor1" id="editorE" rows="30" cols="80">
    ${texto}
</textarea>
<script>
    CKEDITOR.replace( 'editorE', {
        height: "300px",
        customConfig: 'config.js'
    });
</script>

<div class="row" style="margin-top: -10px">
    <nav>
        <ul class="pager">
            <a href="#" id="btnGuardarEmisiones" class="btn btn-success" title="Guardar texto">
                <i class="fa fa-save"></i> Guardar
            </a>

        </ul>
    </nav>
</div>


<script>
    $("#btnGuardarEmisiones").click(function () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'situacionAmbiental', action: 'guardarEmisiones_ajax')}",
            data: {
                descripcion: CKEDITOR.instances.editorE.getData(),
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
</script>