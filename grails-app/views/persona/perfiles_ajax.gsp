<%@ page import="Seguridad.Prfl" %>
<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 24/04/2016
  Time: 22:05
--%>

<div id="divPerfles" class="panel-collapse collapse in">
    <div class="panel-body">
        <p>
            <a href="#" class="btn btn-default btn-sm" id="quitarTodos">Quitar todos los perfiles</a>
        </p>
        <g:form name="frmPerfiles" action="savePerfiles_ajax">
            <ul class="fa-ul">
                <g:each in="${Prfl.list([sort: 'nombre'])}" var="perfil">
                    <li class="perfil">
                        <i data-id="${perfil.id}" data-cd="${perfil.codigo}"
                           class="fa-li fa ${perfiles.contains(perfil.id) ? "fa-check-square" : "fa-square-o"}"></i>
                        <span> ${perfil.nombre}</span>
                    </li>
                </g:each>
            </ul>
        </g:form>
    </div>
</div>

<script type="text/javascript">


  $("#quitarTodos").click(function () {
      $(".perfil .fa-li").removeClass("fa-check-square").addClass("fa-square-o");
      return false;
  });

  $(".perfil .fa-li, .perfil span").click(function () {
      var ico = $(this).parent(".perfil").find(".fa-li");
//      var perf = ico.data("cd");

          if (ico.hasClass("fa-check-square")) { //descheckear
              ico.removeClass("fa-check-square").addClass("fa-square-o");
          } else { //checkear
              ico.removeClass("fa-square-o").addClass("fa-check-square");
          }
  });


</script>