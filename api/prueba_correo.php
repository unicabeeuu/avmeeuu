<?php
    require '../chatbot/librerias/vendor/autoload.php';
    use PHPMailer\PHPMailer\PHPMailer;
	    
    // ###################### INICIO ENVIO DE CORREO ###################
    try {
        //$mail = new PHPMailer(true);
		$mail = new PHPMailer;
    }
    catch(Exception $e) {
        echo $e;
    }
    
    try {

    // Configuración del servidor SMTP
    $mail->isSMTP();
    $mail->Host       = 'smtp.gmail.com';
    $mail->SMTPAuth   = true;
    $mail->Username   = 'g.h.fig.1073@gmail.com';
    $mail->Password   = 'gsel uewf dvjr iqlr';
    //$mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port       = 587;
    $mail->SMTPDebug = 3;
    $mail->Debugoutput = 'html';

    // Remitente
    $mail->setFrom('g.h.fig.1073@gmail.com', 'Mi Web');

    // Destinatario
    $mail->addAddress('g.h.fig.1073@gmail.com');
    $mail->addAddress('nick.figueredofrison@gmail.com');
    // Contenido
    $mail->isHTML(true);
    $mail->Subject = 'Correo de prueba desde PHP';
    $mail->Body    = '<h1>Hola</h1>Correo enviado desde PHP local con PHPMailer';
    $mail->AltBody = 'Correo enviado desde PHP local';

    $mail->send();
    echo 'Correo enviado correctamente';
     $resultado = 'correo ok';

} catch (Exception $e) {
    echo "Error al enviar: {$mail->ErrorInfo}";
     $resultado = 'correo error';
}
    
    // ###################### FIN ENVIO DE CORREO ###################
    
?>

