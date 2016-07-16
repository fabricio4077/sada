
<%@ page import="plan.PlanManejoAmbiental" %>

<g:if test="${!planManejoAmbientalInstance}">
    <elm:notFound elem="PlanManejoAmbiental" genero="o" />
</g:if>
<g:else>

    <g:if test="${planManejoAmbientalInstance?.codigo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Código
            </div>
            
            <div class="col-md-6">
                <g:fieldValue bean="${planManejoAmbientalInstance}" field="codigo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${planManejoAmbientalInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>
            
            <div class="col-md-8">
                <g:fieldValue bean="${planManejoAmbientalInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${planManejoAmbientalInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            
            <div class="col-md-8">
                <g:fieldValue bean="${planManejoAmbientalInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${planManejoAmbientalInstance?.objetivo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Objetivo
            </div>
            
            <div class="col-md-8">
                <g:fieldValue bean="${planManejoAmbientalInstance}" field="objetivo"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>