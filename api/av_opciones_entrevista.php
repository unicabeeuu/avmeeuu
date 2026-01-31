 <?php 
 	require("../registro/docenteunicab/updreg/1cc3s4db.php");
	// Habilitar CORS solo para tu entorno local durante desarrollo
	header("Access-Control-Allow-Origin: http://localhost:90");
	header("Access-Control-Allow-Methods: GET, POST"); //, OPTIONS
	header("Access-Control-Allow-Headers: Content-Type");
	//https://unicab.org/avadmisiones/av_opciones_entrevista.php

	// Configuración
	$horas_posibles = ["08", "09", "10", "11", "14", "15", "16", "17"];
	$max_opciones = 12;
	$disponibles = [];

	// Fecha actual
	$hoy = new DateTime();
	$dia_siguiente = $hoy->modify('+1 day');
	//echo $dia_siguiente->format('Y-m-d');
	
	// Si cae en fin de semana (6=sábado,7=domingo), avanzar hasta que sea día hábil (1..5)
	while ((int)$dia_siguiente->format('N') >= 6) {
		$dia_siguiente->modify('+1 day');
	}
	//echo $dia_siguiente->format('Y-m-d');

	// Buscar próximos días hábiles
	while (count($disponibles) < $max_opciones) {
		$dia_semana = $dia_siguiente->format("N"); // 1 (Lunes) - 7 (Domingo)
		//echo $dia_semana;
		if ($dia_semana < 6) { // Solo lunes a viernes
			$fecha = $dia_siguiente->format("Y-m-d");
			$ocupadas = [];

			foreach ($horas_posibles as $hora) {
				// Verificar si está ocupada
				/*$sql_agenda_entrevistas = "SELECT DISTINCT e.nombre_est, e.documento_est, e.fecha, e.hora, 
					pm.acudiente_1 nombre_a, pm.telefono_acudiente_1 celular_a, pm. email_acudiente_1 email_a, 'entrevista' fuente 
					FROM tbl_entrevistas e LEFT JOIN estudiantes pm ON e.documento_est = pm.n_documento WHERE e.id_psicologo = 42 AND e.fecha = ? AND e.hora = ?
					UNION ALL 
					SELECT CONCAT(e.nombres, ' ', e.apellidos) nombre_est, s.documento_est, s.fecha, s.hora, e.acudiente_1, e.telefono_acudiente_1, e.email_acudiente_1, 'seguimiento' fuente
					FROM tbl_seguimientos s, estudiantes e WHERE s.documento_est = e.n_documento AND s.id_psicologo = 42 AND s.fecha = ? AND s.hora = ? 
					UNION ALL 
					SELECT CONCAT(e.nombres, ' ', e.apellidos) nombre_est, e.n_documento, s.fecha, s.hora, e.acudiente_1, e.telefono_acudiente_1, e.email_acudiente_1, 'seguimiento' fuente
					FROM tbl_seg_psi s, tbl_seg_psi_val v, estudiantes e WHERE s.id_valoracion = v.id AND v.n_documento = e.n_documento AND s.id_psicologo = 42 AND s.fecha = ? AND s.hora = ? 
					UNION ALL 
					SELECT a.descripcion nombre_est, '--' documento, a.fecha, a.hora, '--' nombre_a, '--' cel_a, '--' email_a, ta.tipo_agenda fuente 
					FROM tbl_agendamientos a, tbl_tipos_agenda ta WHERE a.id_tipo_agenda = ta.id AND a.id_empleado = 42 AND a.fecha = ? AND a.hora = ?";*/
				$sql_agenda_entrevistas = "SELECT DISTINCT e.nombre_est, e.documento_est, e.fecha, e.hora, 
					pm.acudiente_1 nombre_a, pm.telefono_acudiente_1 celular_a, pm. email_acudiente_1 email_a, 'entrevista' fuente 
					FROM tbl_entrevistas e LEFT JOIN estudiantes pm ON e.documento_est = pm.n_documento WHERE e.id_psicologo = 42 AND e.fecha = ? AND e.hora = ?
					UNION ALL 
					SELECT CONCAT(e.nombres, ' ', e.apellidos) nombre_est, s.documento_est, s.fecha, s.hora, e.acudiente_1, e.telefono_acudiente_1, e.email_acudiente_1, 'seguimiento' fuente
					FROM tbl_seguimientos s, estudiantes e WHERE s.documento_est = e.n_documento AND s.id_psicologo = 42 AND s.fecha = ? AND s.hora = ? 
					UNION ALL 
					SELECT CONCAT(e.nombres, ' ', e.apellidos) nombre_est, e.n_documento, s.fecha, s.hora, e.acudiente_1, e.telefono_acudiente_1, e.email_acudiente_1, 'seguimiento' fuente
					FROM tbl_seg_psi s, tbl_seg_psi_val v, estudiantes e WHERE s.id_valoracion = v.id AND v.n_documento = e.n_documento AND s.id_psicologo = 42 AND s.fecha = ? AND s.hora = ? 
					UNION ALL 
					SELECT a.descripcion nombre_est, '--' documento, a.fecha, a.hora, '--' nombre_a, '--' cel_a, '--' email_a, ta.tipo_agenda fuente 
					FROM tbl_agendamientos a, tbl_tipos_agenda ta WHERE a.id_tipo_agenda = ta.id AND a.id_empleado = 42 AND a.fecha = ? AND a.hora = ? 
					UNION ALL 
					SELECT 'día festivo' nombre_est, '0' documento_est, dia fecha, ? hora,
					'NA' nombre_a, 0 celular_a, 'NA' email_a, 'día festivo' fuente 
					FROM tbl_dias_festivos WHERE dia = ?";
				//echo "<br>".$sql_agenda_entrevistas;
				
				$exe_agenda_entrevistas = $mysqli1->prepare($sql_agenda_entrevistas);
				//$exe_agenda_entrevistas->bind_param("ssssssss", $fecha, $hora, $fecha, $hora, $fecha, $hora, $fecha, $hora);
				$exe_agenda_entrevistas->bind_param("ssssssssss", $fecha, $hora, $fecha, $hora, $fecha, $hora, $fecha, $hora, $hora, $fecha);
				$exe_agenda_entrevistas->execute();
				$result = $exe_agenda_entrevistas->get_result();

				while ($row = $result->fetch_assoc()) {
					$ocupadas[] = strtolower(trim($row['hora']));
				}

				if (!in_array(strtolower(trim($hora)), $ocupadas)) {
					// Convertir la hora 24h a 12h (AM/PM)
					$hora_formato = date("g a", strtotime($hora . ":00"));
				
					//$texto = date("d M", strtotime($fecha)) . " " . strtoupper($hora);
					$texto = date("d M", strtotime($fecha)) . " " . strtoupper($hora_formato);
					$valor = $fecha . "|" . str_replace(" ", "", $hora);

					$disponibles[] = [
						"texto" => $texto,
						"valor" => $valor,
						"tipo" => "intencion",
						"destino" => "confirmar_agendamiento"
					];
					//if (count($disponibles) >= 6) break; // Ya tenemos los 6 primeros
				}

				if (count($disponibles) >= $max_opciones) break;
			}
		}

		$dia_siguiente->modify("+1 day");
	}
	
	//Se consultan los datos del psicólogo
	$psicologo = "";
	$celular_psi = "";
	$meet_psi = "";
	$sql_psicologo = "SELECT * FROM tbl_empleados WHERE id = 42";
	$res_psicologo = $mysqli1->query($sql_psicologo);
    while($row_psicologo = $res_psicologo->fetch_assoc()){
        $psicologo = $row_psicologo['nombres']." ".$row_psicologo['nombres'];
        $celular_psi = str_replace(" ", "", trim($row_psicologo['celular']));
		$meet_psi = $row_psicologo['skype'];
    }

	// Respuesta JSON
	echo json_encode([
		"status" => "success",
		"mensaje" => "Horarios disponibles generados correctamente.",
		"botones" => $disponibles,
		"idpsi" => 42,
		"psicologo" => $psicologo,
		"celular_psi" => $celular_psi,
		"meet_psi" => $meet_psi
	], JSON_UNESCAPED_UNICODE);
	
?>