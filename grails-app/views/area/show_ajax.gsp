
<%@ page import="estacion.Area" %>

<g:if test="${!areaInstance}">
    <elm:notFound elem="Area" genero="o" />
</g:if>
<g:else>

    <g:if test="${areaInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${areaInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${areaInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${areaInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${areaInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Codigo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${areaInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>