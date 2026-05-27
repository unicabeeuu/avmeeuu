<?php
	//Genera el select de los grados
	require("../bd/1cc2s4db.php");
	header("Cache-Control: no-cache, must-revalidate");
	header("Expires: Sat, 1 Jul 2000 05:00:00 GMT");
	//header("Refresh: 30; URL='pen_gra_upddat.php'");
	set_time_limit(300);
	//https://unicab.org/avadmisiones/av_update_paso.php 1222114726 
	
	// Habilitar CORS solo para tu entorno local durante desarrollo
	header("Access-Control-Allow-Origin: http://localhost:90");
	header("Access-Control-Allow-Methods: POST"); //, OPTIONS
	header("Access-Control-Allow-Headers: Content-Type");
	
	$data = json_decode(file_get_contents("php://input"), true);
	
	$documento = $data['documento'] ?? '';
	$año = $data['a'] ?? '';
	$paso = $data['paso'] ?? '';
	$msgControl = $data['msgControl'] ?? '';
	
	$datos = new stdClass();
	$datos->status = "error";
	$idGrado = 0;
	
	date_default_timezone_set('America/Bogota');
	$fecha = time();
	$dia = date("d",$fecha);
	$mes = date("m",$fecha);
	$a = date("Y",$fecha);
	$hora = date("H",$fecha);
	$minutos = date("i",$fecha);
	$fecha2 = $a."-".$mes."-".$dia." ".$hora.":".$minutos;
	$fechaHoy = $a."-".$mes."-".$dia;
	
	if ($_SERVER['REQUEST_METHOD'] == 'POST') {
		if (!isset($documento)) {
			$datos->status = "error";
			$datos->mensaje = "Required fields are missing";
			echo json_encode($datos, JSON_UNESCAPED_UNICODE);
			exit;
		}
	} 
	else {
		$datos->status = "error";
		$datos->mensaje = "Disallowed method";
		echo json_encode($datos, JSON_UNESCAPED_UNICODE);
		exit;
	}
	
	//Se consulta el paso actual
	$paso_actual = "";
	$sql_paso_actual = "SELECT * FROM tbl_asistente_virtual WHERE documento_estudiante = '$documento' AND a = $año";
	$exe_paso_actual = $mysqli1->query($sql_paso_actual);
    while($row_paso_actual = $exe_paso_actual->fetch_assoc()) {
        $paso_actual = $row_paso_actual['paso'];
    }
	
	$partes = explode(' ', $msgControl);
	$datos->paso_actual = $paso_actual;
	$datos->msgControl = $partes[1];
	
	if($paso_actual == $partes[1] && $partes[2] == "terminado") {
		//Se consulta el siguiente paso
		//echo $paso;
		$paso = str_replace('.', '', $paso);
		$pasoFinal = (int)str_pad($paso, 6, '0', STR_PAD_RIGHT);
		$datos->siguiente_paso = "";
		$datos->paso_numero = 0;
		$datos->etiqueta_intencion = "";
		
		$sql_siguiente_paso = "SELECT * FROM tbl_asistente_virtual_pasos WHERE paso_numero > $pasoFinal ORDER BY paso_numero LIMIT 1";
		//echo $sql_siguiente_paso;
		$exe_siguiente_paso = $mysqli1->query($sql_siguiente_paso);
		while($row_siguiente_paso = $exe_siguiente_paso->fetch_assoc()) {
			$datos->siguiente_paso = $row_siguiente_paso['paso'];
			$datos->paso_numero = $row_siguiente_paso['paso_numero'];
			$datos->etiqueta_intencion = $row_siguiente_paso['etiqueta_intencion'];
		}
		
		//Se actualiza el paso
		$sql_upd_paso = "UPDATE tbl_asistente_virtual SET paso = '$datos->siguiente_paso' WHERE documento_estudiante = '$documento' AND a = $año";
		$exe_upd_paso = $mysqli1->query($sql_upd_paso);
		$datos->sentencia = $sql_upd_paso;
	}
	
	$datos->status = "success";	
	
	echo json_encode($datos, JSON_UNESCAPED_UNICODE);
	
?>