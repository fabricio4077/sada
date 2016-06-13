
<%@ page import="complemento.Alcance" %>

<g:if test="${!alcanceInstance}">
    <elm:notFound elem="Alcance" genero="o" />
</g:if>
<g:else>

    <g:if test="${alcanceInstance?.auditoria}">
        <div class="row">
            <div class="col-md-2 text-info">
                Auditoria
            </div>
            
            <div class="col-md-3">
                ${alcanceInstance?.auditoria?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${alcanceInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${alcanceInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>