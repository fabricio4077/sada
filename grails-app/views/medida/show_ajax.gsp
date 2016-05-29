
<%@ page import="plan.Medida" %>

<g:if test="${!medidaInstance}">
    <elm:notFound elem="Medida" genero="o" />
</g:if>
<g:else>

    <g:if test="${medidaInstance?.plazo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Plazo
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${medidaInstance}" field="plazo"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${medidaInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${medidaInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${medidaInstance?.indicadores}">
        <div class="row">
            <div class="col-md-2 text-info">
                Indicadores
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${medidaInstance}" field="indicadores"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${medidaInstance?.verificacion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Verificacion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${medidaInstance}" field="verificacion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>