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

    $documento = $_REQUEST['documento'];
    $valor = $_REQUEST['valor'];
    $referencia = $_REQUEST['referencia'];
    $concepto = $_REQUEST['concepto'];
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
                            <span class="h2-pagos">Pago a través de ePayco</span>
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
                        <div class="col-12">
                            <label for="selmedio">MEDIO DE PAGO  (Efectivo --> Baloto, Efecty, Punto Red, Red Servi, Gana, etc...)</label>
                            <select id="selmedio" class="validar">
                                <option value="NA" selected>Seleccione medio de pago</option>
                                <option value="E">Efectivo</option>
                                <option value="P">PSE</option>
                                <option value="P6">PSE menor 60000</option>
                                <option value="TC">Tarjeta de crédito</option>
                            </select>
                        </div>
                    </div><br>

                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <label for="txtndoc">* Documento estudiante</label>
                            <input type="text" id="txtndoc" class="form-control validar" value="<?php echo $documento; ?>" readonly required/>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <label for="txtano">* Fecha</label>
                            <input type="text" id="txtano" class="form-control validar" value="<?php echo $fecha2; ?>" readonly required/>
                        </div>
                    </div><br>

                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <label for="txtvalor">* Valor a pagar</label><br/>
                            <input type="text" id="txtvalor" class="form-control validar" value="<?php echo $valor; ?>" readonly required/>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <label for="txtref">* Referencia de pago</label>
                            <input type="text" id="txtref" class="form-control validar" value="<?php echo $referencia; ?>" readonly required/>
                        </div>
                    </div><br>

                    <div class="row">
                        <div class="col-12">
                            <label><strong>DATOS DE QUIEN PAGA</strong></label>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <label for="txtnom">* Nombre de quien paga</label><br/>
                            <input type="text" id="txtnom" class="form-control validar" onkeyup="mayus(this, 'txtnom', 'Nombre de quien paga');" required/>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12">
                            <label for="txtidentif">* Número de identificación</label><br/>
                            <input type="text" id="txtidentif" class="form-control validar" onkeyup="validar_numero('txtidentif', 'Número de identificación');" required/>
                        </div>
                    </div><br>
                    <input type="hidden" id="concepto" name="concepto" value="<?php echo $concepto; ?>">

                    <div class="row">
                        <div class="col-12">
                            <button id="btncontinuar" class="btn btn-success" onclick="callEpayco()">Hacer pago por Epayco</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="alert alert-danger" role="alert" id="alert">
                <p>⚠️<span>: </span><label id="pdesc"></label>
                <input type="hidden" class="alert alert-danger" style="width: 20px" id="txtvacio" value="0"></p>
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
    <script src="chatbot/pago.js"></script>

</body>
</html>