
<%@ page import="plan.AspectoAmbiental" %>

<g:if test="${!aspectoAmbientalInstance}">
    <elm:notFound elem="AspectoAmbiental" genero="o" />
</g:if>
<g:else>

    <g:if test="${aspectoAmbientalInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${aspectoAmbientalInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${aspectoAmbientalInstance?.impacto}">
        <div class="row">
            <div class="col-md-2 text-info">
                Impacto
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${aspectoAmbientalInstance}" field="impacto"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${aspectoAmbientalInstance?.planManejoAmbiental}">
        <div class="row">
            <div class="col-md-2 text-info">
                Plan Manejo Ambiental
            </div>
            
            <div class="col-md-3">
                ${aspectoAmbientalInstance?.planManejoAmbiental?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
</g:else>