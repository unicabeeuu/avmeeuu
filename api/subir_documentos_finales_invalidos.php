<?php
	require("../registro/docenteunicab/updreg/1cc3s4db.php");
	header("Cache-Control: no-cache, must-revalidate");
	header("Expires: Sat, 1 Jul 2000 05:00:00 GMT");
	//header("Refresh: 30; URL='pen_gra_upddat.php'");
	set_time_limit(300);
	//https://unicab.org/avadmisiones/subir_documentos_finales.php
	
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
	
	$documento = $_REQUEST['documento'];
	//echo "documento: ".$documento;
	$estado = $_REQUEST['estado'];
	$control_antiguos = $_REQUEST['control_antiguos'];

	$apellidos = strtoupper($_REQUEST['apellidos']);
	$nombres = strtoupper($_REQUEST['nombres']);
	$gradoIngreso = $_REQUEST['grado'];
	$idGradoIngreso = $_REQUEST['idGrado'];
	/*$tipo_documento = $_REQUEST['tipo_documento'];
	$correo_estudiante = $_REQUEST['email'];
	$telefono_estudiante = $_REQUEST['telefono'];
	
	$expedicion = strtoupper($_REQUEST['expedicion']);
	$fecha_nacimiento = $_REQUEST['fecha_nacimiento'];
	$direccion_estudiante = strtoupper($_REQUEST['direccion']);
	$ciudad = strtoupper($_REQUEST['ciudad']);
	
	$nombre_acudiente = strtoupper($_REQUEST['nombreA']);
	$documento_acudiente = $_REQUEST['documentoA'];
	$direccion_acudiente = strtoupper($_REQUEST['direccionA']);
	$celular_acudiente = $_REQUEST['celularA'];*/
	$correo_acudiente = $_REQUEST['correoA'];
	//echo $nombres." ".$apellidos;

	$nombreCompleto = $_REQUEST['nombres']." ".$_REQUEST['apellidos'];
	//echo $nombreCompleto;
	
	//********************************** Se cargan los documentos ************************************************
	$documentos = [
		'contrato',
		'pagare',
		'documento_estudiante',
		'actividad_extra',
		'foto',
		'eps',
		'vacunas',
		'paz_salvo'
	];
	//var_dump($documentos);
	
	//Se agregan los certificados finales de calificaciones 
	if($estado == "nuevo" || $control_antiguos == 2) {
		if($idGradoIngreso >= 7 && $idGradoIngreso < 13) {
			for ($i = 5; $i < $idGradoIngreso - 1; $i++) {
				$documentos[] = 'calificaciones'.$i;
			}
		}
		else if($idGradoIngreso == 14) {
			$documentos[] = 'calificaciones3';
		}
		else if($idGradoIngreso == 15) {
			$documentos[] = 'calificaciones5';
		}
		else if($idGradoIngreso == 16) {
			$documentos[] = 'calificaciones7';
		}
		else if($idGradoIngreso == 17) {
			$documentos[] = 'calificaciones9';
		}
		else if($idGradoIngreso == 18) {
			$documentos[] = 'calificaciones10';
		}
		else {
			if($idGradoIngreso >= 3) {
				$documentos[] = 'calificaciones'.$idGradoIngreso - 2;
			}
		}
	}
	
	$documentos[] = 'documento_acudiente';
	//var_dump($documentos);

	// Variables para almacenar resultados
	$archivos_guardados_info = [];
	$archivos_fallidos = [];

	$uploadDir = 'documentos/matricula/'.$a1."/".$idGradoIngreso."/".$documento."/";
	// Crear carpeta si no existe
	if (!is_dir($uploadDir)) {
		mkdir($uploadDir, 0755, true);
	}
	
	foreach ($documentos as $input_field_name) {
	
		$file_info = $_FILES[$input_field_name] ?? null;

		// Solo entramos si el campo existe y la subida fue exitosa (código 0)
		// Se ignora automáticamente UPLOAD_ERR_NO_FILE (código 4) que indica que el campo está vacío.
		if (isset($file_info) && $file_info['error'] === UPLOAD_ERR_OK) {
			
			$file_name = $file_info['name']; 
			$file_tmp_path = $file_info['tmp_name'];
			$file_type = $file_info['type'];
			
			// Asignación del nombre con prefijo
			$safe_file_name = $input_field_name . '_' . $file_name;
			$destination_path = $uploadDir.$safe_file_name;
			$ruta = "https://unicab.org/avadmisiones/".$destination_path;

			// Mover el archivo
			if (move_uploaded_file($file_tmp_path, $destination_path)) {
				$archivos_guardados_info[] = [
					'documento' => $safe_file_name, 
					'ruta' => $ruta
				];
				
				// Registro en base de datos
				$sql_documento_matricula = "INSERT INTO tbl_documentos_matriculas (documento, a, tipo, ruta, validado) VALUES 
				('$documento', $a1, '$input_field_name', '$ruta', 0) 
				ON DUPLICATE KEY UPDATE ruta = VALUES(ruta), validado = VALUES(validado)";
				$exe_documento_matricula = $mysqli1->query($sql_documento_matricula);				
				
			} else {
				$archivos_fallidos[] = $safe_file_name;				
			}
		} 
		elseif (isset($file_info) && $file_info['error'] !== UPLOAD_ERR_NO_FILE) {
			$archivos_fallidos[] = $input_field_name . " (Código: " . $file_info['error'] . ")";
		}
	}
	$datos->archivos_guardados_info = $archivos_guardados_info;
	$datos->archivos_fallidos = $archivos_fallidos;
	
	$filasAfectadasControlDocumentosInvalidos = 0;
	
	if (count($archivos_guardados_info) > 0) {
		//Se actualiza el campo control_documentos_invalidos 
		$sql_upd_control_documentos_invalidos = "UPDATE tbl_asistente_virtual SET control_documentos_invalidos = 0 WHERE documento_estudiante = ? AND a = ?";
		$exe_upd_control_documentos_invalidos = $mysqli1->prepare($sql_upd_control_documentos_invalidos);
		$exe_upd_control_documentos_invalidos->bind_param('si', $documento, $a1);
		if ($exe_upd_control_documentos_invalidos->execute()) {
			$filasAfectadasControlDocumentosInvalidos = $exe_upd_control_documentos_invalidos->affected_rows;
		}
		else {
			$filasAfectadasControlDocumentosInvalidos = 0;
		}
		$datos->filasAfectadasControlDocumentosInvalidos = $filasAfectadasControlDocumentosInvalidos;
		
		$url_solutions = "https://unicab.solutions/avadmisiones_send_f_documentos_invalidos.php";
		// 1. Codificar los arrays a JSON (Cadenas de texto)
		$metadata_success_json = json_encode($archivos_guardados_info);
		$metadata_failed_json = json_encode($archivos_fallidos);
		$data_original_json = json_encode($_POST);
		$params = [
			'data_original_json' => $data_original_json,
			'archivos_guardados_json' => $metadata_success_json, 
			'archivos_fallidos_json'  => $metadata_failed_json,
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
		
		$respuesta_json = json_decode($respuesta_b, true); // el "true" lo convierte en array asociativo
		$datos->respuesta_correo = $respuesta_json['mensaje'];
	}	
	
	if (count($archivos_guardados_info) > 0) {
		$datos->status = "success";
		$datos->mensaje = "✅ Documentos inválidos guardados con éxito";
	}
	else if (count($archivos_fallidos) > 0) {
		$datos->status = "error";
		$datos->mensaje_fallidos = "❌ Algunos documentos fallaron";
	}
	else {
		$datos->status = "error";
		$datos->mensaje_fallidos = "❌ Los documentos fallaron";
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