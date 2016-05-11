<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 08/05/2016
  Time: 15:04
--%>

<ul class="media-list">
    <li class="media">
        <div class="media-left border" style="margin-top: 20px">
                <img class="img-responsive pull-left"
                     src="${resource(dir: 'images/objetivos', file: 'check-icono.jpg')}" style="width: 100px; height: 100px"/>
        </div>
        <div class="media-body">
            <div style="margin-bottom: 10px"></div>
            <span class="label label-default" style="font-size: medium;">Objetivo General</span>
            <div style="margin-bottom: 20px"></div>
            <g:each in="${general}" var="g">
                <a href="#" class="list-group-item list-group-item-success">
                    ${g?.objetivo?.descripcion} aplicada a la estación de servicio "${auditoria?.preauditoria?.estacion?.nombre}"
                </a>
            </g:each>

            <div style="margin-bottom: 20px"></div>
            <span class="label label-default" style="font-size: medium;">Objetivos Específicos</span>
            <g:each in="${especificos}" var="s">
                <div class="media media-middle">
                    <a href="#" class="btn btn-info btnInformacion" title="Objetivo en progreso....">
                        <i class="fa fa-exclamation"></i>
                    </a>
                    <div class="media-left media-middle">



                        <a href="#">
                            <img class="img-responsive pull-left"
                                 src="${resource(dir: 'images/objetivos', file: s?.objetivo?.imagen)}" style="width: 100px; height: 100px"/>
                        </a>
                    </div>
                    <div class="media-body">
                        <a href="#" class="list-group-item active">
                        ${s?.objetivo?.descripcion}
                        </a>
                    </div>
                </div>
            </g:each>
        </div>
    </li>
</ul>

<script type="text/javascript">

    $(".btnInformacion").click(function () {
        bootbox.alert(" <i class='fa fa-exclamation-triangle fa-3x text-info text-shadow'></i> Este objetivo se encuentra actualmente en progreso!")
    });

</script>