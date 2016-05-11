
<%@ page import="legal.TipoNorma" %>

<g:if test="${!tipoNormaInstance}">
    <elm:notFound elem="TipoNorma" genero="o" />
</g:if>
<g:else>

    <g:if test="${tipoNormaInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${tipoNormaInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${tipoNormaInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Codigo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${tipoNormaInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>