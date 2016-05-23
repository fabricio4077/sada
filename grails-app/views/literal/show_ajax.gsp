
<%@ page import="legal.Literal" %>

<g:if test="${!literalInstance}">
    <elm:notFound elem="Literal" genero="o" />
</g:if>
<g:else>

    <g:if test="${literalInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${literalInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${literalInstance?.identificador}">
        <div class="row">
            <div class="col-md-2 text-info">
                Identificador
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${literalInstance}" field="identificador"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>