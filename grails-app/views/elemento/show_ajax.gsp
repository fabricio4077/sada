
<%@ page import="situacion.Elemento" %>

<g:if test="${!elementoInstance}">
    <elm:notFound elem="Elemento" genero="o" />
</g:if>
<g:else>

    <g:if test="${elementoInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${elementoInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${elementoInstance?.unidad}">
        <div class="row">
            <div class="col-md-2 text-info">
                Unidad
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${elementoInstance}" field="unidad"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>