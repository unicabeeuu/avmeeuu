<?php
	//require("../registro/docenteunicab/updreg/1cc3s4db.php");
	require("../bd/1cc2s4db.php");
	header("Cache-Control: no-cache, must-revalidate");
	header("Expires: Sat, 1 Jul 2000 05:00:00 GMT");
	//header("Refresh: 30; URL='pen_gra_upddat.php'");
	set_time_limit(300);
	//https://unicab.org/avadmisiones/subir_comprobante_matricula.php
	
	// Habilitar CORS solo para tu entorno local durante desarrollo
	header("Access-Control-Allow-Origin: http://localhost:90");
	header("Access-Control-Allow-Methods: GET, POST"); //, OPTIONS
	header("Access-Control-Allow-Headers: Content-Type");
	
	$datos = new stdClass();
	$datos->status = "error";
	
	date_default_timezone_set('America/Bogota');
	$fecha = time();
	$dia = date("d",$fecha);
	$mes = date("m",$fecha);
	$a = date("Y",$fecha);
	$a1 = date("Y",$fecha);
	$hora = date("H",$fecha);
	$minutos = date("i",$fecha);
	$fecha2 = $a."-".$mes."-".$dia." ".$hora.":".$minutos;
	$fechaHoy = $a."-".$mes."-".$dia;
	if ($mes >= 10) {
		$a1++;
	}
	
	if ($_SERVER['REQUEST_METHOD'] != 'POST') {
		$datos->status = "error";
		$datos->mensaje = "Método no permitido";
		echo json_encode($datos, JSON_UNESCAPED_UNICODE);
		exit;
	}
	
	if (!isset($_FILES['comprobante_matricula'])) {
        echo json_encode(['ok' => false, 'error' => 'No se recibió el archivo']);
        exit;
    }

	$valor = $_REQUEST['valor'];
    $file = $_FILES['comprobante_matricula'];
    $uploadDir = 'comprobantes/matricula/'.$a1."/";
    $allowedTypes = ['pdf', 'png', 'jpg', 'jpeg'];
    $maxSize = 5 * 1024 * 1024; // 5MB

    // Crear carpeta si no existe
    if (!is_dir($uploadDir)) {
        mkdir($uploadDir, 0755, true);
    }

    // Validar tamaño
    if ($file['size'] > $maxSize) {
        $datos->status = "error";
		$datos->mensaje = "Archivo demasiado grande";
        echo json_encode($datos, JSON_UNESCAPED_UNICODE);
		exit;
    }

    // Validar tipo
    $ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
    if (!in_array($ext, $allowedTypes)) {
        $datos->status = "error";
		$datos->mensaje = "Tipo de archivo no permitido";
        echo json_encode($datos, JSON_UNESCAPED_UNICODE);
        exit;
    }

    // Usar el nombre original del archivo
    $fileName = $file['name']; // Así de simple
	$partes = explode("-", $fileName);
	$documento = $partes[0];
    $filePath = $uploadDir . $fileName;
	//$ruta = "https://thriveusa.org/avmeeuu/".$filePath;
	$ruta = "http://localhost:90/avmeeuu/avmeeuu/api/".$filePath;

    //Se valida la estructura del archivo
    $nombre_base = pathinfo($fileName, PATHINFO_FILENAME);
    $patron = '/^\d{5,15}-(2026)-pp$/';
    
    if (preg_match($patron, $nombre_base, $matches)) {
		//$matches[0] contendrá la parte de la cadena que coincide con el patrón completo.
		//$matches[1], $matches[2], etc., contendrán el texto que coincide con las primeras subexpresiones capturadoras (las partes del patrón encerradas entre paréntesis ()).
		
        // El formato es correcto. $matches[1] contendrá "AAAA"
        $fecha_str = $matches[1]; 
        
        if ($fecha_str == $a1) {
            //echo "✅ Válido: El archivo '$fileName' es correcto (Formato OK y Fecha Lógica OK).";            
        } else {
            $datos->status = "error";
			$datos->mensaje = "⚠️ Inválido: Formato OK, pero la fecha '$fecha_str' no es correcta para este proceso de matrícula.";
			echo json_encode($datos, JSON_UNESCAPED_UNICODE);
            exit;
        }
        
    } else {
        $datos->status = "error";
		$datos->mensaje = "❌ El nombre de archivo '$fileName' no cumple con el formato requerido.";
		echo json_encode($datos, JSON_UNESCAPED_UNICODE);
        exit;
    }

    // Mover archivo con su nombre original
    if (move_uploaded_file($file['tmp_name'], $filePath)) {
        // Registro en base de datos
		$sql_comprobante_matricula = "INSERT INTO tbl_asistente_virtual_comprobantes_pago (documento, a, tipo, ruta, valor, validado, rechazado) VALUES 
		('$documento', $a1, 'matrícula', '$ruta', $valor, 0, 0) 
		ON DUPLICATE KEY UPDATE ruta = VALUES(ruta), validado = VALUES(validado), rechazado = VALUES(rechazado)";
		$exe_comprobante_matricula = $mysqli1->query($sql_comprobante_matricula);
		
		//Se envía correo al area financiera
		//header('Location: https://unicab.solutions/avadmisiones_enviosoporte.php?ruta='.rawurlencode($ruta).'&tipo=deuda&documento='.rawurlencode($documento).'&archivo='.rawurlencode($fileName));
		
		// --- En lugar de redirigir, llamamos internamente al servidor B ---
		//$url_solutions = "https://unicab.solutions/avmeeuu_envio_comprobante_matricula_correo.php";
		$url_solutions = "http://localhost:90/avmeeuu/avmeeuu/api/avmeeuu_envio_comprobante_matricula_correo.php";
		$params = [
			'ruta' => $ruta,
			'tipo' => 'TUITION',
			'documento' => $documento,
			'archivo' => $fileName
		];
		// Construir la URL completa con parámetros
		$url_con_params = $url_solutions . '?' . http_build_query($params);

		// Usar cURL para hacer la llamada interna
		$ch = curl_init($url_con_params);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // (solo si estás en entorno local de prueba)
		$respuesta_b = trim(curl_exec($ch));
		$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
		curl_close($ch);
		
		$respuesta_json = json_decode($respuesta_b, true); // el "true" lo convierte en array asociativo
		
		if ($http_code == 200) {
			$datos->status = "success";
			$datos->mensaje = "✅ Válido: El archivo '$fileName' es correcto (Formato OK y Fecha Lógica OK).";
			$datos->respuesta_correo = $respuesta_json['mensaje_correo'];
			echo json_encode($datos, JSON_UNESCAPED_UNICODE);
		} else {
			$datos->status = "success";
			$datos->mensaje = "✅ Válido: El archivo '$fileName' es correcto (Formato OK y Fecha Lógica OK).";
			$datos->respuesta_correo = $respuesta_json['mensaje_correo'];
			echo json_encode($datos, JSON_UNESCAPED_UNICODE);
		}
				
    } else {
        $datos->status = "error";
		$datos->mensaje = "❌ Error al guardar el archivo. Verifica permisos de escritura.";
		echo json_encode($datos, JSON_UNESCAPED_UNICODE);
		exit;
    }
	
?>