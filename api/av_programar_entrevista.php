<?php
    //require("../registro/docenteunicab/updreg/1cc3s4db.php");
	require("../bd/1cc2s4db.php");
	header("Cache-Control: no-cache, must-revalidate");
	header("Expires: Sat, 1 Jul 2000 05:00:00 GMT");
	// Habilitar CORS solo para tu entorno local durante desarrollo
	header("Access-Control-Allow-Origin: http://localhost:90");
	header("Access-Control-Allow-Methods: GET, POST"); //, OPTIONS
	header("Access-Control-Allow-Headers: Content-Type");
	header("Content-Type: application/json; charset=UTF-8");
	//https://unicab.org/avadmisiones/av_programar_entrevista.php
	
	if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
		$datos->status = "error";
		$datos->mensaje = "Disallowed method.";
		echo json_encode($datos, JSON_UNESCAPED_UNICODE);
		exit;
	}
	
	$data = json_decode(file_get_contents("php://input"), true);
	
	$id_psicologo = $data['idpsi']; 
	$fecha = $data['fecha_ent'];
	$hora = $data['hora_ent'];
	$documento_est = $data['documento_est'];
	$psicologo1 = str_replace(" ", "_", $data['psicologo']); 
	$cel_psicologo = $data['cel_psi']; 
	$meet_psicologo = $data['meet_psi'];
	
	$nombre_est = "";	
	//$nombre_a = str_replace(" ", "_", $data['nombrea']);
	$nombre_a = "";
	$email_a = "";
	$cel_a = "";
	
	$datos = new stdClass();
	//echo "control";
	
	//Se buscan los datos del estudiante y acudiente
	$sql_estudiante = "SELECT * FROM tbl_estudiantes WHERE n_documento = '$documento_est'";
	$res_estudiante = $mysqli1->query($sql_estudiante);
	while($row_estudiante = $res_estudiante->fetch_assoc()){
		$nombre_est = $row_estudiante['nombres']." ".$row_estudiante['apellidos'];
		$nombre_a = $row_estudiante['acudiente_1'];
		$email_a = $row_estudiante['email_acudiente_1'];
		$cel_a = $row_estudiante['telefono_acudiente_1'];
	}
	//echo $nombre_est;
	
	//Se valida si ya existe un registro para esa fecha y hora
	$ct = 0;
	$sql_valida_fechahora = "SELECT COUNT(1) ct FROM tbl_entrevistas WHERE id_psicologo = ? AND fecha = ? AND hora = ?";
	$exe_avalida_fechahora = $mysqli1->prepare($sql_valida_fechahora);
	$exe_avalida_fechahora->bind_param("sss", $id_psicologo, $fecha, $hora);
	$exe_avalida_fechahora->execute();
	$result = $exe_avalida_fechahora->get_result();

	while ($row = $result->fetch_assoc()) {
		$ct = $row['ct'];
	}
	//echo $ct;
	
	if ($ct == 0) {
		$sql_ins = "INSERT INTO tbl_entrevistas (id_psicologo, fecha, hora, documento_est, nombre_est, generar_contrato) VALUES 
			($id_psicologo, '$fecha', '$hora', '$documento_est', '$nombre_est', 'NO')";
		//echo $sql_ins;
		$exe_ins = $mysqli1->query($sql_ins);
		
		//Se hace el envío del correo
		//$url_eval_entrevista = "https://unicab.solutions/avmeeuu_programar_entrevista_correo.php";
		$url_eval_entrevista = "http://localhost:90/avmeeuu/avmeeuu/api/avmeeuu_programacion_entrevista_correo.php";
		$params = [
			'noma' => $nombre_a,
			'psi' => $psicologo1,
			'celp' => $cel_psicologo,
			'emaila' => $email_a,
			'cela' => $cel_a,
			'f' => $fecha,
			'h' => $hora,
			'meet' => $meet_psicologo,
			'doc_est' => $documento_est
		];
		//var_dump($params);
		// Construir la URL completa con parámetros
		$url_con_params = $url_eval_entrevista . '?' . http_build_query($params);

		// Usar cURL para hacer la llamada interna
		$ch = curl_init($url_con_params);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // (solo si estás en entorno local de prueba)
		$respuesta_b = trim(curl_exec($ch));
		$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
		curl_close($ch);
		
		$respuesta_json = json_decode($respuesta_b, true); // el "true" lo convierte en array asociativo
		//var_dump($respuesta_json);
		$mensaje_entrevista = "";
		if ($http_code == 200) {
			$mensaje_entrevista = $respuesta_json['mensaje'];
		} else {
			$mensaje_entrevista = $respuesta_json['mensaje'];
		}
		
		$datos->status = "success";
		$datos->mensaje = "Successfully scheduled interview.";
		$datos->mensaje_entrevista = $mensaje_entrevista;
	}
	else {
		$datos->status = "error";
		$datos->mensaje = "Schedule is full for that date and time.";
		$datos->mensaje_entrevista = "";
	}
	
	echo json_encode($datos, JSON_UNESCAPED_UNICODE);
	
	//Se direcciona al envío de correo
    //echo "<script>location.href='https://unicab.solutions/entrevista_correo_us.php?noma=".$nombre_a."&psi=".$psicologo1."&celp=".$cel_psicologo."&emaila=".$email_a."&f=".$fecha."&h=".$hora."&meet=".$meet_psicologo."&cela=".$cel_a."&doc_est=".$documento_est."';</script>";

?>