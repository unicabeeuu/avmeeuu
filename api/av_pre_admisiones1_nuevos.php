<?php
	//include "../admin-unicab/php/conexion.php";
    //require("../registro/docenteunicab/updreg/1cc3s4db.php");
	require("../bd/1cc2s4db.php");
	header("Cache-Control: no-cache, must-revalidate");
	header("Expires: Sat, 1 Jul 2000 05:00:00 GMT");
	//header("Refresh: 30; URL='pen_gra_upddat.php'");
	set_time_limit(300);
	//https://unicab.org/avadmisiones/av_pre_admisiones1_nuevos.php 
	
	// Habilitar CORS solo para tu entorno local durante desarrollo
	header("Access-Control-Allow-Origin: http://localhost:90");
	header("Access-Control-Allow-Methods: POST"); //, OPTIONS
	header("Access-Control-Allow-Headers: Content-Type");
	header("Content-Type: application/json; charset=UTF-8");
	
	$datos = new stdClass();
	//echo "control";
	
	if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
		$datos->status = "error";
		$datos->mensaje = "Disallowed method.";
		echo json_encode($datos, JSON_UNESCAPED_UNICODE);
		exit;
	}
	
	$data = json_decode(file_get_contents("php://input"), true);
	//echo json_encode($data, JSON_UNESCAPED_UNICODE);
	
	/*if (json_last_error() !== JSON_ERROR_NONE) {
		$datos->status = "error";
		$datos->mensaje = "Invalid data.";
		echo json_encode($datos, JSON_UNESCAPED_UNICODE);
		exit;
	}*/
	
    require '../chatbot/librerias/PhpSpreadsheet/vendor/autoload.php';
    
    use PhpOffice\PhpSpreadsheet\Spreadsheet;
    use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
    use \PhpOffice\PhpSpreadsheet\IOFactory;
    
    $apellidos = strtoupper($data['apellidos']);
    $nombres = strtoupper($data['nombres']);
    $idgra = $data['grado'];
    $tdoc = $data['td'];
    $td_text = strtoupper($data['td_text']);
    $cel = $data['telefono'];
    $email = $data['correo'];
    $rh = strtoupper($data['factor_rh']);
	$rh = str_replace("mas", "+", $rh);
	$rh = str_replace("menos", "-", $rh);
	$rh = str_replace("positivo", "+", $rh);
	$rh = str_replace("negativo", "-", $rh);
	$medio = strtoupper($data['medio_llegada']);
    $extra = strtoupper($data['actividad_extra']);
	$genero = strtoupper($data['genero']);
	$situacion = strtoupper($data['situacion_se']);
    
	$documento = $data['documento'];
	$estado = $data['estado'];
	$control_antiguos = $data['control_antiguos'];
    
    $nombre_completo = $apellidos." ".$nombres;
    
    $nombreA = strtoupper($data['nombre_acudiente']);
    $documentoA = $data['documento_acudiente'];
    $dirA = strtoupper($data['direccion_acudiente']);
    $celA = $data['celular_acudiente'];
    $emailA = $data['correo_acudiente'];
	$parentesco1 = strtoupper($data['parentesco']);
    
    /*if(is_null($fn)) {
		//No hace nada
	}
	else {
		$partesfn = explode("-", $fn);
	}*/
	
	//Se busca el grado
	$grado = "";
	$sql_grado = "SELECT grado FROM tbl_grados WHERE id = $idgra";
	$res_grado = $mysqli1->query($sql_grado);
	while($row_grado = $res_grado->fetch_assoc()){
		$grado = $row_grado['grado'];
	}
    
    date_default_timezone_set('America/Bogota');
    $dia = date("d");
    $mes = date("m");
    $mesLetra = date("M");
    $fanio = date("Y");
    $fanio1 = date("Y");
    $espaniol = "";
    //echo $fanio;
    $fecha2 = $fanio."/".$mes."/".$dia;
	$fecha2_yyyymmdd = $fanio.$mes.$dia;
	$controlfinaño = "NO";
    
    if($mes >= 10) {
	    $fanio++;
		$controlfinaño = "OK";
	}
    
    $fecha3 = $fanio."/01/".$dia;
    $fecha_cbpp = date("Ymd");
    if($mes == "02") {
        $diapp = 28;
    }
    else {
        $diapp = 30;
    }
    $fecha1_cbpp = $fanio.$mes.$diapp;
    $fecha2_cbpp = date("Ymd",strtotime($fecha1_cbpp."+ 30 days"));
	//echo $fecha2;
	
	switch ($mes) {
    	case '1':
    		$espaniol="Enero"; 
    		break;
    	case '2':
    		$espaniol="Febrero";
    		break;
    	case '3':
    		$espaniol="Marzo";
    		break;
    	case '4':
    		$espaniol="Abril";
    		break;
    	case '5':
    		$espaniol="Mayo";
    		break;
    	case '6':
    		$espaniol="Junio";
    		break;
    	case '7':
    		$espaniol="Julio";
    		break;
    	case '8':
    		$espaniol="Agosto";
    		break;
    	case '9':
    		$espaniol="Septiembre";
    		break;
    	case '10':
    		$espaniol="Octubre";
    		break;
    	case '11':
    		$espaniol="Noviembre";
    		break;
    	case '12':
    		$espaniol="Diciembre";
    		break;
    }
    
    $codigo = "";
	$sa1 = ["q","a","1","z","x","2","s","w","3","p","l","4","m","k","5","o","e","6",
            "d","c","7","i","j","8","n","r","9","f","v","0","u","h","b","t","g"];
	$meses = ["", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"];
	
	for($i = 1; $i <=10; $i++) {
		$ale=mt_rand(1,sizeof($sa1));
		$codigo = $codigo.$sa1[$ale-1];
	}
	//$codigo = "VER_".$codigo;
	//echo $codigo;
	
	//Se valida si el documento ya tiene código de pre-matrícula para el año lectivo
	$ct_pre = 0;
	$sql = "SELECT COUNT(1) ct, codigo FROM tbl_cod_pre_matricula WHERE identificacion = $documento AND periodo_lectivo = $fanio 
	GROUP BY codigo";
	//echo $sql;
	
	$res_sql=$mysqli1->query($sql);
    while($row_sql = $res_sql->fetch_assoc()){
        $ct_pre = $row_sql['ct'];
        $codigo = $row_sql['codigo'];
    }
    //echo "<br>".$codigo;
    //echo $ct_pre;
    if($ct_pre == 0) {
        $sql_insert0 = "INSERT INTO tbl_cod_pre_matricula (identificacion, periodo_lectivo, codigo, email_pre_mat) VALUES 
        ($documento, $fanio, '$codigo', '$email')";
        //echo $sql_insert0;
        $res_insert0=$mysqli1->query($sql_insert0);
    } 
    
    //**************************************************************************************************************
    //Se actualizan las tablas de estudiantes con los pagos y matrículas
    
    //Se valida la fecha actual con respecto a los cierres de periodo para el periodo de ingreso
    $per = 1;
	if(date($fecha2) >= date('2025/10/01') && date($fecha2) < date('2026/03/21')) {
	    $per = 1;
		$comienzocontrato = "2026/02/02";
	}
	else if(date($fecha2) >= date('2026/03/22') && date($fecha2) < date('2026/05/31')) {
	    $per = 2;
		$comienzocontrato = "2026/03/22";
	}
	else if(date($fecha2) >= date('2026/06/01') && date($fecha2) < date('2026/08/23')) {
	    $per = 3;
		$comienzocontrato = "2026/06/01";
	}
	else if(date($fecha2) >= date('2026/08/24')) {
	    $per = 4;
		$comienzocontrato = "2026/08/24";
	}
	
	$fincontrato = "2026/11/14";
	//echo "<br> per=".$per." comienzo contrato=".$comienzocontrato;
	//beca = 0 -> sin beca; = 1 media beca; = 2 beca completa
	//pension_a -> es la nueva pensión de promoción anticipada
	$beca = 0;
    $descuento = 0;
    $ct_pagos = 0;
        
	/*$sql_beca = "SELECT * FROM tbl_becas WHERE identificacion = $documento AND periodo_lectivo = 2026";
	$res_beca=$mysqli1->query($sql_beca);
    while($row_beca = $res_beca->fetch_assoc()){
        $beca = $row_beca['beca'];
        $descuento = $row_beca['descuento'];
        $ct_pagos = $row_beca['ct_pagos'];
    }*/
    
    $sql_costos = "SELECT * FROM tbl_costos WHERE a = $fanio AND id_grado = $idgra";
    //echo $sql_costos;
	$res_costos=$mysqli1->query($sql_costos);
    while($row_costos = $res_costos->fetch_assoc()){
        $matricula = $row_costos['matricula'];
        $pension = $row_costos['pension'];
        $ocp = $row_costos['ocp'];
        $poliza = $row_costos['poliza'];
        $dg = $row_costos['dg'];
        $pp = $row_costos['pp'];
    }
    
    if($idgra > 16) {
        if($per == 2) {
            $pagos_anuales_de = 2.5;
			$pagos_anuales_de_letra = $pagos_anuales_de." (Dos punto cinco)";
			$fincontrato = "2026/06/13";
        }
		else if($per == 4) {
            $pagos_anuales_de = 2.5;
			$pagos_anuales_de_letra = $pagos_anuales_de." (Dos punto cinco)";
			$fincontrato = "2026/11/13";
        }
        else {
            $pagos_anuales_de = 5;
			$pagos_anuales_de_letra = $pagos_anuales_de." (Cinco)";
			if($per == 1) {
				$fincontrato = "2026/06/13";
			}
			else if($per == 3) {
				$fincontrato = "2026/11/13";
			}
        }
    }
    else {
        if($per == 2) {
            $pagos_anuales_de = 7.5;
			$pagos_anuales_de_letra = $pagos_anuales_de." (Siete punto cinco)";
        }
        else if($per == 3) {
            $pagos_anuales_de = 5;
			$pagos_anuales_de_letra = $pagos_anuales_de." (Cinco)";
        }
        else {
            $pagos_anuales_de = 10;
			$pagos_anuales_de_letra = $pagos_anuales_de." (Diez)";
        }
    }
    $total_anual_de = $pension * $pagos_anuales_de;
    $descuento1 = $descuento/100 * $pension;
    $total_anual_sd = ($pension - $descuento1) * $pagos_anuales_de;
    if($beca == 1) {
        $beca1 = $pension/2;
    }
    else if($beca == 2) {
        $beca1 = $pension;
    }
    else {
        $beca1 = 0;
    }
    $total_anual_sb = ($pension - $beca1) * $pagos_anuales_de;
    $pension_final = $total_anual_sb / $pagos_anuales_de;
    
	$estnuevo = "SI";
    if($estnuevo == "NO") {
        $sql_updins_est = "UPDATE tbl_estudiantes SET  
        telefono_estudiante = $cel, tipo_documento = $tdoc, 
        email_acudiente_1 = '$emailA', acudiente_1 = '$nombreA', telefono_acudiente_1 = '$celA', documento_responsable = '$documentoA', 
        rh = '$rh', parentesco_acudiente_1 = '$parentesco1' 
        WHERE n_documento = '$documento'";
    }
    else if($estnuevo == "SI") {
		if($estado == "nuevo") {
			$sql_updins_est = "INSERT INTO tbl_estudiantes (apellidos, nombres, genero, tipo_documento, n_documento, telefono_estudiante, actividad_extra, situacion_se, rh, 
			email_acudiente_1, acudiente_1, telefono_acudiente_1, parentesco_acudiente_1, fecha_datos, documento_responsable, a_matricula, 
			direccion, direccion_estudiante) 
			VALUES ('$apellidos', '$nombres', '$genero', $tdoc, '$documento', $cel, '$extra', '$situacion', '$rh',  
			'$emailA', '$nombreA', '$celA', '$parentesco1', $fecha2, '$documentoA', $fanio, 
			'$dirA', '$dirA', '$email') 
			ON DUPLICATE KEY UPDATE 
			apellidos = values(apellidos), nombres = values(nombres), genero = values(genero), tipo_documento = values(tipo_documento), telefono_estudiante = values(telefono_estudiante), actividad_extra = values(actividad_extra), 
			direccion = values(direccion), email_acudiente_1 = values(email_acudiente_1), acudiente_1 = values(acudiente_1), telefono_acudiente_1 = values(telefono_acudiente_1), parentesco_acudiente_1 = values(parentesco_acudiente_1), 
			documento_responsable = values(documento_responsable), estado = values(estado), situacion_se = values(situacion_se), email_institucional = values(email_institucional), direccion_estudiante = values(direccion_estudiante)";
		}
		else {
			$sql_updins_est = "UPDATE tbl_estudiantes SET 
			apellidos = '$apellidos', nombres = '$nombres', genero = '$genero', tipo_documento = $tdoc, telefono_estudiante = $cel, actividad_extra = '$extra', 
			direccion = '$dirA', email_acudiente_1 = '$emailA', acudiente_1 = '$nombreA', telefono_acudiente_1 = '$celA', parentesco_acudiente_1 = '$parentesco1', 
			documento_responsable = '$documentoA', rh = '$rh', situacion_se = '$situacion', email_institucional = '$email' 
			WHERE n_documento = '$documento'";
		}
		//Se hace el insert en la tabla tbl_pre_matricula
    }
    //echo "<br>".$sql_updins_est;
    $res_updinst_est = $mysqli1->query($sql_updins_est);
    
    //se arma el n_matricula
    $sql_maxa = "SELECT MAX(DATE_FORMAT(fecha_ingreso, '%Y')) a FROM tbl_matriculas";
    /*$exe_maxa = mysqli_query($conexion,$sql_maxa);
    while ($rowa = mysqli_fetch_array($exe_maxa)) {
        $maxa = $rowa['a'];
    }*/
	$exe_maxa=$mysqli1->query($sql_maxa);
    while($rowa = $exe_maxa->fetch_assoc()){
        $maxa = $rowa['a'];
    }
    //echo "<br/>".$a;
    //echo $fanio."<br/>".$maxa;
    if($fanio == $maxa) {
        $sql_mat = "SELECT MAX(id) maxid FROM tbl_matriculas WHERE date_format(fecha_ingreso, '%Y') = $fanio OR fecha_ingreso >= '2025-10-01'";
        //echo "<br/>".$sql_mat;
        /*$exe_mat = mysqli_query($conexion,$sql_mat);
        while ($rowm = mysqli_fetch_array($exe_mat)) {
            $consecutivo = $rowm['maxid'];
            $consecutivo1 = $consecutivo + 1;
        }*/
		$exe_mat=$mysqli1->query($sql_mat);
        while($rowm = $exe_mat->fetch_assoc()){
			$consecutivo = $rowm['maxid'];
            $consecutivo1 = $consecutivo + 1;
		}
    }
    else {
        $consecutivo = 1;
        $consecutivo1 = 1;
    }
    //echo "<br/>".$consecutivo;
    
	if($fanio == $maxa) {
		//Se captura el n_matricula del maxid
		//$sql_n_matric = "SELECT n_matricula FROM matricula WHERE idMatricula = $consecutivo";
		$sql_n_matric = "SELECT n_matricula FROM tbl_matriculas 
		WHERE id = (SELECT MAX(id) maxid FROM tbl_matriculas WHERE date_format(fecha_ingreso, '%Y') = $fanio OR fecha_ingreso >= '2025-10-01')";
		$exe_n_matric = $mysqli1->query($sql_n_matric);
		while($row_n_matric = $exe_n_matric->fetch_assoc()) {
			$n_matric = $row_n_matric['n_matricula'];
		}
		$consec_n_matric = explode("-", $n_matric);
		$consec_n_matric0 = $consec_n_matric[0];
		$consec_n_matric1 = $consec_n_matric0 + 1;
		
		//$n_matricula = $consecutivo."-".$fanio."-".$idgra."G";
		//$n_matricula1 = $consecutivo1."-".$fanio."-".$idgra."G";
		$n_matricula = $consec_n_matric1."-".$fanio."-".$idgra."G";
	}
	else {
		$n_matricula = $consecutivo."-".$fanio."-".$idgra."G";
	}
    //echo "<br>".$n_matricula;
    //echo "<br>".$n_matricula1;
    
    //Se captura el id del estudiante
	$sqlid = "SELECT id FROM tbl_estudiantes WHERE n_documento = '$documento'";
	/*$exe_id = mysqli_query($conexion,$sqlid);
    while ($rowid = mysqli_fetch_array($exe_id)) {
        $idest = $rowid['id'];
    }*/
	$exe_id=$mysqli1->query($sqlid);
	while($rowid = $exe_id->fetch_assoc()){
		$idest = $rowid['id'];
	}
	//echo $idest;
	
	//Se hace el insert en la tabla de matrículas
	if($idest != 0) {
	    //Se valida si ya existe un registro en estado pre_solicitud
	    $ct_matric = 0;
	    $sql_valm = "SELECT COUNT(1) ct FROM tbl_matriculas 
		WHERE id_estudiante = $idest AND estado IN ('pre_solicitud', 'nuevo_pre_solicitud', 'antiguo_pre_solicitud') AND (date_format(fecha_ingreso, '%Y') = $fanio OR fecha_ingreso >= '2025-10-01')";
	    $msg_estudiante = "EstudianteOK";
	    /*$exe_valm = mysqli_query($conexion,$sql_valm);
        while ($row_valm = mysqli_fetch_array($exe_valm)) {
            $ct_matric = $row_valm['ct'];
        }*/
		$exe_valm=$mysqli1->query($sql_valm);
		while($row_valm = $exe_valm->fetch_assoc()){
			$ct_matric = $row_valm['ct'];
		}
        //echo $ct_matric;
        if($ct_matric == 0) {
            if($mes >= 10) {
				if($control_antiguos == 1) {
					$sql_insert1 = "INSERT INTO tbl_matriculas (n_matricula, fecha_ingreso, estado, id_estudiante, id_grado, estado_grado, grupo) 
					VALUES ('$n_matricula', '$fecha3', 'antiguo_pre_solicitud', $idest, $idgra, 'NA', 'A')";
				}
				else if($estado == "nuevo") {
					$sql_insert1 = "INSERT INTO tbl_matriculas (n_matricula, fecha_ingreso, estado, id_estudiante, id_grado, estado_grado, grupo) 
					VALUES ('$n_matricula', '$fecha3', 'nuevo_pre_solicitud', $idest, $idgra, 'NA', 'A')";
				}
				else {
					$sql_insert1 = "INSERT INTO tbl_matriculas (n_matricula, fecha_ingreso, estado, id_estudiante, id_grado, estado_grado, grupo) 
					VALUES ('$n_matricula', '$fecha3', 'pre_solicitud', $idest, $idgra, 'NA', 'A')";
				}
        	}
        	else {
				if($control_antiguos == 1) {
					$sql_insert1 = "INSERT INTO tbl_matriculas (n_matricula, fecha_ingreso, estado, id_estudiante, id_grado, estado_grado, grupo) 
					VALUES ('$n_matricula', '$fecha2', 'antiguo_pre_solicitud', $idest, $idgra, 'NA', 'A')";
				}
				else if($estado == "nuevo") {
					$sql_insert1 = "INSERT INTO tbl_matriculas (n_matricula, fecha_ingreso, estado, id_estudiante, id_grado, estado_grado, grupo) 
					VALUES ('$n_matricula', '$fecha2', 'nuevo_pre_solicitud', $idest, $idgra, 'NA', 'A')";
				}
				else {
					$sql_insert1 = "INSERT INTO tbl_matriculas (n_matricula, fecha_ingreso, estado, id_estudiante, id_grado, estado_grado, grupo) 
					VALUES ('$n_matricula', '$fecha2', 'pre_solicitud', $idest, $idgra, 'NA', 'A')";
				}
        	}
            
            //echo "<br/>".$sql_insert1;
            //$exe_insert1 = mysqli_query($conexion,$sql_insert1);
			$exe_insert1 = $mysqli1->query($sql_insert1);
        }
	}
	
    //************FIN ACTUALIZACION TABLAS ESTUDIANTES Y MATRICULA **************************************************************
    
    //$sql_insert2 = str_replace(" ", "_", $sql_insert1);
    //echo "<br/>".$sql_insert2;
	
	//**************************************************************************************************************
    //************FIN ACTUALIZACION TABLA PRE MATRÍCULA **************************************************************
	
	
	//Se hace un insert en tbl_pre_matricula si no existe
	$ct_premat = 0;
	$sql_premat = "SELECT COUNT(1) ct FROM tbl_pre_matriculas WHERE documento_est = '$documento' AND año = $fanio";
	//echo "<br>".$sql_premat;
	$res_premat = $mysqli1->query($sql_premat);	
	while($row_premat = $res_premat->fetch_assoc()){
		$ct_premat = $row_premat['ct'];
	}
	//echo "<br>ct_premat: ".$ct_premat;
	
	if ($ct_premat > 0) {
		$sql_insupd_prem = "UPDATE tbl_pre_matriculas 
		SET id_grado = $idgra, nombres_est = '$nombres', apellidos_est = '$apellidos', fecha = '$fecha2', actividad_extra = '$extra', 
		nombre_a = '$nombreA', celular_a = '$celA', email_a = '$emailA', ciudad_a = '', id_medio = $medio, entrevista = 'NO' 
		WHERE documento_est = '$documento' AND año = $fanio";
		
	}
	else {
		$sql_insupd_prem = "INSERT INTO tbl_pre_matriculas (id_grado, documento_est, nombres_est, apellidos_est, fecha, actividad_extra, 
		nombre_a, celular_a, email_a, ciudad_a, entrevista, eval, id_medio, año) 
		VALUES ($idgra, '$documento', '$nombres', '$apellidos', '$fecha2', '$extra', 
		'$nombreA', '$celA', '$emailA', '', 'NO', 0, $medio, $fanio)";
	}
	//echo "<br>".$sql_insupd_prem;
	//$exe_insupd_prem = mysqli_query($conexion,$sql_insupd_prem);
	$exe_insupd_prem = $mysqli1->query($sql_insupd_prem);
	
    
    // ###################### INICIO CONTRATO ###################
	try {
		$inputFileName = '../chatbot/documentos/formato_contrato.xlsx';
		$spreadsheet = IOFactory::load($inputFileName);
		$spreadsheet->setActiveSheetIndex(0); //opcional
		$sheet = $spreadsheet->getActiveSheet();
		
		$sheet->setCellValue('R9', $dia);
		$sheet->setCellValue('S9', $mes);
		$sheet->setCellValue('T9', $fanio1);
		if($estnuevo == "SI") {
			$sheet->setCellValue('I13', "X");
		}
		else {
			$sheet->setCellValue('U13', "X");
		}
		if($idgra < 7) {
			$sheet->setCellValue('L14', "X");
		}
		else if($idgra < 10) {
			$sheet->setCellValue('Q14', "X");
		}
		else {
			$sheet->setCellValue('U14', "X");
		}
		if($idgra < 13) {
			$sheet->setCellValue('H15', $grado);
		}
		else {
			$sheet->setCellValue('P15', $grado);
		}
		$sheet->setCellValue('R17', $n_matricula);
		$sheet->setCellValue('C19', $nombres." ".$apellidos);
		if($tdoc == 1) {
			$sheet->setCellValue('C22', "X");
		}
		else if($tdoc == 3) {
			$sheet->setCellValue('D22', "X");
		}
		else if($tdoc == 4) {
			$sheet->setCellValue('E22', "X");
		}
		$sheet->setCellValue('F22', $documento);
		/*if(is_null($fn)) {
			//No hace nada
		}
		else {
			$sheet->setCellValue('O22', $partesfn[2]);
			$sheet->setCellValue('P22', $partesfn[1]);
			$sheet->setCellValue('R22', $partesfn[0]);
		}*/
		if($genero == "MASCULINO") {
			$sheet->setCellValue('T22', "M");
		}
		else if($genero == "FEMENINO") {
			$sheet->setCellValue('T22', "F");
		}
		
		//Se consulta el último grado aprobado
		$sql_ultgrado = "SELECT grado FROM tbl_grados WHERE id = ($idgra - 1)";
		/*$exe_ultgrado = mysqli_query($conexion,$sql_ultgrado);
		while ($row_ultgrado = mysqli_fetch_array($exe_ultgrado)) {
			$ultgrado = $row_ultgrado['grado'];
		}*/
		$exe_ultgrado = $mysqli1->query($sql_ultgrado);	
		while($row_ultgrado = $exe_ultgrado->fetch_assoc()){
			$ultgrado = $row_ultgrado['grado'];
		}
		//echo "<br/>".$sql_ultgrado;
		$sheet->setCellValue('R24', $ultgrado);
		
		//Se calcula la edad
		//echo "<br/>fn ".$fn;
		//echo "<br/>a ".$partesfn[0]." m ".$partesfn[1]." d ".$partesfn[2];
		/*$difa = $fanio1 - $partesfn[0];
		$difm = $mes - $partesfn[1];
		$difd = $dia - $partesfn[2];*/
		//echo "<br/>difa ".$difa." difm ".$difm." difd ".$difd;
		/*if($difm <= 0 && $difd < 0) {
			$difa--;
		}*/
		//$sheet->setCellValue('K26', $difa);
		
		$sheet->setCellValue('C27', $cel);
		$sheet->setCellValue('M27', $email);
		//$sheet->setCellValue('C28', $aextra);
		
		//Inicio Datos Acudiente
		$sheet->setCellValue('C34', $nombreA);
		$sheet->setCellValue('C36', $documentoA);
		$sheet->setCellValue('I37', $dirA);
		$sheet->setCellValue('C39', $celA);
		$sheet->setCellValue('K39', $emailA);
		//Fin Datos Acudiente
		
		//Inicio Datos Padre
		if($parentesco1 == "PADRE") {
			$sheet->setCellValue('C41', $nombreA);
			$sheet->setCellValue('C43', $documentoA);
			$sheet->setCellValue('I44', $dirA);
			$sheet->setCellValue('C46', $celA);
			$sheet->setCellValue('K46', $emailA);
		}
		/*else if($parentesco2 == "PADRE") {
			$sheet->setCellValue('C41', $nombre2);
			//$sheet->setCellValue('C43', $documentoA);
			//$sheet->setCellValue('I44', $dirA);
			$sheet->setCellValue('C46', $tel2);
			$sheet->setCellValue('K46', $email2);
		}*/
		//Fin Datos Padre
		
		//Inicio Datos Madre
		if($parentesco1 == "MADRE") {
			$sheet->setCellValue('C48', $nombreA);
			$sheet->setCellValue('C50', $documentoA);
			$sheet->setCellValue('I51', $dirA);
			$sheet->setCellValue('C53', $celA);
			$sheet->setCellValue('K53', $emailA);
		}
		/*else if($parentesco2 == "MADRE") {
			$sheet->setCellValue('C48', $nombre2);
			//$sheet->setCellValue('C50', $documentoA);
			//$sheet->setCellValue('I51', $dirA);
			$sheet->setCellValue('C53', $tel2);
			$sheet->setCellValue('K53', $email2);
		}*/
		//Fin Datos Madre
		
		$sheet->setCellValue('H75', $nombre_completo);
		$sheet->setCellValue('F76', $nombreA);
		//$sheet->setCellValue('L76', $nombre2);
		
		$partescomienzocontrato = explode("/", $comienzocontrato);
		$partesfincontrato = explode("/", $fincontrato);
		
		$sheet->setCellValue('K108', $partescomienzocontrato[2]);
		$sheet->setCellValue('M108', $meses[intval($partescomienzocontrato[1])]);
		$sheet->setCellValue('P108', $partescomienzocontrato[0]);
		$sheet->setCellValue('S108', $partesfincontrato[2]);
		$sheet->setCellValue('B109', $meses[intval($partesfincontrato[1])]);
		$sheet->setCellValue('D109', $partesfincontrato[0]);
		
		$sheet->setCellValue('G115', $pagos_anuales_de_letra);
		$sheet->setCellValue('F126', $pagos_anuales_de_letra);
		
		if($controlfinaño == "OK") {
			$sheet->setCellValue('H189', "3 día(s)");
			$sheet->setCellValue('K189', "Febrero");
			$sheet->setCellValue('P189', "2025");
		}
		else if($fecha2_yyyymmdd >= "20250101" && $fecha2_yyyymmdd < "20250201") {
			$sheet->setCellValue('H189', "3 día(s)");
			$sheet->setCellValue('K189', "Febrero");
			$sheet->setCellValue('P189', "2025");
		}
		else {
			$sheet->setCellValue('H189', $dia." día(s)");
			$sheet->setCellValue('K189', $espaniol);
			$sheet->setCellValue('P189', $fanio);
		}

		$sheet->setCellValue('G194', "Nombre: ".$nombreA);	
		$sheet->setCellValue('K194', "Nombre: ".$nombre_completo);
		$sheet->setCellValue('H195', $documentoA);	
		$sheet->setCellValue('M195', $documento);
		
		$sheet->setCellValue('C235', $nombreA);
		$sheet->setCellValue('C236', $documentoA);
		
		//Se crea la carpeta del contrato
		$path = '../chatbot/documentos/contratos/'.$fanio.'/'.str_replace(" ","_",$grado).'/';
		//echo "<br/>path=".$path;
		if (!file_exists($path)) {
			mkdir($path, 0755, true);
		}	
		
		$folder0 = '/chatbot/documentos/contratos/'.$fanio.'/'.str_replace(" ","_",$grado).'/';
		$folder_correo = '../chatbot/documentos/contratos/'.$fanio.'/'.str_replace(" ","_",$grado).'/';
		$folder = __DIR__.$folder0;
		$nombre_excel = "contrato_".$documento."_".$n_matricula.".xlsx";
		//$ruta = "https://unicab.org".$folder0.$nombre_excel;
		$ruta = "../".$folder0.$nombre_excel;
		//echo "<br/>ruta=".$ruta;
		
		//Se guarda el contrato en la tabla
		$sql_contrato = "SELECT COUNT(1) ct FROM tbl_contratos WHERE n_documento = '$documento' AND año = $fanio";
		/*$exe_contrato = mysqli_query($conexion,$sql_contrato);
		while ($row_contrato = mysqli_fetch_array($exe_contrato)) {
			$ct_contrato = $row_contrato['ct'];
		}*/
		$exe_contrato = $mysqli1->query($sql_contrato);	
		while($row_contrato = $exe_contrato->fetch_assoc()){
			$ct_contrato = $row_contrato['ct'];
		}
		if($ct_contrato == 0) {
			$writer = new Xlsx($spreadsheet);
			//$writer->save('registro/adminunicab/php/contratos/formato_contrato_ghf.xlsx');
			$writer->save($path.$nombre_excel);
		
			if($mes >= 10) {
				$sql_insertc = "INSERT INTO tbl_contratos (n_documento, n_contrato, ruta, año, fecha_modificacion) 
				VALUES ('$documento', '$n_matricula', '$ruta', $fanio, '$fecha3')";
			}
			else {
				$sql_insertc = "INSERT INTO tbl_contratos (n_documento, n_contrato, ruta, año, fecha_modificacion) 
				VALUES ('$documento', '$n_matricula', '$ruta', $fanio, '$fecha2')";
			}
			//$exe_insertc = mysqli_query($conexion,$sql_insertc);
			$exe_insertc = $mysqli1->query($sql_insertc);	
			//echo "<br/>".$sql_insertc;
		}
		else {
			
		}
	}
	catch(Exception $e) {
		//echo $e->getMessage();
	}
	
    // ###################### FIN CONTRATO ###################
	
	//Se debe actualizar el grado en tbl_asistente_virtual
	$sql_upd_grado_av = "UPDATE tbl_asistente_virtual SET id_grado = $idgra WHERE documento_estudiante = '$documento' AND a = $fanio";
	//$exe_upd_grado_av = mysqli_query($conexion, $sql_upd_grado_av);
	$exe_upd_grado_av = $mysqli1->query($sql_upd_grado_av);	
	
	//Se debe programar la evaluación admisión
	$url_eval_admisiones = "http://localhost:90/avmeeuu/avmeeuu/api/av_programar_eval_admision.php";
	$params = [
		'nombree' => $nombres,
		'apellidoe' => $apellidos,
		'documentoe' => $documento,
		'selgrado' => $idgra,
		'email' => $email
	];
	// Construir la URL completa con parámetros
	$url_con_params = $url_eval_admisiones . '?' . http_build_query($params);

	// Usar cURL para hacer la llamada interna
	$ch = curl_init($url_con_params);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // (solo si estás en entorno local de prueba)
	$respuesta_b = trim(curl_exec($ch));
	$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
	curl_close($ch);
	
	$respuesta_json = json_decode($respuesta_b, true); // el "true" lo convierte en array asociativo
	$mensaje_evaluacion = "";
	if ($http_code == 200) {
		$mensaje_evaluacion = $respuesta_json['mensaje'];
	} else {
		$mensaje_evaluacion = $respuesta_json['mensaje'];		
	}
	
	//Se envía correo de aviso de inico de proceso
	//$url_mail = "https://unicab.solutions/avmeeuu_inicio_proceso_correo.php";
	$url_mail = "http://localhost:90/avmeeuu/avmeeuu/api/avmeeuu_inicio_proceso_correo.php";
	$data_original_json = json_encode($data);
	$params = [
		'data_original_json' => $data_original_json
	];
	//var_dump($params); 
	// Construir la URL completa con parámetros --- Esto no funciona cuando se envía archivos
	//$url_con_params = $url_mail . '?' . http_build_query($params);

	// Usar cURL para hacer la llamada interna
	$ch = curl_init($url_mail);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // (solo si estás en entorno local de prueba)
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
	$respuesta_b = trim(curl_exec($ch));
	$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
	curl_close($ch);
	
	$respuesta_json = json_decode($respuesta_b, true); // el "true" lo convierte en array asociativo
	$mensaje_inicio_proceso = "";
	if ($http_code == 200) {
		$mensaje_inicio_proceso = $respuesta_json['mensaje'];
	} else {
		$mensaje_inicio_proceso = $respuesta_json['mensaje'];		
	}	
	
	$datos->status = "success";
	$datos->mensaje = "Data saved successfully.";
	$datos->grado = $grado;
	$datos->id_grado = $idgra;
	$datos->contrato = $ruta;
	$datos->mensaje_evaluacion = $mensaje_evaluacion;
	$datos->matricula = $matricula;
	$datos->pension = $pension;
	$datos->ocp = $ocp;
	$datos->poliza = $poliza;
	$datos->dg = $dg;
	$datos->pp = $pp;
	$datos->mensaje_inicio_proceso = $mensaje_inicio_proceso;
	
	echo json_encode($datos, JSON_UNESCAPED_UNICODE);	
?>

