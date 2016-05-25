
<%@ page import="evaluacion.PlanAccion" %>

<g:if test="${!planAccionInstance}">
    <elm:notFound elem="PlanAccion" genero="o" />
</g:if>
<g:else>

    <g:if test="${planAccionInstance?.actividad}">
        <div class="row">
            <div class="col-md-2 text-info">
                Actividad
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${planAccionInstance}" field="actividad"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${planAccionInstance?.responsable}">
        <div class="row">
            <div class="col-md-2 text-info">
                Responsable
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${planAccionInstance}" field="responsable"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${planAccionInstance?.estado}">
        <div class="row">
            <div class="col-md-2 text-info">
                Estado
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${planAccionInstance}" field="estado"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${planAccionInstance?.avance}">
        <div class="row">
            <div class="col-md-2 text-info">
                Avance
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${planAccionInstance}" field="avance"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${planAccionInstance?.costo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Costo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${planAccionInstance}" field="costo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${planAccionInstance?.verficacion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Verficacion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${planAccionInstance}" field="verficacion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${planAccionInstance?.hallazgo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Hallazgo
            </div>
            
            <div class="col-md-3">
                ${planAccionInstance?.hallazgo?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${planAccionInstance?.plazo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Plazo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${planAccionInstance}" field="plazo"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>