<?php
    require("../bd/1cc2s4db.php");
    header("Cache-Control: no-store");
    //http://localhost:90/avmeeuu/avmeeuu/avmeeuu_programacion_entrevista_correo.php
    
    require '../chatbot/librerias/vendor/autoload.php';
    use PHPMailer\PHPMailer\PHPMailer;
    
    $nombrea = str_replace("_", " ", $_REQUEST['noma']);
    $psi = str_replace("_", " ", $_REQUEST['psi']);
    $celp = $_REQUEST['celp'];
    $emaila = $_REQUEST['emaila'];
    $cela = $_REQUEST['cela'];
    $f = $_REQUEST['f'];
    $h = $_REQUEST['h'];
    $meet = $_REQUEST['meet'];
    $doc_est = $_REQUEST['doc_est'];
    //echo $doc_est;
    
    date_default_timezone_set('America/Bogota');
    $dia=date("d");
    $mes=date("m");
    $mesLetra=date("M");
    $fanio=date("Y");
    //$faniop=date("Y");
    $espaniol="";
    //echo $fanio;
    if($mes >= 12) {
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
        //$mail->addAddress('liliasda19@gmail.com');     // Add a recipient
        //$mail->addAddress('unicabfinanciera@gmail.com');     // Add a recipient
        $mail->addAddress($emaila);     // Add a recipient
        //$mail->addReplyTo('numericopensamientoclei2@gmail.com', 'FYI');
        
		//$mail->addCC('admisiones02@unicab.org');
        $mail->addBCC('numericopensamientoclei2@gmail.com');
		//$mail->addAddress('admisiones@unicab.org');
    
        // Attachments
        //$mail->addAttachment('../../assets/descargas/Portafolio_unicab_2022.pdf', 'Portafolio_unicab_2022.pdf');         // Add attachments
        
        // Content
        $mail->isHTML(true);                                  // Set email format to HTML
        $mail->CharSet = 'UTF-8';
        $mail->Subject = 'CONFIRMACION ENTREVISTA ';
        $mail->Body    = '<p>Señor(a): </p>
            <p>'.strtoupper($nombrea).'</p>
            <p style="text-align: justify">Reciba un cordial saludo de bienvenida por parte del Colegio UNICAB Virtual, agradecemos que nos hayan contactado y deseamos éxito en sus labores diarias.</p>
            <p style="text-align: justify">El perfil de los estudiantes que culminan su año lectivo con nosotros, es el de ser un ser humano <strong>activo, autónomo, creativo y talentoso</strong> ya que nuestro servicio se presta a través de un modelo innovador el cual es mediado a través de nuestra plataforma tecnológica Moodle y maestros mediadores, para que el estudiante desarrolle sus habilidades y talentos en el deporte, las artes, las ciencias y la cultura entre otras.</p>
            <p>Atentamente nos permitimos enviar los datos para la entrevista con el área de psicología:</p>
            <p><strong>Ps.</strong> '.$psi.'</p>
            <p><strong>Whatsapp:</strong> '.$celp.'</p>
            <p><strong>Enlace GOOGLE MEET:</strong> '.$meet.'</p>
            <p><strong>Fecha:</strong> '.$f.'</p>
            <p><strong>Hora:</strong> '.$h.'</p>
            <p><strong>Identificación estudiante:</strong> '.$doc_est.'</p>
            <p style="text-align: justify">Tener en cuenta contactar 10 minutos antes al Whatsapp '.$celp.'. El tiempo máximo de espera es de 10 minutos después de la hora asignada, de no presentarse a tiempo deberá asignarse nuevamente.</p>
			<p>Es <strong>OBLIGATORIO</strong> que el <strong>ACUDIENTE</strong> debe estar presente en la entrevista.</p>
            <p style="color: red; text-align: justify"><strong>NOTA:</strong> En caso de no poder asistir por favor ingresar nuevamente a nuestro <a href="https://unicab.org/avadmisiones/avadmisiones" target="_blank"><strong>asistente virtual (Clic AQUÍ) <img src="https://unicab.org/avadmisiones/img/unibot3.png" style="width: 5%;"></strong></a> para realizar la reprogramación de la misma.</p>
			<hr>
			<!--<p>Se anexa nuestro portafolio con la información de la Institución y un link con un formulario de Informe de Procedencia para ser diligenciado por parte del acudiente 
                del estudiatne y de esta manera pueda ser evaluado por el equipo de Psicología previo a la fecha de la entrevista.</p>
            <p><a href="https://forms.gle/9AHSC6i7hoRJ7Tig6" target="_blank">Descargar Informe de Procedencia</a></p>-->
            <p>Adjuntamos también nuestro <a href="https://unicab.org/assets/descargas/Portafolio_2024.pdf" target="_blank">Portafolio Unicab</a></p>

            <p>NOTA: Este es un sistema de envío automático de correos. Por favor no contestar a este email.</p>
            <p></p>
            <br><p>Atentamente</p>
            <p>--</p>
            <p><img src="https://www.unicab.org/assets/img/firma_correo_entrevista2.jpg" width="600px"/></p>';
        //$mail->AltBody = 'This is the body in plain text for non-HTML mail clients';
		
		if ($emaila != "") {
			$mail->send();
			//echo 'Message has been sent';
			$msg_correo = "CorreoOK";
		}
		else {
			$msg_correo = "CorreoError";
		}
        
    } catch (Exception $e) {
        //echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
        $msg_correo = "CorreoError";
        
    }
    
    // ###################### FIN ENVIO DE CORREO ###################
    
    $resultado = $msg_correo.'_'.$emaila;
    
	$datos->status = "success";
	$datos->mensaje = $resultado;
	echo json_encode($datos, JSON_UNESCAPED_UNICODE);
    
    //redireccionamos a unicab.org
	//header('Location: https://unicab.org/admin-unicab/administrador/entrevista_putdat0.php');
    	
?>

