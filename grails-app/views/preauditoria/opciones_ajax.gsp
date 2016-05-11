<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 10/04/2016
  Time: 12:47
--%>
<style type="text/css">
    .bgOpcion:hover {
    background : #395B81 !important;
        width: 200px;
        color: #fffff9;
    }
    .bgOpcion{
      width: 200px;
    }
    .margen {
        margin-left: 180px;
    }

</style>


<div class="list-group margen" style="text-align: center">
<g:link controller="preauditoria" action="crearAuditoria" class="list-group-item bgOpcion">
    <h4 class="list-group-item-heading"><span class="icon"></span>
        <i class="fa fa-plus"></i>
    </h4>
    <p class="list-group-item-text">
        <strong>Iniciar Auditoría</strong>
    </p>
</g:link>
</div>

<div class="list-group margen" style="text-align: center">
    <g:link controller="preauditoria" action="list" class="list-group-item bgOpcion">
        <h4 class="list-group-item-heading"><span class="icon"></span>
            <i class="fa fa-history"></i>
        </h4>
        <p class="list-group-item-text">
           <strong>Continuar una Auditoría</strong>
        </p>
    </g:link>
</div>

<g:if test="${session.perfil.codigo == 'ADMI'}">
    <div class="list-group margen" style="text-align: center;">
        <g:link controller="persona" action="list" class="list-group-item bgOpcion ">
            <h4 class="list-group-item-heading"><span class="icon"></span>
                <i class="fa fa-navicon"></i>
            </h4>
            <p class="list-group-item-text">
                <strong>Listar Auditorías</strong>
            </p>
        </g:link>
    </div>
</g:if>


<script type="text/javascript">
//    $(function () {
//        $(".list-group-item").hover(function () {
//            $(this).find(".icon").html(' <i class="fa fa-thumbs-up"></i>');
//        }, function () {
//            $(this).find(".icon").html('');
//        });
//    });
</script>


