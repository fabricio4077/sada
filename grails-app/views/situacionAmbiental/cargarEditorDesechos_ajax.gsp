<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 19/06/2016
  Time: 11:16
--%>

<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 14/06/16
  Time: 03:45 PM
--%>

<script src="${resource(dir: 'js/plugins/ckeditor-full', file: 'ckeditor.js')}"></script>



<textarea name="editorR" id="editorR" rows="30" cols="80">
    ${texto}
</textarea>
<script>
    CKEDITOR.replace( 'editorR', {
        height: "450px"
    });
</script>

<div class="row">
    <nav>
        <ul class="pager">
            <a href="#" id="btnGuardarResiduos" class="btn btn-success" title="Guardar texto">
                <i class="fa fa-save"></i> Guardar
            </a>

        </ul>
    </nav>
</div>


<script>
    $("#btnGuardarResiduos").click(function () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'situacionAmbiental', action: 'guardarTextoDesechos_ajax')}",
            data: {
                descripcion: CKEDITOR.instances.editorR.getData(),
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