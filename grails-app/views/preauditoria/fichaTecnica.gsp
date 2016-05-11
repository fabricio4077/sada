<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 26/04/16
  Time: 12:17 PM
--%>

<%@ page import="estacion.Canton" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada"/>
    <title>Ficha Técnica - Estación: ${pre?.estacion?.nombre}</title>

    <style type="text/css">
    .estilo{
        font-weight: bold;
    }

    .back{
        background: #446e9b !important;
        color: #ffffff; !important;
    }

    td{
        text-align: center;
    }

    th{
        text-align: center;
    }
    </style>


</head>

<body>


<div class="panel panel-primary" style="width: 80%; margin-left: 100px">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> Proyecto</h3>
    </div>

    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-10 estilo">Auditoría Ambiental de ${pre?.tipo?.descripcion} ${pre?.periodo?.inicio?.format("yyyy") + " - " +
                pre?.periodo?.fin?.format("yyyy")} de la estación de servicios "${pre?.estacion?.nombre}"
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%">
                <thead >
                <tr>
                    <th class="back" width="100px">Razón Social de la estación de servicios</th>
                    <th class="back" width="100px">Representante Legal</th>
                    <th class="back" width="60px">Dirección</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>${pre?.estacion?.nombre}</td>
                    <td>${pre?.estacion?.representante}</td>
                    <td rowspan="3">${pre?.estacion?.direccion}<br/>Provincia de ${pre?.estacion?.provincia?.nombre?.toLowerCase()}</td>
                </tr>
                <tr>
                    <td>Teléfono</td>
                    <td>${pre?.estacion?.telefono}</td>
                </tr>
                <tr>
                    <td>Correo electrónico</td>
                    %{--<td> <a href="${pre?.estacion?.mail}">${pre?.estacion?.mail}</a>  </td>--}%
                    <td>${pre?.estacion?.mail}</td>
                </tr>
                </tbody>
            </table>
        </div>
    %{--</div>--}%

    %{--<div class="row" style="margin-top: -10px">--}%
        <div class="col-md-12" style="margin-top: -20px">
            <table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%">
                <thead >
                <tr>
                    <th class="back" width="115px">Razón Social de la compañia</th>
                    <th class="back" width="100px">Representante Legal de la Comercializadora</th>
                    <th class="back" width="70px">Dirección</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>${pre?.estacion?.comercializadora?.nombre}</td>
                    <td>${pre?.estacion?.comercializadora?.representante}</td>
                    <td rowspan="3">${pre?.estacion?.comercializadora?.direccion}</td>
                </tr>
                <tr>
                    <td>Teléfono</td>
                    <td>${pre?.estacion?.comercializadora?.telefono}</td>
                </tr>
                <tr>
                    <td>Correo electrónico</td>
                    <td> <a href=http://${pre?.estacion?.comercializadora?.mail}>${pre?.estacion?.comercializadora?.mail}</a>  </td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="col-md-12" style="margin-top: -20px">
            <table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%">
                <thead >
                <tr>
                    <th class="back" width="285px">Facilidades</th>
                    <th class="back" colspan="3" width="100px">Localización Geográfica del proyecto <br/> (Coordenadas Planas UTM WGS84)</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td rowspan="${coordenadas?.size()?.toInteger() + 1}"><br/><br/>Estación de Servicios</td>
                    <td width="200px"> X </td>
                    <td width="200px"> Y</td>
                    <td rowspan="${coordenadas?.size()?.toInteger() + 1}"><br/> Cantón: ${estacion.Canton.get(pre?.estacion?.canton)?.nombre?.toUpperCase() ?: ''}
                        <br/> Provincia: ${pre?.estacion?.provincia?.nombre} </td>
                </tr>
                <g:each in="${coordenadas}" var="coor">
                    <tr>
                        <td>${coor?.coordenadasX}</td>
                        <td>${coor?.coordenadasY}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

        <g:if test="${especialista?.consultora}">
            <div class="col-md-12" style="margin-top: -20px">
                <table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%">
                    <thead >
                    <tr>
                        <th class="back" width="85px">Nombre de la Compañia Consultora Ambiental</th>
                        <th class="back" width="100px">Representante Legal</th>
                        <th class="back" width="70px">Registro de la Compañia Consultora Ambiental</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>${especialista?.consultora?.nombre}</td>
                        <td>${especialista?.consultora?.administrador}</td>
                        <g:set var="reg" value="${especialista?.consultora?.registro}"/>
                        <td>MAE: ${reg?.split("_")[0]} <br/> DPA: ${reg?.split("_")[1]}</td>
                    </tr>
                    <tr>
                        <td>Dirección</td>
                        <td colspan="2">${especialista?.consultora?.direccion}</td>
                    </tr>
                    <tr>
                        <td>RUC</td>
                        <td colspan="2">${especialista?.consultora?.ruc}</td>
                    </tr>
                    <tr>
                        <td>Teléfono</td>
                        <td colspan="2">${especialista?.consultora?.telefono}</td>
                    </tr>
                    <tr>
                        <td>Correo electrónico</td>
                        <td colspan="2">${especialista?.consultora?.mail}</td>
                    </tr>
                    <tr>
                        <td>Página web</td>
                        <td colspan="2"> <a href=http://${especialista?.consultora?.pagina}>${especialista?.consultora?.pagina}</a>  </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </g:if>
        <g:else>

          </g:else>

        <div class="col-md-12" style="margin-top: -20px">
            <table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%">
                <thead >
                <tr>
                    <th class="back" width="115px">Cargo</th>
                    <th class="back" width="100px">Equipo Técnico</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Coordinación del Proyecto</td>
                    <td>${(coordinador?.titulo ?: '') + " " + (coordinador?.nombre ?: '') + " " + (coordinador?.apellido ?: '')}</td>
                </tr>
                <tr>
                    <td>Especialista Ambiental</td>
                    <td>${(especialista?.titulo  ?: '') + " " + (especialista?.nombre ?: '') + " " + (especialista?.apellido ?: '')}</td>
                </tr>
                <tr>
                    <td>Técnico Biólogo</td>
                    <td>${(biologo?.titulo ?: '') + " " + (biologo?.nombre ?: '') + " " + (biologo?.apellido ?: '')}</td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="col-md-12" style="margin-top: -20px">
            <table class="table table-condensed table-bordered table-striped table-hover" style="width: 100%">
                <thead >
                <tr>
                    <th class="back" width="115px">Plazo de Ejecución del Estudio</th>
                 </tr>
                </thead>
                <tbody>
                <tr>
                    <td>60 días</td>
                </tr>
                </tbody>
            </table>
        </div>

    </div>

