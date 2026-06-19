<?php
    require("../bd/1cc2s4db.php");
    header("Cache-Control: no-store");
    //http://localhost:90/avmeeuu/avmeeuu/avmeeuu_programacion_entrevista_correo.php
    
    require '../chatbot/librerias/vendor/autoload.php';
    use PHPMailer\PHPMailer\PHPMailer;
    
    $ruta = $_REQUEST['ruta'];
	$tipo = strtoupper($_REQUEST['tipo']);
	$documento = $_REQUEST['documento'];
	$archivo = $_REQUEST['archivo'];
	    
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
        //$mail->addAddress('cartera@unicab.org');     // Add a recipient
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
        $mail->Subject = 'NOTIFICACIÓN DE ENVÍO DE SOPORTE DE PAGO DE '.$tipo;
        $mail->Body    = '<p>Este es un envío de correo automático de UNICAB COLEGIO VIRTUAL.</p>
            <p>El siguiente soporte de pago de '.$tipo.' ha sido subido desde el asitente virtual de admisiones</p>
			<p>Documento: '.$documento.'</p>
			<p>Soporte: '.$ruta.'</p>
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
    $datos = new stdClass();
    
	$datos->status = "success";
	$datos->mensaje_correo = $msg_correo;
	echo json_encode($datos, JSON_UNESCAPED_UNICODE);
    	
?>

