
<%@ page import="consultor.Asignados" %>

<g:if test="${!asignadosInstance}">
    <elm:notFound elem="Asignados" genero="o" />
</g:if>
<g:else>

    <g:if test="${asignadosInstance?.persona}">
        <div class="row">
            <div class="col-md-2 text-info">
                Persona
            </div>
            
            <div class="col-md-3">
                ${asignadosInstance?.persona?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${asignadosInstance?.preauditoria}">
        <div class="row">
            <div class="col-md-2 text-info">
                Preauditoria
            </div>
            
            <div class="col-md-3">
                ${asignadosInstance?.preauditoria?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
</g:else>