</div>


%{--<div class="row" style="margin-bottom: 10px">--}%
    %{--<div class="col-md-2"></div>--}%
<nav>
    <ul class="pager">
        <li>
            <a href="#" id="btnRegresar" class="btn btn-primary ${pre ? '' : 'disabled'}" title="Retornar al paso anterior">
            <i class="fa fa-angle-double-left"></i> Regresar </a>
        </li>

        <a href="#" id="btnImprimir" class="btn btn-default" title="Imprimir la ficha ténica">
            <i class="fa fa-print"></i> Imprimir</a>

        <li>
            <a href="#" id="btnContinuar" class="btn btn-success" title="Objetivos de la auditoría">
                Objetivos <i class="fa fa-angle-double-right"></i>
            </a>
        </li>
    </ul>
</nav>
%{--</div>--}%

%{--<div class="row" style="margin-bottom: 10px">--}%
    %{--<div class="col-md-2"></div>--}%
    %{--<a style="float: left" href="#" id="btnRegresar" class="btn btn-primary ${pre ? '' : 'disabled'}" title="Retornar al paso anterior">--}%
        %{--<i class="fa fa-angle-double-left"></i> Regresar--}%
    %{--</a>--}%
    %{--<div class="col-md-5"></div>--}%

    %{--<a href="#" id="btnImprimir" class="btn btn-primary" title="Imprimir la ficha ténica">--}%
        %{--<i class="fa fa-print"></i> Imprimir--}%
    %{--</a>--}%
%{--</div>--}%

<script type="text/javascript">

    //botón de regreso al paso anterior 3

    $("#btnRegresar").click(function () {
        location.href="${createLink(action: 'crearPaso5')}/" + ${pre?.id};
    });

    //botón continuar al siguiente paso
    $("#btnContinuar").click(function (){
        location.href="${createLink(controller: 'auditoria', action: 'objetivos')}/" + ${pre?.id};
    });

</script>

</body>
</html>