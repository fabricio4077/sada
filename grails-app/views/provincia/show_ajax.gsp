
<%@ page import="estacion.Provincia" %>

<g:if test="${!provinciaInstance}">
    <elm:notFound elem="Provincia" genero="o" />
</g:if>
<g:else>

    <g:if test="${provinciaInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${provinciaInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${provinciaInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Código
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${provinciaInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>