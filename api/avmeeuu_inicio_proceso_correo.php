<?php
    require "conexion_org.php";
    require("1cc3s4db_org.php");
    header("Cache-Control: no-store");
    //https://unicab.solutions/avadmisiones_inicio_proceso_correo.php
    
    require 'vendor/autoload.php';
    use PHPMailer\PHPMailer\PHPMailer;
    
    $json_data_original = $_REQUEST['data_original_json'];
	$data = json_decode($json_data_original, true);             // Array con los datos del formulario
    
    date_default_timezone_set('America/Bogota');
    $dia=date("d");
    $mes=date("m");
    $mesLetra=date("M");
    $fanio=date("Y");
    //$faniop=date("Y");
    $espaniol="";
    //echo $fanio;
    if($mes >= 10) {
	    $fanio++;
	}
    
    $fecha2 = $fanio."/".$mes."/". $dia;
    $fecha_cbpp = date("Ymd");
    if($mes == "02") {
        $diapp = 28;
    }
    else {
        $diapp = 30;
    }
    $fecha1_cbpp = $fanio.$mes.$diapp;
    $fecha2_cbpp = date("Ymd",strtotime($fecha1_cbpp."+ 30 days"));
	//echo $fecha2;
	
	$datos = new stdClass();

	$estado = "";
	if ($data['estado'] == "nuevo" || $data['control_antiguos'] == 0 || $data['control_antiguos'] == 2) {
		$estado = "NUEVO";
	}
	else {
		$estado = "ANTIGUO";
	}
	$nombre_completo = strtoupper($data['nombres'])." ".strtoupper($data['apellidos']);
	$documento = $data['documento'];
	$idgra = $data['grado'];
	//Se busca el grado
	$grado = "";
	$sql_grado = "SELECT grado FROM grados WHERE id = $idgra";
	$res_grado = $mysqli1->query($sql_grado);
	while($row_grado = $res_grado->fetch_assoc()){
		$grado = $row_grado['grado'];
	}
	$emailA = $data['correo_acudiente'];
	    
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
		$mail->Host       = 'smtp.hostinger.com';                    // Set the SMTP server to send through
		$mail->SMTPAuth   = true;
        //$mail->Username   = 'numericopensamientoclei2@gmail.com';                     // SMTP username
        //$mail->Username   = 'unicabfinanciera@gmail.com';
        //$mail->Password   = 'Financiera2020#';
        //$mail->Username   = 'sistemasunicab@gmail.com';
        //$mail->Password   = 'psfa0301';
        //$mail->Username   = 'webmasterunicab@unicab.org';
        //$mail->Password   = 'Web.mas2022';
		$mail->Username = 'webmaster@unicab.solutions';
		$mail->Password = 'JsNp4321*';
        //$mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;         // Enable TLS encryption; `PHPMailer::ENCRYPTION_SMTPS` encouraged
        $mail->Port       = 587;
    
        //Recipients
        //$mail->setFrom('sistemasunicab@gmail.com');
        $mail->setFrom('webmaster@unicab.solutions', 'Equipo de Sistemas Unicab');
        //$mail->addAddress('liliasda19@gmail.com');     // Add a recipient
        //$mail->addAddress('unicabfinanciera@gmail.com');     // Add a recipient
        $mail->addAddress($emailA);     // Add a recipient
        //$mail->addReplyTo('numericopensamientoclei2@gmail.com', 'FYI');
        
		$mail->addCC('admisiones02@unicab.org');
        $mail->addBCC('numericopensamientoclei2@gmail.com');
		$mail->addAddress('admisiones@unicab.org');
    
        // Attachments
        //$mail->addAttachment('../../assets/descargas/Portafolio_unicab_2022.pdf', 'Portafolio_unicab_2022.pdf');         // Add attachments
        
        // Content
        $mail->isHTML(true);                                  // Set email format to HTML
        $mail->CharSet = 'UTF-8';
        $mail->Subject = 'INICIO PROCESO ADMISIÓN ESTUDIANTE '.$estado.' '.$fanio;
        $mail->Body    = '<p>Este es un envío de correo automático de UNICAB COLEGIO VIRTUAL.</p>
            <p>El(la) estudiante <strong>'.$nombre_completo.'</strong> con número de documento <strong>'.$documento.'</strong> inicio proceso de admisión a través del Asistente Virtual para el grado '.$grado.'.</p>
			<p>Email acudiente: '.$emailA.'</p>
			<br><p>--</p>
            <p>Áreas de Sistemas</p>
            <p>UNICAB COLEGIO VIRTUAL</p>';
        //$mail->AltBody = 'This is the body in plain text for non-HTML mail clients';
		
		$mail->send();
    
		$msg_correo = "CorreoOK";
        
    } catch (Exception $e) {
        //echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
        $msg_correo = "CorreoError";
        
    }
    
    // ###################### FIN ENVIO DE CORREO ###################
    
    $resultado = $msg_correo;
    
	$datos->status = "success";
	$datos->mensaje = $resultado;
	echo json_encode($datos, JSON_UNESCAPED_UNICODE);
    
    //redireccionamos a unicab.org
	//header('Location: https://unicab.org/admin-unicab/administrador/entrevista_putdat0.php');
    	
?>

