<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 25/05/2016
  Time: 22:14
--%>

<div class="row-fluid"  style="width: 99.7%;height: 300px;overflow-y: auto;float: right;">
    <div class="span12">
        %{--<div style="width: 500px; height: 500px;">--}%
            <table class="table table-condensed table-bordered table-striped">
            <tbody>
            <g:each in="${lista}" var="lis" >
                <tr>
                    <td style="width: 40%">${lis?.actividad}</td>
                    <td style="width: 20%">${lis?.responsable}</td>
                    <td style="width: 7%">${lis?.plazo} Días</td>
                    <td style="width: 7%">${lis?.costo}</td>
                    <td style="width: 10%">
                        <a href="#" id="btnSeleccionarPlan" class="btn btn-success" title="">
                            <i class="fa fa-check"></i> Seleccionar Plan
                        </a>
                    </td>
                </tr>
            </g:each>
            </tbody>
            </table>
        %{--</div>--}%
    </div>
</div>