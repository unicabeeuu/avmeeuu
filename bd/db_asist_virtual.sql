DROP DATABASE IF EXISTS admin_unieeuu;

CREATE DATABASE admin_unieeuu DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_asistente_virtual_comprobantes_pago;

CREATE TABLE tbl_asistente_virtual_comprobantes_pago (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  documento varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  a int(11) UNSIGNED NOT NULL,
  tipo varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'deuda, matrícula',
  ruta varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  valor int(11) NOT NULL DEFAULT 0,
  validado int(2) UNSIGNED NOT NULL,
  correo int(2) NOT NULL DEFAULT 0,
  rechazado int(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

ALTER TABLE tbl_asistente_virtual_comprobantes_pago
ADD UNIQUE KEY documento (documento,a,tipo);

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_asistente_virtual_pasos;

CREATE TABLE tbl_asistente_virtual_pasos (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  paso varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  descripcion varchar(100) NOT NULL,
  paso_numero int(11) UNSIGNED NOT NULL,
  etiqueta_intencion varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_asistente_virtual_pasos (id, paso, descripcion, paso_numero, etiqueta_intencion) VALUES
(1, '0', 'documento_estudiante', 0, 'menu_inicial'),
(2, '1.1', 'bienvenida antiguo sin deuda', 110000, 'bienvenida_ant_sd'),
(3, '1.2', 'datos actuales antiguo sin deuda', 120000, 'datos_actuales_ant_sd'),
(4, '1.2.1', 'actualiza datos antiguo sin deuda', 121000, 'actualiza_datos_ant_sd'),
(5, '1.3', 'costos matrícula antiguo sin deuda', 130000, 'costos_matricula_ant_sd'),
(6, '1.3.1', 'comprobante matrícula antiguo sin deuda', 131000, 'comprobante_matricula_ant_sd'),
(7, '1.3.2', 'validando comprobante matrícula antiguo sin deuda', 132000, 'validando_comprobante_matricula_ant_sd'),
(8, '1.4', 'documentos y datos finales antiguo sin deuda', 140000, 'documentos_finales_ant_sd'),
(9, '1.4.1', 'validando documentos antiguo sin deuda', 141000, 'validando_documentos_ant_sd'),
(10, '1.5', 'resumen antiguo sin deuda', 150000, 'resumen_ant_sd'),
(11, '2.1', 'bienvenida antiguo con deuda', 210000, 'bienvenida_ant_cd'),
(12, '2.1.1', 'valor deuda antiguo con deuda', 211000, 'valor_dueda_ant_cd'),
(13, '2.1.1.1', 'comprobante pago deuda antiguo con deuda', 211100, 'comprobante_deuda_ant_cd'),
(14, '2.1.1.2', 'validando comprobante deuda antiguo con deuda', 211200, 'validando_comprobante_deuda_ant_cd'),
(15, '2.2', 'datos actuales antiguo con deuda', 220000, 'datos_actuales_ant_cd'),
(16, '2.2.1', 'actualiza datos antiguo con deuda', 221000, 'actualiza_datos_ant_cd'),
(17, '2.3', 'costos matrícula antiguo con deuda', 230000, 'costos_matricula_ant_cd'),
(18, '2.3.1', 'comprobante matrícula antiguo con deuda', 231000, 'comprobante_matricula_ant_cd'),
(19, '2.3.2', 'validando comprobante matrícula antiguo con deuda', 232000, 'validando_comprobante_matricula_ant_cd'),
(20, '2.4', 'documentos y datos finales antiguo con deuda', 240000, 'documentos_finales_ant_cd'),
(21, '2.4.1', 'validando documentos antiguo con deuda', 241000, 'validando_documentos_ant_cd'),
(22, '2.5', 'resumen antiguo con deuda', 250000, 'resumen_ant_cd'),
(23, '3.1', 'bienvenida antiguo nuevo con deuda', 310000, 'bienvenida_ant_nuevo_cd'),
(24, '3.1.1', 'valor deuda antiguo nuevo con deuda', 311000, 'opciones_pago_deuda_antiguo_nuevo'),
(25, '3.1.1.1', 'comprobante pago deuda antiguo nuevo con deuda', 311100, 'comprobante_deuda_ant_nuevo_cd'),
(26, '3.1.1.2', 'validando comprobante deuda antiguo nuevo con deuda', 311200, 'validando_comprobante_deuda_ant_nuevo_cd'),
(27, '3.2', 'datos actuales antiguo nuevo con deuda', 320000, 'datos_actuales_ant_nuevo_cd'),
(28, '3.2.1', 'actualiza datos antiguo nuevo con deuda', 321000, 'datos_actuales_ant_nuevo_cd'),
(29, '3.3', 'evaluación admisión antiguo nuevo con deuda', 330000, 'evaluacion_admision_ant_nuevo_cd'),
(30, '3.4', 'entrevista antiguo nuevo con deuda', 340000, 'entrevista_ant_nuevo_cd'),
(31, '3.5', 'costos matrícula antiguo nuevo con deuda', 350000, 'costos_matricula_ant_nuevo_cd'),
(32, '3.5.1', 'comprobante matrícula antiguo nuevo con deuda', 351000, 'comprobante_matricula_ant_nuevo_cd'),
(33, '3.5.2', 'validando comprobante matrícula antiguo nuevo con deuda', 352000, 'validando_comprobante_matricula_ant_nuevo_cd'),
(34, '3.6', 'documentos y datos finales antiguo nuevo con deuda', 360000, 'documentos_finales_ant_nuevo_cd'),
(35, '3.6.1', 'validando documentos antiguo nuevo con deuda', 361000, 'validando_documentos_ant_nuevo_cd'),
(36, '3.7', 'resumen antiguo nuevo con deuda', 370000, 'resumen_ant_nuevo_cd'),
(37, '4.1', 'bienvenida antiguo nuevo sin deuda', 410000, 'bienvenida_ant_nuevo_sd'),
(38, '4.2', 'datos actuales antiguo nuevo sin deuda', 420000, 'datos_actuales_ant_nuevo_sd'),
(39, '4.2.1', 'actualiza datos antiguo nuevo sin deuda', 421000, 'actualiza_datos_ant_nuevo_sd'),
(40, '4.3', 'evaluación admisión antiguo nuevo sin deuda', 430000, 'evaluacion_admision_ant_nuevo_sd'),
(41, '4.4', 'entrevista antiguo nuevo sin deuda', 440000, 'entrevista_ant_nuevo_sd'),
(42, '4.5', 'costos matrícula antiguo nuevo sin deuda', 450000, 'costos_matricula_ant_nuevo_sd'),
(43, '4.5.1', 'comprobante matrícula antiguo nuevo sin deuda', 451000, 'comprobante_matricula_ant_nuevo_sd'),
(44, '4.5.2', 'validando comprobante matrícula antiguo nuevo sin deuda', 452000, 'validando_comprobante_matricula_ant_nuevo_sd'),
(45, '4.6', 'documentos y datos finales antiguo nuevo sin deuda', 460000, 'documentos_finales_ant_nuevo_sd'),
(46, '4.6.1', 'validando documentos antiguo nuevo sin deuda', 461000, 'validando_documentos_ant_nuevo_sd'),
(47, '4.7', 'resumen antiguo nuevo sin deuda', 470000, 'resumen_ant_nuevo_sd'),
(48, '5.1', 'bienvenida nuevo', 510000, 'bienvenida_nuevo'),
(49, '5.2', 'mostrar formulario inicial nuevo', 520000, 'formulario_inicial_nuevo'),
(50, '5.3', 'evaluación admisión nuevo', 530000, 'evaluacion_admision_nuevo'),
(51, '5.4', 'entrevista nuevo', 540000, 'entrevista_nuevo'),
(52, '5.5', 'costos de matrícula nuevo', 550000, 'costos_matricula_nuevo'),
(53, '5.5.1', 'comprobante pago matrícula nuevo', 551000, 'comprobante_matricula_nuevo'),
(54, '5.5.2', 'validando comprobante pago matrícula nuevo', 552000, 'validando_comprobante_matricula_nuevo'),
(55, '5.6', 'documentos y datos finales nuevo', 560000, 'documentos_finales_nuevo'),
(56, '5.6.1', 'validando documentos nuevo', 561000, 'validando_documentos_nuevo'),
(57, '5.7', 'mostrar resumen nuevo', 570000, 'resumen_nuevo');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_asistente_virtual;

CREATE TABLE tbl_asistente_virtual (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  documento_estudiante varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  a int(4) UNSIGNED NOT NULL,
  proceso_iniciado int(2) UNSIGNED NOT NULL DEFAULT 1,
  paso varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1',
  antiguo int(2) UNSIGNED NOT NULL DEFAULT 0,
  control_antiguos int(2) UNSIGNED NOT NULL DEFAULT 0,
  nuevo int(2) UNSIGNED NOT NULL DEFAULT 0,
  id_grado int(11) UNSIGNED NOT NULL DEFAULT 0,
  con_deuda int(2) UNSIGNED NOT NULL DEFAULT 0,
  deuda int(11) UNSIGNED NOT NULL DEFAULT 0,
  control_documentos_invalidos int(2) NOT NULL DEFAULT 0,
  fecha datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_estudiantes;

CREATE TABLE tbl_estudiantes (
  id int(5) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  apellidos varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  nombres varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  genero varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  tipo_documento varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  n_documento varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  fecha_nacimiento date DEFAULT NULL,
  expedicion varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  ciudad varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  direccion varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  direccion_estudiante varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  telefono_estudiante varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  email_institucional varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'NA',
  actividad_extra varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'No Registra',
  email_acudiente_1 varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  email_acudiente_2 varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  acudiente_1 varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  acudiente_2 varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  telefono_acudiente_1 varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  telefono_acudiente_2 varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  parentesco_acudiente_1 varchar(10) DEFAULT 'NA',
  parentesco_acudiente_2 varchar(10) DEFAULT 'NA',
  rh varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '--',
  password varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  mensaje varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  fecha_datos date NOT NULL,
  documento_responsable varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  situacion_se varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

ALTER TABLE tbl_estudiantes
ADD UNIQUE KEY n_documento (n_documento);

INSERT INTO tbl_estudiantes (apellidos, nombres, genero, tipo_documento, n_documento, fecha_nacimiento, expedicion, ciudad, direccion, direccion_estudiante, telefono_estudiante, email_institucional, actividad_extra, email_acudiente_1, email_acudiente_2, acudiente_1, acudiente_2, telefono_acudiente_1, telefono_acudiente_2, parentesco_acudiente_1, parentesco_acudiente_2, rh, password, mensaje, fecha_datos, documento_responsable, situacion_se) VALUES
('FIGUEREDO GUEVARA', 'GREGORY HERNANDO', 'MASCULINO', '3', '93974544', '1973-01-10', 'SOGAMOSO', 'SOGAMOSO', 'CA 14 2-27', 'CA 14 2-27', '1234567', 'gregory.figueredo@unicab.org', 'PROG', 'gregory.figueredo@unicab.org', '', 'ANA ELVA GUEVARA', '', '3192997229', '', 'MADRE', 'NA', 'B+', '9397454', '', '2023-10-29', '23543550', 'PRUEBA'),
('FIGUEREDO GUEVARA', 'GREGORY HERNANDO', 'MASCULINO', '3', '93974543', '1973-01-10', 'SOGAMOSO', 'SOGAMOSO', 'CA 14 2-27', 'CA 14 2-27 	', '1234567', 'gregory.figueredo@unicab.org', 'PROG', 'gregory.figueredo@unicab.org', '', 'ANA ELVA GUEVARA', '', '3192997229', '', 'MADRE', 'NA', 'B+', '9397454', '', '2023-10-29', '23543550', 'PRUEBA'),
('FIGUEREDO GUEVARA', 'GREGORY HERNANDO', 'MASCULINO', '3', '93974542', '1973-01-10', 'SOGAMOSO', 'SOGAMOSO', 'CA 14 2-27', 'CA 14 2-27', '1234567', 'gregory.figueredo@unicab.org', 'PROG', 'gregory.figueredo@unicab.org', '', 'ANA ELVA GUEVARA', '', '3192997229', '', 'MADRE', 'NA', 'B+', '9397454', '', '2023-10-29', '23543550', 'PRUEBA'),
('FIGUEREDO GUEVARA', 'GREGORY HERNANDO', 'MASCULINO', '3', '93974541', '1973-01-10', 'SOGAMOSO', 'SOGAMOSO', 'CA 14 2-27', 'CA 14 2-27', '1234567', 'gregory.figueredo@unicab.org', 'PROG', 'gregory.figueredo@unicab.org', '', 'ANA ELVA GUEVARA', '', '3192997229', '', 'MADRE', 'NA', 'B+', '9397454', '', '2023-10-29', '23543550', 'PRUEBA')
;

/*ALTER TABLE tbl_estudiantes
MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;*/


/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_generos;

CREATE TABLE tbl_generos (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  genero varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_generos (genero) VALUES
('FEMENINO'),
('MASCULINO');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_matriculas;

CREATE TABLE tbl_matriculas (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  n_matricula varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  fecha_ingreso date DEFAULT NULL,
  estado varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'pre_solicitud',
  id_estudiante int(11) NOT NULL,
  id_grado int(2) NOT NULL,
  estado_grado varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  grupo varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_matriculas (n_matricula, fecha_ingreso, estado, id_estudiante, id_grado, estado_grado, grupo) VALUES
('-1-2025-4G', '2025-01-01', 'aprobado', -4, 4, 'ant', 'A'),
('-2-2025-4G', '2025-01-01', 'aprobado', -3, 4, 'ant con deuda', 'A'),
('-3-2024-4G', '2024-01-01', 'aprobado', -2, 4, 'ant nuevo con deuda', 'A'),
('-4-2024-4G', '2024-01-01', 'aprobado', -1, 4, 'ant nuevo', 'A')
;

/*ALTER TABLE tbl_matriculas
MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;*/

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_tipos_documento;

CREATE TABLE tbl_tipos_documento (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  tipo_documento varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_tipos_documento (tipo_documento) VALUES
('TARJETA DE IDENTIDAD'),
('REGISTRO CIVIL'),
('CEDULA'),
('PASAPORTE'),
('PERMISO DE PERMANENCIA TEMPORAL'),
('PERMISO POR PROTECCIÓN TEMPORAL');


/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_grados;

CREATE TABLE tbl_grados (
  id int(2) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  grado varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_grados (grado) VALUES
('Sin grado'),
('Primero'),
('Segundo'),
('Tercero'),
('Cuarto'),
('Quinto'),
('Sexto'),
('Séptimo'),
('Octavo'),
('Noveno'),
('Décimo'),
('UnDécimo'),
('Ciclo I'),
('Ciclo II'),
('Ciclo III'),
('Ciclo IV'),
('Ciclo V'),
('Ciclo VI')
;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_pre_matriculas;

CREATE TABLE tbl_pre_matriculas (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_grado int(11) DEFAULT NULL,
  documento_est varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  nombres_est varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  apellidos_est varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  fecha date NOT NULL,
  actividad_extra varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  nombre_a varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  celular_a varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  email_a varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  ciudad_a varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  observaciones varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  entrevista varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  observaciones_ent varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  admitido int(2) NOT NULL DEFAULT 0,
  eval int(2) NOT NULL DEFAULT 0,
  id_medio int(11) DEFAULT NULL,
  interesado varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  año int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_pre_matriculas (id_grado, documento_est, nombres_est, apellidos_est, fecha, actividad_extra, nombre_a, celular_a, email_a, ciudad_a, observaciones, entrevista, observaciones_ent, admitido, eval, id_medio, interesado, año) VALUES
(5, '93974544', 'GREGORY HERNANDO', 'FIGUEREDO GUEVARA', '2025-11-12', 'PROG', 'ANA ELVA GUEVARA', '3192997229', 'gregory.figueredo@unicab.org', '', NULL, 'NO', 'PRUEBA', 0, 0, 3, NULL, 2026),
(5, '93974545', 'GREGORY HERNANDO', 'FIGUEREDO GUEVARA', '2025-11-17', 'NINGUNA', 'ANA ELVA GUEVARA', '3192997229', 'gregory.figueredo@unicab.org', '', NULL, 'NO', 'PRUEBA', 0, 0, 1, NULL, 2026),
(5, '93974542', 'GREGORY HERNANDO', 'FIGUEREDO GUEVARA', '2025-11-05', 'PROG', 'ANA ELVA GUEVARA', '3192997229', 'gregory.figueredo@unicab.org', '', NULL, 'NO', NULL, 0, 0, 1, NULL, 2026),
(5, '93974541', 'GREGORY HERNANDO', 'FIGUEREDO GUEVARA', '2025-11-05', 'PROG', 'ANA ELVA GUEVARA', '3192997229', 'gregory.figueredo@unicab.org', '', NULL, 'NO', NULL, 0, 0, 1, NULL, 2026)
;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_entrevistas;

CREATE TABLE tbl_entrevistas (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_psicologo int(11) NOT NULL,
  fecha date NOT NULL,
  hora varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  documento_est varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  nombre_est varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  generar_contrato varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_parametros;

CREATE TABLE tbl_parametros (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  parametro varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  v1 int(11) DEFAULT NULL,
  v2 int(11) DEFAULT NULL,
  t1 varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  t2 varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  f1 date DEFAULT NULL,
  f2 date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_parametros (parametro, v1, v2, t1, t2, f1, f2) VALUES
('mat_ordinarias', NULL, NULL, NULL, NULL, '2025-10-01', '2026-03-31'),
('mat_extraordinarias', NULL, NULL, NULL, NULL, '2025-10-01', '2026-03-31')
;


/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_estudiantes_bloqueados;

CREATE TABLE tbl_estudiantes_bloqueados (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  n_documento varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_deudas_anteriores;

CREATE TABLE tbl_deudas_anteriores (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  documento varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  a int(11) UNSIGNED NOT NULL,
  deuda int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_deudas_anteriores (documento, a, deuda) VALUES
('93974543', 2022, 923900),
('93974543', 2023, 90400);

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_informacion_financiera;

CREATE TABLE tbl_informacion_financiera (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  documento_estudiante varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  periodo_ingreso int(11) NOT NULL DEFAULT 0,
  a int(11) NOT NULL DEFAULT 0,
  documento_acudiente varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  deuda_anterior int(11) NOT NULL DEFAULT 0,
  matricula_ocp int(11) NOT NULL DEFAULT 0,
  valor_pension_mes int(11) NOT NULL DEFAULT 0,
  total_pension_anual int(11) NOT NULL DEFAULT 0,
  cantidad_pensiones int(11) NOT NULL DEFAULT 0,
  derechos_grado int(11) NOT NULL DEFAULT 0,
  icfes int(11) NOT NULL DEFAULT 0,
  total_pagar_anual int(11) NOT NULL DEFAULT 0,
  pago_deuda int(11) NOT NULL DEFAULT 0,
  pago_matricula varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  pago_icfes varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  pago_derechos_grado varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  valor_recargo int(11) NOT NULL DEFAULT 0,
  diciembre int(11) NOT NULL DEFAULT 0,
  enero int(11) NOT NULL DEFAULT 0,
  febrero int(11) NOT NULL DEFAULT 0,
  marzo int(11) NOT NULL DEFAULT 0,
  abril int(11) NOT NULL DEFAULT 0,
  mayo int(11) NOT NULL DEFAULT 0,
  junio int(11) NOT NULL DEFAULT 0,
  julio int(11) NOT NULL DEFAULT 0,
  agosto int(11) NOT NULL DEFAULT 0,
  septiembre int(11) NOT NULL DEFAULT 0,
  octubre int(11) NOT NULL DEFAULT 0,
  noviembre int(11) NOT NULL DEFAULT 0,
  cantidad_pensiones_pagas int(11) NOT NULL DEFAULT 0,
  total_pagado int(11) NOT NULL DEFAULT 0,
  saldo_pendiente int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_informacion_financiera (documento_estudiante, periodo_ingreso, a, documento_acudiente, deuda_anterior, matricula_ocp, valor_pension_mes, total_pension_anual, cantidad_pensiones, derechos_grado, icfes, total_pagar_anual, pago_deuda, pago_matricula, pago_icfes, pago_derechos_grado, valor_recargo, diciembre, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, cantidad_pensiones_pagas, total_pagado, saldo_pendiente) VALUES
('93974543', 1, 2025, '23453550', 1287500, 410475, 249625, 2496250, 10, 0, 0, 4194225, 0, 'SI', 'NO', 'NO', 0, 0, 660100, 0, 249625, 249625, 249625, 499250, 0, 249625, 0, 0, 0, 7, 2157850, 2036375),
('93974542', 1, 2025, '23453550', 500000, 410475, 249625, 2496250, 10, 0, 0, 2906725, 0, 'SI', 'NO', 'NO', 0, 0, 660100, 0, 249625, 249625, 249625, 499250, 0, 249625, 0, 0, 0, 7, 2157850, 748875),
('93974541', 1, 2025, '23453550', 0, 410475, 249625, 2496250, 10, 0, 0, 3406725, 0, 'SI', 'NO', 'NO', 0, 0, 660100, 0, 249625, 249625, 249625, 499250, 0, 249625, 0, 0, 0, 7, 2157850, 1248875),
('93974544', 1, 2025, '23453550', 0, 410475, 249625, 2496250, 10, 0, 0, 2906725, 0, 'SI', 'NO', 'NO', 0, 0, 660100, 0, 249625, 249625, 249625, 499250, 0, 249625, 0, 0, 0, 7, 2157850, 748875)
;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_documentos_matriculas;

CREATE TABLE tbl_documentos_matriculas (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  documento varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  a int(11) UNSIGNED NOT NULL,
  tipo varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  ruta varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  validado int(2) UNSIGNED NOT NULL,
  correo int(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_costos;

CREATE TABLE tbl_costos (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  a int(11) NOT NULL,
  id_grado int(11) NOT NULL,
  matricula int(11) NOT NULL,
  pension int(11) NOT NULL,
  ocp int(11) NOT NULL,
  poliza int(11) NOT NULL,
  dg int(11) NOT NULL,
  dgv int(11) NOT NULL,
  pp int(11) NOT NULL,
  mocp int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_costos (a, id_grado, matricula, pension, ocp, poliza, dg, dgv, pp, mocp) VALUES
(2026, 2, 275507, 247956, 133114, 25364, 0, 0, 656577, 408621),
(2026, 3, 277361, 249625, 133114, 25364, 0, 0, 660100, 410475),
(2026, 4, 277361, 249625, 133114, 25364, 0, 0, 660100, 410475),
(2026, 5, 277361, 249625, 133114, 25364, 0, 0, 660100, 410475),
(2026, 6, 277361, 249625, 133114, 25364, 319000, 0, 660100, 410475),
(2026, 7, 277361, 249625, 133114, 25364, 0, 0, 660100, 410475),
(2026, 8, 251299, 226170, 133114, 25364, 0, 0, 610583, 384413),
(2026, 9, 251299, 226170, 133114, 25364, 0, 0, 610583, 384413),
(2026, 10, 250135, 225122, 133114, 25364, 319000, 0, 608371, 383249),
(2026, 11, 250135, 225122, 133114, 25364, 0, 0, 608371, 383249),
(2026, 12, 250135, 225122, 133114, 25364, 319000, 0, 608371, 383249),
(2026, 13, 128106, 115296, 96500, 0, 0, 0, 339902, 224606),
(2026, 14, 128106, 115296, 96500, 0, 0, 0, 339902, 224606),
(2026, 15, 128106, 115296, 96500, 0, 0, 0, 339902, 224606),
(2026, 16, 128106, 115296, 96500, 0, 259000, 0, 339902, 224606),
(2026, 17, 68700, 61830, 96500, 0, 0, 0, 227030, 165200),
(2026, 18, 68700, 61830, 96500, 0, 259000, 0, 227030, 165200),
(2026, 0, 0, 0, 0, 0, 0, 0, 76500, 116500)
;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_medios_llegada;

CREATE TABLE tbl_medios_llegada (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  medio varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_medios_llegada (medio) VALUES
('PAGINA WEB UNICAB'),
('OTRAS PAGINAS WEB'),
('RECOMENDACION'),
('REDES SOCIALES');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_parentescos;

CREATE TABLE tbl_parentescos (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  parentesco varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
);

INSERT INTO tbl_parentescos (parentesco) VALUES
('MADRE'),
('PADRE'),
('ABUELA'),
('ABUELO'),
('HERMANA'),
('HERMANO'),
('TIA'),
('TIO'),
('PRIMA'),
('PRIMO'),
('OTRO');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_instituciones;

CREATE TABLE tbl_instituciones (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  logo varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  slogan varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  dominio varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
);

  INSERT INTO tbl_instituciones (nombre, logo, slogan, dominio) VALUES 
  ('GHF SCHOOL', 'chatbot/img/logo_ghfschool3.png', 'Sabiduría y Crecimiento', 'ghfscholl.digitalnextstep.link');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_colores;

CREATE TABLE tbl_colores (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_institucion int(11) NOT NULL,
  color1 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  color2 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  color3 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  color4 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  color5 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
);

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_textos;

CREATE TABLE tbl_textos (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_institucion int(11) NOT NULL,
  texto1 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  texto2 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  texto3 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  texto4 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  texto5 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  texto6 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  texto7 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  texto8 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  texto9 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  texto10 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  texto11 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  texto12 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  texto13 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  texto14 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  texto15 varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
);

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_respuestas;

CREATE TABLE tbl_respuestas (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_grado int(11) NOT NULL,
  id_materia int(11) NOT NULL,
  id_pregunta int(11) NOT NULL,
  a int(11) NOT NULL,
  identificacion varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  respuesta varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  resultado varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  estado varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_empleados;

CREATE TABLE tbl_empleados (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombres varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  apellidos varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  email varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  pc varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  perfil varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  n_documento int(11) NOT NULL,
  dependencia varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  skype varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  celular varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  celular_what varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  cargo varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  profesion varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  descripcion varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  foto varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  nombre_corto varchar(100)  CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  infografia varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  rh varchar(10)  CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT 'NA',
  estado varchar(20)  CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_empleados (nombres, apellidos, email, pc, perfil, n_documento, dependencia, skype, celular, celular_what, cargo, profesion, descripcion, foto, nombre_corto, infografia, rh, estado) VALUES
('NA', 'NA', 'NA', 'NA', 'NA', 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA'),
('IMELDA', 'VERGARA', 'rectoria@unicab.org', 'aGaZRQ3n55KcwCxx/enWHg==', 'AR_AW', 46352177, 'RECTORIA', 'NA', '', '322 254 0389', 'RECTORA', 'INGENIERA DE MINAS', 'Soy respetuosa de mí misma, autónoma, comprometida y agradecida con la vida. Ingeniera de Minas de profesión, gerente social por convicción, apasionada por aprender, investigar y liderar procesos que generen mejores condiciones de vida, con respeto, dignidad y confiabilidad. Me encanta bailar, degustar buenos alimentos y caminar para mantener mi cuerpo, mi mente y mi alma en equilibrio. Feliz por ser la cocreadora de UNICAB, de ver los excelentes resultados de quienes han confiado en este proyecto. Sueño con un mundo de seres humanos felices, libres y en armonía con la naturaleza.', '../../../assets/img/equipo/imeldavergara.png', 'Imelda Vergara', NULL, 'O +', 'activo'),
('JULIAN ADOLFO', 'MESA VERGARA', 'psico01@unicab.org', 'Dhph+K0OBrDCxpTvKawNRp093HwtKghR9lWYsXhn0Lw=', 'AR_AW', 1057583959, 'COORDINACION ACADEMICA', 'https://meet.google.com/hfj-atbe-bjm', '318 400 4412', '318 400 4412', 'COORDINADOR ACADEMICO', 'PSICÓLOGO CLINICO', 'Soy un apasionado por el deporte y la lectura ya que fue un privilegio que me cambió la vida y me brinda mayores posibilidades junto a mi profesión, de poder abrir más puertas para mi crecimiento, apoyar a más personas y seguir aprendiendo constantemente. Me gusta observar más allá, observar y vivir el presente. Dentro de UNICAB manejo lo concerniente a la psicología y desde esta direcciono lo que es la coordinación académica. Para lograr junto con un equipo de maestros apasionados por su labor, una excelente educación de calidad.', '../../../assets/img/equipo/Julianvergara.png', 'Julián Mesa', NULL, 'A +', 'activo'),
('INGRID LILIANA', 'LASPRILLA GARCIA', 'matriculas@unicab.org', 'ZVJqXjqJHhbuHYD+8gWmWg==', 'AR', 1049630464, 'ADMINISTRATIVA', 'NA', '315 696 5291', '315 696 5291', 'SECRETARIA ACADEMICA', 'ADMINISTRADORA COMERCIAL Y FINANCIERA', '', '', 'Liliana Lasprilla', 'https://unicab.org/assets/img/equipo/ingrit_liliana.png', 'B +', 'activo'),
('MARIA CAMILA', 'CUBILLOS GUTIERREZ', 'psico02@unicab.org', 'uzxPzveQ2k7OQpRGZhIyKg==zzz', 'NA', 1015441071, 'ADMINISTRATIVA', '', '311 588 7849', '311 588 7849', 'PSICOLOGA ADMINISTRATIVA', 'PSICÓLOGA', 'Soy Psicóloga egresada de la Universidad Manuela Beltrán con experiencia y conocimiento en los distintos enfoques y campos del desempeño profesional psicológico. Cuento con estudios en Neuropsicología Forense, Psicología Educativa, Psicología Jurídica, SG-SST y Administración de Recursos Humanos. \r\nÁreas de experiencia: – Psicología educativa y Jurídica, producción y publicación de artículos académicos, creación e implementación de proyectos académicos y empresariales, experiencia en áreas administrativas.\r\nEn UNICAB se respira un ambiente laboral muy alegre, el equipo de trabajo es comprometido e innovador, esto hace que cada día más familias estén interesadas en unirse y emprender la educación de sus hijos en esta modalidad tan revolucionaria y actualizada.\r\n', '../../../assets/img/equipo/Camila_Cubillos.png', 'Camila Gutiérrez', NULL, 'A +', 'retirado'),
('DIANA', 'CHAPARRO UNIVIO', 'psico03zzz@unicab.org', '/38zEkfyO49mHTDbd18LgQ==', 'NA', 46376556, 'ADMISIONES', 'https://meet.google.com/teb-ujzw-giq', '320 588 6995', '320 588 6995', 'PSICOLOGA', 'PSICÓLOGA', 'Psicóloga social especialista en salud ocupacional y riesgos laborales, con diplomados en psicología clínica, primera infancia y desarrollo social. Con experiencia profesional de más de 10 años en áreas como: Tallerista, capacitadora, docente, psicóloga de atención en salud mental, psicóloga de comisaria de familia, participante de diferentes proyectos de carácter social con el área de convenios de la UPTC. Caracterizada por su capacidad para trabajar en equipo y facilidad de adaptación a diferentes entornos laborales, habilidades cognitivas, comunicativas y valorativas, lo que le permite participar en cualquier tipo de proyecto o acciones en pro del mejoramiento de la calidad de vida del ser humano.', '../../../assets/img/equipo/DIANA_UNIVIO.png', 'Diana Univio', NULL, 'O +', 'retirado'),
('LILIANA', 'DAVILA ALBARRACIN', 'unicabfinanciera@gmail.com', 'laZVWL5Ep/RFL9HG2LBZhA==', 'FI', 46371319, 'FINANCIERA', 'NA', '318 714 3774', '318 714 3774', 'CONTADORA', 'CONTADORA', 'Contadora Publica egresada de la Universidad de Pamplona, con experiencia de más de cinco años en compañías de diferentes actividades y obligaciones tributarias, tengo la capacidad de enfrentarme y resolver casos contables en relación de impuestos, registros contables, soportes de contabilidad, análisis de estados financieros acorde a las normas y estándares de contabilidad generalmente aceptadas; con manejo de Software Flash contable, flash efectivo, Siigo Contador y Siigo Nube.\r\nSoy una persona íntegra con valores como el respeto, tolerancia, responsabilidad, amabilidad y honestidad.\r\n', '../../../assets/img/equipo/LILIANA_ALBARRACIN.png', 'Liliana Albarracín', 'https://unicab.org/assets/img/equipo/lili.png', 'B +', 'activo'),
('CINDY LORENA', 'QUEMBA CARMAGO', 'unicabfinanciera@gmail.com', 'Vhqt7o6Sm9gzV5uMq6HDsw==', 'FI', 1057606165, 'FINANCIERA', 'NA', '318 714 3774', '318 714 3774', 'AUXILIAR CONTABLE', 'AUXILIAR CONTABLE', 'Estudiante de Contaduría Pública de la Universidad Pedagógica y Tecnológica de Colombia UPTC seccional Sogamoso con experiencia en el área contable, financiera y de  auditoría acordé a las normas y estándares  internacionales de contabilidad, con adecuado manejo de software  contable como Flash Efectivo, Flash Contable, SIIGO, con un  nivel alto de excel, word, nivel intermedio de Autocad bidimensional, y programas ofimáticos. Aporto seguridad y credibilidad en las labores que me son asignadas, con una adecuada administración  del tiempo , aplicando los conocimientos y la formación como valores fundamentales demostrando resultados sobresalientes y de calidad, reflejando así mi sentido de pertenencia y liderazgo. Cuento con capacidad de trabajo en equipo, y asimilo  rápidamente nuevos conocimientos a través de herramientas tecnológicas. me caracterizó además, por ser una persona responsable, honesta, creativa, proactiva y comprometida con el cumplimiento de los objetivos de la corporación; me gusta asumir retos y responsabilidades dejando a disposición todos mis conocimientos, capacidades y aptitudes', '../../../assets/img/equipo/CINDY_QUEMBA.png', 'Lorena Quemba', NULL, 'A +', 'retirado'),
('PAOLA ANDREA', 'MUÑOZ VARGAS', 'archivo@unicab.org', 'vp8nZrqKeM71/U8DQEQYkQ==', 'ARCH', 1057590334, 'ADMINISTRATIVA', 'NA', '318 714 3774', '318 714 3774', 'AUXILIAR DE ARCHIVO', 'AUXILIAR DE ARCHIVO', 'Me presento como una persona profesional en el área de archivistica y gestión documental, incluida las actividades que hacen parte de la producción, distribución y manejo de los documentos, acorde a la normatividad actual y los estándares nacionales. Dispuesta a asumir con responsabilidad las tareas asignadas, con capacidad de adaptación al cambio, principios y valores enmarcados dentro de las leyes constitucionales éticas y morales.', '../../../assets/img/equipo/PAOLA_VARGAS.png', 'Paola Vargas', NULL, 'B +', 'retirado'),
('OLGA STELLA', 'HURTADO RODRIGUEZ', 'olgastella.bioetico@unicab.org', 'Jh/LDs8sWCr/BxXwnxHYqA==', 'TU', 23769780, 'PENSAMIENTO BIOETICO', 'Olga.stella.hurtado.rodriguez', '316 259 6171', '316 259 6171', 'TUTOR MEDIADOR', 'INGENIERA DE ALIMENTOS', 'Me gusta mucho y disfruto al máximo compartir con mi familia y amigos. Me apasiona una buena lectura, escribir, cocinar, caminar y meditar en espacios naturales, preferentemente en las montañas. Aprendo de cada instante que comparto con mi esposo y mi hija y juntos admiramos la belleza de lo simple y de buen gusto. Agradezco sinceramente un saludo alegre, un abrazo fuerte, un gesto amable, porque creo en la generosidad de las personas. En el ámbito laboral doy lo mejor de mi experiencia profesional y procuro mantenerme actualizada para acompañar de manera efectiva los procesos de la Organización a la cual pertenezco.', '../../../assets/img/equipo/Olga_Hurtado.png', 'Olga Stella Hurtado', '../../../assets/img/equipo/info_stellita.jpg', 'O +', 'inactivo'),
('JOHANNA', 'MONROY MONGUA', 'johannamonroy@unicab.org', 'ihXRP88cBvjiFiVlhOQXMg==', 'TU', 1002393985, 'PENSAMIENTO TECNOLOGICO', 'diseno.unicab', '321 316 9663', '321 316 9663', 'TUTOR MEDIADOR', 'MG EN EDUCACIÓN', 'Soy tutora mediadora de pensamiento tecnológico, hago parte del equipo creativo y del grupo de investigación GIU del colegio virtual Unicab.\r\nMe llama la atención el impacto que las nuevas tecnologías han generado en el ser humano, de ahí el interés en investigar cómo estas pueden incidir positivamente en un contexto e-learning desde el diseño gráfico como un medio de comunicación en el que se integra diversidad de códigos visuales que posiblemente movilice conocimiento combinando adecuadamente elementos pedagógicos y tecnológicos en un escenario virtual de aprendizaje. \r\n', '../../../assets/img/equipo/Johanna_ Mongua.png', 'Johanna Monroy', 'https://unicab.org/assets/img/equipo/jOHANNA mONROY.png', 'O +', 'activo'),
('GINNA MARCELA', 'CASTELLANOS HUERTAS', 'ginna.castellanos@unicab.org', 'AEebInGbAkt1Vfj/vRTCXg==', 'TU', 1049615423, 'PENSAMIENTO BIOETICO', 'ginna.castellanos', '310 464 0244', '310 464 0244', 'TUTOR MEDIADOR', 'MG EN EDUCACIÓN', 'Soy Tutora mediadora de Pensamiento Tecnológico y Bioético Licenciada en informática y tecnología, actualmente curso una Maestría en educación, me encanta correr en las mañanas, nadar, hacer ejercicio, practicar algunas actividades deportivas me hace sentir muy bien pienso que” Cuerpo sano, mente sana”, me gusta el baile, en los tiempos libres compartir con mis seres queridos, pienso que la familia es muy valiosa y hay que disfrutarla lo máximo, me encanta el cine y la música. Mis metas son terminar con éxito mi Posgrado, viajar por toda Colombia, conocer otros países conocer sus culturas y aprender su idioma entre otras cosas, quiero profundizar y aprender más sobre el uso de las TIC en el aula, sobre nuevas tecnologías, seguir aprendiendo cada vez más para poder brindar lo mejor de mí.\r\nHago parte del colegio UNICAB hace 2 años los cuales han sido enriquecedores para mi formación como docente y como persona, estoy enamorada de la educación que brinda el colegio ya que trabajamos para que el niño y niña sea feliz y pueda desarrollar desde temprana edad su proyecto de vida, me siento muy bien cuando los niños nos comparten sus logros deportivos y además son muy buenos académicamente, esto demuestra que se están formando personitas con propósitos definidos y claros.\r\n', '../../../assets/img/equipo/Ginna_Marcela_Castellanos_Huertas.png', 'Ginna Castellanos', '../../../assets/img/equipo/info_ginna.jpg', 'O +', 'inactivo'),
('EDWIN GEOVANNY', 'PIRATOVA MESA', 'ed.tecnologico@unicab.org', 'ADoeQmGFUVCrlYg01GDAeQ==', 'TU', 1049620983, 'PENSAMIENTO TECNOLOGICO', 'edwingeo.unicab', '314 490 3460', '314 490 3460', 'TUTOR MEDIADOR', 'MG EN EDUCACIÓN', 'Me gusta ser parte del equipo creativo de Unicab, ya que me permite aportar e innovar en temas relacionados al diseño, informática y nuevas tecnologías. Así mismo, puedo contribuir creativamente en temas relacionados a lo educativo.Me gusta escuchar música, tocar guitarra, salir a caminar, ver cine y tenis de campo. Como meta tengo poder terminar mis estudios posgraduales avanzando en los diferentes peldaños educativos.', '../../../assets/img/equipo/Edwin-Piratova-1.png', 'Edwin Piratova', NULL, 'B +', 'retirado'),
('JUAN SEBASTIAN', 'SUAREZ CARRASQUILLA', 'juansebastian.suarez@unicab.org', 'VKuOsAgTNleLLK0942VcSQ==', 'TU', 1057578396, 'PENSAMIENTO SOCIAL', 'yo1587', '311 674 2264', '311 674 2264', 'TUTOR MEDIADOR', 'MG EN DERECHOS HUMANOS', 'Soy un ser humano convencido de que los procesos de interacción en cualquier espacio son necesarios para construir identidad. Y en los procesos pedagógicos encuentra esos espacios apropiados para contribuir a que todos construyamos nuestra felicidad. Soy un mediador convencido que desde el conocimiento de las ciencias sociales mediado por las TIC permite que cada uno de nuestros estudiantes florezca y se permita ser feliz y por esta razón es que me apasiona mi profesión y lo que hago como mediador. Cumplo con mi proyecto de vida: servir a mi sociedad e impulsarla para que sea equitativa, justa y digna.', '../../../assets/img/equipo/Juan_Carrasquilla.png', 'Juan Sebastían Suarez', '../../../assets/img/equipo/info_sebastian.jpg', 'A +', 'activo'),
('MONICA ALEJANDRA', 'RIVERA RAMIREZ', 'alejandra.rivera@unicab.org', '7UgSZ0cCGZ4JhQXlRaGGSw==', 'TU', 53160496, 'PENSAMIENTO HUMANISTICO ESPAÑOL', 'Alejandra.Phumanistico01', '310 464 0176', '310 464 0176', 'TUTOR MEDIADOR', 'LICENCIADA EN EDUCACIÓN BASICA', 'Soy tutora mediadora del Pensamiento Humanístico Español comprometida con una formación integral mediante la literatura, lengua castellana, tecnología, investigación  y responsabilidad social y ética consciente de una transformación en la educación. \r\nSoy feliz y orgullosa de pertenecer a Unicab y de estar al pendiente del proceso lectoescritor, es primordial leer y escribir correctamente para conseguir organizar y transmitir ideas de forma reflexiva “piensa antes de hablar” hoy en día podría ser  “Lee y escribe bien antes de expresarte”  \r\n Me gusta bailar y hacer ejercicio ya que beneficia mi salud mental y emocional, me gusta leer y escuchar música. Creo en Dios porque la fe obra y lo encuentro viviendo una vida buena, honesta, misericordiosa, desinteresada y moral, uno de mis principios es “Quien no vive para servir no sirve para vivir”.\r\n', '../../../assets/img/equipo/ALEJANDRA_RIVERA_RAMIREZ.png', 'Alejandra Rivera', 'https://unicab.org/assets/img/equipo/Monica Alejandra.png', 'O +', 'activo'),
('ANGELA CONSTANZA', 'CASAS PINILLA', 'angela.casas@unicab.org', 'zUA0icaHA9vVKm/fMlyBJg==999', 'TU', 52534296, 'PENSAMIENTO HUMANISTICO INGLES', 'Angela.Phumanistico02', '300 316 9550', '300 316 9550', 'TUTOR MEDIADOR', 'MG EN GESTIÓN DE LA TECNOLOGÍA DUCATIVA', 'Es una gran bendición ser parte de este espectacular grupo de tutores mediadores, estoy convencida que el cambio en la educación comienza por casa pero también se genera en ambientes opcionales que le brinden a nuestros niños alternativas de ver la educación como lo que realmente es, la mejor forma de conseguir sus sueños, siempre he sido una apasionada a los retos, a la música, la lectura, el arte, los deportes, la familia, los adelantos tecnológicos, el cine,la comida y la vida; valoro cada segundo que Dios me da para disfrutar lo que hago, amo mi profesión soy muy feliz compartiendo con niños y jóvenes pues ellos te llenan de vitalidad y te enseñan cada día algo nuevo, mi misión en la vida ser feliz e irradiar esa felicidad con todas las personas que me rodean. Mi mayor tesoro mi familia, mi mayor alegría mis hijos y mejor bendición mi esposo.', '../../../assets/img/equipo/Angela_Casas_Pinilla.png', 'Angela Casas', '../../../assets/img/equipo/inf_angela.png', 'O +', 'retirado'),
('DIEGO FERNANDO', 'ACERO VARGAS', 'diegoacero@unicab.org', 'DX6zNz40PoMcYtJSdcbevQ==', 'TU', 7184911, 'PENSAMIENTO SOCIAL', 'difev7', '310 463 5342', '310 463 5342', 'TUTOR MEDIADOR', 'ESP EN ARCHIVISTICA', 'Como mediador de las Ciencias Sociales he trabajado siempre en equipo con docentes y profesionales de la rama, elaborando estudios de investigación, históricos, sociales, geográficos, humanitarios y documentales contribuyendo en el rescate de la historia mediante el ejercicio constante en paleografía.  Como mediador cognitivo del pensamiento siempre logrando los propósitos asignados, armonizando la pedagogía y la didáctica en la construcción del pensamiento crítico. Me gusta la formación continua en herramientas virtuales de aprendizaje,  para mi es importante el desarrollo de las habilidades y talentos, con criterio social, crítico y ético, forjando el respeto y los valores en cada uno de los estudiantes que son el futuro del mañana para Colombia y el mundo.', '../../../assets/img/equipo/Diego_Acero.png', 'Diego Acero', 'https://unicab.org/assets/img/equipo/diego Social.png', 'O +', 'activo'),
('JUAN GUILLERMO', 'REY PEREZ', 'juanrey@unicab.org', 'U+8ksYHFXMyxUbU51Qphkg==', 'TU', 1058038030, 'PENSAMIENTO HUMANISTICO ESPAÑOL', 'juan_creed12', '322 362 5125', '322 362 5125', 'TUTOR MEDIADOR', 'MG EN LINGÜÍSTICA', 'Soy un docente convencido que la mejor herramienta para transformar al mundo es la educación. Por este motivo, veo la necesidad de mejorar mi práctica profesional y personal a través de la lectura y la investigación.\r\nPertenecer al grupo de trabajo de Unicab ha implicado tener una visión holística de mi quehacer docente, en este sentido, implica fortalecer el pensamiento crítico de los discentes, en aras de construir una mejor sociedad.  \r\n', '../../../assets/img/equipo/Juan_Rey.png', 'Juan Rey', '../../../assets/img/equipo/info_juan.jpg', 'O +', 'inactivo'),
('GREGORY HERNANDO', 'FIGUEREDO GUEVARA', 'gregory.figueredo@unicab.org', 'IL4g1TjPlYc+LgOtlWferA==', 'SU', 9397454, 'PENSAMIENTO NUMERICO', 'gregory.figueredo', '322 265 3547', '322 265 3547', 'TUTOR MEDIADOR', 'INGENIERO INDUSTRIAL', 'Aprecio mucho cada instante de vida que nos regala nuestro Padre Creador Yehovah. Doy gracias por todo y en especial por las bendiciones, pero también por las pruebas y tribulaciones, porque he aprendido que a través de ellas aprendemos, crecemos y podemos dar pasos importantes para restaurar nuestra vida por las sendas del ahavah (amor), simcha (gozo), shalom (paz), savlanut (paciencia), anah (benignidad), chesed (bondad), emunah (fe), anawah (mansedumbre) y templanza. Procuró con todas mis fuerzas y todo mi ser servir a todos de la mejor manera. Me encanta la naturaleza. Tengo una hermosa familia con cuatro hijos.\r\nEn cuanto a la parte profesional, soy Ingeniero Industrial apasionado por la optimización de los recursos y el mejoramiento de los procesos a través del diseño, desarrollo e implementación de tecnologías de información. Experto y certificado en lenguajes de programación y administración de bases de datos relacionales y multidimensionales.\r\n', '../../../assets/img/equipo/Gregory_Figueredo.png', 'Gregory Figueredo', '../../../assets/img/equipo/inf_ghf1_1.png', 'B +', 'activo'),
('JOHN HENRY', 'RAMIREZ MALAVER', 'john.ramirez@unicab.org', 'h6q5c4AIcpnhfdN4IBEcWw==', 'TU', 1057586900, 'PENSAMIENTO SOCIAL', 'john.ramirez16', '310 463 9566', '310 463 9566', 'TUTOR MEDIADOR', 'MG EN DERECHOS HUMANOS', 'Soy un ser humano convencido que la educación es el camino para la transformación social y cultural de cualquier sociedad. Por ende, cada día me levanto con el compromiso constante de brindar lo mejor de mi profesión para acompañar los diferentes proyectos de vida de nuestros estudiantes. \r\n\r\nSer maestro mediador a través de las TIC´S me ha permitido encontrar un espacio para el encuentro de ideas y de saberes que se construyen entre los participantes, esto a su vez permite enriquecer las visiones y las experiencias de los que allí confluimos. \r\n', '../../../assets/img/equipo/John Henry Ramírez Malaver.png', 'John Ramirez', '../../../assets/img/equipo/info_john.jpg', 'A +', 'inactivo'),
('PAULA ALEJANDRA', 'CRISTANCHO GOMEZ', 'paulacristancho@unicab.org', 'PmD4Arj850uo+AyZEBMXZg==', 'TU', 1057593704, 'PENSAMIENTO HUMANISTICO INGLES', 'live:paucg_teacher', '311 649 6218', '311 649 6218', 'TUTOR MEDIADOR', 'LICENCIADA EN LENGUAS EXTRANJERAS INGLÉS - FRANCÉS', 'Soy tutora mediadora del Pensamiento Humanístico Inglés, amante de la enseñanza, los idiomas, las artes plásticas, la danza y la música. Soy una persona comprometida, curiosa por excelencia, perfeccionista, autocrítica, y nada tradicional en cuanto a enseñanza se refiere. Me gusta aprender, imaginar, crear, evolucionar, cuestionar y cuestionarme todos los días, para poder de esta manera avanzar y ver más allá. No me gusta conformarme con el presente y busco el futuro constantemente. Estoy convencida de que se puede transformar el mundo por medio de la educación y de que la educación virtual es el futuro, razón por la que quiero aportar y ser parte de este proceso, no sólo en mi país sino alrededor del mundo. Por eso siento la necesidad de aprender y conocer diferentes culturas e idiomas. Considero que al integrar cada idioma y cultura dentro de los procesos de aprendizaje, estoy ayudando a abrir los horizontes de mis estudiantes, además de aportar en el crecimiento personal, moral y académico de cada uno de ellos. Ser tutora mediadora me ha dado la posibilidad de aprender y reinventarme cada día, estoy agradecida con Dios de poder formar parte de un equipo que trabaja y se exige al máximo para transformar la educación, y para fortalecer los proyectos de vida de cada uno de sus estudiantes.\r\n«Todo lo que puedas imaginar, es real»\r\n«Everything you can imagine is real»\r\n«Tout ce que tu peux imaginer est réel»\r\n«Alles, was du dir vorstellen kannst, ist real»\r\n«당신이 상상할 수있는 모든 것이 진짜입니다»\r\n                                                                          	 - Pablo Picasso \r\n', '../../../assets/img/equipo/Paula Cristancho.png', 'Paula Cristancho', '../../../assets/img/equipo/info_paulacrist.png', 'O +', 'inactivo'),
('PAULA ALEJANDRA', 'ALMONACID CARRASQUILLA', 'paulaalmonacid@unicab.org', 'MmtJHzToNGGIjULR5R4t1g==', 'TU', 1057601005, 'PENSAMIENTO BIOETICO', 'paulaalmonacid23@gmail.com', '310 464 8838', '310 464 8838', 'TUTOR MEDIADOR', 'INGENIERA AMBIENTAL Y SANITARIA', 'Soy tutora mediadora del pensamiento bioético, totalmente convencida de que es un pensamiento muy completo que permite que los estudiantes comprendan los temas y los relacionen con su entorno, ya que nosotros estamos compuestos por la biología, por la química y el deber de todos es  cuidar nuestro cuerpo, tanto física como mentalmente siendo personas éticas he íntegras. Me gustan mucho los niños, que sean felices, que sientan apoyo y cariño siempre, pienso que una persona cuando es querida a si sea por una sola persona tiene la fuerza suficiente para salir adelante en la vida. Creo en las maravilla de Dios, por eso me esfuerzo por dar lo mejor de mi siempre, actuando con honestidad y responsabilidad. Me gusta mucho ver películas, leer y estar informada, el tiempo en familia, cocinar y hacer manualidades. ', '../../../assets/img/equipo/Paula_Almonacid.png', 'Paula Almonacid', 'https://unicab.org/assets/img/equipo/Paula.png', 'A +', 'activo'),
('YULY ANDREA', 'AFRICANO TORRES', 'english.secondary@unicab.org', 'AilEBIY0Le4saLJVPM9fkg==999', 'TU', 1057586870, 'PENSAMIENTO HUMANISTICO INGLES', 'humanistico3.unicab', '312 479 9815', '312 479 9815', 'TUTOR MEDIADOR', 'LICENCIADA EN IDIOMAS MODERNOS', 'Soy tutor mediador de Pensamiento Humanístico Inglés. Soy un ser humano comprometido con la educación de mi país, convencida que desde el aprendizaje y enseñanza de los idiomas es posible generar cambios sociales y crear oportunidades de intercambio cultural en Colombia y en el mundo.  \r\nDisfruto mucho el compartir e interactuar con las personas porque a partir de la interacción aprendo bastante, así que, me gusta viajar y conocer culturas, aprender idiomas; escuchar música, en especial góspel en inglés y francés, además cantar e interpretar la guitarra acústica. \r\nConsidero muy interesante e importante el ejercicio de investigar e indagar sobre las herramientas, metodologías, estrategias y experiencias en el campo del aprendizaje-enseñanza, ya que me permite reflexionar sobre mi quehacer pedagógico y realizar acciones de cambio.\r\nSer maestro mediador es un privilegio, ya que tengo la oportunidad de orientar los procesos de aprendizaje de una lengua extranjera en ambientes virtuales.\r\nSer parte de un equipo que trabaja en pos de los sueños y talentos de los jóvenes, niños y familias es una bendición y un proceso continuo de cambios y aprendizajes.\r\n', '../../../assets/img/equipo/Yuly_Andrea_Africano_Torres.png', 'Yuly Africano', '../../../assets/img/equipo/inf_yuly1.png', 'A +', 'retirado'),
('SERGIO ANDRES', 'CADENA BAUTISTA', 'sergio.cadena@unicab.org', 'YNzGICsrWUlkQZsv4pZrNw==', 'TU', 1052383274, 'PENSAMIENTO TECNOLOGICO', 'sergiocadenab', '322 308 2360', '322 308 2360', 'TUTOR MEDIADOR', 'MG EN AMBIENTES EDUCATIVOS MEDIADOS POR TIC', 'Licenciado en informática y Tecnología, aspirante a Magister en Ambientes Educativos Mediados por TIC. Investigador del grupo de investigación GUI UNICAB virtual, administrado Moodle y G Suite (gmail) del colegio UNICAB Virtual.\r\n\r\nEntusiasta de los conocimientos científicos que a lo largo de la historia como a la fecha, han propiciado el desarrollo de la tecnología. Dentro de los campos de la tecnología que domina se encuentra el diseño y la producción audiovisual, la programación y la electrónica, y trabajar por la generación del nuevo conocimiento que, a través de la investigación, la tecnología genera para favorecer la educación.\r\n', '../../../assets/img/equipo/Sergio_Andres_Cadena_Bautista.png', 'Sergio Cadena', 'https://unicab.org/assets/img/equipo/Sergio Andres.png', 'B +', 'activo'),
('KAREN MAGALY', 'TORRES GUERRERO', 'karen.torres@unicab.org', 'CLBmBuPypnl2yzQS+3NAmA==', 'TU', 1048847702, 'PENSAMIENTO NUMERICO', 'karentorres355', '310 464 9658', '310 464 9658', 'TUTOR MEDIADOR', 'ESP EN NECESIDADES DE APRENDIZAJE EN LECTURA, ESCRITURA Y MATEMÁTICAS', 'Este año orientó Pensamiento Numérico y Bioético, me gusta trabajar en Unicab pues me permite ser,  dinámica, creativa, propositiva, estoy comprometida con el aprendizaje y progreso de los estudiantes, transmisora de criterio, búsqueda continua para incentivar valores humanos, desarrollar habilidades básicas, me gusta la investigación, formación permanente en herramientas virtuales de aprendizaje. Especialista en Necesidades de Aprendizaje en Lectura, Escritura y Matemáticas, Licenciada en Educación Básica con énfasis en Matemáticas y Humanidades, doce años de experiencia laboral, tengo un hermoso hogar, del cual me siento orgullosa y  en lo que les pueda colaborar estaré dispuesta. ', '../../../assets/img/equipo/Karen_Torres_Guerrero.png', 'KAREN TORRES', '../../../assets/img/equipo/info_karen.jpg', 'B +', 'inactivo'),
('ANA MILENA', 'NIEVES GONZALEZ', 'milena.humanistico@unicab.org', 'cZRt8HGE4KdwIxmECenGcg==', 'TU', 68305434, 'PENSAMIENTO HUMANISTICO ESPAÑOL', 'humanistico2.unicab@gmail.com', '310 465 0920', '310 465 0920', 'TUTOR MEDIADOR', 'MG EN TECNOLOGÍA EDUCATIVA Y COMPETENCIAS DIGITALES', 'Licenciada en  Lengua Castellana  y  Comunicación  mi  propósito  como   orientadora  del  Pensamiento  Humanístico es  ayudar  al  estudiante  a  descubrir  su  potencial    crítico, argumentativo  y  creativo   como  herramienta  para   expresar  su   aprendizaje  y   resolver  un  problema.\r\n”...Un problema solo existe en la ausencia de la conversación correcta”\r\nPaulo Freire. \r\n\r\n Me  gusta el cine, los buenos  hábitos , leer temas relacionados a la innovación, escuchar música, practicar  natación  y salir a caminar. \r\n\r\nSoy Tutora  mediadora del  Colegio  UNICAB porque me gustan los retos, los cambios y la creatividad. Mi  sueño  es  vivir en el mundo de las posibilidades para hacer una diferencia en la vida de las futuras generaciones  desde  la  creación ,  el  fortalecimiento  y   la aplicación   de   nuevos   paradigmas   educativos.', '../../../assets/img/equipo/Ana_Milena_Nieves.png', 'MILENA NIEVES', '../../../assets/img/equipo/info_milena.jpg', 'A -', 'retirado'),
('DENISSE LILYBETH', 'PUERTO COY', 'denissepuerto.numerico@unicab.org', 'WHErs98H4gvLP2tfQmmHCg==', 'TU', 46378121, 'PENSAMIENTO NUMERICO', 'numerico.unicab@gmail.com', '300 268 3009', '300 268 3009', 'TUTOR MEDIADOR', 'INGENIERA INDUSTRIAL', 'Soy tutora mediadora de Pensamiento Numérico, me gusta mi trabajo porque logro que los conceptos físicos y matemáticos sean entendidos de la mejor manera, de forma práctica y útil. Además del ambiente laboral, donde todos son compañeros y amigos, y no se ve sesgado cada uno de los departamentos del colegio. En la parte profesional, me gusta consultar sobre los procesos físicos actuales y como el hombre ha mejorado la investigación y tecnología para vivir mejor y por más tiempo. Quisiera continuar como tutora mediadora de Pensamiento Numérico, seguir capacitándome en pedagogía conceptual y orientar de la mejor manera a mis estudiantes, para que quieran la matemática y la física, como yo la quiero.', '../../../assets/img/equipo/Denisse_Coy.png', 'DENISSE PUERTO', '../../../assets/img/equipo/info_denisse.jpg', 'O +', 'retirado'),
('DAVID SANTIAGO', 'MARTINEZ CELY', 'santiagomartinez@unicab.org', '4ozt/Yu3V0oMHkcg33XFPg==', 'TU', 1057581651, 'PENSAMIENTO NUMERICO', 'santiagomartinez@unicab.org', '310 464 2837', '310 464 2837', 'TUTOR MEDIADOR', 'ESP EN GERENCIA DE TALENTO HUMANO', 'Como ser activo de la sociedad, estoy convencido en la humanización de los procesos que llevan a mejorar la calidad de vida de las personas de una forma sostenible y ética; así como del cuidado ambiental y el uso de sistemas numéricos que facilitan la comprensión del mundo en el que vivimos y le da importancia a su preservación. Disfruto plenamente de la música y la literatura. \r\nSer parte del equipo Unicab es hacer parte de un cambio necesario en los modelos pedagógicos en nuestro país, mirar al futuro apoyados en herramientas TIC para que cada estudiante asimile y cree su conocimiento demostrando puntos de vista cada vez más objetivos y sustentados en la investigación.      ', '../../../assets/img/equipo/Santiago_Martinez.png', 'Santiago Martínez', '../../../assets/img/equipo/info_santiago.jpg', 'O +', 'inactivo'),
('EDWIN', 'GONZALEZ', 'soporte@unicab.org', 'E4BXYrOHSuG7NKflNh1R+Q==', 'TU', 1049645073, 'PENSAMIENTO TECNOLOGICO', 'ferney0296@hotmail.com', '310 463 6867', '310 463 6867', 'SOPORTE TECNICO', 'LICENCIADO EN INFORMÁTICA Y TECNOLOGÍA', 'Soy tutor mediador del Pensamiento Tecnológico. Licenciado en Informática y Tecnología,\nme gusta practicar fútbol, salgo a jugar los fines de semana, escucho música, me gusta\npasar tiempo con mi familia lo cual lo disfruto al máximo. También me gusta mucho\ninvestigar sobre las nuevas tecnologías y herramientas para profundizar mis\nconocimientos sobre las Tic y así poder aprender y ofrecer mis habilidades a mis\nestudiantes. Hago parte del colegio UNICAB hace 2 años el cual ha sido muy enriquecedor\nmi trabajo ya que he aprendido bastante del colegio y de los estudiantes y tengo bastante\nsentido de pertenencia hacia la institución, de igual manera he podido ofrecerle al colegio\ny a los estudiantes mis conocimientos y poder brindar mi ayuda en lo que sea necesario,\ncada día en el colegio e fortalecido mi aprendizaje como docente ya que he aprendido de\nmis compañeros y de mis estudiantes para poder llegar hacer mejor docente.', 'NA', 'Edwin Gonzalez', 'https://unicab.org/assets/img/equipo/Edwin.png', 'NA', 'activo'),
('OLGA VICTORIA', 'GOMEZ PEREZ', 'admisiones@unicab.org', '5MZTlkHzWsMwOMIXTpaTXw==999', 'PS', 51768852, 'ADMISIONES', 'NA', '300 815 6531 Tel(+57) 8 7752309', '300 815 6531', 'ASISTENTE DE ADMISIONES', 'ADMINISTRADORA DE EMPRESAS', '', NULL, 'Olga', NULL, 'O +', 'retirado'),
('CLARA EMILSE', 'LIZCANO', 'admisiones02@unicab.org', 'R/BxadImr53FgQLTFE6dpA==', 'PS', 123456789, 'ADMINISTRATIVA', 'NA', '300 815 6531', '300 815 6531', 'AUXILIAR ADMINISTRATIVA', 'NA', 'NA', 'NA', 'Clara Lizcano', 'https://unicab.org/assets/img/equipo/clara.png', 'O +', 'activo'),
('ERICKA YURIETH', 'AVELLA LOPEZ', 'erickaavellalopez@unicab.org', 'gV60h3h8D4ASV00sSmxCsg==999', 'TU', 1057572753, 'PENSAMIENTO NUMERICO', 'NA', '314 300 9214', 'NA', 'TUTOR MEDIADOR', 'NA', 'NA', 'NA', 'Ericka Avella', '../../../assets/img/equipo/inf_ericka.png', 'A +', 'retirado'),
('CARLOS ADOLFO', 'LEMUS PATIÑO', 'carloslemuspatino@unicab.org', 'H1ksWX172+AgHrLt/RccPg==', 'TU', 9532021, 'PENSAMIENTO NUMERICO', 'NA', '313 867 1672', 'NA', 'TUTOR MEDIADOR', 'NA', 'Soy Tutor Mediador de pensamiento Matemático.\nLicenciado en Educación Industrial Especialidad (Electricidad), hace 20 años que me\ndesempeño como Docente en el Área de Matemáticas y afines; con lo cual me siento\nrealizado con mi profesión ya que le ha aportado a mi vida cada vez más conocimientos,\naprendizajes y satisfacción, con esto he podido transmitir los conocimientos a mis\nestudiantes y así poder contribuir a la formación académica, personal y profesional.\n\nMe gusta practicar el deporte en general, ya que desde pequeño me gusta el fútbol,\nciclismo, baloncesto, voleibol, me encanta realizar caminatas en familia compartir al\nmáximo momentos libres aprovechando con esto nos integremos cada vez más como\nfamilia.\nMis metas son cada vez adquirir más conocimientos como docente, también ver realizados\na mis hijos como grandes profesionales, que sean dados al servicio de la familia y la\ncomunidad, otra meta es terminar totalmente mi casa y viajar con mi familia. Hago parte\ndel colegio UNICAB VIRTUAL, hace 2 años los cuales me han permitido ampliar mis\nconocimientos como docente en la parte virtual, conocer a familias extraordinarias, a\njóvenes con unos proyectos de vida envidiables.\nTambién he conocido herramientas tecnológicas con las cuales he podido transmitir a los\nestudiantes mis conocimientos y apoyo en mejorar las habilidades y competencias que\ntienen cada uno de ellos que forman esta gran institución. La cual ha traído grandes\nresultados, en la parte académica, deportiva y personal. Me queda el gran reto de seguir\ncapacitándome para ser cada día mejor.', 'NA', 'Carlos Lemus', '../../../assets/img/equipo/info_carlos.jpg', 'B +', 'inactivo'),
('LAURA YERALDIN', 'FLOREZ DIAZ', 'lauraflorezdiaz@unicab.org', 'AYTnyI2roi+KEZMkdw1lRA==', 'TU', 1057599116, 'PENSAMIENTO BIOETICO', 'NA', '310 464 0345', '310 464 0345', 'TUTOR MEDIADOR', 'NA', 'Soy tutora mediadora de pensamiento bioético, convencida del poder transformador de la\neducación, por tal razón, desde mi profesión y vocación acompaño el proceso de\naprendizaje de cada uno de mis estudiantes, comprometida con una formación integral,\npara que a partir de ésta y de sus proyectos de vida los estudiantes puedan crecer con un\npropósito de vida claro, que les permita crecer como personas que aportan a la sociedad\ndesde cualquier ámbito disciplinar y ser felices.\nMe gusta bailar, leer, compartir tiempo en familia y aprender constantemente. Me siento\nfeliz con lo que hago como mediadora y de poder aportar un granito de arena en pro a una\neducación integra, de calidad y pertinente a las necesidades actuales.', 'NA', 'Laura Florez', 'https://unicab.org/assets/img/equipo/Laura.png', 'O +', 'activo'),
('INGRID ESTEFANY', 'AVELLA LOPEZ', 'ingridavellalopez@unicab.org', 'zRfnwJUj3Vii2YPPQClU0Q==', 'TU', 1057578583, 'PENSAMIENTO SOCIAL', 'NA', '315 308 1823', 'NA', 'TUTOR MEDIADOR', 'NA', 'Soy tutora mediadora de pensamiento Social soy licenciada en Ciencias Sociales y\nEspecialista en Archivo y Gestión Documental, me gusta leer, ver películas, compartir con\nmi familia, soy muy espiritual y me encanta vivir en completa armonía, paz y tranquilidad,\nen este año culmine mis estudios de especialización, así que deseo poder realizar mi\nmaestría pronto, aunque aún no me he decidido si en Historia o en Archivo, me gusta\nviajar, amo mi trabajo, y amo ser parte de UNICAB, mi experiencia como docente es de 9\naños, pero siento que estar en esta corporación ha ampliado en todos los sentidos mis\nexpectativas, que ha aumentado mi curiosidad y sentido de investigación, para ofrecer una\nmejor formación a mis estudiantes, me siento muy orgullosa cuando veo a mis\nestudiantes lograr sus propósitos, verlos sobresalir, ya sea frente a sus actividades\nexteriores al colegio, como en sus dificultades. Realmente creo que somos bendecidos y\nque podemos demostrar que la virtualidad va más allá de una simple red o pantalla, si no\nque la disciplina y el compromiso forma grandes seres humanos.', 'NA', 'Ingrid Avella', 'https://unicab.org/assets/img/equipo/ingrit.png', 'A +', 'activo'),
('LUIS FERNANDO', 'SILVA CASTRO', 'luissilvacastro@unicab.org', '+DHU8/lc5NpVhYPCqoElWw==', 'TU', 4168826, 'PENSAMIENTO HUMANISTICO ESPAÑOL', 'NA', '322 475 7508', 'NA', 'TUTOR MEDIADOR', 'NA', 'Tutor del Pensamiento Humanístico-español\nDecir que soy es muy difícil, he logrado en mi experiencia como persona entender que\nvamos siendo y que cada acción y circunstancia de nuestro día a día nos permite irnos\nentendiendo en esta existencia. De joven me preocupaba por aquellas personas que no\ntenían las oportunidades para vivir dignamente, pensamiento que me llevó a elegir una\nvida cercana a los más necesitados desde una experiencia religiosa, pero las circunstancias\nque me acompañaron, me dirigieron a optar por una vida profesional consagrada a los\nniños y jóvenes y fue así que logré terminar en la universidad Licenciatura en Filosofía, eso\npasó hace 26 años, en los cuales he compartido con muchas personas, las cuales me han\nenseñado a aprender y a desaprender. Creo que es la tarea más difícil, pero al mismo\ntiempo hermosa. Nunca dejaremos de hacerlo y como docente hace dos años de UNICAB,\nme ha tocado desaprender del modelo tradicional y aprender de esta nueva mirada de la\neducación desde la virtualidad, espacio en mi vida profesional y personal que ha\nconllevado a reconocer que nada está dicho en la educación y que si estamos\ncompartiendo este espacio, debemos asumirlo como el reto de construir siempre vidas\ndignas, que favorezcan la construcción de una sociedad en la cual todos “seamos” y\npermitamos que los otros “sean”.', 'NA', 'Luis Silva', '../../../assets/img/equipo/info_luis.jpg', 'A +', 'inactivo'),
('ANGIE DAYANNA', 'MENDOZA NOSSA', 'angiemendozanossa@unicab.org', '8XAi0bvOiIGV/DtlWiIrCg==', 'TU', 1052398133, 'PENSAMIENTO HUMANISTICO INGLES', 'NA', '313 228 5898', 'NA', 'TUTOR MEDIADOR', 'NA', 'Hey there! Soy Angie Mendoza, tutora mediadora del Pensamiento Humanístico Ingles.\nEste es mi segundo año en el Colegio Virtual Unicab, trabajando con secundaria. Creo\ntotalmente en el modelo educativo que el colegio ofrece tanto a estudiantes como a\npadres de familia, pues otorga el espacio para que los chicos desarrollen sus habilidades y\ntalentos. Como mamá de una pequeña niña, espero algún día ella pueda ser parte de esta\nfamilia. A parte de mi labor como tutora, amo la naturaleza, caminar y disfrutar de lo\nsimple pero hermoso que hay en el planeta. Normalmente me intereso por aprender\ndiferentes labores u oficios, como el diseño y confección de ropa, tiro con arco, patinaje,\ncocina, entre otros. Pienso que aprender algo nuevo siempre será bien venido, al igual\naprender a tratar y convivir con los demás, siendo un individuo empático y con gran\nconciencia social.', 'NA', 'Angie Mendoza', '../../../assets/img/equipo/ANGIE_MENDOZA_2024.jpg', 'O +', 'inactivo'),
('SONIA DEL PILAR', 'BARRERA CHAPARRO', 'soniabarrerachaparro@unicab.org', 'rSo4UhBEjJFzZAg8IxBVOw==999', 'TU', 1057570837, 'PENSAMIENTO HUMANISTICO INGLES', 'NA', '320 280 6185', 'NA', 'TUTOR MEDIADOR', 'NA', 'NA', 'NA', 'Sonia Barrera', '../../../assets/img/equipo/inf_sonia.png', 'A -', 'inactivo'),
('LEIDY CATHERINE', 'MONTAÑEZ LEON', 'catherinemontanez@unicab.org', '/mdvN+fWhKXFbYJiBZxevg==', 'TU', 1057592583, 'PENSAMIENTO BIOETICO', 'NA', '311 546 7820', 'NA', 'TUTOR MEDIADOR', 'NA', 'Soy tutora mediadora del pensamiento bioético Licenciada en Ciencias Naturales y\nEducación Ambiental especialista en Gestión Ambiental y actualmente estoy culminando\nla maestría en innovaciones Educativas, dentro de mis actividades diarias esta ir al\ngimnasio porque el ejercicio mantiene mi mente y cuerpo sano y activo durante el día, me\nencanta salir a caminar viajar y descubrir culturas, paisajes nuevos y pintar, además\ncompartir con mis seres queridos y amigos dándole paso a un momento de esparcimiento.\nTengo grandes expectativas de mi futuro como tener una familia, poder seguir\nformándome para ser una gran docente y líder destacada dentro de este campo, y poder\nimpactar a muchos más niños y jóvenes desde la educación, ofreciéndoles todos mis\nconocimientos por experiencia de vida o por profesión para que sean los mejores seres\nhumanos en cualquier lugar del mundo. Hago parte del colegio UNICAB desde hace año y\n6 meses aproximadamente donde considero he tenido una de las mejores experiencias\nlaborales por el excelente equipo de trabajo desde la alta dirección hasta la calidez\nhumano del equipo administrativo, he logrado aprender un modelo pedagógico\nextraordinario en el cual me he venido formando y fortaleciendo habilidades en\ninnovación y Tic, además contar con la fortuna de conocer a los estudiantes que desde\ndistintas culturas me han enseñado la autenticidad y el que ellos puedan compartir logros\ndeportivos artísticos académicos y personales me enorgullece, son un gran talento\napreciados estudiantes y seguiré ofreciendo lo mejor de mí al servicio de ustedes.', 'NA', 'Leidy Montañez', '../../../assets/img/equipo/info_catherine.jpg', 'O +', 'inactivo'),
('VICTOR EDUARDO', 'NUÑEZ MORALES', 'eduardonunezmorales@unicab.org', 'QvMvbhA+99IyBoXrTCsNsg==', 'TU', 315860, 'PENSAMIENTO BIOETICO', 'NA', '311 255 1499', 'NA', 'TUTOR MEDIADOR', 'NA', 'NA', 'NA', 'Victor Nuñez', '../../../assets/img/equipo/inf_eduardo.png', 'O +', 'retirado'),
('MARLI YINED', 'BALAGUERA PRIETO', 'marlibalagueraprieto@unicab.org', 'UYH0+zw4PQo3U0/XIIcApw==', 'TU', 1052407840, 'PENSAMIENTO NUMERICO', 'NA', '313 288 3737', '313 288 3737', 'TUTOR MEDIADOR', 'LICENCIADA EN MATEMATICAS Y ESTADISTICA', 'Soy tutora mediadora de pensamiento matemático. Soy Licenciada en Matemáticas y\nEstadística, actualmente estoy cursando una Maestría en Educación Matemática. En mi\ntiempo libre me gusta compartir en familia, leer y escuchar música. Me gusta el deporte,\ncomparto esta pasión con mi familia por el baloncesto, también caminar para poder\n\ndisfrutar de los paisajes. Estoy enfocada en mi posgrado con el fin de poder aprender más\nacerca de la matemática y mostrarles a mis estudiantes todo lo que las matemáticas\ntienen para brindar. Mis metas son culminar de manera satisfactoria mi posgrado, seguir\ndisfrutando del tiempo en familia, poder trasmitir ese amor y admiración que siento hacia\nla matemática a mis estudiantes y viajar para conocer y aprender de otras culturas. Desde\nhace 2 años me desempeño como tutora mediadora en el Colegio UNICAB, este tiempo ha\nsido enriquecedor en muchos ámbitos, todos los días apuesto por esta educación\ninnovadora que busca la felicidad de nuestros estudiantes, apoyándolos en sus proyectos\nde vida, donde la parte fundamental es la familia, experimento mucha felicidad cuando los\nestudiantes nos comunican sus logros. Me siento contenta de ser parte de ese cambio de\nla educación que tanto necesitamos, no se trata de buscar excelencia sino felicidad en los\nestudiantes y esta es la idea central de UNICAB.', 'NA', 'Marli Balaguerra', '../../../assets/img/equipo/info_marli.jpg', 'B +', 'inactivo'),
('MARIA ALEJANDRA', 'COY RODRIGUEZ', 'psico03@unicab.org', 'W9hGSR1U9VnnI+HShKV0vg==', 'PS', 1057610931, 'ADMINISTRATIVA', 'http://meet.google.com/uqq-iusq-umf', '320 588 6995', 'NA', 'PSICOLOGA', 'PSICOLOGA', 'Soy Psicóloga egresada de la universidad el Bosque, especialista en Gerencia de Seguridad\ny salud en el trabajo, mi formación está orientada hacia las diferentes áreas y teorías, me\ncaracterizo por ser una persona alegre y comprometida, me apasionan los animales y el\npoder apoyar los procesos de las personas que me rodean. Hago parte del equipo\nadministrativo del colegio UNICAB el cual me ha permitido fortalecer mis habilidades a\nnivel personal y profesional, desde mi área he podido apoyar los procesos de estudiantes y\nfamilias aportando en sus proyectos de vida, me siento feliz el poder hacer parte de esta\ninstitución la cual me ha brindado la posibilidad de conocer una manera diferente de\naprender.', 'NA', 'Maria Coy', NULL, 'A +', 'activo'),
('PAULA MILDRED', 'PEREZ LEON', 'matriculas.unicab@gmail.com', 'ojdbvt2ZOpwZeAhuSkJo3g==', 'AR1', 1057587239, 'ADMINISTRATIVA', 'NA', '312 786 9003', 'NA', 'ASISTENTE SECRETARIA ACADEMICA', 'ADMINISTRADORA EN SALUD', 'Soy Administradora de Servicios de Salud con Especialización en Gerencia de empresas de\nSalud, egresada de la Universidad Pedagógica y Tecnológica de Colombia “U.P.T.C.”. Me\ncaracterizo por ser una persona responsable, amable y comprometida con cada proyecto\nque me trazo en la vida. Me encanta viajar dentro y fuera de Colombia, ya que me permite\nconocer otras culturas, mejorar mi nivel de inglés y cultural, así como socializar con otras\npersonas. Hago parte del equipo administrativo de UNICAB hace año y medio,\ndesarrollando mis actividades en el área de secretaria académica como Asistente, tiempo\nque ha sido enriquecedor para mi vida personal y profesional, además de permitirme\ndesarrollar todas mis habilidades y haber encontrado oportunidades de seguir\ncapacitándome.', 'NA', 'Paula Pérez', NULL, 'O +', 'retirado'),
('JULIAN CAMILO', 'DIAZ ACERO', 'julian.diaz@unicab.org', '6BGP16udj3A4xaUbjGNTiQ==999', 'TU', 1052413329, 'PENSAMIENTO NUMERICO', 'NA', '320 216 8417', 'NA', 'TUTOR MEDIADOR', 'LICENCIADO EN MATEMATICAS Y ESTADISTICA', 'NA', 'NA', 'Julian Díaz', '../../../assets/img/equipo/info_julian.jpg', 'O +', 'retirado'),
('KAREN MARIANA', 'GRANADOS OVIEDO', 'karengranadosoviedo@unicab.org', '6tKYFeiSVHrK9B4n2TupdQ==', 'TU', 1052406703, 'PENSAMIENTO NUMERICO', 'NA', '317 495 2167', 'NA', 'TUTOR MEDIADOR', 'NA', 'Soy tutora mediadora de pensamiento matemático, licenciada en matemáticas y\nestadística, actualmente me encuentro involucrada en investigación matemática, más\nprecisamente en el área del álgebra y matemática avanzada, me encanta la estadística y\n\nsiempre estoy en búsqueda de conocimiento relacionado con esta área, actualmente\npráctico actividad física calistenia y pesas, mis metas son culminar dos postgrados, uno\nrelacionado con matemáticas y otro relacionado con actuaría (análisis de riesgos,\nestadística). Hago parte del equipo de UNICAB desde hace 10 meses, los cuales han\nenriquecido mi vida profesional y personal, lo que más me gusta de esta institución es su\nmodelo pedagógico, ya que no solo permite explorar los talentos de nuestros estudiantes,\nsino más importante aún potenciarlos, me gusta compartir mis conocimientos\nespecialmente en matemáticas y aplicar las diferentes teorías de estadística en la\ninstitución.', 'NA', 'Mariana Granados', 'https://unicab.org/assets/img/equipo/Karen .png', 'A +', 'activo'),
('FIDEL MAURICIO', 'DIAZ MARCIALES', 'mauricio.diaz@unicab.org', 'TqSCd2WdPKIdBRjkR+qoWw==', 'TU', 1053559294, 'PENSAMIENTO TECNOLOGICO', 'NA', '310 464 6612', '310 464 6612', 'TUTOR MEDIADOR', 'LICENCIADO EN INFORMATICA Y TECNOLOGIA', 'Soy Tutor mediador de Pensamiento Tecnológico, Licenciado en Informática y Tecnología,\nestudiante de la maestría en ambientes educativos mediados por las TIC ofrecida por la\nUniversidad Pedagógica y Tecnológica de Colombia, La Tecnología está presente en todos\nlos campos, siempre estará en constante innovación y la educación no es la excepción;\nestamos en una sociedad del conocimiento y debido a esto se ha dado un cambio a la\nconducta de la misma. Esto sucede gracias a la forma de comportarnos, de comunicarnos\nincluso la forma de emplearnos; estos son algunos de los motivos por el cual siento una\ngran atracción educativa por la ciencia y la tecnología, La institución UNICAB hace parte de\nestos cambios socio-educativos, por esta y más razones me siento agradecido y dichoso de\npertenecer a este establecimiento de alta calidad.\nMe apasiona los deportes extremos y competitivos, porque puedo superarme a mí mismo\ny para ello, es necesario el desarrollo de cualidades físicas, habilidades motoras,\nresistencia general y, sobre todo, adquirir preparación psicológica, cabe resaltar mi gusto\npor el medio ambiente y la naturaleza, quienes son escenarios para practicar mis\nactividades.', 'NA', 'Mauricio Díaz', 'https://unicab.org/assets/img/equipo/Mauricio.png', 'O +', 'activo');
INSERT INTO tbl_empleados (nombres, apellidos, email, pc, perfil, n_documento, dependencia, skype, celular, celular_what, cargo, profesion, descripcion, foto, nombre_corto, infografia, rh, estado) VALUES
('NAHOMY JERALDIN', 'MINOTA RODRIGUEZ', 'nahomyminota@unicab.org', 'SJPXRDvuQBKvKjrWnTwQ/Q==', 'TU', 1024584082, 'PENSAMIENTO HUMANISTICO ESPAÑOL', 'NA', '313 880 2392', 'NA', 'TUTOR MEDIADOR', 'LICENCIADA EN ESPAÑOL Y FILOLOGÍA CLÁSICA', 'Soy tutora de Pensamiento Humanístico inglés, licenciada y filóloga clásica de la\nUniversidad Nacional de Colombia. Soy amante de los idiomas, hasta el momento tengo\nconocimientos en inglés, francés, algo de latín y griego antiguo, pero quiero seguir\naprendiendo muchos más. Me encanta expresarme a través del arte, ya sea cantar\nmientras toco mi piano o guitarra, o con la actuación. Actualmente, pertenezco a un grupo\nde teatro, donde he retomado una pasión que surgió desde muy pequeña hacía las artes\nescénicas. Me siento afortunada de haber encontrado, hace año y medio, en UNICAB un\nespacio para desarrollar toda mi creatividad, ya que, la enseñanza de idiomas en esta\ninstitución, a través de las TIC me ha permitido enlazar mis dos pasiones, transmitiendo\nmis conocimientos en idiomas mediante el arte. Igualmente, he observado la fascinante\nexperiencia de los estudiantes, cuando encuentran en UNICAB un lugar donde se les\nmotiva a usar sus contextos y habilidades en el proceso de aprendizaje; así, esta\ninstitución se convierte día a día en un espacio seguro para desarrollar las pasiones y\nproyectos de vida de cada niño y niña.', 'NA', 'Nahomy Minota', 'https://unicab.org/assets/img/equipo/Nahomy.png', 'A +', 'activo'),
('YOHANA', 'MORALES', 'administracion@unicab.org', 'FIHiJetMBXePJ3N0juiD0w==', 'PS', 51784292, 'ADMINISTRATIVA', 'NA', '312 786 9003', '312 786 9003', 'ASISTENTE ADMINISTRATIVA', 'NA', '', 'NA', 'Yohana Morales', 'https://unicab.org/assets/img/equipo/yohanna.png', 'NA', 'activo'),
('LIZETH TATIANA', 'GONZALEZ CUEVAS', 'admisiones02@unicab.org', 'fFwc8772EzmhZj0IyhC8kg==', 'PS', 1007413821, 'ADMINISTRATIVA', 'NA', 'NA', 'NA', 'AUXILIAR ADMINISTRATIVA', 'NA', 'Soy estudiante de Contaduría Pública de la Corporación Universitaria Remington de la\nciudad de Sogamoso, soy técnico contable y financiero por el ITEANDES, cuento con\nexperiencia en análisis y cobro de cartera, manejo de programas ofimáticos, Gestión\ndocumental contable-financiera, atención al cliente, recepción de documentos, brindo\ninformación general en el área de admisiones, recibo solicitudes, llamadas y mensajes de\nla planta administrativa, las cuales son redireccionadas a cada área respectiva. También\nbrindo apoyo en el área de coordinación académica en la recepción y respuesta de\nmensajes relacionados con mi área.\nMe caracterizo por un buen manejo y disposición para el trabajo en equipo, soy\npropositiva, creativa, respetuosa, amable con un gran sentido de pertenencia, estoy a\ndisposición de escuchar, aprender y poner en práctica todo tipo de conocimientos y\nobservaciones en pro de mi crecimiento personal, profesional y laboral.', 'NA', 'Tatiana Gonzalez', '../../../assets/img/equipo/Tatiana_2024.jpg', 'NA', 'inactivo'),
('CAMILA ANDREA', 'PALACIOS OLARTE', 'camilapalacios@unicab.org', 'JAW3dEdwxUZRZgv5Fb/Sqw==', 'TU', 1057605307, 'PENSAMIENTO HUMANISTICO INGLES', 'NA', '313 717 9490', 'NA', 'TUTOR MEDIADOR', 'NA', 'Tutora Mediadora del Pensamiento Humanístico Inglés. Licenciada en Lenguas Extranjeras\n(inglés-francés). Actualmente cursando una Maestría en Docencia de Idiomas. Me\napasionan el arte, la música, la literatura, el patinaje y los idiomas. He aprendido y\nenseñado idiomas durante toda mi vida y creo que son la manera más bonita de conocer\notras culturas y conocerte a ti mismo. Para mí, la educación y la docencia son\noportunidades de cambiar el mundo, de sembrar ideas, de cultivar sueños y de construir\nfuturos brillantes. En UNICAB trabajamos no sólo para enseñar inglés sino también para\nfomentar una comunicación real y significativa. Ser Tutora Mediadora me ha permitido\nconocer el mundo deportivo, artístico y cultural de cada uno de mis estudiantes, al igual\nque guiarlos para potenciar sus habilidades y conocimientos a través del idioma. Ser guía\nde su aprendizaje, fomentar sus proyectos de vida y observar todo lo que tienen para\nbrindarle al mundo ha sido una experiencia muy gratificante.\n&quot;Education is the most powerful weapon which you can use to change the world.&quot; -Nelson\nMandela.', 'NA', 'Camila Palacios', '../../../assets/img/equipo/info_camila.png', 'O +', 'inactivo'),
('EILEEN KARINA', 'LA ROTA CORREA', 'eileenlarota@unicab.org', 'bz+aeJbV0m3dSUf7gjAESg==', 'TU', 1057601020, 'PENSAMIENTO HUMANISTICO ESPAÑOL', 'NA', '314 420 4224', 'NA', 'TUTOR MEDIADOR', 'NA', 'Soy tutora mediadora de pensamiento bioético, profesional en educación básica con\nénfasis en matemáticas, inglés y lengua castellana, especialista en necesidades de la\neducación. Mi interés primordial es poder transmitir con calidad mis conocimientos a mis\nestudiantes, lograr que el aprendizaje sea para ellos un disfrute y no una obligación\nporque a través del afianzamiento de los conocimientos primarios lograremos que tengan\nbases suficientes para superar con fluidez los nuevos retos, los siguientes cursos y demás\naspectos de la vida académica. En mi tiempo libre me encanta disfrutar del cine y la\nfamilia, soy apasionada por la lectura y la investigación en mi área de conocimiento, para\nlograr así tener nuevas herramientas actualizadas para desarrollar mi labor.\nSoy docente de UNICAB desde abril de 2021 y ha sido una experiencia gratificante, el\nfuturo de la educación no puede ser otro que el virtual, la inmediatez de la tecnología al\nservicio del conocimiento, espero poder seguir aportando para la formación de\nestudiantes bien preparados.', 'NA', 'Eileen La Rota', NULL, 'O +', 'inactivo'),
('MARIA JOSE', 'BELLO', 'comunicacion@unicab.org', 'H7htvFNJHiexQaZvv7uObg==', 'PU', 1007751497, 'EQUIPO CREATIVO', 'NA', '310 481 7115', 'NA', 'COMUNICADORA SOCIAL', 'COMUNICADORA SOCIAL', 'NA', 'NA', 'María José Bello', NULL, 'NA', 'inactivo'),
('JUAN DAVID', 'ALVAREZ LOPEZ', '_psico03@unicab.org', 'jBI+0bFf0OLBQsFUhijlmQ==', 'PS', 1057589940, 'ADMINISTRATIVA', 'https://meet.google.com/teb-ujzw-giq', '320 588 6995', 'NA', 'PSICOLOGO', 'PSICOLOGO', 'NA', 'NA', 'Juan Alvarez', '../../../assets/img/equipo/Psicologo_Juan_David_2024.jpg', 'O +', 'inactivo'),
('DANIEL', 'CONDIA FIGUEREDO', 'daniel.condia@unicab.org', 'HsU0VX8L1oHmgFxhIMwGSA==', 'SU_2', 1023163168, 'SISTEMAS', 'NA', '316 747 0699', '316 747 0699', 'DESARROLLADOR WEB', 'PRACTICANTE UNIVERSITARIO', 'NA', 'NA', 'N', NULL, 'NA', 'retirado'),
('ANGÉLICA', 'MESA VERGARA', 'angelicamesa@unicab.org', 'Gm0MP7h+x83LkcpFWhMv0g==', 'TU', 123456789, 'PENSAMIENTO HUMANISTICO INGLES', 'NA', '000 000 0000', 'NA', 'TUTOR MEDIADOR', 'NA', 'NA', 'NA', 'Angélica Mesa', 'https://unicab.org/assets/img/equipo/Angelica.png', 'NA', 'activo'),
('DIEGO FERNEY', 'CAÑÓN LÓPEZ', 'diegofernerclopez@unicab.org', 'r3Vm6536xbxYJ2cbR/sYtQ==', 'TU', 123456789, 'PENSAMIENTO NUMERICO', 'NA', '000 000 0000', '000 000 0000', 'TUTOR MEDIADOR', 'NA', 'NA', 'NA', 'DIEGO FERNEY', 'https://unicab.org/assets/img/equipo/diego.png', 'NA', 'activo'),
('DIANA', 'SANCHEZ', 'dianasanchez@unicab.org', 'zjn4IOYM4XjkGMepQso4mQ==', 'TU', 1052397899, 'PENSAMIENTO HUMANISTICO INGLES', 'NA', '321 492 5803', 'NA', 'TUTOR MEDIADOR', 'NA', 'NA', 'NA', '', 'https://unicab.org/assets/img/equipo/Diana.png', 'NA', 'activo'),
('HAYDER ORLANDO', 'ZORRO RIZO', 'hayderzorrorizo2@gmail.com', 'ZF7VKAVqJtHq0XrKzF0PLA==', 'TU', 1058352021, 'ADMINISTRATIVA', 'NA', '000 000 0000', 'NA', 'CREADOR DE CONTENIDO', 'NA', 'NA', 'NA', 'Hayder Zorro', NULL, 'NA', 'activo'),
('ARNULFO', 'MESA LARA', 'arnulfomesa@gmail.com', 'w8GbK1amufoYODUQLb5mmw==', 'PS', 9526629, 'ADMINISTRATIVA', '', '000 000 0000', 'NA', 'ASESOR', 'NA', 'NA', 'NA', 'Arnulfo Mesa', NULL, 'NA', 'activo');

/*ALTER TABLE tbl_empleados
MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;*/

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_seguimientos;

CREATE TABLE tbl_seguimientos (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_psicologo int(11) NOT NULL,
  fecha date NOT NULL,
  hora varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  documento_est varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_seg_psi;

CREATE TABLE tbl_seg_psi (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_valoracion int(11) NOT NULL,
  id_psicologo int(11) NOT NULL,
  objetivo varchar(500) NOT NULL,
  desarrollo varchar(500) NOT NULL,
  fecha date NOT NULL,
  hora varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  estado varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL COMMENT 'abierto, realizado, no_realizado',
  fecha_real date NOT NULL,
  hora_real varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  avances varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  acciones_est varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  acciones_acu varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  compromisos varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  proc_post varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_agendamientos;

CREATE TABLE tbl_agendamientos (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_empleado int(11) NOT NULL,
  id_tipo_agenda int(11) NOT NULL,
  fecha varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  hora varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  descripcion varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  estado varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL COMMENT 'en proceso, confirmado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_dias_festivos;

CREATE TABLE tbl_dias_festivos (
  dia varchar(10) NOT NULL PRIMARY KEY,
  descripcion varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_dias_festivos (dia, descripcion) VALUES
('2025-12-08', 'festivo'),
('2025-12-12', 'receso'),
('2025-12-13', 'receso'),
('2025-12-14', 'receso'),
('2025-12-15', 'receso'),
('2025-12-16', 'receso'),
('2025-12-17', 'receso'),
('2025-12-18', 'receso'),
('2025-12-19', 'receso'),
('2025-12-20', 'receso'),
('2025-12-21', 'receso'),
('2025-12-22', 'receso'),
('2025-12-23', 'receso'),
('2025-12-24', 'receso'),
('2025-12-25', 'festivo'),
('2025-12-26', 'receso'),
('2025-12-27', 'receso'),
('2025-12-28', 'receso'),
('2025-12-29', 'receso'),
('2025-12-30', 'receso'),
('2025-12-31', 'receso'),
('2026-01-01', 'festivo'),
('2026-01-02', 'receso'),
('2026-01-03', 'receso'),
('2026-01-04', 'receso'),
('2026-01-05', 'receso'),
('2026-01-06', 'receso'),
('2026-01-07', 'receso'),
('2026-01-08', 'receso'),
('2026-01-09', 'receso'),
('2026-01-10', 'receso'),
('2026-01-11', 'receso'),
('2026-01-12', 'festivo'),
('2026-01-13', 'receso'),
('2026-01-14', 'receso'),
('2026-01-15', 'receso'),
('2026-01-16', 'receso'),
('2026-01-17', 'receso'),
('2026-01-18', 'receso'),
('2026-03-23', 'festivo'),
('2026-04-02', 'festivo'),
('2026-04-03', 'festivo'),
('2026-05-01', 'festivo'),
('2026-05-18', 'festivo'),
('2026-06-08', 'festivo'),
('2026-06-15', 'festivo'),
('2026-06-29', 'festivo'),
('2026-07-20', 'festivo'),
('2026-08-07', 'festivo'),
('2026-08-17', 'festivo'),
('2026-10-12', 'festivo'),
('2026-11-02', 'festivo'),
('2026-11-16', 'festivo'),
('2026-12-08', 'festivo'),
('2026-12-25', 'festivo'),
('2027-01-01', 'festivo'),
('2027-01-11', 'festivo'),
('2027-03-22', 'festivo'),
('2027-03-25', 'festivo'),
('2027-03-26', 'festivo'),
('2027-05-10', 'festivo'),
('2027-05-31', 'festivo'),
('2027-06-07', 'festivo'),
('2027-07-05', 'festivo'),
('2027-07-20', 'festivo'),
('2027-08-16', 'festivo'),
('2027-10-18', 'festivo'),
('2027-11-01', 'festivo'),
('2027-11-15', 'festivo'),
('2027-12-08', 'festivo');

/*######################################################################################################*/

/*######################################################################################################*/

/*######################################################################################################*/

/*######################################################################################################*/