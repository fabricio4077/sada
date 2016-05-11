<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 01/05/2016
  Time: 21:27
--%>

%{--<g:textField name="canton_name" id="canton" class="form-control" value="${estacion?.canton}"/>--}%
<g:select name="canton_name" id="canton" from="${cantones}" optionValue="nombre" optionKey="id"
          class="form-control" value="${estacion?.canton}" noSelection="[null: 'Seleccione...']"/>
