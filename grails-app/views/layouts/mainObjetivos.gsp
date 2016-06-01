<%--
  Created by IntelliJ IDEA.
  User: gato
  Date: 31/05/16
  Time: 01:24 PM
--%>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- los favicon de todos los tamaños -->
    <elm:favicon/>

    <title><g:layoutTitle default="Sada"/></title>

    <!-- Bootstrap core CSS 3.1.1 -->
    <elm:bootstrapCss/>



    <!-- FontAwsome, mFizz y octicons: las fuentes con dibujitos para los iconos -->
    <link href="${resource(dir: 'font-awesome-4.2.0/css', file: 'font-awesome.min.css')}" rel="stylesheet">
    <link href="${resource(dir: 'font-mfizz-1.2', file: 'font-mfizz.css')}" rel="stylesheet">
    <link href="${resource(dir: 'octicons', file: 'octicons.css')}" rel="stylesheet">

    <!-- JQuery -->
    <script src="${resource(dir: 'js/jquery/js', file: 'jquery-1.9.1.js')}"></script>
    <script src="${resource(dir: 'js/jquery/js', file: 'jquery-ui-1.10.3.custom.min.js')}"></script>
    <link href="${resource(dir: 'js/jquery/css/ui-lightness', file: 'jquery-ui-1.10.3.custom.min.css')}" rel="stylesheet">

    <!-- funciones de JS -->
    <!-- funciones de strings y formats sacados de internet (pad, starts y ends with, capitalize, format_number, str_replace) -->
    <script src="${resource(dir: 'js', file: 'functions.js')}"></script>
    <!-- funciones custom (validar int, validar dec, mensajes) -->
    <script src="${resource(dir: 'js', file: 'funciones.js')}"></script>
    <script src="${resource(dir: 'js', file: 'loader.js')}"></script>

    <!-- plugins -->
    <!-- para los alerts y confirms y dialogs -->
    <script src="${resource(dir: 'js/plugins/bootbox/js', file: 'bootbox.js')}"></script>

    %{--<!-- el datepicker -->--}%
    <script src="${resource(dir: 'js/plugins/bootstrap-datepicker/js', file: 'bootstrap-datepicker.js')}"></script>
    <script src="${resource(dir: 'js/plugins/bootstrap-datepicker/js/locales', file: 'bootstrap-datepicker.es.js')}"></script>
    <link href="${resource(dir: 'js/plugins/bootstrap-datepicker/css', file: 'datepicker.css')}" rel="stylesheet">

    <!-- lo q muestra la cantidad restante de caracteres en los texts -->
    <script src="${resource(dir: 'js/plugins/bootstrap-maxlength/js', file: 'bootstrap-maxlength.js')}"></script>

    <!-- la validacion del lado del cliente -->
    <script src="${resource(dir: 'js/plugins/jquery-validation-1.11.1/js', file: 'jquery.validate.min.js')}"></script>
    <script src="${resource(dir: 'js/plugins/jquery-validation-1.11.1/localization', file: 'messages_es.js')}"></script>
    <script src="${resource(dir: 'js', file: 'jquery.validate.custom.js')}"></script>

    <!-- las alertas growl -->
    <script src="${resource(dir: 'js/plugins/pines/js', file: 'jquery.pnotify.js')}"></script>
    <link href="${resource(dir: 'js/plugins/pines/css', file: 'jquery.pnotify.default.css')}" rel="stylesheet">

    <!-- context menu para el click derecho -->
    %{--<script src="${resource(dir: 'js/plugins/context/js', file: 'context.js')}"></script>--}%
    %{--<link href="${resource(dir: 'js/plugins/context/css', file: 'context.css')}" rel="stylesheet">--}%
    <script type="text/javascript" src="${resource(dir: 'js/plugins/lzm.context/js', file: 'lzm.context-0.5.js')}"></script>
    <link href="${resource(dir: 'js/plugins/lzm.context/css', file: 'lzm.context-0.5.css')}" rel="stylesheet">

    <!-- el timer para cerrar la sesion -->
    <script src="${resource(dir: 'js/plugins/jquery.countdown', file: 'jquery.countdown.min.js')}"></script>
    <link href="${resource(dir: 'js/plugins/jquery.countdown', file: 'jquery.countdown.css')}" rel="stylesheet">

    <link href='${resource(dir: "font/open", file: "stylesheet.css")}' rel='stylesheet' type='text/css'>
    <link href='${resource(dir: "font/tulpen", file: "stylesheet.css")}' rel='stylesheet' type='text/css'>

    <!-- el manager de fechas -->
    <script src="${resource(dir: 'js/plugins', file: 'date.js')}"></script>

    <!-- los tooltips bonitos -->
    <script src="${resource(dir: 'js/plugins/jquery.qtip-2.2.0', file: 'jquery.qtip.min.js')}"></script>
    <link href='${resource(dir: "js/plugins/jquery.qtip-2.2.0", file: "jquery.qtip.min.css")}' rel='stylesheet' type='text/css'>

    <!-- pie chart -->
    <script src="${resource(dir: 'js/plugins/Radial-Progress-Bar', file: 'radial-progress-bar.js')}"></script>

    <!-- Custom styles -->
    <link href="${resource(dir: 'css', file: 'custom.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'custom/banner.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'custom/sticky-footer.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'custom/loader.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'custom/modals.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'custom/tablas.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'custom/datepicker.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'custom/context.css')}" rel="stylesheet">
    <link href="${resource(dir: 'css', file: 'custom/wizard.css')}" rel="stylesheet">
    <link href='${resource(dir: "css", file: "varios.css")}' rel='stylesheet' type='text/css'>
    <link href='${resource(dir: "css", file: "custom/pnotify.css")}' rel='stylesheet' type='text/css'>
    <link href='${resource(dir: "css", file: "custom/menu.css")}' rel='stylesheet' type='text/css'>
    <link href='${resource(dir: "css", file: "custom/menu2.css")}' rel='stylesheet' type='text/css'>
    %{--<link href='${resource(dir: "css", file: "custom/menuV.css")}' rel='stylesheet' type='text/css'>--}%
    %{--Buscador--}%
    <link href='${resource(dir: 'css', file: 'buscador.css')}' rel='stylesheet'>

    <link rel="shortcut icon" href="${resource(dir: 'images/inicio', file: 'favicon.ico')}" type="image/x-icon">

    <script type="text/javascript">
        var spinner24Url = "${resource(dir:'images/spinners', file:'spinner_24.GIF')}";
        var spinner64Url = "${resource(dir:'images/spinners', file:'spinner_64.GIF')}";

        var spinnerSquare64Url = "${resource(dir: 'images/spinners', file: 'spinner.gif')}";

        var spinner = $("<img src='" + spinner24Url + "' alt='Cargando...'/>");
        var spinner64 = $("<img src='" + spinner64Url + "' alt='Cargando...'/>");
        var spinnerSquare64 = $("<img src='" + spinnerSquare64Url + "' alt='Cargando...'/>");
    </script>

    <g:layoutHead/>


    <script type="text/javascript">
        /* deshabilita navegación --inicailiza */
        //        $(document).ready(function(){
        //            initControls();
        //        });
        //
        //        /* deshabilita navegación hacia atras */
        //        function initControls(){
        //
        //            window.location.hash="no-back-button";
        //            window.location.hash="Again-No-back-button" //chrome
        //            window.onhashchange=function(){window.location.hash="no-back-button";}
        //
        //        }
    </script>
