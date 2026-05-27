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
	
	$documento = $_REQUEST['documento'] ?? '';
	$razon = $_REQUEST['razon'] ?? '';
	
	$datos = new stdClass();
	$datos->status = "error";
	$archivos = [];
	
	if ($_SERVER['REQUEST_METHOD'] != 'POST') {
		$datos->status = "error";
		$datos->mensaje = "Disallowed method";
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
	FROM tbl_asistente_virtual av, tbl_estudiantes e, tbl_grados g, tbl_asistente_virtual_pasos avp 
	WHERE av.documento_estudiante = e.n_documento AND av.id_grado = g.id AND av.paso = avp.paso 
	AND av.documento_estudiante = ? AND av.a = ?";
	$exe_info = $mysqli1->prepare($sql_info);
    $exe_info->bind_param('si', $documento, $fanio);
	$exe_info->execute();
	$result = $exe_info->get_result();

	while ($row = $result->fetch_assoc()) {
		$nombre = $row['nombres']." ".$row['apellidos'];
		$paso = $row['paso'];
		$paso_numero = $row['paso_numero'];
		$id_grado = $row['id_grado'];
		$grado = $row['grado'];
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
	
	$respuesta_jsona = json_decode($respuesta_a, true);*/ // el "true" lo convierte en array asociativo
	
	$filasAfectadasCambioPaso = 0;
	$datos->control_documentos_invalidos = "";
	$sql_paso_anterior = "UPDATE tbl_asistente_virtual 
		SET paso = (SELECT paso FROM tbl_asistente_virtual_pasos WHERE paso_numero = ? - 1000), control_documentos_invalidos = 1 
		WHERE documento_estudiante = ? AND a = ?";
	//$params = [$paso_numero, $documento, $fanio];
	//$datos->consulta_upd_paso = mostrarSentencia($sql_paso_anterior, $params);
	$exe_paso_anterior = $mysqli1->prepare($sql_paso_anterior);
    $exe_paso_anterior->bind_param('isi', $paso_numero, $documento, $fanio);
	if ($exe_paso_anterior->execute()) {
        $filasAfectadasCambioPaso = $exe_paso_anterior->affected_rows;
		$datos->control_documentos_invalidos = "OK";
	}
	else {
		$filasAfectadasCambioPaso = 0;
		$datos->control_documentos_invalidos = "ERROR";
	}
	$datos->filasAfectadasCambioPaso = $filasAfectadasCambioPaso;
	
	//if ($respuesta_jsona['status'] == "success") {
	if ($filasAfectadasCambioPaso > 0 && $datos->control_documentos_invalidos == "OK") {
		//Se actualiza el campo control_documentos_invalidos de tbl_asistente_virtual
		/*$datos->control_documentos_invalidos = "";
		$sql_update_control_documentos_invalidos = "UPDATE tbl_asistente_virtual SET control_documentos_invalidos = 1 WHERE documento_estudiante = ?";
		$exe_update_control_documentos_invalidos = $mysqli1->prepare($sql_update_control_documentos_invalidos);
		$exe_update_control_documentos_invalidos->bind_param('s', $documento);
		if ($exe_update_control_documentos_invalidos->execute()) {
			$datos->control_documentos_invalidos = "OK";
		} else {
			$datos->control_documentos_invalidos = "ERROR";
		}*/
		
		$url_solutions = "https://unicab.solutions/avadmisiones_rechazar_documentos_finales.php";
		$params = [
			'nombree' => $nombre,
			'documento'  => $documento,
			'grado' => $grado,
			'nombrea' => $nombrea,
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
	
	if ($datos->respuesta_correo == "CorreoOK") {
		$datos->status = "success";
		$datos->mensaje = "✅ Final document rejection email successfully sent";
	}
	else {
		$datos->status = "error";
		$datos->mensaje = "❌ Error sending final document rejection email";
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