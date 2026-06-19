<?php
    require("../bd/1cc2s4db.php");
    header("Cache-Control: no-store");
    //http://localhost:90/avmeeuu/avmeeuu/avmeeuu_admisiones_sent_f_antiguos_correo.php
    
    $datos = new stdClass();
	
	$json_guardados = $_REQUEST['archivos_guardados_json'];
	$json_fallidos = $_REQUEST['archivos_fallidos_json'];
	$json_data_original = $_REQUEST['data_original_json'];
	
	$archivos_guardados_info = json_decode($json_guardados, true); // Array de arrays con 'documento' y 'ruta'
	$archivos_fallidos = json_decode($json_fallidos, true);       // Array de nombres de campos fallidos
	$data = json_decode($json_data_original, true);             // Array con los datos del formulario

    require '../chatbot/librerias/vendor/autoload.php';
    use PHPMailer\PHPMailer\PHPMailer;

    date_default_timezone_set('America/Bogota');
	$fecha = time();
	$dia = date("d",$fecha);
	$mes = date("m",$fecha);
	$a = date("Y",$fecha);
	$fecha2 =$a."/".$mes."/". $dia;
	if($mes >= 10) {
	    $a++;
	}
	
	$msg_correo = "";
	
	// estudiante
	$documento = addslashes (quotemeta (strtoupper($data['documento'])));
	//echo "documento: ".$documento;
	$estado=$data['estado'];

	$apellidos = strtoupper($data['apellidos']);
	$nombres = strtoupper($data['nombres']);
	$gradoIngreso = $data['grado'];
	$tipo_documento = $data['tipo_documento'];
	$correo_estudiante = $data['email'];
	$telefono_estudiante = strtoupper($data['telefono']);
	
	$expedicion = strtoupper($data['expedicion']);
	$fecha_nacimiento = strtoupper($data['fecha_nacimiento']);
	$direccion_estudiante = strtoupper($data['direccion']);
	$ciudad = strtoupper($data['ciudad']);
	
	$nombre_acudiente = strtoupper($data['nombreA']);
	$documento_acudiente = $data['documentoA'];
	$direccion_acudiente = strtoupper($data['direccionA']);
	$celular_acudiente = $data['celularA'];
	$correo_acudiente = $data['correoA'];
	//echo $nombres." ".$apellidos;

	$nombreCompleto = $data['nombres']." ".$data['apellidos'];
	$asuntoMensaje = "Solicitud de Matrícula ".$nombreCompleto;
	$cuerpoMensaje = "<h2>--- INFORMACIÓN DEL ESTUDIANTE ----</h2>
	<br> Nombres: ".$data['nombres']."<br> Apellidos: ".$data['apellidos']."<br> Grado al que ingresa: ".$gradoIngreso."<br> 
	Tipo de Documento: ".$data['tipo_documento']."<br> Número de Documento: ".$data['documento']."<br> 
	Correo: ".$data['email']."<br> Fecha de Nacimiento: ".$data['fecha_nacimiento']."<br> Lugar de Nacimiento: ".$data['expedicion']. "<br> 
	Dirección: ".$data['direccion']."<br> Ciudad: ".$data['ciudad']. "<br> Teléfono: ".$data['telefono']."<br> 
	<hr><br> <h2>--- INFORMACIÓN DEL ACUDIENTE ----</h2>".
	"<br> Nombre: ".strtoupper($data['nombreA']).
	"<br> Documento: ".$data['documentoA']."<br> Dirección: ".$data['direccionA'].
	"<br> Celular: ".$data['celularA']."<br> Correo: ".$data['correoA']."<br>
	<hr><br> <h2>--- RESUMEN DE DOCUMENTOS GUARDADOS ----</h2>
	<br>";
	
	foreach ($archivos_guardados_info as $info) {
        // Formato para cada archivo guardado
        $cuerpoMensaje .= "Documento: {$info['documento']} <br>";
        $cuerpoMensaje .= "Ruta: {$info['ruta']} <br>";
        $cuerpoMensaje .= "-------------------------------------------------<br>";
    }
	$cuerpoMensaje .= "<hr><br> <h2>--- RESUMEN DE DOCUMENTOS FALLIDOS ----</h2>
	<br>";
	foreach ($archivos_fallidos as $fallo) {
        $cuerpoMensaje .= "- " . $fallo . "<br>";
    }
	
	//echo "<br>".$cuerpoMensaje;

    // ###################### INICIO ENVIO DE CORREO ###################
    try {
        //$mail = new PHPMailer(true);
		$mail = new PHPMailer;
    }
    catch(Exception $e) {
        echo $e;
    }
    
    try {
        //echo $email;
        //Server settings
        //$mail->SMTPDebug = SMTP::DEBUG_SERVER;                      // Enable verbose debug output
        //$mail->isSMTP();                                            // Send using SMTP
        //$mail->Host       = 'smtp.hostinger.com';                    // Set the SMTP server to send through
        //$mail->SMTPAuth   = false;
		
		$mail->isSMTP();                                            // Send using SMTP
		$mail->SMTPDebug = 0;										//0 producción, 2 ver detalle de comandos
		//$mail->Host       = 'smtp.hostinger.com';  
        $mail->Host       = 'smtp.gmail.com';                  // Set the SMTP server to send through
		$mail->SMTPAuth   = true;
        //$mail->Username   = 'numericopensamientoclei2@gmail.com';                     // SMTP username
        //$mail->Username   = 'unicabfinanciera@gmail.com';
        //$mail->Password   = 'Financiera2020#';
        //$mail->Username   = 'sistemasunicab@gmail.com';
        //$mail->Password   = 'psfa0301';
        //$mail->Username   = 'webmasterunicab@unicab.org';
        //$mail->Password   = 'Web.mas2022';
		$mail->Username   = 'g.h.fig.1073@gmail.com';
        $mail->Password   = 'gsel uewf dvjr iqlr';
        //$mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;         // Enable TLS encryption; `PHPMailer::ENCRYPTION_SMTPS` encouraged
        $mail->Port       = 587;
    
        //Recipients
        //$mail->setFrom('sistemasunicab@gmail.com');
        $mail->setFrom('g.h.fig.1073@gmail.com', 'Sistemas');
        //$mail->addAddress('matriculas@unicab.org');     // Add a recipient
        //$mail->addAddress('unicabfinanciera@unicab.org');     // Add a recipient
		//$mail->addAddress('admisiones@unicab.org');
        $mail->addAddress('numericopensamientoclei2@gmail.com');     // Add a recipient
        //$mail->addReplyTo('numericopensamientoclei2@gmail.com', 'FYI');
        
		//$mail->addCC('admisiones02@unicab.org');
        //$mail->addBCC('numericopensamientoclei2@gmail.com');
		//$mail->addAddress('admisiones@unicab.org');
    
        // Attachments
        //$mail->addAttachment('../../assets/descargas/Portafolio_unicab_2022.pdf', 'Portafolio_unicab_2022.pdf');         // Add attachments
        
        // Content
        $mail->isHTML(true);                                  // Set email format to HTML
        $mail->CharSet = 'UTF-8';
        $mail->Subject = $asuntoMensaje;
        $mail->Body    = $cuerpoMensaje;
        //$mail->AltBody = 'This is the body in plain text for non-HTML mail clients';
		
		$mail->send();
        $msg_correo = "CorreoOK";
        
    } catch (Exception $e) {
        //echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
        $msg_correo = "CorreoError";
    }
    
    // ###################### FIN ENVIO DE CORREO ###################
    
	$datos->status = "success";
	$datos->mensaje_correo = $msg_correo;
	echo json_encode($datos, JSON_UNESCAPED_UNICODE);
    	
?>

