
<%@ page import="estacion.Comercializadora" %>

<g:if test="${!comercializadoraInstance}">
    <elm:notFound elem="Comercializadora" genero="o" />
</g:if>
<g:else>

    <g:if test="${comercializadoraInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${comercializadoraInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${comercializadoraInstance?.direccion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Dirección
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${comercializadoraInstance}" field="direccion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${comercializadoraInstance?.representante}">
        <div class="row">
            <div class="col-md-2 text-info">
                Representante
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${comercializadoraInstance}" field="representante"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${comercializadoraInstance?.mail}">
        <div class="row">
            <div class="col-md-2 text-info">
                Mail
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${comercializadoraInstance}" field="mail"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${comercializadoraInstance?.telefono}">
        <div class="row">
            <div class="col-md-2 text-info">
                Teléfono
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${comercializadoraInstance}" field="telefono"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>