</head>

<body>

<mn:bannerTop title="${layoutTitle(default: 'Sada')}"/>


<div style="width: 100%">
    <mn:menuObjetivos title="${g.layoutTitle(default: 'Sada')}"/>
</div>


%{--<div id="nav" style="position: fixed; margin-top: 200px; margin-left: 20px">--}%
    %{--<ul id="navList">--}%
        %{--<li style="text-align: center"><a href="#">Home</a>--}%
            %{--<!-- This is the sub nav -->--}%
            %{--<ul class="listTab">--}%
                %{--<li><a href="#">About This Template Here</a></li>--}%
                %{--<li><a href="#">Flash</a></li>--}%
                %{--<li><a href="#">jQuery</a></li>--}%
            %{--</ul>--}%
        %{--</li>--}%
        %{--<li><a href="#">Blog</a>--}%
            %{--<!-- This is the sub nav -->--}%
            %{--<ul class="listTab">--}%
                %{--<li><a href="#">About This Template Here</a></li>--}%
                %{--<li><a href="#">Flash</a></li>--}%
                %{--<li><a href="#">jQuery</a>--}%
                    %{--<ul class="listTab">--}%
                        %{--<li><a href="#">About This Template Here</a></li>--}%
                        %{--<li><a href="#">Flash</a></li>--}%
                        %{--<li><a href="#">jQuery</a></li>--}%
                    %{--</ul>--}%
                %{--</li>--}%
            %{--</ul>--}%
        %{--</li>--}%
        %{--<li><a href="#">About</a>--}%
            %{--<!-- This is the sub nav -->--}%
            %{--<ul class="listTab">--}%
                %{--<li><a href="#">About This Template Here</a></li>--}%
                %{--<li><a href="#">Flash</a></li>--}%
                %{--<li><a href="#">jQuery</a></li>--}%
            %{--</ul>--}%
        %{--</li>--}%
        %{--<li><a href="#">Porfolio</a></li>--}%
        %{--<li><a href="#">Contact</a></li>--}%
    %{--</ul>--}%
