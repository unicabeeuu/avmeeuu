<?php
	//Genera el select de los grados
	require("../registro/docenteunicab/updreg/1cc3s4db.php");
	header("Cache-Control: no-cache, must-revalidate");
	header("Expires: Sat, 1 Jul 2000 05:00:00 GMT");
	//header("Refresh: 30; URL='pen_gra_upddat.php'");
	set_time_limit(300);
	//https://unicab.org/avadmisiones/av_validar_comprobantes.php
	
	// Habilitar CORS solo para tu entorno local durante desarrollo
	header("Access-Control-Allow-Origin: http://localhost:90");
	header("Access-Control-Allow-Methods: POST"); //, OPTIONS
	header("Access-Control-Allow-Headers: Content-Type");
	
	$id = $_REQUEST['id'] ?? '';
	$documento = $_REQUEST['documento'] ?? '';
	$tipo = $_REQUEST['tipo'] ?? '';
	$valor = $_REQUEST['valor'] ?? '';
	$razon = $_REQUEST['razon'] ?? '';
	
	$datos = new stdClass();
	$datos->status = "error";
	$archivos = [];
	
	if ($_SERVER['REQUEST_METHOD'] != 'POST') {
		$datos->status = "error";
		$datos->mensaje = "Método no permitido";
		echo json_encode($datos, JSON_UNESCAPED_UNICODE);
		exit;
	}
	
	date_default_timezone_set('America/Bogota');
	$fecha = time();
	$dia = date("d",$fecha);
	$mes = date("m",$fecha);
	$fanio = date("Y",$fecha);
	$fecha2 =$fanio."/".$mes."/". $dia;
	if($mes >= 10) {
	    $fanio++;
	}
	
	//Se busca la información del estudiante y asistente virtual
	$nombre = "";
	$paso = 0;
	$paso_numero = 0;
	$a = 0;
	$id_grado = 0;
	$grado = "";
	$email = "";
	$nombrea = "";
	$datos->respuesta_correo = "";
	
	$sql_info = "SELECT av.*, avp.paso_numero, e.nombres, e.apellidos, e.acudiente_1, e.email_acudiente_1, g.grado 
	FROM tbl_asistente_virtual av JOIN estudiantes e ON av.documento_estudiante = e.n_documento 
	JOIN tbl_asistente_virtual_pasos avp ON av.paso = avp.paso 
	LEFT JOIN grados g ON av.id_grado = g.id 
	WHERE av.documento_estudiante = ? AND av.a = ?";
	//$params = [$documento, $fanio];
	//$datos->sql_info = mostrarSentencia($sql_info, $params);
	$exe_info = $mysqli1->prepare($sql_info);
    $exe_info->bind_param('si', $documento, $fanio);
	$exe_info->execute();
	$result = $exe_info->get_result();

	while ($row = $result->fetch_assoc()) {
		$nombre = $row['nombres']." ".$row['apellidos'];
		$paso = $row['paso'];
		$paso_numero = $row['paso_numero'];
		$id_grado = $row['id_grado'] > 1 ? $row['id_grado']: 0;
		$grado = $row['id_grado'] > 1 ? $row['grado'] : "";
		$a = $row['a'];
		$email = $row['email_acudiente_1'];
		$nombrea = $row['acudiente_1'];
	}
	$datos->email = $email;
	$datos->paso_numero = $paso_numero;
	
	//Se consume el web service de revertir paso
	/*$msgControl = "paso ".$paso." pendiente";
	$datos->msgControl = $msgControl;
	$url = "https://unicab.org/avadmisiones/av_update_paso_anterior.php";
	$params = [
		'documento'  => $documento,
		'a' => $a,
		'paso' => $paso,
		'msgControl' => $msgControl
	];
	$json_data = json_encode($params);
	// Usar cURL para hacer la llamada interna
	$ch = curl_init($url);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // (solo si estás en entorno local de prueba)
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $json_data);
	curl_setopt($ch, CURLOPT_HTTPHEADER, array(
		'Content-Type: application/json',
		'Content-Length: ' . strlen($json_data)
	));
	$respuesta_a = trim(curl_exec($ch));
	$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
	curl_close($ch);
	
	$respuesta_jsona = json_decode($respuesta_a, true);*/
	
	$filasAfectadasCambioPaso = 0;
	$filasAfectadasRechazo = 0;
	if ($tipo == "matrícula") {
		$sql_paso_anterior = "UPDATE tbl_asistente_virtual 
		SET paso = (SELECT paso FROM tbl_asistente_virtual_pasos WHERE paso_numero = ? - 2000) WHERE documento_estudiante = ? AND a = ?";
	}
	else if ($tipo == "deuda") {
		$sql_paso_anterior = "UPDATE tbl_asistente_virtual 
		SET paso = (SELECT paso FROM tbl_asistente_virtual_pasos WHERE paso_numero = ? - 200) WHERE documento_estudiante = ? AND a = ?";
	}
	//$params = [$paso_numero, $documento, $fanio];
	//$datos->sql_paso_anterior = mostrarSentencia($sql_paso_anterior, $params);
	$exe_paso_anterior = $mysqli1->prepare($sql_paso_anterior);
    $exe_paso_anterior->bind_param('isi', $paso_numero, $documento, $fanio);
	if ($exe_paso_anterior->execute()) {
        $filasAfectadasCambioPaso = $exe_paso_anterior->affected_rows;
	}
	else {
		$filasAfectadasCambioPaso = 0;
	}
	$datos->filasAfectadasCambioPaso = $filasAfectadasCambioPaso;
	$datos->filasAfectadasRechazo = 0;
	
	//if ($respuesta_jsona['status'] == "success") {
	if ($filasAfectadasCambioPaso > 0) {
		//Se actualiza la columna de rechazado
		$sql_upd_rechazado = "UPDATE tbl_asistente_virtual_comprobantes_pago SET rechazado = 1 WHERE id = ? AND documento = ?";
		//$params = [$id, $documento];
		//$datos->sql_upd_rechazado = mostrarSentencia($sql_upd_rechazado, $params);
		$exe_upd_rechazado = $mysqli1->prepare($sql_upd_rechazado);
		$exe_upd_rechazado->bind_param('is', $id, $documento);
		if ($exe_upd_rechazado->execute()) {
			$filasAfectadasRechazo = $exe_upd_rechazado->affected_rows;
		}
		else {
			$filasAfectadasRechazo = 0;
		}
		$datos->filasAfectadasRechazo = $filasAfectadasRechazo;
		
		if ($filasAfectadasRechazo > 0) {
			$url_solutions = "https://unicab.solutions/avadmisiones_rechazar_comprobante.php";
			$params = [
				'nombree' => $nombre,
				'documento'  => $documento,
				'grado' => $grado,
				'nombrea' => $nombrea,
				'tipo' => $tipo,
				'razon' => $razon,
				'email' => $email
			];
			//var_dump($params); 
			// Construir la URL completa con parámetros --- Esto no funciona cuando se envía archivos
			//$url_con_params = $url_solutions . '?' . http_build_query($params);

			// Usar cURL para hacer la llamada interna
			$ch = curl_init($url_solutions);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // (solo si estás en entorno local de prueba)
			curl_setopt($ch, CURLOPT_POST, 1);
			curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
			$respuesta_b = trim(curl_exec($ch));
			$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
			curl_close($ch);
			
			$respuesta_jsonb = json_decode($respuesta_b, true); // el "true" lo convierte en array asociativo
			$datos->respuesta_correo = $respuesta_jsonb['mensaje'];
		}
	}
	
	if ($datos->respuesta_correo == "CorreoOK") {
		$datos->status = "success";
		$datos->mensaje = "✅ Correo de rechazo de comprobante enviado con éxito";
	}
	else {
		$datos->status = "error";
		$datos->mensaje = "❌ Error al enviar correo de rechazo del comprobante";
	}
	
	echo json_encode($datos, JSON_UNESCAPED_UNICODE);
	
	function mostrarSentencia($sql, $params) {
		$consulta = $sql;
		foreach ($params as $param) {
			if ($param === null) {
				$valor = $param;
			}
			else {
				$valor = "'" . $param . "'";
			}
			//echo "<br>".$valor;
			
			$consulta = preg_replace('/\?/', $valor, $consulta, 1);
		}
		return $consulta;
	}
	
?>