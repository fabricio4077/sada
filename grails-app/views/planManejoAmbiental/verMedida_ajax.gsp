<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 29/05/2016
  Time: 18:15
--%>




<div class="row">
    <div id="divTablaM" class="col-md-12">

    </div>
</div>

<script type="text/javascript">
    cargarTablaM(${aupm?.medida?.id}, ${aupm?.id});

    function cargarTablaM (id,au){
        $.ajax({
            type: 'POST',
            url: "${createLink(controller: 'planManejoAmbiental', action: 'tablaMedida_ajax')}",
            data:{
                id:id,
                aupm: au,
                ver: 1
            },
            success: function (msg) {
                $("#divTablaM").html(msg)
            }
        })
    }
</script>