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
	$validado = $_REQUEST['validado'] ?? '';
	
	$datos = new stdClass();
	$datos->status = "error";
	$archivos = [];
	
	if ($_SERVER['REQUEST_METHOD'] != 'POST') {
		$datos->status = "error";
		$datos->mensaje = "Método no permitido";
		echo json_encode($datos, JSON_UNESCAPED_UNICODE);
		exit;
	}
	
	$control_antiguos = 0;
	$tipo_comprobante = "";
	$documento = "";
	$a = 0;
	$id_grado = 0;
	$correo = -1;
	
	$sql_datos = "SELECT av.*, cp.tipo, cp.correo FROM tbl_asistente_virtual av, tbl_asistente_virtual_comprobantes_pago cp 
	WHERE av.documento_estudiante = cp.documento AND cp.id = ?";
	$exe_datos = $mysqli1->prepare($sql_datos);
    $exe_datos->bind_param('i', $id);
	$exe_datos->execute();
	$result = $exe_datos->get_result();

	while ($row = $result->fetch_assoc()) {
		$control_antiguos = $row['control_antiguos'];
		$tipo_comprobante = $row['tipo'];
		$documento = $row['documento_estudiante'];
		$id_grado = $row['id_grado'];
		$a = $row['a'];
		$correo = $row['correo'];
	}
	
	$datos->respuesta_correo = "";
	$grado_matricula = $id_grado;
	if ($tipo_comprobante == "matrícula" && $validado == 1 && $control_antiguos == 1 && $documento != "" && $correo == 0) {
		//echo "control";
		//Enviar correo con contrato, paz y salvo y certificado final. Se envía como parámetro el documento
		
		//Se consulta el contrato
		$ruta = "";
		$sql_contrato = "SELECT * FROM tbl_contratos WHERE n_documento = ? AND año = ?";
		$params = [$documento, $a];
		//$datos->consulta_contrato = mostrarSentencia($sql_contrato, $params);
		//echo $consulta;
		$exe_contrato = $mysqli1->prepare($sql_contrato);
		$exe_contrato->bind_param("si", $documento, $a);
		$exe_contrato->execute();
		$result = $exe_contrato->get_result();

		while ($row = $result->fetch_assoc()) {
			$ruta = $row['ruta'];
		}
		$archivos[] = [
			'documento' => "Contrato", 
			'ruta'      => $ruta
		];		
		
		//Se consulta el paz y salvo
		$ruta = "";
		$a1 = $a - 1;
		$sql_pazsalvo = "SELECT * FROM tbl_pazysalvos WHERE identificacion = ? AND a = ?";
		//$params = [$documento, $a1];
		//$datos->consulta_pazysalvo = mostrarSentencia($sql_pazsalvo, $params);
		//echo $consulta;
		$exe_pazsalvo = $mysqli1->prepare($sql_pazsalvo);
		$exe_pazsalvo->bind_param("si", $documento, $a1);
		$exe_pazsalvo->execute();
		$result = $exe_pazsalvo->get_result();

		while ($row = $result->fetch_assoc()) {
			$ruta = $row['ruta'];
		}
		$archivos[] = [
			'documento' => "Paz y salvo", 
			'ruta'      => $ruta
		];
		
		//Se consulta el certificado final de calificaciones
		$ruta = "";
		$id_grado = $id_grado - 1;
		$sql_certificado = "SELECT * FROM tbl_certificados WHERE identificacion = ? AND numero like '%CFF%' AND a = ? AND tipo_certificado = 'Certificado final' AND id_grado = ?";
		//$params = [$documento, $a1, $id_grado];
		//$datos->consulta_certificado_final = mostrarSentencia($sql_certificado, $params);
		//echo $consulta;
		$exe_certificado = $mysqli1->prepare($sql_certificado);
		$exe_certificado->bind_param("sii", $documento, $a1, $id_grado);
		$exe_certificado->execute();
		$result = $exe_certificado->get_result();

		while ($row = $result->fetch_assoc()) {
			$ruta = $row['ruta'];
		}
		$archivos[] = [
			'documento' => "Certificado final de calificaciones", 
			'ruta'      => $ruta
		];
		//var_dump($archivos);
		
		$url_solutions = "https://unicab.solutions/avmeeuu_documentos_matricula_correo.php";
		// 1. Codificar los arrays a JSON (Cadenas de texto)
		$archivos_json = json_encode($archivos);
		$data_original_json = json_encode($_POST);
		$params = [
			'data_original_json' => $data_original_json,
			'archivos_json' => $archivos_json, 
			'documento'  => $documento,
			'grado_matricula' => $grado_matricula
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
	else if ($tipo_comprobante == "matrícula" && $validado == 1 && $documento != "" && $correo == 0) {
		//echo "control matrícula";
		//Enviar correo con contrato. Se envía como parámetro el documento
		
		//Se consulta el contrato
		$ruta = "";
		$sql_contrato = "SELECT * FROM tbl_contratos WHERE n_documento = ? AND año = ?";
		$params = [$documento, $a];
		//$datos->consulta_contrato = mostrarSentencia($sql_contrato, $params);
		$exe_contrato = $mysqli1->prepare($sql_contrato);
		$exe_contrato->bind_param("si", $documento, $a);
		$exe_contrato->execute();
		$result = $exe_contrato->get_result();

		while ($row = $result->fetch_assoc()) {
			$ruta = $row['ruta'];
		}
		$archivos[] = [
			'documento' => "Contrato", 
			'ruta'      => $ruta
		];
		//echo $ruta;
		//var_dump($archivos);
		
		$url_solutions = "https://unicab.solutions/avmeeuu_documentos_matricula_correo.php";
		// 1. Codificar los arrays a JSON (Cadenas de texto)
		$archivos_json = json_encode($archivos);
		$data_original_json = json_encode($_POST);
		$params = [
			'data_original_json' => $data_original_json,
			'archivos_json' => $archivos_json, 
			'documento'  => $documento,
			'grado_matricula' => $grado_matricula
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
	else if ($tipo_comprobante == "deuda" && $validado == 1 && $documento != "" && $correo == 0) {
		//echo "control deuda";
		//Se envía como parámetro el documento
		
		$url_solutions = "https://unicab.solutions/avmeeuu_comprobante_deuda_validado_correo.php";
		// 1. Codificar los arrays a JSON (Cadenas de texto)
		$data_original_json = json_encode($_POST);
		$params = [
			'data_original_json' => $data_original_json,
			'documento'  => $documento,
			'grado_matricula' => $grado_matricula
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
	
	if ($datos->respuesta_correo == "CorreoOK") {
		$sql = "UPDATE tbl_asistente_virtual_comprobantes_pago SET validado = ?, correo = 1 WHERE id = ?";
	}
	else {
		$sql = "UPDATE tbl_asistente_virtual_comprobantes_pago SET validado = ? WHERE id = ?";
	}
	$stmt = $mysqli1->prepare($sql);
	$stmt->bind_param('ii', $validado, $id);
	
	if ($stmt->execute()) {
        $datos->status = "success";
		$datos->mensaje = "✅ Comprobante validado con éxito";
    } else {
        $datos->status = "error";
		$datos->mensaje = "❌ Error al validar el comprobante";
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