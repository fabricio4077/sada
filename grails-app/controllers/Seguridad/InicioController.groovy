package Seguridad

class InicioController extends Shield {

    def inicio() {
        redirect(action: "index")
    }

    def index() {}
}
