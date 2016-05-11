<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 10/04/2016
  Time: 21:44
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Parámetros del Sistema</title>

    <style type="text/css">
        .margen{
            margin-top: 10px;
        }
    </style>


</head>

<body>

<div class="row">
    <div class="col-md-6">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title">Parámetros del Sistema</h3>
            </div>

            <div class="panel-body">
                <ul class="fa-ul">

                    <li class="margen">
                        <g:link controller="prfl" class="over" action="list">
                            <i class="fa fa-credit-card"> Perfiles de usuario </i>
                        </g:link>
                        <div class="descripcion hidden">
                            <h4>Perfiles</h4>
                            <p>Administración de los perfiles, los cuales se asignan a los usuarios para acceder al sistema SADA.
                            </p>
                        </div>
                    </li>

                    <li class="margen">
                        <g:link controller="consultora" class="over" action="list">
                            <i class="fa fa-globe"> Consultora ambiental </i>
                        </g:link>
                        <div class="descripcion hidden">
                            <h4>Consultora</h4>

                            <p>Administración de la Consultora ambiental a la cual pertenece el usuario del sistema o el personal que realizará la auditoría.
                              </p>
                        </div>
                    </li>
                    <li class="margen">
                            <g:link controller="provincia" class="over" action="list">
                                <i class="fa fa-map-marker"> Provincia </i>
                            </g:link>
                        <div class="descripcion hidden">
                            <h4>Provincia</h4>

                            <p>Administración de la provincia en la que se encuentra ubicada la estación de servicio.
                            </p>
                        </div>
                    </li>
                    <li class="margen">
                        <g:link controller="actividad" class="over" action="list">
                            <i class="fa fa-tasks"> Actividades</i>
                        </g:link>
                        <div class="descripcion hidden">
                            <h4>Actividades</h4>

                            <p>Administración de las actividades a realizarse durante el tiempo de desarrollo de una auditoría.</p>
                        </div>
                    </li>
                    <li class="margen">
                        <g:link controller="tipoNorma" class="over" action="list">
                            <i class="fa fa-file"> Tipo de Norma Legal</i>
                        </g:link>
                        <div class="descripcion hidden">
                            <h4>Tipo de Norma Legal</h4>
                            <p>
                                Administración de los diferentes tipos a los cuales puede pertenecer una Norma Legal
                            </p>
                        </div>
                    </li>
                    <li class="margen">
                        <g:link controller="norma" class="over" action="list">
                            <i class="fa fa-file-text"> Norma Legal</i>
                        </g:link>
                        <div class="descripcion hidden">
                            <h4>Norma Legal</h4>

                            <p>Administración de las Normas Legales pertenecientes a la Ley Ecuatoriana.</p>
                        </div>
                    </li>
                    <li class="margen">
                        <g:link controller="objetivo" class="over" action="list">
                            <i class="fa fa-check-circle-o"> Objetivos de la auditoría</i>
                        </g:link>
                        <div class="descripcion hidden">
                            <h4>Objetivos </h4>

                            <p>Administración de los objetivos a cumplirse en una auditoría ambiental.</p>
                        </div>
                    </li>
                    <li class="margen">
                        <g:link controller="area" class="over" action="list">
                            <i class="fa fa-automobile"> Instalaciones de la estación de servicio</i>
                        </g:link>
                        <div class="descripcion hidden">
                            <h4>Instalaciones </h4>

                            <p>Administración de las instalaciones pertenecientes a las estaciones de servicio</p>
                        </div>
                    </li>
                </ul>
            </div>

        </div>

    </div>

    <div class="col-md-4">
        <div class="panel panel-info right hidden">
            <div class="panel-heading">
                <h3 class="panel-title"></h3>
            </div>

            <div class="panel-body"> </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        $(".over").hover(function () {
            var $h4 = $(this).siblings(".descripcion").find("h4");
            var $cont = $(this).siblings(".descripcion").find("p");
            $(".right").removeClass("hidden").find(".panel-title").text($h4.text()).end().find(".panel-body").html($cont.html());
        }, function () {
            $(".right").addClass("hidden");
        });
    });
</script>

</body>
</html>