%{--</div>--}%

%{--//menu elements--}%

%{--<header class='masthead' style="margin-top: 120px; position: fixed">--}%
    %{--<div class='brand-container'>--}%
    %{--<a href='#'>--}%
    %{--<span class='brand-initials'>Ob</span>--}%
    %{--<span class='brand-name'>Objetivos</span>--}%
    %{--</a>--}%
    %{--</div>--}%
    %{--<nav>--}%
        %{--<div class='nav-container'>--}%
            %{--<div>--}%
                %{--<input id='slider1' name='slider1' type='checkbox'>--}%
                %{--<label class='slide has-child' for='slider1'>--}%
                    %{--<span class='element'>Bg</span>--}%
                    %{--<span class='name'>Blog</span>--}%
                %{--</label>--}%
                %{--<div class='child-menu'>--}%
                    %{--<a href='#'>Recent</a>--}%
                    %{--<a href='#'>Archives</a>--}%
                    %{--<a href='#'>Categories</a>--}%
                %{--</div>--}%
            %{--</div>--}%
            %{--<div>--}%
                %{--<a class='slide' href='#'>--}%
                    %{--<span class='element'>Po</span>--}%
                    %{--<span class='name'>Portfolio</span>--}%
                %{--</a>--}%
            %{--</div>--}%
            %{--<div>--}%
                %{--<input id='slider2' name='slider2' type='checkbox'>--}%
                %{--<label class='slide has-child' for='slider2'>--}%
                    %{--<span class='element'>Xp</span>--}%
                    %{--<span class='name'>Laboratory</span>--}%
                %{--</label>--}%
                %{--<div class='child-menu'>--}%
                    %{--<a href='#'>PHP</a>--}%
                    %{--<a href='#'>Javascript</a>--}%
                    %{--<a href='#'>Css</a>--}%
                    %{--<a href='#'>Ruby</a>--}%
                    %{--<a href='#'>Python</a>--}%
                    %{--<a href='#'>Design</a>--}%
                %{--</div>--}%
            %{--</div>--}%
            %{--<div>--}%
                %{--<a class='slide' href='#'>--}%
                    %{--<span class='element'>Ab</span>--}%
                    %{--<span class='name'>About</span>--}%
                %{--</a>--}%
            %{--</div>--}%
            %{--<div>--}%
                %{--<a class='slide' href='#'>--}%
                    %{--<span class='element'>C</span>--}%
                    %{--<span class='name'>Contact</span>--}%
                %{--</a>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</nav>--}%
    %{--<div class='social-container'>--}%
        %{--<span>--}%
            %{--<a class='social-roll github' href='#'></a>--}%
        %{--</span>--}%
        %{--<span>--}%
            %{--<a class='social-roll twitter' href='#'></a>--}%
        %{--</span>--}%
        %{--<span>--}%
            %{--<a class='social-roll linkedin' href='#'></a>--}%
        %{--</span>--}%
        %{--<span>--}%
            %{--<a class='social-roll rss' href='#'></a>--}%
        %{--</span>--}%
    %{--</div>--}%
%{--</header>--}%


<div class="container" style="min-width: 1000px !important; margin-top: 50px">
    <g:layoutBody/>
</div> <!-- /container -->


<mn:stickyFooter2/>
<mn:stickyFooter/>

<!-- Bootstrap core JavaScript
    ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<elm:bootstrapJs/>

<!-- funciones de ui (tooltips, maxlength, bootbox, contextmenu, validacion en keydown para los numeros) -->
<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<script type="text/javascript">



    $(document).ready(function($) {
        //Menu animation
        $('#navList ul').css({display: "none"}); //Fix Opera

        $('#navList li').hover(function() {
            $(this).addClass('addPosition');
            $(this).find('a').stop().animate({'width' : "280"});
            $(this).find('ul:first').css({visibility : "visible", display : "none"}).show(400);

        }, function() {
            $(this).find('ul:first').css({visibility : "hidden"}).hide(400);
            $(this).find('a').stop().animate({'width' : "250"});
            $(this).removeClass('addPosition');
        });
    });









    var ot = document.title;
    function resetTimer() {
        var ahora = new Date();
        var fin = ahora.clone().add(5).minute();
        fin.add(1).second()
        $("#countdown").countdown('option', {
            until : fin
        });
        $(".countdown_amount").removeClass("highlight");
        document.title = ot;
    }

    function validarSesion() {
        /*
         $.ajax({
         url     : '
        ${createLink(controller: "login", action: "validarSesion")}',
         success : function (msg) {
         if (msg == "NO") {
         location.href = "
        ${g.createLink(controller: 'login', action: 'login')}";
         } else {
         resetTimer();
         }
         }
         });
         */
    }

    function highlight(periods) {
//        if ((periods[5] == 5 && periods[6] == 0) || (periods[5] < 5)) {
//            document.title = "Fin de sesión en " + (periods[5].toString().lpad('0', 2)) + ":" + (periods[6].toString().lpad('0', 2)) + " - " + ot;
//            $(".countdown_amount").addClass("highlight");
//        }
    }

    //            $(function () {
    ////                $(".annoying").show("pulsate")
    //                setInterval(function () {
    //                    $(".annoying").hide()
    //                    setTimeout(function () {
    //                        $(".annoying").show()
    //                    }, 500)
    //                    setTimeout(function () {
    //                        $(".annoying").hide()
    //                    }, 1000)
    //                    setTimeout(function () {
    //                        $(".annoying").show()
    //                    }, 1500)
    //                    setTimeout(function () {
    //                        $(".annoying").hide()
    //                    }, 2000)
    //                    setTimeout(function () {
    //                        $(".annoying").show()
    //                    }, 2500)
    //                    setTimeout(function () {
    //                        $(".annoying").hide()
    //                    }, 3000)
    //                    setTimeout(function () {
    //                        $(".annoying").show()
    //                    }, 3500)
    //                    setTimeout(function () {
    //                        $(".annoying").hide()
    //                    }, 4000)
    //                    setTimeout(function () {
    //                        $(".annoying").show()
    //                    }, 4500)
    //                    setTimeout(function () {
    //                        $(".annoying").hide()
    //                    }, 5000)
    //                    setTimeout(function () {
    //                        $(".annoying").show()
    //                    }, 5500)
    //                    setTimeout(function () {
    //                        $(".annoying").hide()
    //                    }, 6000)
    //                    setTimeout(function () {
    //                        $(".annoying").show()
    //                    }, 6500)
    //                    setTimeout(function () {
    //                        $(".annoying").hide()
    //                    }, 7000)
    //                    setTimeout(function () {
    //                        $(".annoying").show()
    //                    }, 7500)
    //                    setTimeout(function () {
    //                        $(".annoying").hide()
    //                    }, 8000)
    //                    setTimeout(function () {
    //                        $(".annoying").show()
    //                    }, 8500)
    //                }, 60000);
    //
    //                var ahora = new Date();
    //                var fin = ahora.clone().add(5).minute();
    //                fin.add(1).second()
    //
    //                $('#countdown').countdown({
    //                    until    : fin,
    //                    format   : 'MS',
    //                    compact  : true,
    //                    onExpiry : validarSesion,
    //                    onTick   : highlight
    //                });
    //
    //                $(".btn-ajax").click(function () {
    //                    resetTimer();
    //                });
    //
    //                $(".bloqueo").draggable()
    //                $(".cerrar-bloqueo").click(function () {
    //                    $(this).parent().parent().hide("explode")
    //                })
    //            });


    //            var affixElement = '#navbar-main';
    //
    //            $(affixElement).affix({
    //                offset: {
    //                    // Distance of between element and top page
    //                    top: function () {
    //                        return (this.top = $(affixElement).offset().top)
    //                    },
    //                    // when start #footer
    //                    bottom: function () {
    //                        return (this.bottom = $('#footer').outerHeight(true))
    //                    }
    //                }
    //            });


</script>

</body>
</html>
