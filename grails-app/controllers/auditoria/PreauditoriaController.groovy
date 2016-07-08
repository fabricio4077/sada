package auditoria

import Seguridad.Persona
import complemento.ActiAudi
import consultor.Asignados
import estacion.Coordenadas
import estacion.Estacion
import legal.TipoNorma
import objetivo.ObjetivosAuditoria
import tipo.Periodo
import tipo.Tipo


class PreauditoriaController extends Seguridad.Shield {

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def getLista(params, all) {
        params = params.clone()
        if (all) {
            params.remove("offset")
            params.remove("max")
        }
        def lista
        if (params.search) {
            def c = Preauditoria.createCriteria()
            lista = c.list(params) {
//                or {
//                    /* TODO: cambiar aqui segun sea necesario */
//                    ilike("tipo", "%" + params.search + "%")
//                    ilike("descripcion", "%" + params.search + "%")
//                }


                or{
                    estacion{
                        ilike("nombre", "%" + params.search + "%")
                    }

                    tipo{
                        ilike("descripcion", "%" + params.search + "%")
                    }
                }
//
//                estacion{
//                    ilike("nombre", "%" + params.search + "%")
//                }


            }
        } else {
            lista = Preauditoria.list(params)
        }

        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def preauditoriaInstanceList = getLista(params, false)
        def preauditoriaInstanceCount = getLista(params, true).size()
        if(preauditoriaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        preauditoriaInstanceList = getLista(params, false)

        def creador = session.usuario.apellido + "_" + session.usuario.login
        def listaAuditorias = Preauditoria.findAllByCreadorAndEstado(creador, 1, [sort:"creador", order:'desc'])

//        println("creadores " + listaAuditorias.creador)

        //revisar avance

        def porcentaje
        def obau
        def audi
        listaAuditorias.each {li->
            porcentaje = 0
            if(li.estacion){
                porcentaje += 5
            }
            audi = Auditoria.findByPreauditoria(li)
            obau = ObjetivosAuditoria.findAllByAuditoria(audi)

            obau.each {ob->
                if(ob?.objetivo?.identificador == 'Evaluar Áreas de la Estación' && ob?.completado == 1){
                    porcentaje += 15
                }
                if(ob?.objetivo?.identificador == 'Evaluación Ambiental' && ob?.completado == 1){
                    porcentaje += 35
                }
                if(ob?.objetivo?.identificador == 'Plan de Acción' && ob?.completado == 1){
                    porcentaje += 15
                }
                if(ob?.objetivo?.identificador == 'Situación Ambiental' && ob?.completado == 1){
                    porcentaje += 10
                }
                if(ob?.objetivo?.identificador == 'PMA' && ob?.completado == 1){
                    porcentaje += 10
                }
                if(ob?.objetivo?.identificador == 'Cronograma' && ob?.completado == 1){
                    porcentaje += 5
                }
                if(ob?.objetivo?.identificador == 'Recomendaciones' && ob?.completado == 1){
                    porcentaje += 5
                }
            }

            li.avance = porcentaje
            try{
                li.save(flush: true)
            }catch (e){
                println("error al asignar el porcentaje de la auditoria " + li.errors)
            }
        }

        return [preauditoriaInstanceList: preauditoriaInstanceList, preauditoriaInstanceCount: preauditoriaInstanceCount, params: params,
                lista: listaAuditorias]
    } //list


    def listaGeneral () {

        if (session.perfil.codigo == 'ADMI') {
            params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
            def preauditoriaInstanceList = getLista(params, false)
            def preauditoriaInstanceCount = getLista(params, true).size()
            if(preauditoriaInstanceList.size() == 0 && params.offset && params.max) {
                params.offset = params.offset - params.max
            }
            preauditoriaInstanceList = getLista(params, false)

            def listaGeneral = Preauditoria.findAllByEstado(1, [sort: 'creador', order: 'asc'])

//        return [preauditoriaInstanceList: preauditoriaInstanceList, preauditoriaInstanceCount: preauditoriaInstanceCount, params: params]
            return [preauditoriaInstanceList: listaGeneral, preauditoriaInstanceCount: preauditoriaInstanceCount, params: params]
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su perfil."
            response.sendError(403)
        }


    }

    def show_ajax() {
        if(params.id) {
            def preauditoriaInstance = Preauditoria.get(params.id)
            if(!preauditoriaInstance) {
                notFound_ajax()
                return
            }
            return [preauditoriaInstance: preauditoriaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def preauditoriaInstance = new Preauditoria(params)
        if(params.id) {
            preauditoriaInstance = Preauditoria.get(params.id)
            if(!preauditoriaInstance) {
                notFound_ajax()
                return
            }
        }
        return [preauditoriaInstance: preauditoriaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def preauditoriaInstance = new Preauditoria()
        if(params.id) {
            preauditoriaInstance = Preauditoria.get(params.id)
            if(!preauditoriaInstance) {
                notFound_ajax()
                return
            }
        } //update
        preauditoriaInstance.properties = params
        if(!preauditoriaInstance.save(flush:true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Preauditoria."
            msg += renderErrors(bean: preauditoriaInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Preauditoria exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if(params.id) {
            def preauditoriaInstance = Preauditoria.get(params.id)
            if(preauditoriaInstance) {
                try {
                    preauditoriaInstance.delete(flush:true)
                    render "OK_Eliminación de Preauditoria exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Preauditoria."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Preauditoria."
    } //notFound para ajax

    def opciones_ajax () {

    }

    def crearAuditoria () {

        def creador = session.usuario.apellido + "_" + session.usuario.login
        def paso1 = Preauditoria.get(params.id)

        if(paso1){
            if (creador == paso1?.creador) {
                return [pre: paso1]
            } else {
                flash.message = "Está tratando de ingresar a un pantalla restringida para su usuario."
                response.sendError(403)
            }
        }

    }

    def guardarPaso1_ajax () {

        println("params paso 1 " + params)

        def creador = session.usuario.apellido + "_" + session.usuario.login
        def tipo = Tipo.get(params.tipo)
        def periodo = Periodo.get(params.periodo)

        def paso

        if(params.id){
            paso = Preauditoria.get(params.id)
            paso.tipo = tipo
            paso.periodo = periodo
            try{
                paso.save(flush: true)
                render "ok_${paso?.id}"
            }catch(e){
                render "no_Error al guardar el tipo y el período"
                println("error al guardar el paso 1 - crearAuditoria");
            }
        }else{
            paso = new Preauditoria()
            paso.tipo = tipo
            paso.periodo = periodo
            paso.fechaCreacion = new Date()
            paso.creador = creador
            paso.estado = 1
            try{
                paso.save(flush: true)
                render "ok_${paso?.id}"
            }catch(e){
                render "no_Error al guardar el tipo y el período"
                println("error al guardar el paso 1 - crearAuditoria");
            }
        }
    }

    def crearPaso2 () {
        def creador = session.usuario.apellido + "_" + session.usuario.login
        def paso2 = Preauditoria.get(params.id)

        if (creador == paso2?.creador) {
            def estacion
            if(paso2?.estacion){
                estacion = paso2.estacion?.id
            }else{
                estacion = '0'
            }

            return [pre: paso2, idEstacion: estacion]
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su usuario."
            response.sendError(403)
        }



    }

    def crearPaso3 () {

        def creador = session.usuario.apellido + "_" + session.usuario.login
        def pre = Preauditoria.get(params.id)
        def estacion = params.estacion

        if (creador == pre?.creador) {
            def coordenadas = Coordenadas.findAllByEstacion(pre?.estacion)
            return [pre: pre, estacion: estacion, coor: coordenadas]
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su usuario."
            response.sendError(403)
        }
    }


//    def prueba () {
//        /// Latitud
////        String ALLLATSTR = "254733N"
//        String ALLLATSTR = "818649S"
//        String DIRLat = ALLLATSTR[6..-1] // se espera N o S
//        String latStr = ALLLATSTR[0..-2] // forma numerica
//        String DEGLat = latStr[0..-5] // grados
//        String MINLat = latStr[2..-3] // minutos
//        String SECLat = latStr[4..-1] // segundos
//
//        def signoLat = (DIRLat.equals("S")?-1:1) // definir signo de latitud
//        def alat = Math.abs( Math.round(DEGLat.toInteger() * 1000000));
//        def latitudem = Math.abs(Math.round(MINLat.toInteger() * 1000000)/1000000)
//        def absmlat = Math.abs(Math.round(latitudem * 1000000));
//        def latitudes = Math.abs(Math.round(SECLat.toInteger() * 1000000)/1000000)
//        def absslat = Math.abs(Math.round(latitudes * 1000000))
//        def latitude = Math.round(alat + (absmlat/60) + (absslat/3600) ) * signoLat/1000000;
//
//////Longitud
////        String ALLLONSTR = "0801710W"
//        String ALLLONSTR = "0038290E"
//        String DIRLon = ALLLONSTR[7..-1] // Se espera W o E
//        String lonStr = ALLLONSTR[0..-2] // forma numerica
//        String DEGLon = lonStr[0..-5] //grados
//        String MINLon = lonStr[3..-3] // minutos
//        String SECLon = lonStr[5..-1] //segundos
//
//        def signoLon = (DIRLon.equals("W")?-1:1)  // definir signo de longitud
//        def alon = Math.abs( Math.round(DEGLon.toInteger() * 1000000));
//        def longitudem = Math.abs(Math.round(MINLon.toInteger() * 1000000)/1000000);
//        def absmlon = Math.abs(Math.round(longitudem * 1000000));
//        def longitudes = Math.abs(Math.round(SECLon.toInteger() * 1000000)/1000000);
//        def absslon = Math.abs(Math.round(longitudes * 1000000));
//        def longitude = Math.round(alon + (absmlon/60) + (absslon/3600) ) * signoLon/1000000;
//
//
//        println("Lat: "+latitude+" Lon: "+longitude)
//    }

    def prueba () {
        BigDecimal a = new BigDecimal("6378388.0");
        BigDecimal b = new BigDecimal("6356911.946130");

        BigDecimal e1 = a.pow(2);
        BigDecimal e2 = b.pow(2);
        BigDecimal e3= e1.subtract(e2);
        BigDecimal e4= a.subtract(b);


        double excentricidad=Math.sqrt(e3.doubleValue())/a.doubleValue();
        double excentricidad2=Math.sqrt(e3.doubleValue())/b.doubleValue();
        double exp=Math.pow(Math.sqrt(e3.doubleValue())/b.doubleValue(),2);
        double c=Math.pow(a.doubleValue(),2)/b.doubleValue();


        double logrados= Double.valueOf(jlogrados.getText());
        double lominutos= Double.valueOf(jlominutos.getText());
        double losegundos= Double.valueOf(jlosegundos.getText());


        double lagrados= Double.valueOf(jlagrados.getText());
        double laminutos= Double.valueOf(jlaminutos.getText());
        double lasegundos= Double.valueOf(jlasegundos.getText());

        double lodecimales
        double loradianes

        if(loposicion.equals("W")){
            lodecimales=-1*(logrados+lominutos/60+losegundos/60/60);
            loradianes=lodecimales*Math.PI/180;
        }
        else{
            lodecimales=logrados+lominutos/60+losegundos/60/60;
            loradianes=lodecimales*Math.PI/180;
        }

        if(laposicion.equals("S")){
            ladecimales=-1*(lagrados+laminutos/60+lasegundos/60/60);
            laradianes=ladecimales*Math.PI/180;
        }else{
            ladecimales=lagrados+laminutos/60+lasegundos/60/60;
            laradianes=ladecimales*Math.PI/180;
        }

        int huson=(int)Math.floor((lodecimales/6)+31);
        int meridianohuson=huson*6-183;

        double lambda=loradianes-((meridianohuson*Math.PI)/180);
        double A=Math.cos(laradianes)*Math.sin(lambda);


        BigDecimal e6= new BigDecimal(A);
        BigDecimal uno = new BigDecimal("1");
        BigDecimal e7= uno.subtract(e6);
        BigDecimal e8= uno.add(e6);
        double aux= e8.doubleValue()/e7.doubleValue();
        double xi=0.5*Math.log(aux);



        double ni=(c/(1+exp*Math.pow(Math.pow(Math.cos(laradianes),2),0.5))*0.9996);
        double zeta=(exp/2)*Math.pow(xi,2)*Math.pow(Math.cos(laradianes),2);
        double eta=Math.atan(Math.tan(laradianes)/Math.cos(lambda))-laradianes;
        double a1=Math.sin(2*laradianes);
        double a2=a1*Math.pow(Math.cos(laradianes),2);
        double j2=laradianes+(a1/2);
        double j4=((3*j2)+a2)/4;
        double j6=(5*j4+a2*Math.pow(Math.cos(laradianes),2))/3;
        double alfa=(0.75)*exp;
        double beta=(1.6666666)*Math.pow(alfa,2);
        double gamma=(1.2962962)*Math.pow(alfa,3);
        double bfi=0.9996*c*(laradianes-(alfa*j2)+(beta*j4)-(gamma*j6));

        X=xi*ni*(1+zeta/3)+500000;

        if(laposicion.equals("S")){
            Y=eta*ni*(1+zeta)+bfi+10000000;
        }
        else{
            Y=eta*ni*(1+zeta)+bfi;
        }
    }


    def transformarUTM () {

        def fi, ni, mc, se, sd, a, a1, a2, j2, j4, j6, alfa, beta, ganma, bfi, b, zeta, xi, eta, sxi, delta, tau, sexas, radiantes;

        fi= UtmY / (6366197.724*0.9996);
        ni= (6399593.626/Power((1+0.006739497*sqr(cos(fi))), 0.5))*0.9996;
        mc= (6*zona-183);
        se= UtmY;
        a= (UtmX-500000)/ni;
        a1= sin(2*fi);
        a2= a1*Power((COS(fi)), 2);
        j2= fi+(a1/2);
        j4= (3*j2+a2)/4;
        j6= (5*j4+a2*Power((COS(fi)),2))/3;
        alfa= (3/4)*0.006739497;
        beta= (5/3)*Power(alfa, 2);
        ganma= (35/27)*Power(alfa, 3);
        bfi= 0.9996*6399593.626*(fi-(alfa*j2)+(beta*j4)-(ganma*j6));
        b= (se-bfi)/ni;
        zeta= ((0.006739497*Power(a,2))/2)*Power(COS(fi),2);
        xi= a*(1-(zeta/3));
        eta= b*(1-zeta)+fi;
        sxi= (EXP(xi)-EXP(-xi))/2;
        delta= arcTAN(sxi/COS(eta));
        sd= +(delta/PI)*180+mc;
        tau= ARCTAN(COS(delta)*TAN(eta));
        radiantes= fi+(1+0.006739497*Power(COS(fi),2)-(3/2)*0.006739497*sin(fi)*COS(fi)*(tau-fi))*(tau-fi);
        sexas= +(radiantes/PI)*180;
    }


    def guardarPaso2_ajax () {

//        println("params paso 2 " + params)

        def  paso = Preauditoria.get(params.id)
        def estacion = Estacion.get(params.estacion)
        def tipoIni = Tipo.findByCodigo('INIC')
        def tipoLic = Tipo.findByCodigo('LCM1')
        def tipoCump = Tipo.findByCodigo('CMPM')

        def inicio = Preauditoria.findByEstacionAndTipoAndIdNotEqual(estacion,paso.tipo,paso.id)
//        println("inicio " + inicio)
        def licenciamiento = Preauditoria.findByEstacionAndTipoAndIdNotEqual(estacion,tipoLic,paso.id)
//        println("lice " + licenciamiento)
        def anteriores = Preauditoria.findByEstacionAndTipoAndPeriodoAndIdNotEqual(estacion,tipoCump,paso.periodo,paso.id)


        def existente = Preauditoria.findByEstacionAndTipoAndPeriodoAndIdNotEqual(estacion, paso?.tipo, paso?.periodo, paso?.id)


//        println("existente " + existente?.tipo?.descripcion)

//        println("anteriores " + anteriores)

//        if(inicio){
//            render "no_Ya existe una auditoría para esta estación del tipo <strong>INICIO</strong>, seleccione otra estación."
//         }
//        if(licenciamiento){
//            render "no_Ya existe una auditoría para esta estación del tipo <strong>LICENCIAMIENTO</strong>, seleccione otra estación."
//        }
//        else{
//            if(anteriores){
//                render "no_Ya existe una auditoría para esta estación del tipo <strong>CUMPLIMIENTO</strong> en el período ${paso?.periodo?.inicio?.format("yyyy") + " - " + paso?.periodo?.fin?.format("yyyy")}, seleccione otra estación."
//            }else{
//                paso.estacion = estacion
//                try{
//                    paso.save(flush: true)
//                    render "ok_${paso?.id}"
//                }catch(e){
//                    render "no_Error al asignar la estación"
//                    println("error al guardar el paso 2 - crearAuditoria");
//                }
//            }
//        }

        if(existente){
            render "no_Ya existe una auditoría para esta estación del tipo <strong>${existente?.tipo?.descripcion?.toUpperCase()}</strong>, seleccione otra estación."
        }else{
            paso.estacion = estacion
            try{
                paso.save(flush: true)
                render "ok_${paso?.id}"
            }catch(e){
                render "no_Error al asignar la estación"
                println("error al guardar el paso 2 - crearAuditoria");
            }
        }


    }

    def guardarCoordenadas_ajax () {

//        println("params coordenadas " + params)

        def estacion = Preauditoria.get(params.id).estacion
        def coordenada

        if(params.idCor){
            coordenada = Coordenadas.get(params.idCor)
            coordenada.coordenadasX = params.enX.toDouble()
            coordenada.coordenadasY = params.enY.toDouble()
            try{
                coordenada.save(flush: true)
                render "ok"
            }catch(e){
                render "no"
                println("error al actualizar las coordenadas " + coordenada.errors)
            }

        }else{

            coordenada = new Coordenadas()
            coordenada.estacion = estacion
            coordenada.coordenadasX = params.enX.toDouble()
            coordenada.coordenadasY = params.enY.toDouble()
            try{
                coordenada.save(flush: true)
                render "ok"
            }catch(e){
                render "no"
                println("error al guardar las coordenadas " + coordenada.errors)
            }
        }
    }

    def crearPaso4 () {

        def creador = session.usuario.apellido + "_" + session.usuario.login
        def pre = Preauditoria.get(params.id)
        def asignados = Asignados.findAllByPreauditoria(pre)

        def coordinador = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona {
                eq("cargo", "Coordinador")
            }
        }

        def biologo = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona {
                eq("cargo", "Biologo")
            }
        }

        def especialista = Asignados.withCriteria {
            eq("preauditoria",pre)
            persona {
                eq("cargo", "Especialista")
            }
        }

        def band = 0

        if(asignados.size() == 3){
            band = 1
        }

        def listaCoordinadores = Persona.findAllByCargo("Coordinador")
        def listaEspecialistas = Persona.findAllByCargo("Especialista")
        def listaBiologos = Persona.findAllByCargo("Biologo")



        if (creador == pre?.creador) {
            return[pre: pre, asignados: asignados, coordinador: coordinador, biologo: biologo, band: band]
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su usuario."
            response.sendError(403)
        }

    }

    def crearPaso5 () {
        def pre = Preauditoria.get(params.id)
        def actividades = ActiAudi.findAllByPreauditoria(pre)
        return [pre: pre, actividades: actividades]
    }

    def fichaTecnica () {
        def creador = session.usuario.apellido + "_" + session.usuario.login
        def pre = Preauditoria.get(params.id)
        def coordenadas = Coordenadas.findAllByEstacion(pre?.estacion)
        def especialista = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Especialista"));
        def coordinador = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Coordinador"));
        def biologo = Asignados.findByPreauditoriaAndPersona(pre, Persona.findByCargo("Biologo"));

        if (creador == pre?.creador) {
            return [pre: pre, coordenadas: coordenadas, especialista: especialista?.persona, coordinador: coordinador?.persona, biologo: biologo?.persona]
        } else {
            flash.message = "Está tratando de ingresar a un pantalla restringida para su usuario."
            response.sendError(403)
        }
    }

    def revisarEstacion_ajax () {
        def pre = Preauditoria.get(params.id)
        if(pre?.estacion){
            render false
        }else{
            render true
        }
    }

    def borrarAuditoria_ajax () {
        println("params borrar auditoria" + params)

        def pre = Preauditoria.get(params.id)
        pre.estado = 0
        try{
            pre.save(flush: true)
            render "ok"
        }catch (e){
            render "no"
            println("error al borrar la auditoría")
        }
    }

    def revisarObjetivos_ajax () {
        def pre = Preauditoria.get(params.id)
        def auditoria = Auditoria.findByPreauditoria(pre)

        def obau = ObjetivosAuditoria.findAllByAuditoria(auditoria)

        if(obau){
            render false
        }else{
            render true
        }

    }

    def tablaAuditoriaUsuario_ajax () {

        def creador = session.usuario.apellido + "_" + session.usuario.login
        def listaAuditorias

        if (params.fecha) {
            params.fecha = new Date().parse("dd-MM-yyyy", params.fecha)
        }

//        println("params tabla " + params)

        if(!params.estacion && !params.tipo){
            listaAuditorias = Preauditoria.findAllByCreadorAndEstado(creador, 1, [sort:"estacion.nombre", order:'desc'])
        }else{
            def t = Tipo.get(params.tipo)

            listaAuditorias = Preauditoria.withCriteria {
                eq("tipo", t)
                eq("estado",1)
                eq("creador", creador)

                if(params.estacion){
                    estacion{
                        ilike('nombre', '%' + params.estacion + '%')
                    }
                }

                if(params.fecha){
                    between('fechaCreacion',params.fecha,params.fecha)
                }

                order ("estacion")
            }
        }


        //revisar avance

        def porcentaje
        def obau
        def audi
        listaAuditorias.each {li->
            porcentaje = 0
            if(li.estacion){
                porcentaje += 5
            }
            audi = Auditoria.findByPreauditoria(li)
            obau = ObjetivosAuditoria.findAllByAuditoria(audi)

            obau.each {ob->
                if(ob?.objetivo?.identificador == 'Evaluar Áreas de la Estación' && ob?.completado == 1){
                    porcentaje += 15
                }
                if(ob?.objetivo?.identificador == 'Evaluación Ambiental' && ob?.completado == 1){
                    porcentaje += 35
                }
                if(ob?.objetivo?.identificador == 'Plan de Acción' && ob?.completado == 1){
                    porcentaje += 15
                }
                if(ob?.objetivo?.identificador == 'Situación Ambiental' && ob?.completado == 1){
                    porcentaje += 10
                }
                if(ob?.objetivo?.identificador == 'PMA' && ob?.completado == 1){
                    porcentaje += 10
                }
                if(ob?.objetivo?.identificador == 'Cronograma' && ob?.completado == 1){
                    porcentaje += 5
                }
                if(ob?.objetivo?.identificador == 'Recomendaciones' && ob?.completado == 1){
                    porcentaje += 5
                }
            }

            li.avance = porcentaje
            try{
                li.save(flush: true)
            }catch (e){
                println("error al asignar el porcentaje de la auditoria " + li.errors)
            }
        }

        return [lista: listaAuditorias]
    }

    def tablaAuditoriaGeneral_ajax() {
        def creador = session.usuario.apellido + "_" + session.usuario.login
        def listaAuditorias

        if (params.fecha) {
            params.fecha = new Date().parse("dd-MM-yyyy", params.fecha)
        }

//        println("params tabla " + params)

        if(!params.estacion && !params.tipo){
            listaAuditorias = Preauditoria.findAllByEstado(1, [sort:"creador", order:'asc'])
        }else{
            def t = Tipo.get(params.tipo)

            listaAuditorias = Preauditoria.withCriteria {
                eq("tipo", t)
                eq("estado",1)
//                eq("creador", creador)

                if(params.estacion){
                    estacion{
                        ilike('nombre', '%' + params.estacion + '%')
                    }
                }

                if(params.fecha){
                    between('fechaCreacion',params.fecha,params.fecha)
                }

                order ("creador")
            }
        }


        //revisar avance

        def porcentaje
        def obau
        def audi
        listaAuditorias.each {li->
            porcentaje = 0
            if(li.estacion){
                porcentaje += 5
            }
            audi = Auditoria.findByPreauditoria(li)
            obau = ObjetivosAuditoria.findAllByAuditoria(audi)

            obau.each {ob->
                if(ob?.objetivo?.identificador == 'Evaluar Áreas de la Estación' && ob?.completado == 1){
                    porcentaje += 15
                }
                if(ob?.objetivo?.identificador == 'Evaluación Ambiental' && ob?.completado == 1){
                    porcentaje += 35
                }
                if(ob?.objetivo?.identificador == 'Plan de Acción' && ob?.completado == 1){
                    porcentaje += 15
                }
                if(ob?.objetivo?.identificador == 'Situación Ambiental' && ob?.completado == 1){
                    porcentaje += 10
                }
                if(ob?.objetivo?.identificador == 'PMA' && ob?.completado == 1){
                    porcentaje += 10
                }
                if(ob?.objetivo?.identificador == 'Cronograma' && ob?.completado == 1){
                    porcentaje += 5
                }
                if(ob?.objetivo?.identificador == 'Recomendaciones' && ob?.completado == 1){
                    porcentaje += 5
                }
            }

            li.avance = porcentaje
            try{
                li.save(flush: true)
            }catch (e){
                println("error al asignar el porcentaje de la auditoria " + li.errors)
            }
        }

        return [lista: listaAuditorias]
    }



}
