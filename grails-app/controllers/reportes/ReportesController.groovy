package reportes

import Seguridad.Persona
import auditoria.Preauditoria
import consultor.Asignados
import estacion.Canton
import estacion.Coordenadas

class ReportesController {

    def index() {}

    def imprimirUI () {
        def pre = Preauditoria.get(params.id)
        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def arr = ['1','2', '3','4','5','6','7','8','9','10','11','12','13','14','15']
        return [pre:pre, especialista: especialista, arr: arr]
    }


    def fichaTecnicaPdf () {

//        println("params ficha pdf " + params)

        def pre = Preauditoria.get(params.id)
        def coordenadas = Coordenadas.findAllByEstacion(pre?.estacion)
        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def coordinador = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Coordinador"));
        def biologo = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Biologo"));
        def canton = Canton.get(pre?.estacion?.canton)
        return [pre: pre, coordenadas: coordenadas, especialista: especialista?.persona,
                coordinador: coordinador?.persona, biologo: biologo?.persona,
                canton: canton, orden: params.orden]

    }
}
