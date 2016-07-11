<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 10/07/2016
  Time: 12:11
--%>
<script src="${resource(dir: 'js/plugins/ckeditor-full', file: 'ckeditor.js')}"></script>

<g:if test="${det?.recomendaciones}">
    <form>
        <textarea name="editor1" id="editor1" rows="30" cols="80">
            ${det?.recomendaciones}
        </textarea>
        <script>
            CKEDITOR.replace( 'editor1', {
                height: "500px"
            });
        </script>
    </form>
</g:if>
<g:else>
    <form>
        <textarea name="editor1" id="editor1" rows="30" cols="80">
            <util:renderHTML html="${texto}"/>
        </textarea>
        <script>
            CKEDITOR.replace( 'editor1', {
                height: "500px"
            });
        </script>
    </form>
</g:else>


<div class="row">
    <nav>
        <ul class="pager">
            <a href="#" id="btnGuardarMet" class="btn btn-success" title="Guardar texto">
                <i class="fa fa-save"></i> Guardar
            </a>

        </ul>
    </nav>
</div>



<script>
    $("#btnGuardarMet").click(function () {
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'auditoria', action: 'guardarRecomendacion_ajax')}",
            data: {
                descripcion: CKEDITOR.instances.editor1.getData(),
                det: '${det?.id}'
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