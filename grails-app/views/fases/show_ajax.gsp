
<%@ page import="metodologia.Fases" %>

<g:if test="${!fasesInstance}">
    <elm:notFound elem="Fases" genero="o" />
</g:if>
<g:else>

    <g:if test="${fasesInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fasesInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fasesInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fasesInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${fasesInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Codigo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${fasesInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>