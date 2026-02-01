CREATE DATABASE avm_unieeuu DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;

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
  genero varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
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
  parametro varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  v1 int(11) DEFAULT NULL,
  v2 int(11) DEFAULT NULL,
  t1 varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  t2 varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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

/*######################################################################################################*/

/*######################################################################################################*/

/*######################################################################################################*/

/*######################################################################################################*/

/*######################################################################################################*/