<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 15/05/2016
  Time: 16:47
--%>

<table class="table table-bordered table-condensed table-hover" style="width: 440px">
    <thead>
    <tr>
        <th style="width: 40%">Tipo</th>
        <th style="width: 40%">Capacidad</th>
        <th style="width: 20%">Acciones</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${lista}" var="s">
        <tr>
            <td>${s?.tipo}</td>
            <td>${s?.capacidad} LBS</td>
            <td style="text-align: center">
                <a href="#" class="btn btn-danger btn-sm btnBorrar" title="Borrar extintor" data-id="${s?.id}">
                    <i class="fa fa-trash"></i>
                </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">
    $(".btnBorrar").click(function () {
        var idE = $(this).data('id');
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'area', action: 'borrarExtintor_ajax')}',
            data:{
                id: idE
            },
            success: function(msg){
            cargarTablaEx();
            }
        });
    });
</script>

