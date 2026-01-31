<?php
    date_default_timezone_set('America/Bogota');
	$fecha = time();
	$dia = date("d",$fecha);
	$mes = date("m",$fecha);
	$a = date("Y",$fecha);
	$hora = date("H",$fecha);
	$minutos = date("i",$fecha);
    $fecha2 = $a.$mes. $dia;

    $estado = $_REQUEST['estado'];
    $ref = $_REQUEST['ref'];
    $fact = $_REQUEST['fact'];
    $val = $_REQUEST['val'];
    $conc = str_replace("_", " ", $_REQUEST['conc']);

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

    <!-- EPAYCO  -->
    <script type="text/javascript" src="https://checkout.epayco.co/checkout.js"></script>    
    
</head>
<body>

    <!-- CABECERA DEL SITIO -->
    <header>        
        <div id="header2" class="header">
            <img src="chatbot/img/logo_nuevo.png" alt="Logo" class="logo">
            <span class="header-titulo"> Asistente Virtual de Admisiones<br>
            del Colegio UNICAB<br>
            Pago Deuda
            </span>
            <img src="chatbot/img/unibot2.png" alt="Bot" class="bot">
        </div>
    </header>

    <!--== Resultado Epayco Start ==-->
    <section id="page-title-areaxx">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 m-auto text-center">
                    <div class="page-title-content">
                        <?php
							//https://secure.payco.co/restpagos/transaction/response.json?ref_payco=23611413&public_key=870fd53ee9274a76a62c34f434b09569
						?>
						<br/><h4 style="color: blue;">¡RESULTADO DE SU PAGO!</h4><hr>
						<h5>Estado de la transacción: <span id="respuesta"></span></h5><hr>
						<h4 style='color: blue;'>DETALLE DEL PAGO</h4><hr>
						<h5>Fecha: <span id="fecha"></span></h5>
						<h5>Referencia de pago: <span id="referencia"></span></h5>
						<h5>Valor: <span id="valor"></span></h5>
						<h5>Concepto: <span id="concepto"></span></h5>
						<h5>Factura: <span id="factura"></span></h5>
						<h5>Autorización: <span id="autorizacion"></span></h5>
						<h5>Recibo: <span id="recibo"></span></h5>
						<h5>Banco: <span id="banco"></span></h5><hr>
						<h5>PIN: <span id="ref_epayco"></span></h5>
						<h5>Código proyecto: <span id="cod_proyecto"></span></h5>
						<h5>Descripción respuesta: <span id="desc_res"></span></h5><hr>
						<h6 style="color: red;">NOTA: Si la transacción fue por Baloto, Efecty, Punto Red, Red Servi o Gana; 
						tiene 5 días a partir de la fecha actual para utilizar el PIN y Código proyecto.</h6><hr>
						<!--<a href='pagos_payservices.php' class='btn btn-brand smooth-scroll'>Realizar otro pago</a>-->
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--== Resultado Epayco End ==-->


    <!-- PIE DE PÁGINA -->
    <footer>
        &copy; <?= date('Y') ?> Colegio UNICAB Virtual. Todos los derechos reservados.
    </footer>
    <?php 
        //include 'footer.php';
    ?>

    <!-- CARGA DE SCRIPTS -->
    <script src="chatbot/pago.js"></script>

</body>
</html>