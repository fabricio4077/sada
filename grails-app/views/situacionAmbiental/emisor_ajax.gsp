<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 12/06/2016
  Time: 19:38
--%>

<g:select name="emisor_name" id="emisorSituacion"
          from="${diferentes}"
          class="form-control" optionKey="id" optionValue="nombre" noSelection="[null: 'Seleccione...']"/>