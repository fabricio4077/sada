
<%@ page import="Seguridad.Persona" %>

<g:if test="${!personaInstance}">
    <elm:notFound elem="Persona" genero="o" />
</g:if>
<g:else>

    <g:if test="${personaInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${personaInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.apellido}">
        <div class="row">
            <div class="col-md-2 text-info">
                Apellido
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${personaInstance}" field="apellido"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.telefono}">
        <div class="row">
            <div class="col-md-2 text-info">
                Teléfono
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${personaInstance}" field="telefono"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.mail}">
        <div class="row">
            <div class="col-md-2 text-info">
                Mail
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${personaInstance}" field="mail"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${personaInstance?.login}">
        <div class="row">
            <div class="col-md-2 text-info">
                Login
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${personaInstance}" field="login"/>
            </div>
            
        </div>
    </g:if>
    
    %{--<g:if test="${personaInstance?.password}">--}%
        %{--<div class="row">--}%
            %{--<div class="col-md-2 text-info">--}%
                %{--Password--}%
            %{--</div>--}%
            %{----}%
            %{--<div class="col-md-3">--}%
                %{--<g:fieldValue bean="${personaInstance}" field="password"/>--}%
            %{--</div>--}%
            %{----}%
        %{--</div>--}%
    %{--</g:if>--}%
    
    <g:if test="${personaInstance?.activo}">
        <div class="row">
            <div class="col-md-2 text-info">
                Activo
            </div>
            
            <div class="col-md-3">
                <g:if test="${personaInstance?.activo == 1}">
                    Activo
                </g:if>
                <g:else>
                    No activo
                </g:else>
            </div>
            
        </div>
    </g:if>
    
</g:else>