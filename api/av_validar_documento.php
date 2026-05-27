<?php
	//Genera el select de los grados
	require("../bd/1cc2s4db.php");
	header("Cache-Control: no-cache, must-revalidate");
	header("Expires: Sat, 1 Jul 2000 05:00:00 GMT");
	//header("Refresh: 30; URL='pen_gra_upddat.php'");
	set_time_limit(300);
	//http://localhost:90/avmeeuu/avmeeuu/api/av_validar_documento.php?documento=93974541
	
	// Habilitar CORS solo para tu entorno local durante desarrollo
	header("Access-Control-Allow-Origin: http://localhost");
	header("Access-Control-Allow-Methods: POST"); //, OPTIONS
	header("Access-Control-Allow-Headers: Content-Type");
	
	$data = json_decode(file_get_contents("php://input"), true);
	
	$documento = $data['documento'] ?? '';
	$datos = new stdClass();
	$datos->status = "error";
	$idGrado = 0;
	$grado = "";
	
	date_default_timezone_set('America/Bogota');
	$fecha = time();
	$dia = date("d",$fecha);
	$mes = date("m",$fecha);
	$a = date("Y",$fecha);
	$fanio = date("Y",$fecha);
	$hora = date("H",$fecha);
	$minutos = date("i",$fecha);
	$fecha2 = $a."-".$mes."-".$dia." ".$hora.":".$minutos;
	if($mes >= 10) {
        $fanio = $fanio + 1;
    }
	$fechaHoy = $a."-".$mes."-".$dia;
	$fechaControlEntrevistas = $a."-10-01";
	//echo $fecha2." ".$fechaHoy;
	
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
	
	$grados = array();
	$keys = ['id_gra','gra'];
	$i = 0;	
	
	$tablae = "tbl_estudiantes";
	$tablam = "tbl_matriculas";
	$ct_av = 0;
	$paso = 0;
	$datos->paso = 1;
	$datos->año_matricula = $fanio;
	
	// Se consulta el paso en el cual se encuentra el proceso del asistente virtual
	$datos->etiqueta_intencion = "";
	$datos->control_documentos_invalidos = 0;
	$sql_paso = "SELECT COUNT(1) ct FROM tbl_asistente_virtual WHERE documento_estudiante = '$documento' AND a = $fanio";
	$exe_paso = $mysqli1->query($sql_paso);
    while($row_paso = $exe_paso->fetch_assoc()) {
        $ct_av = $row_paso['ct'];
    }
	if ($ct_av > 0) {
		$sql_paso1 = "SELECT a.*, p.* FROM tbl_asistente_virtual a, tbl_asistente_virtual_pasos p 
		WHERE a.paso = p.paso AND a.documento_estudiante = '$documento' AND a.a = $fanio";
		$exe_paso1 = $mysqli1->query($sql_paso1);
		while($row_paso1 = $exe_paso1->fetch_assoc()) {
			$datos->paso = $row_paso1['paso'];
			$datos->etiqueta_intencion = $row_paso1['etiqueta_intencion'];
			$datos->control_documentos_invalidos = $row_paso1['control_documentos_invalidos'];
			$paso = $row_paso1['paso'];
		}
	}
	
	//Se hace la consulta del máximo registro en matrículas
	$query0 = "SELECT IFNULL(max(m.id), 0) maxid FROM ".$tablae." e, ".$tablam." m WHERE e.id = m.id_estudiante AND e.n_documento = '$documento'";
	//$query0 = "SELECT IFNULL(max(m.id), 0) maxid FROM ".$tablae." e, ".$tablam." m WHERE e.id = m.id_estudiante AND e.n_documento = '$documento'";
	//echo $query0;
	$resultado0 = $mysqli1->query($query0);
	while($row0 = $resultado0->fetch_assoc()) {
	    $maxid = $row0['maxid'];
	}
	$datos->maxid = $maxid;
	
	$datos->nombre = "Hola";
	$datos->apellidos = "";
	$datos->acudiente = "";
	$datos->emailA = "";
	$datos->telA = "";
	$datos->ciudadA = "";
	
	$control_antiguos = 0;
	$datos->control_antiguos = $control_antiguos;
	
	//echo $maxid;
	if($maxid == 0) {
	    $datos->estado = "nuevo";
	    //Se cargan los grados
	    $query_g = "SELECT * FROM tbl_grados WHERE id > 1 AND id < 19";
	    $resultadog = $mysqli1->query($query_g);
    	while($rowg = $resultadog->fetch_assoc()) {
    	    $valores = [$rowg['id'],$rowg['grado']];
    	    $grados_temp = array_combine($keys,$valores);
      		$grados[$i] = $grados_temp;
      		$i++;
    	}
		$datos->rh = "NA";
		
		//Se buscan datos iniciales... ¡si existen!
		$query1 = "SELECT e.* FROM ".$tablae." e 
	    WHERE e.n_documento = '$documento'";
	    //echo $query1;
        $resultado1 = $mysqli1->query($query1);
		while($row1 = $resultado1->fetch_assoc()) {
            $datos->acudiente = $row1['acudiente_1'];
    	    $datos->emailA = $row1['email_acudiente_1'];
    	    $datos->telA = $row1['telefono_acudiente_1'];
    	    $datos->ciudadA = $row1['ciudad'];

			$datos->nombres = $row1['nombres'];
			$datos->apellidos = $row1['apellidos'];
    	}
	}
	else {
		//Se valida que sea antiguo del presente año para matrículas ordinarias o del año anterior para matrículas extraordinarias
		//SELECT * FROM `estudiantes` WHERE `n_documento` IN ('9397454','93974541','93974542','93974543','93974544','93974545') 
		//SELECT *, (YEAR(NOW()) - YEAR(fecha_ingreso)) diferencia, YEAR(now()) actual FROM matricula WHERE idMatricula in (3732,6144,6145,6146,6148);
		//SELECT *, (YEAR(NOW()) - YEAR(fecha_ingreso)) diferencia, YEAR(now()) actual FROM matricula WHERE id_estudiante in (1040,-3486,-3487,-3488,-3489); 
		//SELECT * FROM `tbl_informacion_financiera` WHERE `documento_estudiante` IN ('9397454','93974541','93974542','93974543','93974544','93974545'); 
		
		if($mes < 10) {
			$sql_val_estado = "SELECT *, (YEAR(NOW()) - 1 - YEAR(fecha_ingreso)) diferencia, YEAR(now()) actual FROM ".$tablam." WHERE id = $maxid";
		}
		else {
			$sql_val_estado = "SELECT *, (YEAR(NOW()) - YEAR(fecha_ingreso)) diferencia, YEAR(now()) actual FROM ".$tablam." WHERE id = $maxid";
		}
		//echo $sql_val_estado."<br>";
		$res_val_estado = $mysqli1->query($sql_val_estado);
        while($row_val_estado = $res_val_estado->fetch_assoc()) {
			$estado_val = $row_val_estado['estado'];
			$diferencia_val = $row_val_estado['diferencia'];
			$actual_val = $row_val_estado['actual'];
			$id_grado = $row_val_estado['id_grado'];
			$n_matricula = $row_val_estado['n_matricula'];
			$fecha_ingreso = $row_val_estado['fecha_ingreso'];
		}
		$datos->estado_val = $estado_val;
		if ($estado_val == 'antiguo_pre_solicitud' || $estado_val == 'antiguo_solicitud') {
			$control_antiguos = 1;
		}
		else if ($estado_val == 'nuevo_pre_solicitud' || $estado_val == 'nuevo_solicitud') {
			$control_antiguos = 0;
		}
		//else if ($estado_val != 'activo' && $diferencia_val == 0 && $actual_val = 2025) {
		else if ($estado_val != 'activo' && $diferencia_val == 0) {
			$control_antiguos = 1;
		}
		//else if ($estado_val != 'activo' && $estado_val != 'nuevo_pre_solicitud' && $estado_val != 'nuevo_solicitud' && abs($diferencia_val) >= 1 && $actual_val = 2025) {
		else if ($estado_val != 'activo' && abs($diferencia_val) >= 1) {
			$control_antiguos = 2; //Se considera nuevo si no estuvo con Unicab en el año actual
		}
		else if ($estado_val == 'activo') {
			$datos->estado = $estado_val;
			//Se cargan los grados
			$query_g = "SELECT * FROM tbl_grados WHERE id = ".$id_grado;
			$resultadog = $mysqli1->query($query_g);
			while($rowg = $resultadog->fetch_assoc()) {
				$valores = [$rowg['id'],$rowg['grado']];
				$grados_temp = array_combine($keys,$valores);
				$grados[$i] = $grados_temp;
				$i++;
			}
			
			//Se buscan datos iniciales... ¡si existen!
			$query1 = "SELECT e.acudiente_1, e.email_acudiente_1, e.ciudad, e.telefono_acudiente_1, e.* 
			FROM ".$tablae." e 
			WHERE e.n_documento = '$documento'";
			//echo $query1;
			$resultado1 = $mysqli1->query($query1);
			while($row1 = $resultado1->fetch_assoc()) {
				$datos->acudiente = $row1['acudiente_1'];
				$datos->emailA = $row1['email_acudiente_1'];
				$datos->telA = $row1['telefono_acudiente_1'];
				$datos->ciudadA = $row1['ciudad'];
				$datos->nombres = $row1['nombres'];
				$datos->apellidos = $row1['apellidos'];
			}
		}
		else {
			$datos->estado = "nuevo";
			//Se cargan los grados
			$query_g = "SELECT * FROM tbl_grados WHERE id > 1 AND id < 19";
			$resultadog = $mysqli1->query($query_g);
			while($rowg = $resultadog->fetch_assoc()) {
				$valores = [$rowg['id'],$rowg['grado']];
				$grados_temp = array_combine($keys,$valores);
				$grados[$i] = $grados_temp;
				$i++;
			}
			$datos->rh = "NA";
			
			//Se buscan datos iniciales... ¡si existen!
			$query1 = "SELECT e.acudiente_1, e.email_acudiente_1, e.ciudad, e.telefono_acudiente_1 
			FROM ".$tablae." e 
			WHERE e.n_documento = '$documento'";
			//echo $query1;
			$resultado1 = $mysqli1->query($query1);
			while($row1 = $resultado1->fetch_assoc()) {
				$datos->acudiente = $row1['acudiente_1'];
				$datos->emailA = $row1['email_acudiente_1'];
				$datos->telA = $row1['telefono_acudiente_1'];
				$datos->ciudadA = $row1['ciudad'];
			}
		}
		$datos->control_antiguos = $control_antiguos;
		$datos->diferencia = $diferencia_val;
		$datos->n_matricula = $n_matricula;
		$datos->fecha_ingreso = $fecha_ingreso;
		$datos->id_matricula = $maxid;
		
		//echo $control_antiguos;
		if ($control_antiguos == 1 || $control_antiguos == 2 || $estado_val == "nuevo_pre_solicitud" || $estado_val == "nuevo_solicitud") {
			$query1 = "SELECT m.estado, m.id_grado, e.nombres, e.apellidos, e.telefono_estudiante, e.email_institucional, e.rh, 
			e.acudiente_1, e.email_acudiente_1, e.direccion, e.telefono_acudiente_1, 
			e.documento_responsable, td.id, td.tipo_documento, e.ciudad, e.actividad_extra, e.genero, e.documento_responsable, e.parentesco_acudiente_1, 
			IFNULL(e.situacion_se, '') situacion_se, e.expedicion, e.fecha_nacimiento, e.direccion_estudiante, e.ciudad   
			FROM ".$tablae." e, ".$tablam." m, tbl_tipos_documento td 
			WHERE e.id = m.id_estudiante AND e.tipo_documento = td.id AND e.n_documento = '$documento' AND m.id = $maxid";
			//$query1 = "SELECT m.estado, m.id_grado FROM ".$tablae." e, ".$tablam." m WHERE e.id = m.id_estudiante AND e.n_documento = '$documento' AND m.id = $maxid";
			//echo $query1;
			$resultado1 = $mysqli1->query($query1);
			while($row1 = $resultado1->fetch_assoc()) {
				if ($control_antiguos == 1) {
					$idGrado = $row1['id_grado'] + 1;
				}
				$datos->nombres = $row1['nombres'];
				$datos->apellidos = $row1['apellidos'];
				$datos->tel = $row1['telefono_estudiante'];
				$datos->tdoc = $row1['tipo_documento'];
				$datos->id_tdoc = $row1['id'];
				$datos->estado = $control_antiguos == 1 ? $row1['estado'] : ($control_antiguos == 2 ? $row1['estado'] : "nuevo");
				//$datos->estado = $row1['estado'];
				$datos->email = $row1['email_institucional'];
				$rh = str_replace("+", "mas", $row1['rh']);
				$rh = str_replace("-", "menos", $rh);
				$datos->rh = $rh;
				$datos->actividad_extra = $row1['actividad_extra'];
				$datos->genero = $row1['genero'];
				$datos->expedicion = $row1['expedicion'];
				$datos->fecha_nacimiento = $row1['fecha_nacimiento'];
				$datos->direccion_estudiante = $row1['direccion_estudiante'];
				$datos->ciudad = $row1['ciudad'];
				$datos->acudiente = $row1['acudiente_1'];
				$datos->emailA = $row1['email_acudiente_1'];
				$datos->direccion = $row1['direccion'];
				$datos->telA = $row1['telefono_acudiente_1'];
				$datos->docA = $row1['documento_responsable'];
				$datos->ciudadA = $row1['ciudad'];
				$datos->documento_responsable = $row1['documento_responsable'];
				$datos->parentesco_acudiente_1 = $row1['parentesco_acudiente_1'];
				$datos->situacion_se = $row1['situacion_se'];
				
				if ($control_antiguos == 1) {
					//echo "control antiguos 1";
					if($row1['estado'] == "aprobado") {
						//Se cargan los grados
						$query_g = "SELECT * FROM tbl_grados WHERE id = ".$row1['id_grado']." + 1";
						$resultadog = $mysqli1->query($query_g);
						while($rowg = $resultadog->fetch_assoc()) {
							$valores = [$rowg['id'],$rowg['grado']];
							$grados_temp = array_combine($keys,$valores);
							$grados[$i] = $grados_temp;
							$i++;
						}
					}
					else  {
						//Se cargan los grados
						$query_g = "SELECT * FROM tbl_grados WHERE id = ".$row1['id_grado'];
						$resultadog = $mysqli1->query($query_g);
						while($rowg = $resultadog->fetch_assoc()) {
							$valores = [$rowg['id'],$rowg['grado']];
							$grados_temp = array_combine($keys,$valores);
							$grados[$i] = $grados_temp;
							$i++;
						}
					}					
				}
				else if ($control_antiguos == 2 || $control_antiguos == 0) {
					//echo "control antiguos 2";
					//Se cargan los grados
					$query_g = "SELECT * FROM tbl_grados WHERE id > 1 AND id < 19";
					$resultadog = $mysqli1->query($query_g);
					while($rowg = $resultadog->fetch_assoc()) {
						$valores = [$rowg['id'],$rowg['grado']];
						$grados_temp = array_combine($keys,$valores);
						$grados[$i] = $grados_temp;
						$i++;
					}
				}
				//echo $query_g;
			}
		}
	    
	}
	
	$id = 0;
	//Se consulta el código de entrevista para estudiatnes que no sean nuevos
	$sqlcodigo = "SELECT *, ifnull(id, 0) id1 FROM tbl_entrevistas WHERE documento_est = '$documento'";
	//echo $sqlcodigo;
	$resultado_c = $mysqli1->query($sqlcodigo);
	while($rowc = $resultado_c->fetch_assoc()) {
	    $id = $rowc['id1'];
	}
	$id = (is_null($id)) ? 0 : $id;
	if($id == 0) {
	    $sqlcodigo1 = "SELECT *, ifnull(id, 0) id1 FROM tbl_pre_matriculas WHERE documento_est = '$documento' AND año < $fanio";
    	//echo $sqlcodigo1;
    	$resultado_c1 = $mysqli1->query($sqlcodigo1);
    	while($rowc1 = $resultado_c1->fetch_assoc()) {
    	    $id = $rowc1['id1'];
    	}
	}
	$id = (is_null($id)) ? 0 : $id;
	$datos->cod_ent = $id;
    
	$datos->grados = $grados;
	
	//Se valida si ya tiene un proceso de pre matrícula abierto
	$datos->procesoAbierto = "NO";
	$sql_pre_matricula = "SELECT * FROM tbl_pre_matriculas WHERE documento_est = '$documento' AND año = $fanio";
	$resultado_pre_matricula = $mysqli1->query($sql_pre_matricula);
	while($rowpm = $resultado_pre_matricula->fetch_assoc()) {
	    $datos->procesoAbierto = "SI";
		$datos->gradoSolicitado = $rowpm['id_grado'];
	}
	
	//Se valida si ya se programó entrevista
	$datos->programoEntrevista = "NO";
	$datos->fechaEntrevista = "";
	$datos->horaEntrevista = "";
	$sql_prog_entrevista = "SELECT * FROM tbl_entrevistas WHERE documento_est = '$documento' AND fecha >= '2025-10-01'";
	$resultado_prog_entrevista = $mysqli1->query($sql_prog_entrevista);
	while($row_prog_entrevista = $resultado_prog_entrevista->fetch_assoc()) {
	    $datos->programoEntrevista = "SI";
		$datos->fechaEntrevista = $row_prog_entrevista["fecha"];
		$datos->horaEntrevista = date("g a", strtotime($row_prog_entrevista["hora"] . ":00"));
	}
	/*$datos->programoEntrevista = "SI";
	$datos->fechaEntrevista = "2025-10-17";
	$datos->horaEntrevista = date("g a", strtotime("10" . ":00"));*/
	
	//Se consulta el estado de la entrevista
	$entrevista = "NO";
	$admitido = 0;
	$sql_entrevista = "SELECT entrevista, admitido FROM tbl_pre_matriculas WHERE documento_est = '$documento' AND año = $fanio";
	$resultado_entrevista = $mysqli1->query($sql_entrevista);
	while($row_entrevista = $resultado_entrevista->fetch_assoc()) {
	    $entrevista = $row_entrevista["entrevista"];
		$admitido = $row_entrevista["admitido"];
	}
	$datos->entrevista = $entrevista;
	$datos->admitido = $admitido;
	
	//Se consultan los intentos de programación de entrevista
	$intentos_programacion_entrevista = 0;
	$sql_intentos_programacion_entrevista = "SELECT COUNT(1) ct FROM tbl_entrevistas WHERE documento_est = '$documento' AND fecha >= '$fechaControlEntrevistas'";
	$res_intentos_programacion_entrevista = $mysqli1->query($sql_intentos_programacion_entrevista);
	while($row_intentos_programacion_entrevista = $res_intentos_programacion_entrevista->fetch_assoc()) {
	    $intentos_programacion_entrevista = $row_intentos_programacion_entrevista["ct"];
	}
	$datos->intentos_programacion_entrevista = $intentos_programacion_entrevista;
	
	//Se valida si el código de pre-matricula corresponde al documento
	/*$ct_c1 = 0;
	$sql_c1 = "SELECT COUNT(1) ct, email_pre_mat 
	FROM tbl_cod_pre_matricula WHERE identificacion = $documento AND codigo = '$codigo' 
	GROUP BY email_pre_mat";
	//echo $sql_c1;
	
	$resultado_c1 = $mysqli1->query($sql_c1);
	while($rowc1 = $resultado_c1->fetch_assoc()) {
	    $ct_c1 = $rowc1['ct'];
	    $email_premat = $rowc1['email_pre_mat'];
	}
	if($ct_c1 > 0) {
	    $datos->cod_prematricula = "OK";
	}
	else {
	    $datos->cod_prematricula = "NO";
	}
	$datos->email_prematricula = $email_premat;*/
	
	//Se busca si debe presentar evaluación de validación
	/*$sql_val_ct = "SELECT COUNT(1) ct FROM tbl_validaciones WHERE documento_est = '$documento' AND año = '$fanio'";
	//echo $sql_val_ct;
	$exe_val_ct= $mysqli1->query($sql_val_ct);
    while($row_val_ct = $exe_val_ct->fetch_assoc()) {
        $ct_val_ct = $row_val_ct['ct'];
    }
    //echo $ct_val_ct;
    if($ct_val_ct > 0) {
        $datos->eval_validacion = "SI";
        //Se busca el grado máximo
        $sql_max_grado = "SELECT g.id, g.grado 
        FROM (SELECT MAX(id_grado) id_grado FROM tbl_validaciones WHERE documento_est = '$documento' AND fecha_programacion like '%$fanio%') v, grados g 
        WHERE v.id_grado = g.id";
        $exe_max_grado = $mysqli1->query($sql_max_grado);
        while($row_max_grado = $exe_max_grado->fetch_assoc()) {
            $max_idgrado = $row_max_grado['id'];
            $max_grado = $row_max_grado['grado'];
        }
        //echo $max_grado;
        $datos->idgra_validacion = $max_idgrado;
        $datos->gra_validacion = $max_grado;
        
    	$sql_eval_val = "SELECT COUNT(1) ct FROM tbl_validaciones WHERE documento_est = '$documento' AND resultado = 'APROBADO' 
    	AND id_grado = $max_idgrado";
    	//echo $sql_eval_val;
    	$exe_eval_val = $mysqli1->query($sql_eval_val);
        while($row_eval_val = $exe_eval_val->fetch_assoc()) {
            $ct_eval_val = $row_eval_val['ct'];
        }
        if($ct_eval_val == 1) {
            $datos->res_validacion = "APROBADO";
            //Se consulta el grado a matricular
           $sql_grado_ant = "SELECT * FROM grados WHERE id = $max_idgrado + 1";
           $exe_grado_ant = $mysqli1->query($sql_grado_ant);
            while($row_grado_ant = $exe_grado_ant->fetch_assoc()) {
                //$datos->idgra_validacion_ant = $row_grado_ant['id'];
                $datos->idgra_a_matricular = $row_grado_ant['id'];
                //$datos->gra_validacion_ant = $row_grado_ant['grado'];
                $datos->gra_a_matricular = $row_grado_ant['grado'];
            }
        }
        else {
            $datos->res_validacion = "NO APROBADO";
            //$datos->idgra_a_matricular = $max_idgrado;
            //$datos->gra_a_matricular = $max_grado;
        }
    }
	else {
	   $datos->eval_validacion = "NO";
	   $datos->idgra_validacion = "NA";
	   $datos->gra_validacion = "NA";
	   $datos->res_validacion = "NA";
	   //$datos->idgra_a_matricular = "NA";
       //$datos->gra_a_matricular = "NA";
	}*/
	
	//Se valida si ya presentó la evaluación de presaberes
	$datos->evaluacionPresaberes = "NO";
	if ($documento == "9397454" || $documento == "46376709") {
		$datos->evaluacionPresaberes = "SI";
	}
	$sql_val_pre = "SELECT COUNT(1) ct FROM tbl_respuestas WHERE identificacion = '$documento' AND a = '$fanio' AND estado = 'FINALIZADA'";
	//echo $sql_val_pre;
	$exe_val_pre = $mysqli1->query($sql_val_pre);
    while($row_val_pre = $exe_val_pre->fetch_assoc()) {
        $ct_val_pre = $row_val_pre['ct'];
    }
    //echo $ct_val_pre;
    if($ct_val_pre > 0) {
        $datos->evaluacionPresaberes = "SI";
    }
	//$datos->evaluacionPresaberes = "SI";
	
	//Se valida si el documento no presenta entrevista ni evalución
	$sin_entrevista = '0';
	$sin_evaluacion = '0';
	/*$sql_exento = "SELECT * FROM tbl_estudiantes_sin_ee WHERE n_documento = '$documento'";
	$exe_exento = $mysqli1->query($sql_exento);
	while($row_exento = $exe_exento->fetch_assoc()) {
        $sin_entrevista = $row_exento['sin_entrevista'];
		$sin_evaluacion = $row_exento['sin_evaluacion'];
    }
	if ($sin_entrevista == "1") {
		$datos->programoEntrevista = "SI";
	}
	if ($sin_evaluacion == "1") {
		$datos->evaluacionPresaberes = "SI";
	}*/
	
	if ($datos->gradoSolicitado == 2 || $datos->gradoSolicitado >= 13) {
		$datos->evaluacionPresaberes = "SI";
	}
	
	//Se consulta el rango de matrícula ordinaria
	$sql_matricula = "SELECT f1, f2 FROM tbl_parametros WHERE parametro = 'mat_ordinarias'";
	$exe_matricula = $mysqli1->query($sql_matricula);
	while($row_matricula = $exe_matricula->fetch_assoc()) {
		$f1 = $row_matricula['f1'];
		$f2 = $row_matricula['f2'];
	}
	$datos->mat_ordinaria_desde = $f1;
	$datos->mat_ordinaria_hasta = $f2;
	
	if($fechaHoy >= $f1 && $fechaHoy <= $f2) {
		$datos->mat_ordinaria = "SI";
	}
	else {				
		if($fechaHoy < $f1) {
			$datos->mat_ordinaria = "AUN NO";
		}
		else {
			$datos->mat_ordinaria = "NO";
		}
	}
	
	//Se consulta el rango de matrícula extra ordinaria
	$sql_matricula_extra = "SELECT f1, f2 FROM tbl_parametros WHERE parametro = 'mat_extraordinarias'";
	$exe_matricula_extra = $mysqli1->query($sql_matricula_extra);
	while($row_matricula_extra = $exe_matricula_extra->fetch_assoc()) {
		$f1e = $row_matricula_extra['f1'];
		$f2e = $row_matricula_extra['f2'];
	}
	$datos->mat_extraordinaria_desde = $f1e;
	$datos->mat_extraordinaria_hasta = $f2e;
	
	if($fechaHoy >= $f1e && $fechaHoy <= $f2e) {
		$datos->mat_extraordinaria = "SI";
	}
	else {				
		if($fechaHoy < $f1e) {
			$datos->mat_extraordinaria = "AUN NO";
		}
		else {
			$datos->mat_extraordinaria = "NO";
		}
	}

	//consultar las fechas de cierre de periodo
	$cierre1P = $fechaHoy;
	$cierre2P = $fechaHoy;
	$sql_cierre_periodos = "SELECT parametro, f1 FROM tbl_parametros WHERE parametro IN (?, ?)";
	$params = ['cierre1P', 'cierre2P'];
	$exe_cierre_periodos = $mysqli1->prepare($sql_cierre_periodos);
    $exe_cierre_periodos->bind_param('ss', $params[0], $params[1]);
	$exe_cierre_periodos->execute();
	$result = $exe_cierre_periodos->get_result();

	while ($row_cierre_periodos = $result->fetch_assoc()) {
		if( $row_cierre_periodos['parametro'] == 'cierre1P') {
			$cierre1P = $row_cierre_periodos['f1'];
		}
		else if( $row_cierre_periodos['parametro'] == 'cierre2P') {
			$cierre2P = $row_cierre_periodos['f1'];
		}
	}
	$datos->cierre1P = $cierre1P;
	$datos->cierre2P = $cierre2P;
	
	
	//Se valida si el estudiante esta bloqueado
	$bloqueado = "NO";
	$ct_bloqueado = 0;
	$sql_bloqueado = "SELECT COUNT(1) ct FROM tbl_estudiantes_bloqueados WHERE n_documento = '$documento'";
	$exe_bloqueado = $mysqli1->query($sql_bloqueado);
	while($row_bloqueado = $exe_bloqueado->fetch_assoc()) {
		$ct_bloqueado = $row_bloqueado['ct'];
	}
	if($ct_bloqueado > 0) {
		$bloqueado = "SI";
	}
	$datos->bloqueado = $bloqueado;
	
	//Se consultan las deudas de otros años
	$keys = ['a','deuda'];
	$i = 0;
	$total_deudas_anteriores = 0;
	$deudas = array();
	$sql_duedas_anteriores = "SELECT * FROM tbl_deudas_anteriores WHERE documento = '$documento'";
	$res_duedas_anteriores = $mysqli1->query($sql_duedas_anteriores);
	while ($row_duedas_anteriores = $res_duedas_anteriores->fetch_assoc()) {
		$total_deudas_anteriores += $row_duedas_anteriores['deuda'];
		$valores = [$row_duedas_anteriores['a'],$row_duedas_anteriores['deuda']];
		$deudas_temp = array_combine($keys,$valores);
		$deudas[$i] = $deudas_temp;
		$i++;
	}
	$datos->deudas = $deudas;
	
	//Se valida si tiene deuda 1028871718 / 1222114726 / 1072655893
	$estado_deuda_anterior = "";
	$deuda_año_anterior = 0;
	$deuda_pendiente = $total_deudas_anteriores;
	$sql_deuda = "SELECT i.*, m.id_grado, e.id id_est, CONCAT(e.nombres, ' ', e.apellidos) nombre_completo, 
		CASE i.pago_matricula WHEN 'SI' THEN 'PAGADA' ELSE 'PENDIENTE' END estado_matricula, 
		CASE m.id_grado WHEN 6 THEN (CASE i.pago_derechos_grado WHEN 'SI' THEN 'PAGADOS' ELSE 'PENDIENTE' END) 
		WHEN 10 THEN (CASE i.pago_derechos_grado WHEN 'SI' THEN 'PAGADOS' ELSE 'PENDIENTE' END) 
		WHEN 12 THEN (CASE i.pago_derechos_grado WHEN 'SI' THEN 'PAGADOS' ELSE 'PENDIENTE' END) 
		WHEN 18 THEN (CASE i.pago_derechos_grado WHEN 'SI' THEN 'PAGADOS' ELSE 'PENDIENTE' END) ELSE 'NO APLICA' END estado_derechos_grado, 
		CASE m.id_grado WHEN 12 THEN (CASE i.pago_icfes WHEN 'SI' THEN 'PAGADO' ELSE 'PENDIENTE' END) 
		WHEN 18 THEN (CASE i.pago_icfes WHEN 'SI' THEN 'PAGADO' ELSE 'PENDIENTE' END) ELSE 'NO APLICA' END estado_icfes, 
		CASE WHEN i.deuda_anterior > 0 THEN (CASE WHEN i.pago_deuda >= i.deuda_anterior THEN 'PAGADA' ELSE 'PENDIENTE' END) ELSE 'SIN DEUDA' END estado_deuda_anterior, 
		i.deuda_anterior - i.pago_deuda deuda_pendiente 
		FROM tbl_informacion_financiera i, tbl_estudiantes e, tbl_matriculas m 
		WHERE i.documento_estudiante = e.n_documento AND e.id = m.id_estudiante AND e.n_documento = '$documento' AND e.nombres IS NOT NULL 
		ORDER BY a DESC LIMIT 1";
	//echo $sql_deuda;
	$res_deuda = $mysqli1->query($sql_deuda);
	while ($row_deuda = $res_deuda->fetch_assoc()) {
		$estado_deuda_anterior = $row_deuda['estado_deuda_anterior'];
		$deuda_pendiente += $row_deuda['deuda_pendiente'];
		$deuda_año_anterior += $row_deuda['deuda_pendiente'];
	}
	$datos->estado_deuda_anterior = $estado_deuda_anterior;
	$datos->deuda_año_anterior = $deuda_año_anterior;
	$datos->deuda_pendiente = $deuda_pendiente;
	//$datos->estado_deuda_anterior = "PENDIENTE";
	//$datos->deuda_pendiente = 1000000;
	
	//Se consulta el estado de validación del comprobante de pago de deuda
	$validacion_comprobante_deuda = 0;
	if ($deuda_pendiente > 0) {
		$sql_validacion_deuda = "SELECT * FROM tbl_asistente_virtual_comprobantes_pago WHERE documento = '$documento' AND a = $a AND tipo = 'deuda'";
		$res_validacion_deuda = $mysqli1->query($sql_validacion_deuda);
		while ($row_validacion_deuda = $res_validacion_deuda->fetch_assoc()) {
			$validacion_comprobante_deuda = $row_validacion_deuda['validado'];
		}
	}
	$datos->validacion_comprobante_deuda = $validacion_comprobante_deuda;
	
	//Se consulta el estado de validación del comprobante de pago de matrícula
	$validacion_comprobante_matricula = 0;
	$sql_validacion_matricula = "SELECT * FROM tbl_asistente_virtual_comprobantes_pago WHERE documento = '$documento' AND a = $fanio AND tipo = 'matrícula'";
	$res_validacion_matricula = $mysqli1->query($sql_validacion_matricula);
	while ($row_validacion_matricula = $res_validacion_matricula->fetch_assoc()) {
		$validacion_comprobante_matricula = $row_validacion_matricula['validado'];
	}
	$datos->validacion_comprobante_matricula = $validacion_comprobante_matricula;
	
	//Se consulta el estado de validación de los documentos finales de matrícula
	$validacion_documentos_finales_matricula = 0;
	$ct_doc = 0;
	$ct_val = 0;
	$sql_validacion_documentos = "SELECT COUNT(documento) ct_doc, SUM(validado) ct_val FROM tbl_documentos_matriculas WHERE documento = ? ANd a = ?";
	$exe_validacion_documentos = $mysqli1->prepare($sql_validacion_documentos);
    $exe_validacion_documentos->bind_param('si', $documento, $fanio);
	$exe_validacion_documentos->execute();
	$result = $exe_validacion_documentos->get_result();

	while ($row = $result->fetch_assoc()) {
		$ct_doc = $row['ct_doc'];
		$ct_val = $row['ct_val'];
	}
	//echo $ct_doc." ".$ct_val;
	if ($ct_doc > 0 && $ct_doc == $ct_val) {
		$validacion_documentos_finales_matricula = 1;
	}
	$datos->validacion_documentos_finales_matricula = $validacion_documentos_finales_matricula;
	
	//Se consulta el grado si ya hay registro en matrícula para el nuevo año_matricula
	$sql_grado_matricula = "SELECT m.*, g.grado 
	FROM tbl_matriculas m, tbl_grados g, tbl_estudiantes e 
	WHERE e.id = m.id_estudiante AND m.id_grado = g.id AND m.n_matricula like '%$fanio%' AND e.n_documento = '$documento'";
	//echo $sql_grado_matricula;
	$res_grado_matricula = $mysqli1->query($sql_grado_matricula);
	while ($row_grado_matricula = $res_grado_matricula->fetch_assoc()) {
		$idGrado = $row_grado_matricula['id_grado'];
		$grado = $row_grado_matricula['grado'];
	}
	$datos->id_grado_matricular = $idGrado;
	$datos->grado_matricular = $grado;
	
	//Se consulta el grado, en caso de que no se haya hecho todavía el nuevo registro en matrícula --- consulta anterior
	$sql_grado = "SELECT * FROM tbl_grados WHERE id = ".$datos->id_grado_matricular;
	$res_grado = $mysqli1->query($sql_grado);
	while ($row_grado = $res_grado->fetch_assoc()) {
		$datos->grado_matricular = $row_grado['grado'];
	}
	
	//Se consultan los costos de matrícula
	$pp = 0;
	$poliza = 0;
	$mocp = 0;
	$matricula = 0;
	$pension = 0;
	$ocp = 0;
	if ($idGrado > 0) {
		$sql_costos_matricula = "SELECT * FROM tbl_costos WHERE a = $fanio AND id_grado = $idGrado";
		//echo $sql_costos_matricula;
		$res_costos_matricula = $mysqli1->query($sql_costos_matricula);
		while ($row_costos_matricula = $res_costos_matricula->fetch_assoc()) {
			$pp = $row_costos_matricula['pp'];
			$poliza = $row_costos_matricula['poliza'];
			$mocp = $row_costos_matricula['mocp'];
			$matricula = $row_costos_matricula['matricula'];
			$pension = $row_costos_matricula['pension'];
			$ocp = $row_costos_matricula['ocp'];
		}
	}
	$datos->pp = $pp;
	$datos->poliza = $poliza;
	$datos->mocp = $mocp;
	$datos->matricula = $matricula;
	$datos->pension = $pension;
	$datos->ocp = $ocp;
	
	//Se consulta el medio de llegada
	$datos->id_medio = 1;
	$datos->medio = "PAGINA WEB UNICAB";
	$sql_medio = "SELECT pm.*, IFNULL(pm.id_medio, 0) id_medio1, m.medio 
	FROM tbl_pre_matriculas pm, tbl_medios_llegada m 
	WHERE IFNULL(pm.id_medio, 0) = m.id AND pm.documento_est = '$documento' ORDER BY id DESC LIMIT 1";
	//echo $sql_medio;
	$res_medio = $mysqli1->query($sql_medio);
	while ($row_medio = $res_medio->fetch_assoc()) {
		$datos->id_medio = $row_medio['id_medio1'];
		$datos->medio = $row_medio['medio'];
	}
	
	//Se agregan los tipos de documento
	$keys = ['id_td','td'];
	$i = 0;
	$documentos = array();
	$sql_documentos = "SELECT * FROM tbl_tipos_documento";
	$res_documentos = $mysqli1->query($sql_documentos);
	while ($row_documentos = $res_documentos->fetch_assoc()) {
		$valores = [$row_documentos['id'],$row_documentos['tipo_documento']];
		$documentos_temp = array_combine($keys,$valores);
		$documentos[$i] = $documentos_temp;
		$i++;
	}
	$datos->documentos = $documentos;
	
	//Se agregan los medios de llegada
	$keys = ['id_medio','medio'];
	$i = 0;
	$medios = array();
	$sql_medios = "SELECT * FROM tbl_medios_llegada";
	$res_medios = $mysqli1->query($sql_medios);
	while ($row_medios = $res_medios->fetch_assoc()) {
		$valores = [$row_medios['id'],$row_medios['medio']];
		$medios_temp = array_combine($keys,$valores);
		$medios[$i] = $medios_temp;
		$i++;
	}
	$datos->medios = $medios;
	
	//Se agregan los generos
	$keys = ['id_genero','genero'];
	$i = 0;
	$generos = array();
	$sql_generos = "SELECT * FROM tbl_generos";
	$res_generos = $mysqli1->query($sql_generos);
	while ($row_generos = $res_generos->fetch_assoc()) {
		$valores = [$row_generos['id'],$row_generos['genero']];
		$generos_temp = array_combine($keys,$valores);
		$generos[$i] = $generos_temp;
		$i++;
	}
	$datos->generos = $generos;
	
	//Se agregan los parentescos
	$keys = ['id_parentesco','parentesco'];
	$i = 0;
	$parentescos = array();
	$sql_parentescos = "SELECT * FROM tbl_parentescos";
	$res_parentescos = $mysqli1->query($sql_parentescos);
	while ($row_parentescos = $res_parentescos->fetch_assoc()) {
		$valores = [$row_parentescos['id'],$row_parentescos['parentesco']];
		$parentescos_temp = array_combine($keys,$valores);
		$parentescos[$i] = $parentescos_temp;
		$i++;
	}
	$datos->parentescos = $parentescos;
	
	//Se agregan los documentos finales inválidos
	$tipos = array();
	$keys = ['etiqueta','nombre'];
	$i = 0;
	$_grados = ["ninguno", "Primero", "Segundo", "Tercero", "Cuarto", "Quinto", "Sexto", "Séptimo", "Octavo", "Noveno", "Décimo", "UnDécimo"];
	$sql_documentos_invalidos = "SELECT * FROM tbl_documentos_matriculas WHERE documento = ? AND a = ? AND validado = 0";
	$exe_documentos_invalidos = $mysqli1->prepare($sql_documentos_invalidos);
    $exe_documentos_invalidos->bind_param('si', $documento, $fanio);
	$exe_documentos_invalidos->execute();
	$result = $exe_documentos_invalidos->get_result();

	while ($row = $result->fetch_assoc()) {
		$nombreFile = $row['tipo'];
		if ($nombreFile == "contrato") {
			$etiqueta = "Adjunta el contrato diligenciado y firmado";
		}
		else if ($nombreFile == "pagare") {
			$etiqueta = "Adjunta el pagaré diligenciado, firmado y autenticado en notaría";
		}
		else if ($nombreFile == "documento_estudiante") {
			$etiqueta = "Adjunta el documento de identidad del estudiante <span style='background: yellow; color: red;'>(solo si cambió)</span>";
		}
		else if ($nombreFile == "actividad_extra") {
			$etiqueta = "Adjunta el certificado de actividad extracurricular <span style='background: yellow; color: red;'>(solo si cambió)</span>";
		}
		else if ($nombreFile == "foto") {
			$etiqueta = "Adjunta una fotografía reciente del estudiante";
		}
		else if ($nombreFile == "eps") {
			$etiqueta = "Adjunta el certificado de la EPS";
		}
		else if ($nombreFile == "vacunas") {
			$etiqueta = "Adjunta carnet de vacunación al día, con esquema completo incluyendo refuerzos";
		}
		else if ($nombreFile == "paz_salvo") {
			$etiqueta = "Adjunta el paz y salvo del año lectivo anterior";
		}
		else if ($nombreFile == "calificaciones1") {
			$etiqueta = "Adjunta certificado final calificaciones grado ".$_grados[1];
		}
		else if ($nombreFile == "calificaciones2") {
			$etiqueta = "Adjunta certificado final calificaciones grado ".$_grados[2];
		}
		else if ($nombreFile == "calificaciones3") {
			$etiqueta = "Adjunta certificado final calificaciones grado ".$_grados[3];
		}
		else if ($nombreFile == "calificaciones4") {
			$etiqueta = "Adjunta certificado final calificaciones grado ".$_grados[4];
		}
		else if ($nombreFile == "calificaciones5") {
			$etiqueta = "Adjunta certificado final calificaciones grado ".$_grados[5];
		}
		else if ($nombreFile == "calificaciones6") {
			$etiqueta = "Adjunta certificado final calificaciones grado ".$_grados[6];
		}
		else if ($nombreFile == "calificaciones7") {
			$etiqueta = "Adjunta certificado final calificaciones grado ".$_grados[7];
		}
		else if ($nombreFile == "calificaciones8") {
			$etiqueta = "Adjunta certificado final calificaciones grado ".$_grados[8];
		}
		else if ($nombreFile == "calificaciones9") {
			$etiqueta = "Adjunta certificado final calificaciones grado ".$_grados[9];
		}
		else if ($nombreFile == "calificaciones10") {
			$etiqueta = "Adjunta certificado final calificaciones grado ".$_grados[10];
		}
		else if ($nombreFile == "calificaciones11") {
			$etiqueta = "Adjunta certificado final calificaciones grado ".$_grados[11];
		}
		else if ($nombreFile == "documento_acudiente") {
			$etiqueta = "Adjunta el documento de identidad del acudiente <span style='background: yellow; color: red;'>(solo si cambió)</span>".$_grados[11];
		}
		$valores = [$etiqueta,$nombreFile];
		$tipos_temp = array_combine($keys,$valores);
		$tipos[$i] = $tipos_temp;
		$i++;
	}
	$datos->tipos = $tipos;
	
	$datos->status = "success";
	
	//Se hace el insert en tbl_asistente_virtual si no existe --- controlar desde la consulta inicial
	if ($paso == 0) {
		if ($control_antiguos == 1) {
			if ($datos->deuda_pendiente  > 0) {
				$sql_av = "INSERT INTO tbl_asistente_virtual (documento_estudiante, a, paso, antiguo, control_antiguos, nuevo, id_grado, con_deuda, deuda)  VALUES 
				('$documento', $fanio, '2.1.1', 1, $datos->control_antiguos, 0, $idGrado, 1, $datos->deuda_pendiente) 
				ON DUPLICATE KEY UPDATE paso = VALUES(paso), antiguo = VALUES(antiguo), control_antiguos = VALUES(control_antiguos), 
				nuevo = VALUES(nuevo), id_grado = VALUES(id_grado), con_deuda = VALUES(con_deuda), deuda = VALUES(deuda)";
				$datos->paso = '2.1.1';
				$datos->etiqueta_intencion = "valor_dueda_ant_cd";
			}
			else {
				$sql_av = "INSERT INTO tbl_asistente_virtual (documento_estudiante, a, paso, antiguo, control_antiguos, nuevo, id_grado, con_deuda, deuda)  VALUES 
				('$documento', $fanio, '1.2', 1, $datos->control_antiguos, 0, $idGrado, 0, $datos->deuda_pendiente) 
				ON DUPLICATE KEY UPDATE paso = VALUES(paso), antiguo = VALUES(antiguo), control_antiguos = VALUES(control_antiguos), 
				nuevo = VALUES(nuevo), id_grado = VALUES(id_grado), con_deuda = VALUES(con_deuda), deuda = VALUES(deuda)";
				$datos->paso = '1.2';
				$datos->etiqueta_intencion = "datos_actuales_ant_sd";
			}
		}
		else if ($control_antiguos == 2) {
			if ($datos->deuda_pendiente  > 0) {
				$sql_av = "INSERT INTO tbl_asistente_virtual (documento_estudiante, a, paso, antiguo, control_antiguos, nuevo, id_grado, con_deuda, deuda)  VALUES 
				('$documento', $fanio, '3.1.1', 0, $datos->control_antiguos, 1, $idGrado, 1, $datos->deuda_pendiente) 
				ON DUPLICATE KEY UPDATE paso = VALUES(paso), antiguo = VALUES(antiguo), control_antiguos = VALUES(control_antiguos), 
				nuevo = VALUES(nuevo), id_grado = VALUES(id_grado), con_deuda = VALUES(con_deuda), deuda = VALUES(deuda)";
				$datos->paso = '3.1.1';
				$datos->etiqueta_intencion = "opciones_pago_deuda_antiguo_nuevo";
			}
			else {
				$sql_av = "INSERT INTO tbl_asistente_virtual (documento_estudiante, a, paso, antiguo, control_antiguos, nuevo, id_grado, con_deuda, deuda)  VALUES 
				('$documento', '$fanio', '4.2', 0, $datos->control_antiguos, 1, $idGrado, 0, $datos->deuda_pendiente) 
				ON DUPLICATE KEY UPDATE paso = VALUES(paso), antiguo = VALUES(antiguo), control_antiguos = VALUES(control_antiguos), 
				nuevo = VALUES(nuevo), id_grado = VALUES(id_grado), con_deuda = VALUES(con_deuda), deuda = VALUES(deuda)";
				$datos->paso = '4.2';
				$datos->etiqueta_intencion = "datos_actuales_ant_nuevo_sd";
			}
		}
		else if ($datos->estado == "nuevo") {
			$sql_av = "INSERT INTO tbl_asistente_virtual (documento_estudiante, a, paso, antiguo, control_antiguos, nuevo, id_grado, con_deuda, deuda)  VALUES 
			('$documento', '$fanio', '5.2', 0, $datos->control_antiguos, 1, $idGrado, 0, $datos->deuda_pendiente) 
			ON DUPLICATE KEY UPDATE paso = VALUES(paso), antiguo = VALUES(antiguo), control_antiguos = VALUES(control_antiguos), 
			nuevo = VALUES(nuevo), id_grado = VALUES(id_grado), con_deuda = VALUES(con_deuda), deuda = VALUES(deuda)";
			$datos->paso = '5.2';
			$datos->etiqueta_intencion = "formulario_inicial_nuevo";
		}
		$res_av = $mysqli1->query($sql_av);
	}
	
	echo json_encode($datos, JSON_UNESCAPED_UNICODE);
	
?>