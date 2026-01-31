 <?php 
 	//require "../../php/conexion.php";
	require "../admin-unicab/php/conexion.php";
	// Habilitar CORS solo para tu entorno local durante desarrollo
	//header("Access-Control-Allow-Origin: http://localhost:90");
	//header("Access-Control-Allow-Methods: GET, POST"); //, OPTIONS
	//header("Access-Control-Allow-Headers: Content-Type");
	//https://unicab.org/avadmisiones/av_programar_eval_admision.php?nombree=GREGORY&apellidoe=FIGUEREDO&documentoe=93974543&selgrado=7&email=gregory.figueredo@unicab.org

	$nombree = strtoupper($_REQUEST['nombree']);
	$apellidoe = strtoupper($_REQUEST['apellidoe']);
	$documentoe = $_REQUEST['documentoe'];
	$selgrado = $_REQUEST['selgrado'];
	$email = $_REQUEST['email'];
	$nombreCompleto = $nombree." ".$apellidoe;
	//echo nombreCompleto;
	
	// fecha publicado
	date_default_timezone_set('America/Bogota');
	$fecha = time();
	$dia = date("d",$fecha);
	$mes = date("m",$fecha);
	$fanio = date("Y",$fecha);
	if($mes >= 10) {
		$fanio++;
	}

	$fechaHoy = $fanio."/".$mes."/".$dia;
	// fecha publicado
	
	$datos = new stdClass();
	
	//Se valida que el documento y grado ya existan
	$sql_val = "SELECT COUNT(1) ct FROM estudiantes_eval_admision WHERE n_documento = '$documentoe' AND id_grado = ".$selgrado." AND año = $fanio";
	$exe_val = mysqli_query($conexion, $sql_val);
	while ($row_val = mysqli_fetch_array($exe_val)) {
		$ct = $row_val["ct"];
	}
	
	if ($ct == 0) {
		try {	
			$sql_ins = "INSERT INTO estudiantes_eval_admision (nombre, n_documento, id_grado, email, observaciones, origen, año) 
			VALUES ('$nombreCompleto', '$documentoe', $selgrado, '$email', '', 'Institución Oficial', $fanio)";
			//echo $sql_prem;
			$exe_ins = mysqli_query($conexion, $sql_ins);	
		
			$datos->status = "success";
			$datos->mensaje = "Evaluación de admisión programada con éxito";
				
		} catch (Exception $e) {
			$datos->status = "error";
			$datos->mensaje = "Evaluación de admisión no programada";
		}
	}
	else {
		$datos->status = "success";
		$datos->mensaje = "Este documento ya tiene un registro de evaluación de admisión para el grado ".$selgrado;
	}
	//$datos->status = "success";
	echo json_encode($datos, JSON_UNESCAPED_UNICODE);
	
?>