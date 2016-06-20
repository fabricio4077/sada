package reportes

import Seguridad.Persona
import auditoria.Preauditoria
import consultor.Asignados
import estacion.Canton
import estacion.Coordenadas

class ReportesController {

    def index() {}

    def imprimirUI () {

    }


    def fichaTecnicaPdf () {

        def pre = Preauditoria.get(params.id)
        def coordenadas = Coordenadas.findAllByEstacion(pre?.estacion)
        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def coordinador = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Coordinador"));
        def biologo = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Biologo"));
        def canton = Canton.get(pre?.estacion?.canton)
        return [pre: pre, coordenadas: coordenadas, especialista: especialista?.persona, coordinador: coordinador?.persona, biologo: biologo?.persona, canton: canton]

    }
}
