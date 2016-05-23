<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 22/05/2016
  Time: 18:56
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mainSada">
    <title>Evaluación Ambiental</title>
</head>

<body>



<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title" style="text-align: center"> <i class="fa fa-leaf"></i> Evaluación Ambiental</h3>
    </div>
    <div class="well" style="text-align: center">
        <div class="row">
            <div class="col-md-5 negrilla control-label">Para esta auditoría se está usando las leyes en el Marco Legal: </div>
            <div class="col-md-4">
                <g:textField name="marco_usado" value="${auditoria?.marcoLegal?.descripcion}" readonly="true" class="form-control"/>
           </div>
            <a href="#" id="btnCambiarMarco" class="btn btn-warning" title="">
                Cambiar Marco Legal <i class="fa fa-close"></i>
            </a>

        </div>
    </div>


    <table class="table table-condensed table-bordered table-striped">
        <thead>
        <tr>
            <th style="width: 3%">#</th>
            <th style="width: 10%">Obligación Ambiental</th>
            <th style="width: 31%">Descripción</th>
            <th style="width: 16%">Calificación</th>
            <th style="width: 15%">Hallazgo</th>
            <th style="width: 10%">Evidencia/Anexo</th>
            <th style="width: 1%"></th>
        </tr>
        </thead>
    </table>

    <div class="row-fluid"  style="width: 99.7%;height: 500px;overflow-y: auto;float: right;">
        <div class="span12">
            <div style="width: 1120px; height: 500px;">
                <table class="table table-condensed table-bordered table-striped">
                    <tbody>
                    <g:each in="${leyes}" var="ley" status="j">
                        <tr>
                            <td style="width: 2%">${j+1}</td>
                            <td style="width: 10%; font-size: smaller">${ley?.norma?.nombre + " - Art. N° " + ley?.articulo?.numero}</td>
                            <td style="width: 30%; font-size: smaller">${ley?.literal ? (ley?.literal?.identificador + ")  " + ley?.literal?.descripcion) : ley?.articulo?.descripcion}</td>
                            <td style="width: 15%">

                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        Calificar <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <g:each in="${evaluacion.Calificacion.list([sort: 'nombre', order: 'asc'])}" var="cal">
                                            <li style="background-color: ${cal?.tipo}"><a href="#" class="btnCalificacion" data-id="${cal?.id}" data-ley="${ley?.id}" title="${cal?.nombre}">${cal?.sigla}</a></li>
                                        </g:each>
                                    </ul>
                                </div>
                                <div class="divCalificacion">

                                </div>

                            </td>
                            <td style="width: 15%"></td>
                            <td style="width: 10%"></td>
                        </tr>
                    </g:each>

                    </tbody>
                </table>

            </div>
         </div>
     </div>





</div>

<script type="text/javascript">
    $(".btnCalificacion").click(function () {

        console.log($(this).data("id"))
        console.log($(this).data("ley"))

    })


</script>


</body>
</html>