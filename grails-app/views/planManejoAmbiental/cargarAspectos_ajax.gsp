<%--
  Created by IntelliJ IDEA.
  User: Fabricio
  Date: 28/05/2016
  Time: 20:42
--%>

<g:select name="aspecto_name" class="form-control" from="${listaAspectos}"
          id="aspecto" optionValue="${{it.descripcion + " - " + it.impacto}}"
          optionKey="id" noSelection="[null: 'Seleccione...']"/>