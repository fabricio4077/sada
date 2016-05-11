
<%@ page import="estacion.Coordenadas" %>

<g:if test="${!coordenadasInstance}">
    <elm:notFound elem="Coordenadas" genero="o" />
</g:if>
<g:else>

    <g:if test="${coordenadasInstance?.coordenadasX}">
        <div class="row">
            <div class="col-md-2 text-info">
                Coordenadas X
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${coordenadasInstance}" field="coordenadasX"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${coordenadasInstance?.coordenadasY}">
        <div class="row">
            <div class="col-md-2 text-info">
                Coordenadas Y
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${coordenadasInstance}" field="coordenadasY"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${coordenadasInstance?.estacion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Estacion
            </div>
            
            <div class="col-md-3">
                ${coordenadasInstance?.estacion?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
</g:else>