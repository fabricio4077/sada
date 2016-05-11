
<%@ page import="legal.Articulo" %>

<g:if test="${!articuloInstance}">
    <elm:notFound elem="Articulo" genero="o" />
</g:if>
<g:else>

    <g:if test="${articuloInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${articuloInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${articuloInstance?.norma}">
        <div class="row">
            <div class="col-md-2 text-info">
                Norma
            </div>
            
            <div class="col-md-3">
                ${articuloInstance?.norma?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${articuloInstance?.numero}">
        <div class="row">
            <div class="col-md-2 text-info">
                Numero
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${articuloInstance}" field="numero"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>