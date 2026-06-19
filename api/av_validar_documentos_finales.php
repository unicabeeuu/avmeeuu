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
	//echo $id." ".$validado;
	
	$datos = new stdClass();
	$datos->status = "error";
	$archivos = [];
	
	if ($_SERVER['REQUEST_METHOD'] != 'POST') {
		$datos->status = "error";
		$datos->mensaje = "Disallowed method";
		echo json_encode($datos, JSON_UNESCAPED_UNICODE);
		exit;
	}
	
	$tipo_documento = "";
	$documento = "";
	$a = 0;
	$id_grado = 0;
	$correo = -1;
	
	$sql_datos = "SELECT av.*, dm.tipo, dm.correo FROM tbl_asistente_virtual av, tbl_documentos_matriculas dm 
	WHERE av.documento_estudiante = dm.documento AND dm.id = ?";
	//$params = [$id];
	//$datos->consulta_datos = mostrarSentencia($sql_datos, $params);
	$exe_datos = $mysqli1->prepare($sql_datos);
    $exe_datos->bind_param('i', $id);
	$exe_datos->execute();
	$result = $exe_datos->get_result();

	while ($row = $result->fetch_assoc()) {
		$tipo_documento = $row['tipo'];
		$documento = $row['documento_estudiante'];
		$id_grado = $row['id_grado'];
		$a = $row['a'];
		$correo = $row['correo'];
	}
	//echo $tipo_documento;
	
	//Se valida que todos los documentos estén validados
	$ct_doc = 0;
	$ct_val = 0;
	$sql_validacion_documentos = "SELECT COUNT(documento) ct_doc, SUM(validado) ct_val FROM tbl_documentos_matriculas WHERE documento = ? ANd a = ?";
	$exe_validacion_documentos = $mysqli1->prepare($sql_validacion_documentos);
    $exe_validacion_documentos->bind_param('si', $documento, $a);
	$exe_validacion_documentos->execute();
	$result = $exe_validacion_documentos->get_result();

	while ($row = $result->fetch_assoc()) {
		$ct_doc = $row['ct_doc'];
		$ct_val = $row['ct_val'];
	}
	//echo $ct_doc." ".$ct_val;
	$datos->ct_doc = $ct_doc;
	$datos->ct_val = $ct_val;
	
	$datos->respuesta_correo = "";
	$grado_matricula = $id_grado;
	if ($ct_doc > 0 && ($ct_doc - 1) == $ct_val && $correo == 0 && $validado == 1) {
		//Se envía como parámetro el documento
		
		$url_solutions = "https://unicab.solutions/avadmisiones_documentos_finales_validados.php";
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
		$sql = "UPDATE tbl_documentos_matriculas SET validado = ?, correo = 1 WHERE documento = ? AND a = ?";
		$stmt = $mysqli1->prepare($sql);
		$stmt->bind_param('isi', $validado, $documento, $a);
		$datos->mensaje_todos = "✅ Final registration documents successfully validated";
	}
	else {
		$sql = "UPDATE tbl_documentos_matriculas SET validado = ? WHERE id = ?";
		$stmt = $mysqli1->prepare($sql);
		$stmt->bind_param('ii', $validado, $id);
		$datos->mensaje_todos = "❌ Some final registration documents are missing validation";
	}
	
	
	if ($stmt->execute()) {
        $datos->status = "success";
		$datos->mensaje = "✅ Final document $tipo_documento successfully validated";
    } else {
        $datos->status = "error";
		$datos->mensaje = "❌ Error validating the final document $tipo_documento";
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