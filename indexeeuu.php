<?php
    date_default_timezone_set('America/Bogota');
	$fecha = time();
	$dia = date("d",$fecha);
	$mes = date("m",$fecha);
	$a = date("Y",$fecha);
	$hora = date("H",$fecha);
	$minutos = date("i",$fecha);
    if ($mes >= 9) {
        $a = $a + 1;
    }
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Virtual Assistant - THRIVE Admissions</title>
    <link rel="icon" type="image/x-icon" href="favicon2026.ico">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="chatbot/librerias/bootstrap/css/bootstrap.min.css" />
    
    <!-- Enlace al CSS del asistente -->
    <link rel="stylesheet" href="chatbot/css/chatbot_responsivo.css?v=1.0.1" />

    <script src="chatbot/librerias/jquery-3.7.1.min.js"></script>
</head>
<body>

    <!-- CABECERA DEL SITIO -->
    <header>        
        <div id="header1" class="header" style="display: none;">
            
        </div>
        <div id="header2" class="header" style="display: none;">
            <img src="chatbot/img/logo_thrive.png" alt="Logo" class="logo">
            <span class="header-titulo" style="color: #222A75 !important;"> Welcome To The Virtual Assistant<br>
                <span class="header-titulo" style="color: gray !important; font-size: 0.8rem;">
                THRIVE Global Academy - Academic Year <?php echo $a; ?>
                </span>
            </span>
            
           
        </div>
        <div id="header1eeuu" class="header">
            <img src="chatbot/img/logo_thrive.png" class="logo" id="logo_header">
        </div>
    </header>

    <!-- CONTENIDO PRINCIPAL -->
    <main>
        <section class="content">
            <div class="ocultar">
                <img src="chatbot/img/unibot3eeuu.png" class="boton-icono">
            </div>
            <div class="ocultar">
                <h3 class="azulthrive">Welcome To The Virtual Assistant</h3>
                <p>Start your registration process for the 2026 Academic Year</p>
                <br>
            </div>
            <!-- Botón "Iniciar Asistente de Admisiones" -->
            <div class="bot-inicio-inline" onclick="iniciarAsistente()">
                <span class="btn-text">Start Admissions Assistant</span>
            </div>
            <hr class="ocultar">

            <div class="ocultar">
                <h4 class="azulthrive">
                    About our educational model
                </h4>
            </div>

            <p id="p-inicial">
                Our school offers virtual education from first to eleventh grade and cyclical education for adults, with personalized support and 24/7 platforms.<br>
                Remember that if you have already started the admissions process, after entering the student's document number, you will be directed to the step where you last left off.
            </p><br>
            
            <!-- Contenedor del chatbot full-screen (oculto al inicio) -->
            <div id="asistente-fullscreen" class="asistente-fullscreen">
                <!-- Sección 1: Nombre estudiante y documento -->
                <div class="col-12" id="div-nombre"><span id="s-nombre"></span></div>

                <!-- Sección 1: Chatbot -->
                <div id="seccion-chat" class="row seccion">
                    <div class="col-lg-2 col-md-3 col-sm-3 col-3">
                        <div id="div-pasos" style="margin-left: 10px;"></div>
                    </div>
                    <div class="col-lg-10 col-md-9 col-sm-9 col-9">
                        <div id="chat-mensajes" class="chat-mensajes"></div>
                        <div class="chat-input" style="display: none;">
                            <input type="text" id="entrada-chat" placeholder="Escribe tu pregunta o comentario..." />
                            <button id="btn-enviar-chat">Send</button>
                        </div>
                    </div>
                    
                </div>
            </div>
        </section>
    </main>

    <!-- PIE DE PÁGINA -->
    <footer>
        &copy; <?= date('Y') ?> THRIVE Virtual School. All rights reserved.
    </footer>
    <?php 
        //include 'footer.php';
    ?>

    <!-- CARGA DE SCRIPTS -->
    <script src="chatbot/base-intenciones.js?v=1.0.1"></script>
    <script src="chatbot/chatbot.js?v=1.0.1"></script>

</body>
</html>