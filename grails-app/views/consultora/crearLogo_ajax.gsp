<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 13/07/2016
  Time: 11:51
--%>

<a href="#" id="btnCargar" class="btn btn-info" title="Cargar logo de la consultora">
     <i class="fa fa-photo"></i> Cargar Logo
</a>


<script>

    $("#btnCargar").click(function () {
        cargarLogo(${pre?.consultora?.id})
    });

    function cargarLogo(id) {
        var idConsultora = id;
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'consultora', action:'cargarLogo_ajax')}",
            data    : {
                id: idConsultora
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCargarLogo",
                    title   : "Cargar Logo",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                                location.reload(true)
                            }
                        }
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit
</script>