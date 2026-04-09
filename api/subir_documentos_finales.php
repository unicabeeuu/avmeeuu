<?php
	//require("../registro/docenteunicab/updreg/1cc3s4db.php");
	require("../bd/1cc2s4db.php");
	header("Cache-Control: no-cache, must-revalidate");
	header("Expires: Sat, 1 Jul 2000 05:00:00 GMT");
	//header("Refresh: 30; URL='pen_gra_upddat.php'");
	set_time_limit(300);
	//http://localhost:90/avmeeuu/avmeeuu/api/subir_documentos_finales.php
	
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
	$tipo_documento = $_REQUEST['tipo_documento'];
	$correo_estudiante = $_REQUEST['email'];
	$telefono_estudiante = $_REQUEST['telefono'];
	
	$expedicion = strtoupper($_REQUEST['expedicion']);
	$fecha_nacimiento = $_REQUEST['fecha_nacimiento'];
	$direccion_estudiante = strtoupper($_REQUEST['direccion']);
	$ciudad = strtoupper($_REQUEST['ciudad']);
	
	$nombre_acudiente = strtoupper($_REQUEST['nombreA']);
	$documento_acudiente = $_REQUEST['documentoA'];
	$direccion_acudiente = strtoupper($_REQUEST['direccionA']);
	$celular_acudiente = $_REQUEST['celularA'];
	$correo_acudiente = $_REQUEST['correoA'];
	//echo $nombres." ".$apellidos;

	$nombreCompleto = $_REQUEST['nombres']." ".$_REQUEST['apellidos'];
	//echo $nombreCompleto;
	
	//Se valida si el documento ya existe
	$idest = 0;
	$datos->msg_estudiante = "";
	$datos->msg_matricula = "";
	$sql_buscar = "SELECT * FROM tbl_estudiantes WHERE n_documento = ?";
	$params = [$documento];
	//$datos->consulta_valida_documento = mostrarSentencia($sql_buscar, $params);
	$exe_buscar = $mysqli1->prepare($sql_buscar);
	$exe_buscar->bind_param("s", $documento);
	$exe_buscar->execute();
	$result = $exe_buscar->get_result();

	while ($row = $result->fetch_assoc()) {
		$idest = $row['id'];
		$sql_update = "UPDATE tbl_estudiantes SET fecha_nacimiento = ?, expedicion = ?, ciudad = ?, direccion_estudiante = ?
		WHERE n_documento = ?";
		$params = [$fecha_nacimiento, $expedicion, $ciudad, $direccion_estudiante, $documento];
		//$datos->consulta_update_est = mostrarSentencia($sql_update, $params);
		$exe_update = $mysqli1->prepare($sql_update);
		$exe_update->bind_param("sssss", $fecha_nacimiento, $expedicion, $ciudad, $direccion_estudiante, $documento);
		$exe_update->execute();
	}
	
	//Se actualiza la tabla de matrículas
	//echo $idest;
	if($idest != 0) {
		$msg_estudiante = "EstudianteOK";
		
		//se busca el n_matricula
		$n_matricula = "";
		//$sql_mat = "SELECT n_matricula FROM matricula 
		//WHERE idMatricula = (SELECT MAX(idMatricula) maxid FROM matricula WHERE n_matricula like '%$a1%' AND id_estudiante = $idest)";
		$param_n_matricula = '%'.$a1.'%';
		$sql_mat = "SELECT n_matricula FROM tbl_matriculas 
		WHERE id = (SELECT MAX(id) maxid FROM tbl_matriculas WHERE n_matricula like ? AND id_estudiante = ? )";
		$params = [$param_n_matricula, $idest];
		//$datos->consulta_n_matricula = mostrarSentencia($sql_mat, $params);
		//echo $consulta;
		$exe_mat = $mysqli1->prepare($sql_mat);
		$exe_mat->bind_param("si", $param_n_matricula, $idest);
		$exe_mat->execute();
		$result = $exe_mat->get_result();

		while ($row = $result->fetch_assoc()) {
			$n_matricula = $row['n_matricula'];
		}
		//echo $n_matricula;
		
		//$sql_update1 = "UPDATE matricula SET estado = 'solicitud', EstadoGrado = '$fecha2' WHERE id_estudiante = $idest AND n_matricula = '$n_matricula'";
		if($control_antiguos == 1) {
			$sql_update1 = "UPDATE tbl_matriculas SET estado = 'antiguo_solicitud', estado_grado = ? WHERE id_estudiante = ? AND n_matricula = ?";
		}
		else if($estado == "nuevo") {
			$sql_update1 = "UPDATE tbl_matriculas SET estado = 'nuevo_solicitud', estado_grado = ? WHERE id_estudiante = ? AND n_matricula = ?";
		}
		else {
			$sql_update1 = "UPDATE tbl_matriculas SET estado = 'solicitud', estado_grado = ? WHERE id_estudiante = ? AND n_matricula = ?";
		}		
		$params = [$fecha2, $idest, $n_matricula];
		//$datos->consulta_update_mat = mostrarSentencia($sql_update1, $params);
		//echo $consulta;
		$exe_update1 = $mysqli1->prepare($sql_update1);
		$exe_update1->bind_param("sis", $fecha2, $idest, $n_matricula);
		$exe_update1->execute();
	}
	else {
		$msg_estudiante = "EstudianteError";
	}
	$datos->idGradoIngreso = $idGradoIngreso;
	$datos->msg_estudiante = $msg_estudiante;
	
	//Se valida si quedó el registro en la tabla de matrículas
	$idestmat = 0;
	//$sqlidmat = "SELECT id_estudiante FROM matricula WHERE id_estudiante = $idest";
	$sql_idmat = "SELECT id_estudiante FROM tbl_matriculas WHERE id_estudiante = ?";
	$params = [$idest];
	//$datos->consulta_idestmat = mostrarSentencia($sql_idmat, $params);
	//echo $consulta;
	$exe_idmat = $mysqli1->prepare($sql_idmat);
	$exe_idmat->bind_param("i", $idest);
	$exe_idmat->execute();
	$result = $exe_idmat->get_result();

	while ($row = $result->fetch_assoc()) {
		$idestmat = $row['id_estudiante'];
	}
	
	if($idestmat != 0) {
		$msg_matricula = "MatriculaOK";
	}
	else {
		$msg_matricula = "MatriculaError";
	}
	$datos->msg_matricula = $msg_matricula;
	
	
	//********************************** Se cargan los documentos ************************************************
	if ($msg_estudiante == "EstudianteOK" && $msg_matricula == "MatriculaOK") {
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
			//Esto faltaba... para nuevos
			$documentos[] = 'retiro_SIMAT';
			$documentos[] = 'buena_conducta';
			
			if($idGradoIngreso > 2 && $idGradoIngreso < 7) {
				$documentos[] = 'calificaciones'.$idGradoIngreso - 2;
			}
            else if($idGradoIngreso >= 7 && $idGradoIngreso < 13) {
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
				//$ruta = "https://unicab.org/avadmisiones/".$destination_path;
				$ruta = "http://localhost:90/avmeeuu/avmeeuu/api/".$destination_path;

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
			else if (isset($file_info) && $file_info['error'] !== UPLOAD_ERR_NO_FILE) {
				$archivos_fallidos[] = $input_field_name . " (Código: " . $file_info['error'] . ")";
			}
		}
		$datos->archivos_guardados_info = $archivos_guardados_info;
		$datos->archivos_fallidos = $archivos_fallidos;
		
		if (count($archivos_guardados_info) > 0) {
			//Se consulta el comprobante de pago de matrícula para enviarlo por correo
			$nombre_comprobante = "";
			$ruta_comprobante = "";
			$sql_comprobante_matricula = "SELECT * FROM tbl_asistente_virtual_comprobantes_pago WHERE documento = ? AND a = ? AND tipo = 'matrícula' AND validado = 1";
			$params = [$documento, $a1];
			//$datos->consulta_idestmat = mostrarSentencia($exe_comprobante_matricula, $params);
			//echo $consulta;
			$exe_comprobante_matricula = $mysqli1->prepare($sql_comprobante_matricula);
			$exe_comprobante_matricula->bind_param("si", $documento, $a1);
			$exe_comprobante_matricula->execute();
			$result = $exe_comprobante_matricula->get_result();

			while ($row = $result->fetch_assoc()) {
				$nombre_comprobante = $row['tipo'];
				$ruta_comprobante = $row['ruta'];
			}
			$archivos_guardados_info[] = [
				'documento' => "comprobante_".$nombre_comprobante, 
				'ruta'      => $ruta_comprobante
			];			
			
			//$url_solutions = "https://unicab.solutions/avadmisiones_send_f_antiguos.php";
			$url_solutions = "http://localhost:90/avmeeuu/avmeeuu/api/avmeeuu_admisiones_sent_f_antiguos_correo.php";
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
			$datos->respuesta_correo = $respuesta_json['mensaje_correo'];
		}		
	}	
	
	if ($msg_estudiante == "EstudianteError") {
		$datos->status = "error";
		$datos->mensaje = "❌ Error al guardar información del estudiante.";
	}
	else if ($msg_matricula == "MatriculaError") {
		$datos->status = "error";
		$datos->mensaje = "❌ Error al guardar información de la matrícula.";
	}
	else {
		if (count($archivos_guardados_info) > 0) {
			$datos->status = "success";
			$datos->mensaje = "✅ Documentos y datos guardados con éxito";
		}
		else if (count($archivos_fallidos) > 0) {
			$datos->status = "error";
			$datos->mensaje_fallidos = "❌ Datos guardados con éxito pero algunos documentos fallaron";
		}
		else {
			$datos->status = "error";
			$datos->mensaje_fallidos = "❌ Datos guardados con éxito pero los documentos fallaron";
		}
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