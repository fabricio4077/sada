<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 29/05/2016
  Time: 14:24
--%>

<table class="table table-condensed table-bordered table-striped">
<thead>
    <tr>
        <th>Medida Propuesta</th>
        <th>Indicadores</th>
        <th>Medio de Verificación</th>
        <th>Plazo</th>
    </tr>
</thead>
    <tbody>
    <tr>
        <td>${medida?.descripcion}</td>
        <td>${medida?.indicadores}</td>
        <td>${medida?.verificacion}</td>
        <td>${medida?.plazo}</td>
    </tr>
    </tbody>
</table>