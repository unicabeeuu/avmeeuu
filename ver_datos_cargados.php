<?php
    //http://localhost:90/avadmisiones/pagoMatricula.php?documento=93974543&valor=660100&referencia=93974543-2026-pp
    date_default_timezone_set('America/Bogota');
	$fecha = time();
	$dia = date("d",$fecha);
	$mes = date("m",$fecha);
	$a = date("Y",$fecha);
	$hora = date("H",$fecha);
	$minutos = date("i",$fecha);
    $fecha2 = $a.$mes. $dia;
    if ($mes >= 10) {
        $a++;
    } 
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Asistente Virtual - Admisiones UNICAB</title>
    <link rel="icon" type="image/x-icon" href="favicon2025.ico">

    <!-- BOOTSTRAP CSS -->
    <link rel="stylesheet" href="chatbot/librerias/bootstrap/css/bootstrap.css">
    
    <!-- Enlace al CSS del asistente -->
    <link rel="stylesheet" href="chatbot/css/chatbot_responsivo.css" />

    <!-- Jquery JS  -->
    <script src="chatbot/librerias/jquery-3.7.1.min.js"></script>
    
</head>
<body>

    <!-- CABECERA DEL SITIO -->
    <header>        
        <div id="header2" class="header">
            <img src="chatbot/img/logo_nuevo.png" alt="Logo" class="logo">
            <span class="header-titulo"> Asistente Virtual de Admisiones<br>
            del Colegio UNICAB<br>
            Pago Matrícula
            </span>
            <img src="chatbot/img/unibot2.png" alt="Bot" class="bot">
        </div>
    </header>

    <!-- CONTENIDO PRINCIPAL -->
    <main>
        <section class="contentzz">
            <div class="section-title-pagos">
                <div class="container">
                    <div class="row align-items-center justify-content-center my-2">
                        <div class="col-lg-1 col-md-1 col-sm-1 col-1"></div>
                        <div class="col-lg-8 col-md-8 col-sm-8 col-8">
                            <span class="h2-pagos">Datos Cargados</span>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 col-2">
                            <img class="img-fluid h2-icon-pagos" src="https://unicab.org/homeunicabpro/assets/img/pagos/statement.png" alt="statement-icon">
                        </div>
                        <div class="col-lg-1 col-md-1 col-sm-1 col-1"></div>
                    </div>
                </div>
            </div>

            <div>
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <label for="txtidentif1">* Número de identificación del estudiante</label><br/>
                            <input type="text" id="txtidentif1" class="form-control validar" required/>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <label for="btnVerDatos">---</label><br/>
                            <button id="btnVerDatos" class="btn btn-success" onclick="VerDatosCargados()">Ver</button>
                        </div>
                    </div><br>
                </div><br>

                <div class="container">
                    <div class="row">
                        <p id="datosCargdos"></p>
                    </div>
                </div>
            </div>
            
            <!--<div class="alert alert-danger" role="alert" id="alert">
                <p>⚠️<span>: </span><label id="pdesc"></label>
                <input type="hidden" class="alert alert-danger" style="width: 20px" id="txtvacio" value="0"></p>
            </div>-->
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
    <script src="chatbot/ver_datos.js"></script>

</body>
</html>