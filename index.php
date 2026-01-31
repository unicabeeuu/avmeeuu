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
    <title>Asistente Virtual - Admisiones UNICAB</title>
    <link rel="icon" type="image/x-icon" href="favicon2025.ico">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="chatbot/librerias/bootstrap/css/bootstrap.min.css" />
    
    <!-- Enlace al CSS del asistente -->
    <link rel="stylesheet" href="chatbot/css/chatbot_responsivo.css?v=1.0.1" />

    <script src="chatbot/librerias/jquery-3.7.1.min.js"></script>
</head>
<body>

    <!-- CABECERA DEL SITIO -->
    <header>        
        <div id="header1" class="header">
            <img src="chatbot/img/Logo_blanco.png" alt="Logo" class="logo">
            <span class="header-titulo"> Bienvenido al Asistente Virtual de Admisiones<br>
            del Colegio UNICAB<br>
            Para el Año Lectivo de <?php echo $a; ?>
            </span>
        </div>
        <div id="header2" class="header" style="display: none;">
            <img src="chatbot/img/Logo_nuevo.png" alt="Logo" class="logo">
            <span class="header-titulo"> Bienvenido al Asistente Virtual de Admisiones<br>
            del Colegio UNICAB<br>
            Para el Año Lectivo de <?php echo $a; ?>
            </span>
            <img src="chatbot/img/unibot2.png" alt="Bot" class="bot">
        </div>
    </header>

    <!-- CONTENIDO PRINCIPAL -->
    <main>
        <section class="content">
            <p id="p-inicial">
                Nuestro colegio ofrece educación virtual desde grado primero hasta undécimo y educación por ciclos para adultos, con plataformas tecnológicas disponibles 24/7 y acompañamiento personalizado.<br><br>
                Recuerda que si ya has iniciado el proceso de admisión, después de ingresar el número del documento del estudiante, será dirigido al paso en dónde quedaste por última vez.
            </p><br>
            
            <!-- Botón "Iniciar Asistente de Admisiones" -->
            <div class="bot-inicio-inline" onclick="iniciarAsistente()">
                <img src="chatbot/img/unibot3.png" alt="Bot" class="boton-icono">
                <span class="btn-text">Iniciar Asistente de Admisiones</span>
            </div>

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
                            <button id="btn-enviar-chat">Enviar</button>
                        </div>
                    </div>
                    
                </div>
            </div>
        </section>
    </main>

    <!-- PIE DE PÁGINA -->
    <footer>
        &copy; <?= date('Y') ?> Colegio UNICAB Virtual. Todos los derechos reservados.
    </footer>
    <?php 
        //include 'footer.php';
    ?>

    <!-- CARGA DE SCRIPTS -->
    <script src="chatbot/base-intenciones.js?v=1.0.1"></script>
    <script src="chatbot/chatbot.js?v=1.0.1"></script>

</body>
</html>