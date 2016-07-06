
<%@ page import="auditoria.Preauditoria" %>

<g:if test="${!preauditoriaInstance}">
    <elm:notFound elem="Preauditoria" genero="o" />
</g:if>
<g:else>


    <g:if test="${preauditoriaInstance?.estacion}">
        <div class="row">
            <div class="col-md-3 text-info">
                Estación:
            </div>
            
            <div class="col-md-5">
                ${preauditoriaInstance?.estacion?.nombre?.encodeAsHTML()}
            </div>
            
        </div>
    </g:if>

    <g:if test="${preauditoriaInstance?.tipo}">
        <div class="row">
            <div class="col-md-3 text-info">
                Tipo:
            </div>

            <div class="col-md-5">
                ${preauditoriaInstance?.tipo?.descripcion?.toUpperCase()}
            </div>

        </div>
    </g:if>

    <g:if test="${preauditoriaInstance?.periodo}">
        <div class="row">
            <div class="col-md-3 text-info">
                Período:
            </div>
            
            <div class="col-md-5">
                ${preauditoriaInstance?.periodo?.inicio?.format("yyyy") + " - " + preauditoriaInstance?.periodo?.fin?.format("yyyy")}
            </div>
            
        </div>
    </g:if>

    <div class="row">
        <div class="col-md-3 text-info">
            Usuario creador:
        </div>

        <div class="col-md-5">
            ${preauditoriaInstance?.creador?.split("_")[0] + " (" + preauditoriaInstance?.creador?.split("_")[1] + ")"}
        </div>

    </div>

</g:else>