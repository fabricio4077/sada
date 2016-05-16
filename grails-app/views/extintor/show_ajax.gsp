
<%@ page import="estacion.Extintor" %>

<g:if test="${!extintorInstance}">
    <elm:notFound elem="Extintor" genero="o" />
</g:if>
<g:else>

    <g:if test="${extintorInstance?.tipo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Tipo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${extintorInstance}" field="tipo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${extintorInstance?.capacidad}">
        <div class="row">
            <div class="col-md-2 text-info">
                Capacidad
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${extintorInstance}" field="capacidad"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${extintorInstance?.ares}">
        <div class="row">
            <div class="col-md-2 text-info">
                Ares
            </div>
            
            <div class="col-md-3">
                ${extintorInstance?.ares?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
</g:else>