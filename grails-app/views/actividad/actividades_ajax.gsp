<%@ page import="complemento.Actividad" %>
<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 26/04/16
  Time: 10:33 AM
--%>
<div class="row" style="height: 260px; overflow-y: auto">
    <g:form name="frmActividades" action="saveActividades_ajax">
        <ul class="fa-ul">
            <g:each in="${complemento.Actividad.list([sort: 'descripcion'])}" var="actividad">
                <li class="acti" style="margin-bottom: 5px">
                    <i data-id="${actividad.id}" data-cd="${actividad.codigo}"
                       class="fa-li fa ${actividades.contains(actividad.id) ? "fa-check-square" : "fa-square-o"}"></i>
                    <span> ${actividad?.descripcion}</span>
                </li>
            </g:each>
        </ul>
    </g:form>
</div>

<script type="text/javascript">


    //función para seleccionar los checkbox

    $(".acti .fa-li, .acti span").click(function () {
        var ico = $(this).parent(".acti").find(".fa-li");
        if (ico.hasClass("fa-check-square")) { //descheckear
            ico.removeClass("fa-check-square").addClass("fa-square-o");
        } else { //checkear
            ico.removeClass("fa-square-o").addClass("fa-check-square");
        }

    });



</script>
