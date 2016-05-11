<%@ page import="Seguridad.Prfl" %>

<g:if test="${!prflInstance}">
    <elm:notFound elem="Prfl" genero="o"/>
</g:if>
<g:else>

    <g:if test="${prflInstance?.nombre}">
        <div class="row">
            <div class="col-md-3 text-info">
                Nombre
            </div>

            <div class="col-md-6">
                <g:fieldValue bean="${prflInstance}" field="nombre"/>
            </div>

        </div>
    </g:if>

    <g:if test="${prflInstance?.descripcion}">
        <div class="row">
            <div class="col-md-3 text-info">
                Descripción
            </div>

            <div class="col-md-6">
                <g:fieldValue bean="${prflInstance}" field="descripcion"/>
            </div>

        </div>
    </g:if>
</g:else>