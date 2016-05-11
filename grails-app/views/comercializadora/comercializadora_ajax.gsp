<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 13/04/2016
  Time: 21:43
--%>

<g:select id="comercializadora" name="comercializadora.id" from="${estacion.Comercializadora.list([sort: 'nombre'])}"
optionKey="id" optionValue="nombre" required=""
value="${estacion?.comercializadora?.id}" class="many-to-one form-control required" noSelection="[0:'Seleccione...']"/>