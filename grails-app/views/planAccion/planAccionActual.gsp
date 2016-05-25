<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 24/05/2016
  Time: 22:27
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Síntesis de No Conformidades y Plan de Acción para la estación:
        '${pre?.estacion?.nombre}' en el período ${pre?.periodo?.inicio?.format("yyyy") + " - " + pre?.periodo?.fin?.format("yyyy")}</title>
</head>

<body>

<div class="panel panel-warning">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-asterisk"></i> Plan de Acción</h3>
    </div>
<g:each in="${lista}" var="no">
    <div class="row col-md-12" >
            <div class="col-md-5">
                <table class="table table-condensed table-bordered table-striped">
                    <tbody>
                    <td style="background-color: ${no?.calificacion?.tipo};" class="col-md-2" title="${no?.calificacion?.nombre}">
                        <div class="divCalificacion col-md-4">
                            ${no?.calificacion?.sigla}
                        </div>
                    </td>
                    <td class="col-md-8">
                        ${no?.marcoNorma?.literal ? (no?.marcoNorma?.literal?.identificador + ")  " + no?.marcoNorma?.literal?.descripcion) : no?.marcoNorma?.articulo?.descripcion}
                    </td>
                    </tbody>
                </table>
            </div>
            <div class="col-md-7">
                <ul class="nav nav-tabs">
                    <li class="active"><a data-toggle="tab" href="#home_${no?.id}">Actividades</a></li>
                    <li><a data-toggle="tab" href="#menu1_${no?.id}">Responsable</a></li>
                    <li><a data-toggle="tab" href="#menu2_${no?.id}">Plazo</a></li>
                    <li><a data-toggle="tab" href="#menu3_${no?.id}">Costo</a></li>
                    <li><a data-toggle="tab" href="#menu4_${no?.id}">Verificación</a></li>
                </ul>

                <div class="tab-content">
                    <div id="home_${no?.id}" class="tab-pane fade in active">
                        <h3>Actividades ${no?.id}</h3>
                        <p>Some content.</p>
                    </div>
                    <div id="menu1_${no?.id}" class="tab-pane fade">
                        <h3>Menu 1</h3>
                        <p>Some content in menu 1.</p>
                    </div>
                    <div id="menu2_${no?.id}" class="tab-pane fade">
                        <h3>Menu 2</h3>
                        <p>Some content in menu 2.</p>
                    </div>
                    <div id="menu3_${no?.id}" class="tab-pane fade">
                        <h3>Menu 2</h3>
                        <p>Some content in menu 2.</p>
                    </div>
                    <div id="menu4_${no?.id}" class="tab-pane fade">
                        <h3>Menu 2</h3>
                        <p>Some content in menu 2.</p>
                    </div>
                </div>
            </div>

    </div>
</g:each>
</div>





<script type="text/javascript">

</script>


</body>
</html>