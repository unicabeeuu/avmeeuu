/*DROP DATABASE IF EXISTS admin_unieeuu;

CREATE DATABASE admin_unieeuu DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;*/

/*######################################################################################################*/
SET SQL_SAFE_UPDATES = 0;

DROP TABLE IF EXISTS tbl_carga_profesor;

CREATE TABLE tbl_carga_profesor (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_profesor int(11) NOT NULL,
  id_grado int(11) NOT NULL,
  id_materia int(11) NOT NULL,
  id_empleado int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_certificados;

CREATE TABLE tbl_certificados (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fecha_expedicion date NOT NULL,
  numero varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  tipo_certificado varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_estudiante int(11) NOT NULL,
  id_grado int(11) NOT NULL,
  ruta varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  numero1 int(11) DEFAULT NULL,
  identificacion varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  ruta1 varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  a int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_equivalence_idest;

CREATE TABLE tbl_equivalence_idest (
  id_moodle int(11) NOT NULL,
  id_registro int(11) NOT NULL,
  PRIMARY KEY (id_moodle, id_registro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_equivalence_idest_temp1;

CREATE TABLE tbl_equivalence_idest_temp1 (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_moodle int(11) NOT NULL,
  nom_moodle varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  grado varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_registro int(11) NOT NULL,
  nom_registro varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  actualizar int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_equivalence_idgra;

CREATE TABLE tbl_equivalence_idgra (
  id_category int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_grado_ra int(4) NOT NULL,
  grado_ra varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_equivalence_idmat;

CREATE TABLE tbl_equivalence_idmat (
  id_course int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  shortname varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_materia_ra int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_equivalence_per;

CREATE TABLE tbl_equivalence_per (
  idnumber varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  periodo int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_estudiantes_eval_admision;

CREATE TABLE tbl_estudiantes_eval_admision (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  n_documento varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  id_grado int(11) DEFAULT 0,
  email varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  observaciones varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  origen varchar(30) DEFAULT NULL,
  año int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_grados_materias;

CREATE TABLE tbl_grados_materias (
  id int(15) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_grado int(15) NOT NULL,
  id_materia int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_grados_materias (id, id_grado, id_materia) VALUES
(1, 2, 1),
(4, 2, 4),
(5, 2, 5),
(6, 2, 6),
(7, 2, 7),
(9, 2, 9),
(10, 3, 1),
(13, 3, 4),
(14, 3, 5),
(15, 3, 6),
(16, 3, 7),
(18, 3, 9),
(19, 4, 1),
(22, 4, 4),
(23, 4, 5),
(24, 4, 6),
(25, 4, 7),
(27, 4, 9),
(28, 5, 1),
(31, 5, 4),
(32, 5, 5),
(33, 5, 6),
(34, 5, 7),
(36, 5, 9),
(37, 6, 1),
(40, 6, 4),
(41, 6, 5),
(42, 6, 6),
(43, 6, 7),
(45, 6, 9),
(46, 7, 1),
(49, 7, 4),
(50, 7, 5),
(51, 7, 6),
(52, 7, 7),
(54, 7, 9),
(55, 8, 1),
(58, 8, 4),
(59, 8, 5),
(60, 8, 6),
(61, 8, 7),
(63, 8, 9),
(64, 9, 1),
(67, 9, 4),
(68, 9, 5),
(69, 9, 6),
(70, 9, 7),
(72, 9, 9),
(73, 10, 1),
(76, 10, 4),
(77, 10, 5),
(78, 10, 6),
(79, 10, 7),
(81, 10, 9),
(82, 11, 10),
(85, 11, 7),
(86, 11, 15),
(89, 11, 5),
(90, 11, 11),
(91, 11, 12),
(92, 11, 9),
(93, 12, 10),
(96, 12, 7),
(97, 12, 15),
(100, 12, 5),
(101, 12, 11),
(102, 12, 12),
(103, 12, 9),
(104, 15, 5),
(105, 15, 6),
(106, 15, 7),
(107, 15, 4),
(108, 15, 9),
(109, 15, 1),
(116, 16, 5),
(117, 16, 6),
(118, 16, 7),
(119, 16, 4),
(120, 16, 9),
(121, 16, 1),
(122, 17, 5),
(123, 17, 11),
(124, 17, 7),
(125, 17, 15),
(126, 17, 12),
(128, 17, 9),
(129, 17, 10),
(130, 18, 5),
(131, 18, 11),
(132, 18, 7),
(133, 18, 15),
(134, 18, 12),
(136, 18, 9),
(137, 18, 10),
(138, 13, 1),
(139, 13, 4),
(140, 13, 5),
(141, 13, 6),
(142, 13, 7),
(143, 14, 1),
(144, 14, 4),
(145, 14, 5),
(146, 14, 6),
(147, 14, 7);

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_materias;

CREATE TABLE tbl_materias (
  Id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  materia varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  materiaIngles varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  pensamiento varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  pensamientoingles varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_materias (Id, materia, materiaIngles, pensamiento, pensamientoingles) VALUES
(1, 'CIENCIAS NATURALES ', 'SCIENCE ', 'BIOÉTICO', 'BIOETHICS'),
(2, 'EDUCACIÓN ÉTICA Y EN VALORES', 'ETHICS AND VALUES', 'BIOÉTICO', 'BIOETHICS'),
(3, 'EDUCACIÓN FÍSICA', 'PHYSICAL EDUCATION', 'BIOÉTICO', 'BIOETHICS'),
(4, 'CIENCIAS SOCIALES', 'SOCIAL SCIENCE ', 'SOCIAL', 'SOCIAL'),
(5, 'MATEMÁTICAS', 'MATHS', 'NUMÉRICO', 'NUMERIC'),
(6, 'HUMANIDADES – LENGUA CASTELLANA', 'SPANISH', 'HUMANÍSTICO E', 'HUMANISTIC'),
(7, 'HUMANIDADES- INGLÉS', 'ENGLISH', 'HUMANÍSTICO I', 'HUMANISTIC'),
(8, 'ARTISTICA', 'ARTS', 'HUMANÍSTICO', 'HUMANISTIC'),
(9, 'TECNOLOGÍA E INFORMÁTICA', 'INFORMATION TECHNOLOGY', 'TECNOLÓGICO', 'TECHNOLOGIC '),
(10, 'QUÍMICA', 'CHEMISTRY', 'BIOÉTICO', 'BIOETHICS'),
(11, 'FÍSICA', 'PHYSICS', 'BIOÉTICO F', 'BIOETHICS'),
(12, 'CIENCIAS POLÍTICAS', 'POLITICS SCIENCE', 'SOCIAL', 'SOCIAL'),
(13, 'FILOSOFÍA', 'PHILOSOPHY', 'HUMANÍSTICO', 'HUMANISTIC'),
(15, 'HUMANIDADES - ESPAÑOL', 'SPANISH', 'HUMANÍSTICO E', 'HUMANISTIC'),
(16, 'ÉNFASIS EN EDUCACIÓN FÍSICA', 'EMPHASIS ON PHYSICAL EDUCATION', 'BIOÉTICO', 'BIOETHICS');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_notas;

CREATE TABLE tbl_notas (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nota float NOT NULL DEFAULT 0,
  id_periodo int(11) NOT NULL,
  id_materia int(11) NOT NULL,
  id_grado int(11) NOT NULL,
  id_estudiante int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_notas_mood_temp;

CREATE TABLE tbl_notas_mood_temp (
  id_est int(11) NOT NULL PRIMARY KEY,
  lastname varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  firstname varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  shortname varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id int(11) NOT NULL,
  name varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_grado int(11) NOT NULL,
  periodo varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  periodo_ra int(11) NOT NULL,
  calificacion float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_notas_mood_temp_est;

CREATE TABLE tbl_notas_mood_temp_est (
  id_est int(11) NOT NULL PRIMARY KEY,
  lastname varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  firstname varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  shortname varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_mat_mood int(11) NOT NULL,
  name varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_grado int(11) NOT NULL,
  idnumber varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  calificacion float NOT NULL DEFAULT 0,
  email_inst varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_notas_temp;

CREATE TABLE tbl_notas_temp (
  nota float NOT NULL DEFAULT 0,
  id_periodo int(11) NOT NULL,
  id_materia int(11) NOT NULL,
  id_grado int(11) NOT NULL,
  id_estudiante int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_notas_temp_ins;

CREATE TABLE tbl_notas_temp_ins (
  id_estudiante int(11) NOT NULL PRIMARY KEY,
  apellidos varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  nombres varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  grado varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  materia varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_periodo int(11) NOT NULL,
  id_materia int(11) NOT NULL,
  id_grado int(11) NOT NULL,
  nota_actual float NOT NULL,
  nota_nueva float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_notas_temp_ins_ghf;

CREATE TABLE tbl_notas_temp_ins_ghf (
  id_estudiante int(11) NOT NULL PRIMARY KEY,
  apellidos varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  nombres varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  grado varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  materia varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_periodo int(11) NOT NULL,
  id_materia int(11) NOT NULL,
  id_grado int(11) NOT NULL,
  nota_actual decimal(10,1) NOT NULL DEFAULT 0.0,
  nota_nueva float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_notas_temp_manual;

CREATE TABLE tbl_notas_temp_manual (
  id int(11) NOT NULL DEFAULT 0,
  nota float NOT NULL DEFAULT 0,
  id_periodo int(11) NOT NULL,
  id_materia int(11) NOT NULL,
  id_grado int(11) NOT NULL,
  id_estudiante int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_notas_temp_no_ra;

CREATE TABLE tbl_notas_temp_no_ra (
  id_estudiante int(11) NOT NULL PRIMARY KEY,
  apellidos varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  nombres varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  grado varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  materia varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_periodo int(11) NOT NULL,
  id_materia int(11) NOT NULL,
  id_grado int(11) NOT NULL,
  nota_actual float NOT NULL,
  nota_nueva float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_notas_temp_upd;

CREATE TABLE tbl_notas_temp_upd (
  id_estudiante int(11) NOT NULL PRIMARY KEY,
  apellidos varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  nombres varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  grado varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  materia varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_periodo int(11) NOT NULL,
  id_materia int(11) NOT NULL,
  id_grado int(11) NOT NULL,
  nota_actual float NOT NULL,
  nota_nueva float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_periodos;

CREATE TABLE tbl_periodos (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  periodo int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_periodos (periodo) VALUES
(1),
(2),
(3),
(4);

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_querys_ra;

CREATE TABLE tbl_querys_ra (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  pensamiento varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  grados varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  campos1 varchar(1300) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  campos2 varchar(800) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  campos3 varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  tablas varchar(350) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  condicion1 varchar(450) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  condicion2 varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  condicion3 varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  condicion4 varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  condicion5 varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  orden varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  actualizado varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  seleccionados int(11) NOT NULL,
  insertados_tem int(11) NOT NULL,
  actualizados int(11) NOT NULL,
  nuevos int(11) NOT NULL,
  procesar int(11) NOT NULL,
  est_nue_no_reg int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_querys_ra (pensamiento, grados, campos1, campos2, campos3, tablas, condicion1, condicion2, condicion3, condicion4, condicion5, orden, actualizado, seleccionados, insertados_tem, actualizados, nuevos, procesar, est_nue_no_reg) VALUES
('Hum_Esp', '9, 10, 11', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '15, 16, 17', ') AND c.id IN (', '44, 50, 54, 96, 98, 100', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '202100916_1859', 904, 904, 7, 2, 0, 0),
('Hum_Esp', '6, 7, 8', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '12, 13, 14', ') AND c.id IN (', '90, 92, 94', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '202100916_1902', 1064, 1064, 0, 0, 0, 0),
('Hum_Esp', 'primaria', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '4, 5, 6, 8, 9', ') AND c.id IN (', '80, 82, 84, 86, 88', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '202100916_1904', 951, 951, 3, 0, 0, 0),
('Hum_Ing', '9, 10, 11', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '15, 16, 17', ') AND c.id IN (', '95, 97, 99', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '202100916_1906', 911, 911, 8, 0, 0, 0),
('Hum_Ing', '6, 7, 8', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '12, 13, 14', ') AND c.id IN (', '89, 91, 93', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '202100916_1907', 1059, 1059, 6, 0, 0, 0),
('Hum_Ing', 'primaria', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '4, 5, 6, 8, 9', ') AND c.id IN (', '79, 81, 83, 85, 87', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '202100916_1911', 924, 924, 7, 1, 0, 0),
('Hum_Ing', 'ciclos', '', '', '', '', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '', ') AND c.id IN (', '', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', '', '20191017', 0, 0, 0, 0, 0, NULL),
('Bio', '9, 10, 11', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '15, 16, 17', ') AND c.id IN (', '42, 47, 52', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '202100916_1921', 893, 893, 12, 3, 0, 0),
('Bio', '6, 7, 8', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '12, 13, 14', ') AND c.id IN (', '27, 36, 41', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '202100922_1038', 1111, 1111, 0, 0, 0, 0),
('Bio', 'primaria', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '4, 5, 6, 8, 9', ') AND c.id IN (', '3, 7, 17, 18, 25', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '202100916_1924', 969, 969, 8, 0, 0, 0),
('Bio', 'ciclos', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '19, 20, 22, 23, 28, 30', ') AND c.id IN (', '63, 64, 73, 76, 110, 115', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '202100916_1925', 36, 36, 0, 0, 0, 0),
('Num', '9, 10, 11', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mTqQxBRxn2G7EHUl3iTEZTep/kmpVl+JKfY8QZyaN5L+dbME3FrCcxwMBaVuQ/4HtSbjVsfJw9Cu6oyDHSe7fywb5Kd0AQUD8dw3+7gOcqbcnAx9Q8MJ3pALnmxkiMDvg3MlX6hFnot7GURaQ/QKDHj/u9i1LBRErO7vRzEJF1xyhWWqeyb1ZZdaNKjqI6rwVVaWkxOgKhogzGDVPrLLoaZrHr2Rdrky3mrK/kcZK3+zTHHhYYrhTyA1STeOozNaunAx1m/iVYlEUw248jljlb9Y3LxehHAN7WkMw/cpdaZpWzDnM0O8rXivaFwuZLEzZdhDjSU9SRjrNWmtL2eefl/PyGYJUXZmNsDpNwIzkYRtXx0hLVI2FFI4a6IMdgf42SH/t+vurKzkVuEwAvzxZXzp6d8LBLc0jgs5VClCItAFwnrGrGIvGT3P/AJjMbesRCzIn46n3eYz6Sdri9Zcs2xa2FaDUwOsIFZhfNoUalyMtGqEhpncQV9cMpHq0TwufRCU0bGHc9GRjOtk5UAGdqC9FZFqGSJB1jSvQmoygbJ', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '15, 16, 17', ') AND c.id IN (', '46, 51, 55', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '202100916_1928', 1386, 1386, 481, 0, 0, 0),
('Num', '6, 7, 8', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '12, 13, 14', ') AND c.id IN (', '31, 35, 40', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '202100916_1930', 1106, 1106, 12, 2, 0, 0),
('Num', 'primaria', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '4, 5, 6, 8, 9', ') AND c.id IN (', '8, 13, 16, 19, 26', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20191017', 0, 0, 0, 0, 0, NULL),
('Num', 'ciclos', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mTqQxBRxn2G7EHUl3iTEZRgaLLaMxIdoNOrE2LR80JzQBdjtLNFeTCD+oOsj9Iwq5qfYRLCpPqiY8A8kq88TTDelyQILlcQsHPxIa36/SKOoCrPD9RScbW5gGtKmBTGKJ0dwT7z5s0x/rtk5Iab5ohKF1kXdjDG8OW7mSKEOazWMGvU6UUlLBmSfFaDmOYM87xtWYs/gVt84sWRrFcaHZyzORcgOWLdlxFTcWxuHibGtqFBW1sN8r0OOt/OtJOMRADLZ+Ov3NArVApbauAzNpPawcbPQqEEyZNgGA8Eht38IpCz23ddoZbm39Cx86FgYBGE+qeiXDvzWnXrnwbJA5edZOjKa/GmJwfH+35w4dJI7MSdBZHSkoFfmdsAK7IA202KMXp/GxQAHPDpQmp3YGkSk72bv7VXsD+6aF3xTYHxqRdBsnV/6mAUoy3Ymv66D8WLP0cOq6p/k3NhG1sK25KlOJZqwVaJavSE9DY7tCSQz/4TkzBWkJICi54wO3Wd3g==', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '19, 20, 22, 23, 28, 30', ') AND c.id IN (', '59, 67, 71, 75, 106, 117', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20191017', 0, 0, 0, 0, 0, NULL),
('Tec', '9, 10, 11', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '15, 16, 17', ') AND c.id IN (', '43, 48, 56', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '202100916_1931', 814, 814, 4, 0, 0, 0),
('Tec', '6, 7, 8', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '12, 13, 14', ') AND c.id IN (', '28, 32, 38', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '202100916_1933', 1016, 1016, 7, 1, 0, 0),
('Tec', 'primaria', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '4, 5, 6, 8, 9', ') AND c.id IN (', '2, 4, 5, 6, 22', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20191017', 0, 0, 0, 0, 0, NULL),
('Tec', 'cicloIII', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '19', ') AND c.id IN (', '62', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20191017', 0, 0, 0, 0, 0, NULL),
('Tec', 'ciclos', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '19, 20, 22, 23, 28, 30', ') AND c.id IN (', '62, 68, 69, 78, 109, 114', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20191017', 0, 0, 0, 0, 0, NULL),
('Social', '9, 10, 11', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '15, 16, 17', ') AND c.id IN (', '45, 49, 53', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '202100916_1935', 817, 817, 22, 0, 0, 0),
('Social', '6, 7, 8', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '12, 13, 14', ') AND c.id IN (', '30, 34, 37', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '202100916_1936', 977, 977, 0, 0, 0, 0),
('Social', 'primaria', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '4, 5, 6, 8, 9', ') AND c.id IN (', '10, 11, 15, 20, 24', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20211026_1449', 1008, 1008, 0, 0, 0, 0),
('Social', 'ciclos', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '19, 20, 22, 23, 28, 30', ') AND c.id IN (', '60, 65, 72, 74, 111, 116', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20191017', 0, 0, 0, 0, 0, NULL),
('Hum_Esp', '9', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '15', ') AND c.id IN (', '44, 96', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1600', 268, 268, 19, 0, 0, 0),
('Hum_Esp', '10', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '16', ') AND c.id IN (', '50, 98', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1606', 328, 332, 25, 0, 0, 0),
('Hum_Esp', '11', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '17', ') AND c.id IN (', '54, 100', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1610', 440, 440, 38, 0, 0, 0),
('Hum_Esp', '6', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '12', ') AND c.id IN (', '90', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1549', 128, 128, 1, 0, 0, 0),
('Hum_Esp', '7', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '13', ') AND c.id IN (', '92', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1554', 224, 224, 4, 0, 0, 0),
('Hum_Esp', '8', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '14', ') AND c.id IN (', '94', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1557', 328, 328, 8, 0, 0, 0),
('Hum_Ing', '9', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '15', ') AND c.id IN (', '95', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1604', 268, 201, 0, 0, 0, 0),
('Hum_Ing', '10', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '16', ') AND c.id IN (', '97', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251124_1751', 328, 332, 8, 29, 0, 0),
('Hum_Ing', '11', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '17', ') AND c.id IN (', '99', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251124_1756', 440, 440, 14, 36, 0, 0),
('Hum_Ing', '6', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '12', ') AND c.id IN (', '89', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1550', 128, 128, 1, 0, 0, 0),
('Hum_Ing', '7', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '13', ') AND c.id IN (', '91', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1555', 224, 224, 0, 0, 0, 0),
('Hum_Ing', '8', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '14', ') AND c.id IN (', '93', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1557', 328, 328, 0, 0, 0, 0),
('Bio', '9', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '15', ') AND c.id IN (', '42', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1559', 268, 268, 14, 0, 0, 0);
INSERT INTO tbl_querys_ra (pensamiento, grados, campos1, campos2, campos3, tablas, condicion1, condicion2, condicion3, condicion4, condicion5, orden, actualizado, seleccionados, insertados_tem, actualizados, nuevos, procesar, est_nue_no_reg) VALUES
('Bio', '10', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4oKpXs06a6eF3IarUjg2o7Dm5Q40glxsQm5nvO+g2Z8leTqLCthom/c/j5J7ndsbWB8+6EdlHjYtHPQw0izJIFHX8I5f+QjhbSfkQAhy0+6YvR47cH+uZaP3npjDiClKBIBudinhpOUiEFERONktgVx2avfkgCCxcD6VPiE/DdmbdwWnH+QqrghRMbtnPFy+WPOaLYb8T1WZa/olkRr7EqEAqpQW9gmU14ktJs+InDDJcs0x6axjJwalTc6IxzbdzttGZobihb5Oem3wXw85DCQ7B5G9hSCd3cer4t2A7GRQAY8qIhfE6RPoAAT5GMcB7ZxlSWn2sB3SGCfmuy/i8d6FQDxbdM3CGLP1e4gRXPOXHjprw93y5Wt6WVcp2dpaGty9pGX2bNn2k/otrCcF3mOQnhnOJ/AjsFgB9vlg5XKOrMkUpyaPbJyTotXVPw7C+IP9nuE/fgWCUhw9RFe2JY3i7coPqBLjIchaUq0ULT1sbHBvB5Xcl3D+fljXSj86N7dolalzulQzcVN0wnc2RjnUXYWnibysFJjeYUZ/Yi9yTAjgxLjK5jbZtZkwoFcL1dFQPlN1vE1Q8pZU+KexkMwWbjuO9RKsch6czlVMmvlrVhJD2p4VIwrEOH+p85QGiUBw+i5ZCZxMgB8RSN57wxiyYfeqWAViRUx82y7w1UlD', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '16', ') AND c.id IN (', '135', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1606', 328, 332, 5, 0, 0, 0),
('Bio', '11', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4oKpXs06a6eF3IarUjg2o7Dm5Q40glxsQm5nvO+g2Z8l9dIpcpA95gcm5gr4kWA64La9kW/xIzmqF9XN2cbISnvyULDCt3qWs/rdznLXaQtZ3q+vhbPib0wzVKMCl5JHqCIPCDAHF6SxOv8Xw62vxEhRbF1wSV2PfqHNA1sqkv1spenRJMWU/E7CaSUTeAYWFKgUcixIfbCmf8RA29J9ijhKa6MQlO3R6L/LCvZN8kPz0/J7Wj17OFLr9sOujhY3k3CQTTav04mI/dGdGk6LV3uCwZO4K8fvgva7bIALTmd1bkzAdW/kGyUoQcg7NXF89vWJzv3Mu8Tap4hKy2f6+8upMIAuWDQ365kMCMMIpEvyxupS/9HTmd5gJEa+JIaL1PCWvUMzM7ZMKmOh99ZXwJTHePwp377j5TER0XwR7X88MkqSqbAgXLM+9WUt83TVurunjfnamce/tptrYPQNyGcPxLHPvbNLhv4bq0HRrOMJtVqLm1dmvfkH3f5fiHmO4wiMRr0e4/R7yvbdR5vStPw9yReMdtmRL7P/R2On/XpD76K782nsGXkcug7GcxB7b/L9gXZl7ZjZyBHwDZK28rgIjFwoJ1wrKe7+1BChbNW4Dk432eTiQpCKwhQ0x1fkpHRS4OZr1cL+0RuHXQEiWzC0gYEk45SpBUZ9J1nplNtg', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '17', ') AND c.id IN (', '139', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1609', 440, 440, 0, 0, 0, 0),
('Bio', '6', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '12', ') AND c.id IN (', '27', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1549', 128, 128, 3, 0, 0, 0),
('Bio', '7', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '13', ') AND c.id IN (', '36', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1553', 224, 224, 1, 0, 0, 0),
('Bio', '8', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '14', ') AND c.id IN (', '41', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1557', 328, 328, 5, 0, 0, 0),
('Num', '9', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mTqQxBRxn2G7EHUl3iTEZTep/kmpVl+JKfY8QZyaN5L+dbME3FrCcxwMBaVuQ/4HtSbjVsfJw9Cu6oyDHSe7fywb5Kd0AQUD8dw3+7gOcqbcnAx9Q8MJ3pALnmxkiMDvg3MlX6hFnot7GURaQ/QKDHj/u9i1LBRErO7vRzEJF1xyhWWqeyb1ZZdaNKjqI6rwVVaWkxOgKhogzGDVPrLLoaZrHr2Rdrky3mrK/kcZK3+zTHHhYYrhTyA1STeOozNaunAx1m/iVYlEUw248jljlb9Y3LxehHAN7WkMw/cpdaZpWzDnM0O8rXivaFwuZLEzZdhDjSU9SRjrNWmtL2eefl/PyGYJUXZmNsDpNwIzkYRtXx0hLVI2FFI4a6IMdgf42SH/t+vurKzkVuEwAvzxZXzp6d8LBLc0jgs5VClCItAFwnrGrGIvGT3P/AJjMbesRCzIn46n3eYz6Sdri9Zcs2xa2FaDUwOsIFZhfNoUalyMtGqEhpncQV9cMpHq0TwufRCU0bGHc9GRjOtk5UAGdqC9FZFqGSJB1jSvQmoygbJ', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '15', ') AND c.id IN (', '46', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1605', 268, 268, 18, 0, 0, 0),
('Num', '10', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '16', ') AND c.id IN (', '51', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_1110', 328, 332, 0, 0, 0, 0),
('Num', '11', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '17', ') AND c.id IN (', '55', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1610', 440, 440, 10, 0, 0, 0),
('Num', '6', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '12', ') AND c.id IN (', '31', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1550', 128, 128, 4, 0, 0, 0),
('Num', '7', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '13', ') AND c.id IN (', '35', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1555', 224, 224, 8, 0, 0, 0),
('Num', '8', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '14', ') AND c.id IN (', '40', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1558', 328, 328, 0, 0, 0, 0),
('Tec', '9', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '15', ') AND c.id IN (', '43', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1606', 268, 268, 0, 0, 0, 0),
('Tec', '10', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '16', ') AND c.id IN (', '48', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1608', 328, 332, 4, 4, 0, 0),
('Tec', '11', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '17', ') AND c.id IN (', '56', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1612', 440, 440, 0, 0, 0, 0),
('Tec', '6', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '12', ') AND c.id IN (', '28', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1553', 128, 128, 3, 0, 0, 0),
('Tec', '7', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '13', ') AND c.id IN (', '32', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1556', 224, 224, 9, 0, 0, 0),
('Tec', '8', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '14', ') AND c.id IN (', '38', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1559', 328, 328, 19, 0, 0, 0),
('Social', '9', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '15', ') AND c.id IN (', '45', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1605', 268, 268, 28, 0, 0, 0),
('Social', '10', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '16', ') AND c.id IN (', '49', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1608', 328, 332, 24, 0, 0, 0),
('Social', '11', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '17', ') AND c.id IN (', '53', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1611', 440, 440, 29, 0, 0, 0),
('Social', '6', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '12', ') AND c.id IN (', '30', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1553', 128, 128, 6, 0, 0, 0),
('Social', '7', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '13', ') AND c.id IN (', '34', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1556', 224, 224, 4, 0, 0, 0),
('Social', '8', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '14', ') AND c.id IN (', '37', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1558', 328, 328, 6, 0, 0, 0),
('Hum_Esp', '1', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '4', ') AND c.id IN (', '80', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1538', 16, 16, 0, 0, 0, 0),
('Hum_Esp', '2', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '5', ') AND c.id IN (', '82', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1540', 36, 36, 0, 0, 0, 0),
('Hum_Esp', '3', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '6', ') AND c.id IN (', '84', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1542', 80, 80, 0, 0, 0, 0),
('Hum_Esp', '4', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '8', ') AND c.id IN (', '86', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1544', 64, 64, 0, 0, 0, 0),
('Hum_Esp', '5', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '9', ') AND c.id IN (', '88', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1547', 140, 140, 0, 0, 0, 0),
('Hum_Esp', 'Ciclo III', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4/8PM5dnuqffW72CfepKlCc3MPQWBcFitxKNAwD3NYJWkxutHYh7AO2l4iZO+DroYp2sJ09xA1uomOJDE5SH2kHGf/A3BV88iJQUivqN8tNPrOjuxZr/lsRnxSfXRYweREhwTy+dk9djoOT7tAgJEk7KUtaidNs8gBEciTS51RRL5+FQ7wgr9niTYhksX4mekgS+EWxSrFIstCeB23mEdGyeYgZjHiFMOjaPRu/UawV+B3xa6wpzZ4lSJJwNeYkjo=', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '38', ') AND c.id IN (', '157', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0945', 1, 0, 0, 0, 0, 0),
('Hum_Esp', 'Ciclo IV', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4/8PM5dnuqffW72CfepKlCc3MPQWBcFitxKNAwD3NYJWkxutHYh7AO2l4iZO+DroYp2sJ09xA1uomOJDE5SH2kHGf/A3BV88iJQUivqN8tNPrOjuxZr/lsRnxSfXRYweREhwTy+dk9djoOT7tAgJEk7KUtaidNs8gBEciTS51RRL5+FQ7wgr9niTYhksX4mekgS+EWxSrFIstCeB23mEdGyeYgZjHiFMOjaPRu/UawV+B3xa6wpzZ4lSJJwNeYkjo=', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '39', ') AND c.id IN (', '163', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0947', 2, 0, 0, 0, 0, 0),
('Hum_Esp', 'Ciclo V', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4/8PM5dnuqffW72CfepKlCc3MPQWBcFitxKNAwD3NYJWkxutHYh7AO2l4iZO+DroYp2sJ09xA1uomOJDE5SH2kHGf/A3BV88iJQUivqN8tNPrOjuxZr/lsRnxSfXRYweREhwTy+dk9djoOT7tAgJEk7KUtaidNs8gBEciTS51RRL5+FQ7wgr9niTYhksX4mekgS+EWxSrFIstCeB23mEdGyeYgZjHiFMOjaPRu/UawV+B3xa6wpzZ4lSJJwNeYkjo=', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '40', ') AND c.id IN (', '168', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0948', 2, 0, 0, 0, 0, 0),
('Hum_Esp', 'Ciclo VI', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4/8PM5dnuqffW72CfepKlCc3MPQWBcFitxKNAwD3NYJWkxutHYh7AO2l4iZO+DroYp2sJ09xA1uomOJDE5SH2kHGf/A3BV88iJQUivqN8tNPrOjuxZr/lsRnxSfXRYweREhwTy+dk9djoOT7tAgJEk7KUtaidNs8gBEciTS51RRL5+FQ7wgr9niTYhksX4mekgS+EWxSrFIstCeB23mEdGyeYgZjHiFMOjaPRu/UawV+B3xa6wpzZ4lSJJwNeYkjo=', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '41', ') AND c.id IN (', '174', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0950', 0, 0, 0, 0, 0, 0),
('Hum_Ing', '1', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '4', ') AND c.id IN (', '79', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1538', 16, 16, 0, 0, 0, 0),
('Hum_Ing', '2', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '5', ') AND c.id IN (', '81', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1540', 36, 36, 0, 0, 0, 0),
('Hum_Ing', '3', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '6', ') AND c.id IN (', '83', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1542', 80, 80, 0, 0, 0, 0),
('Hum_Ing', '4', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '8', ') AND c.id IN (', '85', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1544', 64, 64, 0, 0, 0, 0);
INSERT INTO tbl_querys_ra (pensamiento, grados, campos1, campos2, campos3, tablas, condicion1, condicion2, condicion3, condicion4, condicion5, orden, actualizado, seleccionados, insertados_tem, actualizados, nuevos, procesar, est_nue_no_reg) VALUES
('Hum_Ing', '5', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '9', ') AND c.id IN (', '87', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1547', 140, 140, 0, 0, 0, 0),
('Bio', '1', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '4', ') AND c.id IN (', '3', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1537', 16, 16, 0, 0, 0, 0),
('Bio', '2', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '5', ') AND c.id IN (', '7', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1540', 36, 36, 0, 0, 0, 0),
('Bio', '3', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '6', ') AND c.id IN (', '17', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1541', 80, 80, 0, 0, 0, 0),
('Bio', '4', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '8', ') AND c.id IN (', '18', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1544', 64, 64, 0, 0, 0, 0),
('Bio', '5', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '9', ') AND c.id IN (', '25', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1547', 140, 140, 0, 0, 0, 0),
('Bio', 'Ciclo III', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '38', ') AND c.id IN (', '159', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0944', 1, 0, 0, 0, 0, 0),
('Bio', 'Ciclo IV', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '39', ') AND c.id IN (', '161', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0946', 16, 0, 0, 0, 0, 0),
('Bio', 'Ciclo V', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4oKpXs06a6eF3IarUjg2o7Dm5Q40glxsQm5nvO+g2Z8l9IpQ0VTcj+x3ZIIR2PzxkEBX/hdffThNPBQ5tnQp4HM0X3rfE95cO93xzK0WUZ0PBTF8fHuYjxA1Ey8Y+ZtkJrE0HeJXH/jXG1JshGc2rcXfVyQ79oJawYTlji4GlxPycjhYzn7HZYL2FJiDfKu5dtpS6lY6NW9JuYNl0RP/pKqHXdaS2hsz7B7VEC3cwNRXiKIpuauxKvRnGrA5auJG5iZ6snpGwMMbXmn22hdcSQDGNVeWGcP4E9RwcdZOTWQT7xGGyQTkc2LiSmbjDS4du8LlBE3A9FyECsmMXor5lK+mZsSyhmGFiUd/rOh633VSVACMCRpC6Lo3cj2oK+rEi7mohAlaACRC/aMTXRFz7BIf/d5mz4Ici/vPR74ZI2FjbwM3YOwZMo7lkOVLS1vzz4X4W8wtm5HrRV4NH54EOfnCagwDoHfYNYiu64ZrNENVK09diGof8tAbQnIlQigago8DiroI0g4n45rrRJ7qqzqykJ9GLeWglkHccIRHN/P3cdvn43hKPC9XIA4e3Y6kI0KJqNCNF6d0BzQMtFo5ZrJpfA6Y1ZX/adEZjc65QPgHcXtGEnagl0f0wUf2hw+J+S58HTDyEGZII+SSGPmgVns=', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '40', ') AND c.id IN (', '171', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0948', 3, 0, 0, 0, 0, 0),
('Bio', 'Ciclo VI', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4oKpXs06a6eF3IarUjg2o7Dm5Q40glxsQm5nvO+g2Z8l9IpQ0VTcj+x3ZIIR2PzxkEBX/hdffThNPBQ5tnQp4HM0X3rfE95cO93xzK0WUZ0PBTF8fHuYjxA1Ey8Y+ZtkJrE0HeJXH/jXG1JshGc2rcXfVyQ79oJawYTlji4GlxPycjhYzn7HZYL2FJiDfKu5dtpS6lY6NW9JuYNl0RP/pKqHXdaS2hsz7B7VEC3cwNRXiKIpuauxKvRnGrA5auJG5iZ6snpGwMMbXmn22hdcSQDGNVeWGcP4E9RwcdZOTWQT7xGGyQTkc2LiSmbjDS4du8LlBE3A9FyECsmMXor5lK+mZsSyhmGFiUd/rOh633VSVACMCRpC6Lo3cj2oK+rEi7mohAlaACRC/aMTXRFz7BIf/d5mz4Ici/vPR74ZI2FjbwM3YOwZMo7lkOVLS1vzz4X4W8wtm5HrRV4NH54EOfnCagwDoHfYNYiu64ZrNENVK09diGof8tAbQnIlQigago8DiroI0g4n45rrRJ7qqzqykJ9GLeWglkHccIRHN/P3cdvn43hKPC9XIA4e3Y6kI0KJqNCNF6d0BzQMtFo5ZrJpfA6Y1ZX/adEZjc65QPgHcXtGEnagl0f0wUf2hw+J+S58HTDyEGZII+SSGPmgVns=', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '41', ') AND c.id IN (', '177', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0950', 1, 0, 0, 0, 0, 0),
('Num', '1', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '4', ') AND c.id IN (', '8', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1538', 16, 16, 0, 0, 0, 0),
('Num', '2', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '5', ') AND c.id IN (', '13', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1540', 36, 36, 0, 0, 0, 0),
('Num', '3', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '6', ') AND c.id IN (', '16', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1543', 80, 80, 0, 0, 0, 0),
('Num', '4', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '8', ') AND c.id IN (', '19', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1546', 64, 64, 0, 0, 0, 0),
('Num', '5', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '9', ') AND c.id IN (', '26', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0938', 141, 140, 0, 0, 0, 1),
('Num', 'Ciclo III', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mTqQxBRxn2G7EHUl3iTEZRgaLLaMxIdoNOrE2LR80JzQBdjtLNFeTCD+oOsj9Iwq5qfYRLCpPqiY8A8kq88TTDelyQILlcQsHPxIa36/SKOoCrPD9RScbW5gGtKmBTGKJ0dwT7z5s0x/rtk5Iab5ohKF1kXdjDG8OW7mSKEOazWMGvU6UUlLBmSfFaDmOYM87xtWYs/gVt84sWRrFcaHZyzORcgOWLdlxFTcWxuHibGtqFBW1sN8r0OOt/OtJOMRADLZ+Ov3NArVApbauAzNpPawcbPQqEEyZNgGA8Eht38IpCz23ddoZbm39Cx86FgYBGE+qeiXDvzWnXrnwbJA5edZOjKa/GmJwfH+35w4dJI7MSdBZHSkoFfmdsAK7IA202KMXp/GxQAHPDpQmp3YGkSk72bv7VXsD+6aF3xTYHxqRdBsnV/6mAUoy3Ymv66D8WLP0cOq6p/k3NhG1sK25KlOJZqwVaJavSE9DY7tCSQz/4TkzBWkJICi54wO3Wd3g==', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '38', ') AND c.id IN (', '155', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0945', 0, 0, 0, 0, 0, 0),
('Num', 'Ciclo IV', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mTqQxBRxn2G7EHUl3iTEZRgaLLaMxIdoNOrE2LR80JzQBdjtLNFeTCD+oOsj9Iwq5qfYRLCpPqiY8A8kq88TTDelyQILlcQsHPxIa36/SKOoCrPD9RScbW5gGtKmBTGKJ0dwT7z5s0x/rtk5Iab5ohKF1kXdjDG8OW7mSKEOazWMGvU6UUlLBmSfFaDmOYM87xtWYs/gVt84sWRrFcaHZyzORcgOWLdlxFTcWxuHibGtqFBW1sN8r0OOt/OtJOMRADLZ+Ov3NArVApbauAzNpPawcbPQqEEyZNgGA8Eht38IpCz23ddoZbm39Cx86FgYBGE+qeiXDvzWnXrnwbJA5edZOjKa/GmJwfH+35w4dJI7MSdBZHSkoFfmdsAK7IA202KMXp/GxQAHPDpQmp3YGkSk72bv7VXsD+6aF3xTYHxqRdBsnV/6mAUoy3Ymv66D8WLP0cOq6p/k3NhG1sK25KlOJZqwVaJavSE9DY7tCSQz/4TkzBWkJICi54wO3Wd3g==', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '39', ') AND c.id IN (', '166', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0947', 0, 0, 0, 0, 0, 0),
('Num', 'Ciclo V', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '40', ') AND c.id IN (', '172', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0949', 6, 0, 0, 0, 0, 0),
('Num', 'Ciclo VI', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '41', ') AND c.id IN (', '178', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0950', 0, 0, 0, 0, 0, 0),
('Tec', '1', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '4', ') AND c.id IN (', '2', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1539', 16, 16, 0, 0, 0, 0),
('Tec', '2', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '5', ') AND c.id IN (', '4', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1541', 36, 36, 0, 0, 0, 0),
('Tec', '3', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '6', ') AND c.id IN (', '5', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1543', 80, 80, 0, 0, 0, 0),
('Tec', '4', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '8', ') AND c.id IN (', '6', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1546', 64, 64, 0, 0, 0, 0),
('Tec', '5', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '9', ') AND c.id IN (', '22', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1548', 140, 140, 0, 0, 0, 0),
('Tec', 'Ciclo III', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '38', ') AND c.id IN (', '158', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0946', 1, 0, 0, 0, 0, 0),
('Tec', 'Ciclo IV', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '39', ') AND c.id IN (', '165', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0948', 1, 0, 0, 0, 0, 0),
('Tec', 'Ciclo V', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '40', ') AND c.id IN (', '170', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0949', 1, 0, 0, 0, 0, 0),
('Tec', 'Ciclo VI', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '41', ') AND c.id IN (', '176', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0951', 1, 0, 0, 0, 0, 0),
('Social', '1', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '4', ') AND c.id IN (', '10', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1539', 16, 16, 0, 0, 0, 0),
('Social', '2', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '5', ') AND c.id IN (', '11', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1541', 36, 36, 0, 0, 0, 0),
('Social', '3', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '6', ') AND c.id IN (', '15', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1543', 80, 80, 0, 0, 0, 0),
('Social', '4', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '8', ') AND c.id IN (', '20', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1546', 64, 64, 0, 0, 0, 0),
('Social', '5', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '9', ') AND c.id IN (', '24', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251119_1548', 140, 140, 0, 0, 0, 0),
('Social', 'Ciclo III', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '38', ') AND c.id IN (', '160', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0946', 1, 0, 0, 0, 0, 0),
('Social', 'Ciclo IV', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '39', ') AND c.id IN (', '164', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0947', 1, 0, 0, 0, 0, 0),
('Social', 'Ciclo V', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '40', ') AND c.id IN (', '169', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0949', 2, 0, 0, 0, 0, 0);
INSERT INTO tbl_querys_ra (pensamiento, grados, campos1, campos2, campos3, tablas, condicion1, condicion2, condicion3, condicion4, condicion5, orden, actualizado, seleccionados, insertados_tem, actualizados, nuevos, procesar, est_nue_no_reg) VALUES
('Social', 'Ciclo VI', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '41', ') AND c.id IN (', '175', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0951', 0, 0, 0, 0, 0, 0),
('Hum_Esp', 'Ciclo I', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mTqQxBRxn2G7EHUl3iTEZQW5Scd6qo/PK+UlGec4bujeqAXLGeMRhFkmo505lHQ65NTMJpfdRuOFYopGxaBN9HYfXXSsiqPHlIc07EPj7696ycnd2Mnsx0CAh84UCMVNvHe6K1DGByHUBAPZCMKg3hiLh5grAEumknWMzvqVAofu1F3RB0WQIk3Eszpcmq6v/QRRvQ+Ag9C1I70jN1h4MS2urfwzHzLh+MSzPCS1kqlRoIK8Lw+8UGz2CgXGzo+cJytiX8qoZouKoxmlT3kR4+a2g3/dC/nwV4knBmRIfqvYQUCUFqt4lsLrkz7ezmP6B3iXQgxbW+ntK1MEwaTBczxhHp5GCLeuNEom7Ay9Q/Q/sM+h5dFMQ6GBXyJDDgO2oKCGxuqNF5f8mfmKqoDNuBWJLc59voiyQHhmOUrZZkkO2JTTGwCWZC6cuTlqHrsFTVAQn5IaLn/o2MpUbBPKorhesxvNUz1Q2qZJQsbJRwLoNV1avQUIyy7p2Zfx5LwPOyxKvtffr0oLwZtr4WhnKbDLez1iqbzPgKPrH1EhdZyQeus5g0ZOse4WTp6NWM7RIPe6eMx2aWWwllq6uRYCI1u0iQLZdU+87OrL0Jh+dEw', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '36', ') AND c.id IN (', '143', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20251120_0939', 0, 0, 0, 0, 0, 0),
('Hum_Ing', 'Ciclo I', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mTqQxBRxn2G7EHUl3iTEZQW5Scd6qo/PK+UlGec4bujeqAXLGeMRhFkmo505lHQ65NTMJpfdRuOFYopGxaBN9HYfXXSsiqPHlIc07EPj7696ycnd2Mnsx0CAh84UCMVNvHe6K1DGByHUBAPZCMKg3hiLh5grAEumknWMzvqVAofu1F3RB0WQIk3Eszpcmq6v/QRRvQ+Ag9C1I70jN1h4MS2urfwzHzLh+MSzPCS1kqlRoIK8Lw+8UGz2CgXGzo+cJytiX8qoZouKoxmlT3kR4+a2g3/dC/nwV4knBmRIfqvYQUCUFqt4lsLrkz7ezmP6B3iXQgxbW+ntK1MEwaTBczxhHp5GCLeuNEom7Ay9Q/Q/sM+h5dFMQ6GBXyJDDgO2oKCGxuqNF5f8mfmKqoDNuBWJLc59voiyQHhmOUrZZkkO2JTTGwCWZC6cuTlqHrsFTVAQn5IaLn/o2MpUbBPKorhesxvNUz1Q2qZJQsbJRwLoNV1avQUIyy7p2Zfx5LwPOyxKvtffr0oLwZtr4WhnKbDLez1iqbzPgKPrH1EhdZyQeus5g0ZOse4WTp6NWM7RIPe6eMx2aWWwllq6uRYCI1u0iQLZdU+87OrL0Jh+dEw', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '36', ') AND c.id IN (', '144', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20251120_0940', 0, 0, 0, 0, 0, 0),
('Hum_Esp', 'Ciclo II', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mTqQxBRxn2G7EHUl3iTEZQW5Scd6qo/PK+UlGec4bujeqAXLGeMRhFkmo505lHQ65NTMJpfdRuOFYopGxaBN9HYfXXSsiqPHlIc07EPj7696ycnd2Mnsx0CAh84UCMVNvHe6K1DGByHUBAPZCMKg3hiLh5grAEumknWMzvqVAofu1F3RB0WQIk3Eszpcmq6v/QRRvQ+Ag9C1I70jN1h4MS2urfwzHzLh+MSzPCS1kqlRoIK8Lw+8UGz2CgXGzo+cJytiX8qoZouKoxmlT3kR4+a2g3/dC/nwV4knBmRIfqvYQUCUFqt4lsLrkz7ezmP6B3iXQgxbW+ntK1MEwaTBczxhHp5GCLeuNEom7Ay9Q/Q/sM+h5dFMQ6GBXyJDDgO2oKCGxuqNF5f8mfmKqoDNuBWJLc59voiyQHhmOUrZZkkO2JTTGwCWZC6cuTlqHrsFTVAQn5IaLn/o2MpUbBPKorhesxvNUz1Q2qZJQsbJRwLoNV1avQUIyy7p2Zfx5LwPOyxKvtffr0oLwZtr4WhnKbDLez1iqbzPgKPrH1EhdZyQeus5g0ZOse4WTp6NWM7RIPe6eMx2aWWwllq6uRYCI1u0iQLZdU+87OrL0Jh+dEw', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '37', ') AND c.id IN (', '154', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20251120_0941', 1, 0, 0, 0, 0, 0),
('Hum_Ing', 'Ciclo II', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mTqQxBRxn2G7EHUl3iTEZQW5Scd6qo/PK+UlGec4bujeqAXLGeMRhFkmo505lHQ65NTMJpfdRuOFYopGxaBN9HYfXXSsiqPHlIc07EPj7696ycnd2Mnsx0CAh84UCMVNvHe6K1DGByHUBAPZCMKg3hiLh5grAEumknWMzvqVAofu1F3RB0WQIk3Eszpcmq6v/QRRvQ+Ag9C1I70jN1h4MS2urfwzHzLh+MSzPCS1kqlRoIK8Lw+8UGz2CgXGzo+cJytiX8qoZouKoxmlT3kR4+a2g3/dC/nwV4knBmRIfqvYQUCUFqt4lsLrkz7ezmP6B3iXQgxbW+ntK1MEwaTBczxhHp5GCLeuNEom7Ay9Q/Q/sM+h5dFMQ6GBXyJDDgO2oKCGxuqNF5f8mfmKqoDNuBWJLc59voiyQHhmOUrZZkkO2JTTGwCWZC6cuTlqHrsFTVAQn5IaLn/o2MpUbBPKorhesxvNUz1Q2qZJQsbJRwLoNV1avQUIyy7p2Zfx5LwPOyxKvtffr0oLwZtr4WhnKbDLez1iqbzPgKPrH1EhdZyQeus5g0ZOse4WTp6NWM7RIPe6eMx2aWWwllq6uRYCI1u0iQLZdU+87OrL0Jh+dEw', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '37', ') AND c.id IN (', '153', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20251120_0941', 0, 0, 0, 0, 0, 0),
('Bio', 'Ciclo I', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '36', ') AND c.id IN (', '147', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20251120_0939', 0, 0, 0, 0, 0, 0),
('Bio', 'Ciclo II', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '37', ') AND c.id IN (', '152', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20251120_0941', 4, 0, 0, 0, 0, 0),
('Num', 'Ciclo I', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mTqQxBRxn2G7EHUl3iTEZRgaLLaMxIdoNOrE2LR80JzQBdjtLNFeTCD+oOsj9Iwq5qfYRLCpPqiY8A8kq88TTDelyQILlcQsHPxIa36/SKOoCrPD9RScbW5gGtKmBTGKJ0dwT7z5s0x/rtk5Iab5ohKF1kXdjDG8OW7mSKEOazWMGvU6UUlLBmSfFaDmOYM87xtWYs/gVt84sWRrFcaHZyzORcgOWLdlxFTcWxuHibGtqFBW1sN8r0OOt/OtJOMRADLZ+Ov3NArVApbauAzNpPawcbPQqEEyZNgGA8Eht38IpCz23ddoZbm39Cx86FgYBGE+qeiXDvzWnXrnwbJA5edZOjKa/GmJwfH+35w4dJI7MSdBZHSkoFfmdsAK7IA202KMXp/GxQAHPDpQmp3YGkSk72bv7VXsD+6aF3xTYHxqRdBsnV/6mAUoy3Ymv66D8WLP0cOq6p/k3NhG1sK25KlOJZqwVaJavSE9DY7tCSQz/4TkzBWkJICi54wO3Wd3g==', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '36', ') AND c.id IN (', '148', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20251120_0940', 0, 0, 0, 0, 0, 0),
('Num', 'Ciclo II', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mTqQxBRxn2G7EHUl3iTEZRgaLLaMxIdoNOrE2LR80JzQBdjtLNFeTCD+oOsj9Iwq5qfYRLCpPqiY8A8kq88TTDelyQILlcQsHPxIa36/SKOoCrPD9RScbW5gGtKmBTGKJ0dwT7z5s0x/rtk5Iab5ohKF1kXdjDG8OW7mSKEOazWMGvU6UUlLBmSfFaDmOYM87xtWYs/gVt84sWRrFcaHZyzORcgOWLdlxFTcWxuHibGtqFBW1sN8r0OOt/OtJOMRADLZ+Ov3NArVApbauAzNpPawcbPQqEEyZNgGA8Eht38IpCz23ddoZbm39Cx86FgYBGE+qeiXDvzWnXrnwbJA5edZOjKa/GmJwfH+35w4dJI7MSdBZHSkoFfmdsAK7IA202KMXp/GxQAHPDpQmp3YGkSk72bv7VXsD+6aF3xTYHxqRdBsnV/6mAUoy3Ymv66D8WLP0cOq6p/k3NhG1sK25KlOJZqwVaJavSE9DY7tCSQz/4TkzBWkJICi54wO3Wd3g==', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '37', ') AND c.id IN (', '149', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20251120_0943', 0, 0, 0, 0, 0, 0),
('Tec', 'Ciclo I', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '36', ') AND c.id IN (', '145', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20251120_0940', 0, 0, 0, 0, 0, 0),
('Tec', 'Ciclo II', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '37', ') AND c.id IN (', '150', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20251120_0944', 0, 0, 0, 0, 0, 0),
('Social', 'Ciclo I', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '36', ') AND c.id IN (', '146', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20251120_0940', 0, 0, 0, 0, 0, 0),
('Social', 'Ciclo II', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4M+4tThbvajDFHz+N+6PDwEdSjc4jlsvR912QnjmXt29jelNstDZFHL4TOLygqRGNKwGcdrjXrJ85S8Yq/DCkVHGC2k1jfoZBO0BSkih5VdLN9K+b12RWlH2zT/K8rBiRpsTmEvE0bP81vIbzvLEvk', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '37', ') AND c.id IN (', '151', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7GWnsFrH7URyLruhUojkRse/oVokkgGh++dv/LJbOa+Aj/YFetlNyRSbKutOEHBHhA==', '20251120_0944', 1, 0, 0, 0, 0, 0),
('Hum_Ing', 'Ciclo III', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4/8PM5dnuqffW72CfepKlCc3MPQWBcFitxKNAwD3NYJWkxutHYh7AO2l4iZO+DroYp2sJ09xA1uomOJDE5SH2kHGf/A3BV88iJQUivqN8tNPrOjuxZr/lsRnxSfXRYweREhwTy+dk9djoOT7tAgJEk7KUtaidNs8gBEciTS51RRL5+FQ7wgr9niTYhksX4mekgS+EWxSrFIstCeB23mEdGyeYgZjHiFMOjaPRu/UawV+B3xa6wpzZ4lSJJwNeYkjo=', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '38', ') AND c.id IN (', '156', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0945', 0, 0, 0, 0, 0, 0),
('Hum_Ing', 'Ciclo IV', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4/8PM5dnuqffW72CfepKlCc3MPQWBcFitxKNAwD3NYJWkxutHYh7AO2l4iZO+DroYp2sJ09xA1uomOJDE5SH2kHGf/A3BV88iJQUivqN8tNPrOjuxZr/lsRnxSfXRYweREhwTy+dk9djoOT7tAgJEk7KUtaidNs8gBEciTS51RRL5+FQ7wgr9niTYhksX4mekgS+EWxSrFIstCeB23mEdGyeYgZjHiFMOjaPRu/UawV+B3xa6wpzZ4lSJJwNeYkjo=', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '39', ') AND c.id IN (', '162', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0947', 0, 0, 0, 0, 0, 0),
('Hum_Ing', 'Ciclo V', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4/8PM5dnuqffW72CfepKlCc3MPQWBcFitxKNAwD3NYJWkxutHYh7AO2l4iZO+DroYp2sJ09xA1uomOJDE5SH2kHGf/A3BV88iJQUivqN8tNPrOjuxZr/lsRnxSfXRYweREhwTy+dk9djoOT7tAgJEk7KUtaidNs8gBEciTS51RRL5+FQ7wgr9niTYhksX4mekgS+EWxSrFIstCeB23mEdGyeYgZjHiFMOjaPRu/UawV+B3xa6wpzZ4lSJJwNeYkjo=', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '40', ') AND c.id IN (', '167', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0948', 0, 0, 0, 0, 0, 0),
('Hum_Ing', 'Ciclo VI', 'WV/8nnlUkHpylASPyRsq0mnGr90fD7T3+oj6T8v1igHqDgAJrL7ztpYGh/BSR9Fe7CMWTGs1B+uILls2GFdE4mUjWPoXaQuYwL8kkihJ1NS7sqtlkQTtPPT6QRmJdZazs3TNJiY1X+B5RU4Ne5VcC4UnCWTUipKXJRFY08o5lXwmY4nIImRb+hsT9cpBRWh8BEA/+AXJXuDnIyeqOj2fJtuOa6zQasLjJvJ6t3ysTqNoW/I7e9d3650sD/WsBu8LzQLqpb0HcEnjeCmJxGrXQSRPH+lZXf7Nw8UDQnil9F4/8PM5dnuqffW72CfepKlCc3MPQWBcFitxKNAwD3NYJWkxutHYh7AO2l4iZO+DroYp2sJ09xA1uomOJDE5SH2kHGf/A3BV88iJQUivqN8tNPrOjuxZr/lsRnxSfXRYweREhwTy+dk9djoOT7tAgJEk7KUtaidNs8gBEciTS51RRL5+FQ7wgr9niTYhksX4mekgS+EWxSrFIstCeB23mEdGyeYgZjHiFMOjaPRu/UawV+B3xa6wpzZ4lSJJwNeYkjo=', '', '', 'tusBBtALtludCvQ9r9WrYq3eFS8At+k1hw/8bVAe0usTNKwVVfleqeupeUNF36YKlPKzLzxwaivSQjXuY0J6LJO1woOoXU4fy9YBV3pUHfQvWhnx8KG70FPzqlfPA8GzzhIZ9tXxKGiZf92hyYBIFZDGjY131TU19/EN4680Wy5XG0MR7q6YWRVa+T2xbun1Esvkuaq7glniQXRquBLhRw==', 'WHERE u.id = ra.userid AND ra.contextid = ct.id AND ra.roleid = r.id AND ct.instanceid = c.id AND c.category = cc.id AND gi.courseid = c.id AND gi.id = gg.itemid AND gg.userid = u.id AND ct.contextlevel = 50 AND ra.roleid = 5 AND cc.id IN (', '41', ') AND c.id IN (', '173', 'UXFOzGfHKtZ0AiHOEHGKYgieVUnlyshLSPxaFyR/VMejnSRN186QAWOYaWyrEKgIABnLcSr9wluLX6M2paqOLXA3t5tAyJ/lF/GCcjaJW+mZe2WYdHoSSDXQ7sZoUnuUHvd/ViiPd2hWu7rqhZz9fwB8IpcifYs64wjYglKnfaTsS2vWqbiY4r48YYqur79yCNBL1VZX84wJWkU67X41Lw==', 'DDSv1vxs0yqVg6+v1IjN7B+fFoIlt/SkjbPOjm5RYz7N30MXzJzwunG1jb31OvdHsHS0APdc8472qE3tXvi6QQ==', '20251120_0950', 0, 0, 0, 0, 0, 0);

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_solicitudes_matricula;

CREATE TABLE tbl_solicitudes_matricula (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_est int(11) DEFAULT NULL,
  msg varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  sentencia varchar(1200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_asistencias;

CREATE TABLE tbl_asistencias (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  n_documento varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  nombre varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  grado int(2) NOT NULL,
  nombre_a varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  celular_a varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  fecha date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_cargos;

CREATE TABLE tbl_cargos (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  cargo varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_cargos (cargo) VALUES
('RECTOR'),
('RECTORA'),
('COORDINADOR ACADEMICO'),
('COORDINADORA ACADEMICA'),
('SECRETARIO ACADEMICO'),
('SECRETARIA ACADEMICA'),
('PSICOLOGO'),
('PSICOLOGA'),
('PSICOLOGO ADMINISTRATIVO'),
('PSICOLOGA ADMINISTRATIVA'),
('CONTADOR'),
('CONTADORA'),
('AUXILIAR CONTABLE'),
('AUXILIAR DE ARCHIVO'),
('TUTOR MEDIADOR'),
('TUTORA MEDIADORA'),
('PRUEBA1.'),
('ASISTENTE DE ADMISIONES'),
('AUXILIAR ADMINISTRATIVA'),
('SOPORTE TECNICO'),
('ASISTENTE ADMINISTRATIVO'),
('TUTOR'),
('DESARROLLADOR WEB'),
('DESARROLLADOR PHP MYSQL');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_carnets;

CREATE TABLE tbl_carnets (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_emp_est int(11) NOT NULL,
  id_grado int(11) NOT NULL,
  tipo varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  ruta varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  ruta_codqr varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  a varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  msg_correo varchar(200) NOT NULL DEFAULT 'NA'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_categorias_blog;

CREATE TABLE tbl_categorias_blog (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  categoria varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_categorias_blog (categoria) VALUES
('CONDECORACIONES'),
('EXPERIENCIAS EXITOSAS'),
('INVESTIGACIÓN GIU'),
('RESULTADOS ESTUDIANTES'),
('MAESTRO INVESTIGADOR');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_cod_pre_matricula;

CREATE TABLE tbl_cod_pre_matricula (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  identificacion varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  periodo_lectivo int(11) NOT NULL,
  codigo varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  email_pre_mat varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_contratos;

CREATE TABLE tbl_contratos (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  n_documento varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  n_contrato varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  ruta varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  ruta_acudiente varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  año int(4) NOT NULL,
  fecha_modificacion date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_control_upd;

CREATE TABLE tbl_control_upd (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  archivo varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  paso varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  resultado varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_ct_preguntas;

CREATE TABLE tbl_ct_preguntas (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_materia int(11) NOT NULL,
  ct_temas int(11) NOT NULL,
  ct_preguntas int(11) NOT NULL,
  incluir varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_ct_preguntas (id_materia, ct_temas, ct_preguntas, incluir) VALUES
(1, 2, 2, 'SI'),
(4, 2, 2, 'SI'),
(5, 10, 2, 'SI'),
(6, 3, 2, 'SI'),
(7, 5, 2, 'SI'),
(9, 5, 2, 'SI'),
(11, 10, 2, 'SI');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_ct_preguntas_f;

CREATE TABLE tbl_ct_preguntas_f (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_grado int(11) NOT NULL,
  id_materia int(11) NOT NULL,
  ct_temas int(11) NOT NULL,
  ct_preguntas int(11) NOT NULL,
  incluir varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_ct_preguntas_f (id_grado, id_materia, ct_temas, ct_preguntas, incluir) VALUES
(2, 1, 5, 2, 'SI'),
(2, 4, 5, 2, 'SI'),
(2, 5, 7, 2, 'SI'),
(2, 6, 5, 2, 'SI'),
(2, 7, 0, 0, 'SI'),
(2, 9, 0, 0, 'SI'),
(3, 1, 5, 2, 'SI'),
(3, 4, 5, 2, 'SI'),
(3, 5, 8, 2, 'SI'),
(3, 6, 5, 2, 'SI'),
(3, 7, 0, 0, 'SI'),
(3, 9, 0, 0, 'SI'),
(4, 1, 5, 2, 'SI'),
(4, 4, 5, 2, 'SI'),
(4, 5, 5, 2, 'SI'),
(4, 6, 5, 2, 'SI'),
(4, 7, 0, 0, 'SI'),
(4, 9, 5, 2, 'SI'),
(5, 1, 5, 2, 'SI'),
(5, 4, 5, 2, 'SI'),
(5, 5, 5, 2, 'SI'),
(5, 6, 5, 2, 'SI'),
(5, 7, 0, 0, 'SI'),
(5, 9, 5, 2, 'SI'),
(6, 1, 5, 2, 'SI'),
(6, 4, 5, 2, 'SI'),
(6, 5, 5, 2, 'SI'),
(6, 6, 5, 2, 'SI'),
(6, 7, 0, 0, 'SI'),
(6, 9, 5, 2, 'SI'),
(7, 1, 5, 2, 'SI'),
(7, 4, 5, 2, 'SI'),
(7, 5, 5, 2, 'SI'),
(7, 6, 5, 2, 'SI'),
(7, 7, 6, 2, 'SI'),
(7, 9, 5, 2, 'SI'),
(8, 1, 5, 2, 'SI'),
(8, 4, 5, 2, 'SI'),
(8, 5, 10, 2, 'SI'),
(8, 6, 5, 2, 'SI'),
(8, 7, 5, 2, 'SI'),
(8, 9, 5, 2, 'SI'),
(9, 1, 5, 2, 'SI'),
(9, 4, 5, 2, 'SI'),
(9, 5, 11, 2, 'SI'),
(9, 6, 5, 2, 'SI'),
(9, 7, 7, 2, 'SI'),
(9, 9, 5, 2, 'SI'),
(10, 1, 5, 2, 'SI'),
(10, 4, 5, 2, 'SI'),
(10, 5, 12, 2, 'SI'),
(10, 6, 5, 2, 'SI'),
(10, 7, 5, 2, 'SI'),
(10, 9, 5, 2, 'SI'),
(11, 1, 5, 2, 'SI'),
(11, 4, 5, 2, 'SI'),
(11, 5, 5, 2, 'SI'),
(11, 6, 5, 2, 'SI'),
(11, 7, 5, 2, 'SI'),
(11, 9, 5, 2, 'SI'),
(11, 11, 5, 2, 'SI'),
(12, 1, 5, 2, 'SI'),
(12, 4, 5, 2, 'SI'),
(12, 5, 5, 2, 'SI'),
(12, 6, 5, 2, 'SI'),
(12, 7, 5, 2, 'SI'),
(12, 9, 5, 2, 'SI'),
(12, 11, 5, 2, 'SI'),
(13, 1, 5, 2, 'SI'),
(13, 4, 5, 2, 'SI'),
(13, 5, 5, 2, 'SI'),
(13, 6, 5, 2, 'SI'),
(13, 7, 5, 2, 'SI'),
(13, 9, 5, 2, 'SI'),
(14, 1, 5, 2, 'SI'),
(14, 4, 5, 2, 'SI'),
(14, 5, 5, 2, 'SI'),
(14, 6, 5, 2, 'SI'),
(14, 7, 5, 2, 'SI'),
(14, 9, 5, 2, 'SI'),
(15, 1, 5, 2, 'SI'),
(15, 4, 5, 2, 'SI'),
(15, 5, 5, 2, 'SI'),
(15, 6, 5, 2, 'SI'),
(15, 7, 5, 2, 'SI'),
(15, 9, 5, 2, 'SI'),
(16, 1, 5, 2, 'SI'),
(16, 4, 5, 2, 'SI'),
(16, 5, 5, 2, 'SI'),
(16, 6, 5, 2, 'SI'),
(16, 7, 5, 2, 'SI'),
(16, 9, 5, 2, 'SI'),
(17, 1, 5, 2, 'SI'),
(17, 4, 5, 2, 'SI'),
(17, 5, 5, 2, 'SI'),
(17, 6, 5, 2, 'SI'),
(17, 7, 5, 2, 'SI'),
(17, 9, 5, 2, 'SI'),
(17, 11, 5, 2, 'SI'),
(18, 1, 5, 2, 'SI'),
(18, 4, 5, 2, 'SI'),
(18, 5, 5, 2, 'SI'),
(18, 6, 5, 2, 'SI'),
(18, 7, 5, 2, 'SI'),
(18, 9, 5, 2, 'SI'),
(18, 11, 5, 2, 'SI');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_dependencias;

CREATE TABLE tbl_dependencias (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  dependencia varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_dependencias (dependencia) VALUES
('ADMINISTRATIVA'),
('ADMISIONES'),
('PENSAMIENTO BIOETICO'),
('PENSAMIENTO HUMANISTICO ESPAÑOL'),
('PENSAMIENTO HUMANISTICO INGLES'),
('PENSAMIENTO NUMERICO'),
('PENSAMIENTO SOCIAL'),
('PENSAMIENTO TECNOLOGICO'),
('RECTORIA'),
('COORDINACION ACADEMICA'),
('FINANCIERA'),
('SOPORTE TECNICO'),
('SISTEMAS');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_deptos;

CREATE TABLE tbl_deptos (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_deptos (nombre) VALUES
(' SELECCIONE');

UPDATE tbl_deptos SET id = -1 WHERE nombre = ' SELECCIONE';

ALTER TABLE tbl_deptos
MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

INSERT INTO tbl_deptos (nombre) VALUES
('AMAZONAS'),
('ANTIOQUIA'),
('ARAUCA'),
('ATLANTICO'),
('BOGOTA'),
('BOLIVAR'),
('BOYACA'),
('CALDAS'),
('CAQUETA'),
('CASANARE'),
('CAUCA'),
('CESAR'),
('CHOCO'),
('CORDOBA'),
('CUNDINAMARCA'),
('GUAINIA'),
('GUAVIARE'),
('HUILA'),
('LA GUAJIRA'),
('MAGDALENA'),
('META'),
('NARINO'),
('NORTE DE SANTANDER'),
('PUTUMAYO'),
('QUINDIO'),
('RISARALDA'),
('SAN ANDRES Y PROVIDENCIA'),
('SANTANDER'),
('SUCRE'),
('TOLIMA'),
('VALLE DEL CAUCA'),
('VAUPES'),
('VICHADA');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_desemp_pres;

CREATE TABLE tbl_desemp_pres (
  identificacion varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  DSA varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  DA varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  DM varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  DB varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  año int(11) NOT NULL,
  id_grado int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_deudas_anteriores;

CREATE TABLE tbl_deudas_anteriores (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  documento varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  a int(11) UNSIGNED NOT NULL,
  deuda int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_diplomas_virtuales;

CREATE TABLE tbl_diplomas_virtuales (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  documento varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_grado int(2) NOT NULL,
  ruta varchar(500)CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_direcciones_grado;

CREATE TABLE tbl_direcciones_grado (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_empleado int(11) NOT NULL,
  direcciones_grado varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_direccion_grado;

CREATE TABLE tbl_direccion_grado (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_grado int(11) NOT NULL,
  id_empleado int(11) NOT NULL,
  grupo varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_dir_b;

CREATE TABLE tbl_dir_b (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_grado int(11) NOT NULL,
  id_empleado int(11) NOT NULL,
  grupo varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_dir_c;

CREATE TABLE tbl_dir_c (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_grado int(11) NOT NULL,
  id_empleado int(11) NOT NULL,
  grupo varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_dir_d;

CREATE TABLE tbl_dir_d (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_grado int(11) NOT NULL,
  id_empleado int(11) NOT NULL,
  grupo varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_emails_bloqueados_blog;

CREATE TABLE tbl_emails_bloqueados_blog (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  email varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  fecha date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_encuestas;

CREATE TABLE tbl_encuestas (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_encuestas_preguntas;

CREATE TABLE tbl_encuestas_preguntas (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_encuesta int(11) NOT NULL,
  tipo varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  pregunta varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  a varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  b varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  c varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  d varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  e varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  respuesta_texto varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_encuestas_resultados;

CREATE TABLE tbl_encuestas_resultados (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_encuesta int(11) NOT NULL,
  id_pregunta int(11) NOT NULL,
  id_grado int(11) NOT NULL,
  n_documento varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  resultado varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  año int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_estudiantes_mood;

CREATE TABLE tbl_estudiantes_mood (
  id int(11) NOT NULL PRIMARY KEY,
  grado varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  apellidos varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  nombres varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  ciudad varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  email_inst varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  usuario varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  a_modif int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_estudiantes_mood_temp;

CREATE TABLE tbl_estudiantes_mood_temp (
  id int(11) NOT NULL PRIMARY KEY,
  grado varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  apellidos varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  nombres varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  ciudad varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  email_inst varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  usuario varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  a_modif int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_estudiantes_observ_tut;

CREATE TABLE tbl_estudiantes_observ_tut (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  n_documento varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  observacion varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  tutor varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  fecha date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_estudiantes_param;

CREATE TABLE tbl_estudiantes_param (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_estudiante int(11) NOT NULL,
  observacion varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_estudiantes_sin_ee;

CREATE TABLE tbl_estudiantes_sin_ee (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  n_documento varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  sin_entrevista varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  sin_evaluacion varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_eval_cargos;

CREATE TABLE tbl_eval_cargos (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_grado int(11) NOT NULL,
  cargo varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  documento varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  fecha_programacion date NOT NULL,
  email varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  nombre_completo varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  resultado varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  año int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_formas_pago;

CREATE TABLE tbl_formas_pago (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  forma_pago varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  activar varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_formas_pago (forma_pago, activar) VALUES
('TC', '0'),
('PSE', '1'),
('BAL', '1'),
('EFE', '1'),
('PUNR', '1'),
('REDS', '1'),
('GANA', '1');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_grupos;

CREATE TABLE tbl_grupos (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  grupo varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_grupos (grupo) VALUES
('Administrativo'),
('Creativo'),
('Investigación'),
('Mediadores'),
('Psicología'),
('Soporte técnico');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_grupos_emp;

CREATE TABLE tbl_grupos_emp (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_grupo int(11) NOT NULL,
  id_empleado int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_lista_documentos;

CREATE TABLE tbl_lista_documentos (
  n_documento varchar(15) NOT NULL PRIMARY KEY
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_metodo_domain;

CREATE TABLE tbl_metodo_domain (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  palabra varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  imagen varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  fecha date NOT NULL,
  estado int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_metodo_domain_i;

CREATE TABLE tbl_metodo_domain_i (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  palabra varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  imagen varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  fecha date NOT NULL,
  estado int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_notas_historia;

CREATE TABLE tbl_notas_historia (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_est int(11) NOT NULL,
  a int(4) NOT NULL,
  n_matricula varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  json varchar(1200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_notas_mood_temp;

CREATE TABLE tbl_notas_mood_temp (
  id_est int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  lastname varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  firstname varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  shortname varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id int(11) NOT NULL,
  name varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_grado int(11) NOT NULL,
  periodo varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  periodo_ra int(11) NOT NULL,
  calificacion float NOT NULL DEFAULT 0,
  id_tutor int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_notas_prueba;

CREATE TABLE tbl_notas_prueba (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nota float NOT NULL DEFAULT 0,
  id_periodo int(11) NOT NULL,
  id_materia int(11) NOT NULL,
  id_grado int(11) NOT NULL,
  id_estudiante int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_notas_temp;

CREATE TABLE tbl_notas_temp (
  nota float NOT NULL DEFAULT 0,
  id_periodo int(11) NOT NULL,
  id_materia int(11) NOT NULL,
  id_grado int(11) NOT NULL,
  id_estudiante int(11) NOT NULL,
  id_tutor int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_notas_temp_ins;

CREATE TABLE tbl_notas_temp_ins (
  id_estudiante int(11) NOT NULL,
  apellidos varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  nombres varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  grado varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  materia varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_periodo int(11) NOT NULL,
  id_materia int(11) NOT NULL,
  id_grado int(11) NOT NULL,
  nota_actual float NOT NULL,
  nota_nueva float NOT NULL,
  id_tutor int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_notas_temp_no_ra;

CREATE TABLE tbl_notas_temp_no_ra (
  id_estudiante int(11) NOT NULL,
  apellidos varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  nombres varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  grado varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  materia varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_periodo int(11) NOT NULL,
  id_materia int(11) NOT NULL,
  id_grado int(11) NOT NULL,
  nota_actual float NOT NULL,
  nota_nueva float NOT NULL,
  id_tutor int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_notas_temp_upd;

CREATE TABLE tbl_notas_temp_upd (
  id_estudiante int(11) NOT NULL,
  apellidos varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  nombres varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  grado varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  materia varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_periodo int(11) NOT NULL,
  id_materia int(11) NOT NULL,
  id_grado int(11) NOT NULL,
  nota_actual float NOT NULL,
  nota_nueva float NOT NULL,
  id_tutor int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_pazysalvos;

CREATE TABLE tbl_pazysalvos (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fecha_expedicion date NOT NULL,
  id_estudiante int(11) NOT NULL,
  id_grado int(11) NOT NULL,
  ruta varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  identificacion varchar(20) NOT NULL,
  a varchar(4) NOT NULL,
  firma varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_plataformas;

CREATE TABLE tbl_plataformas (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  plataforma varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_plataformas (plataforma) VALUES
('CORREO CORPORATIVO'),
('MATRICULACION WEB'),
('MOODLE'),
('PAGINA WEB'),
('REGISTRO ACADEMICO');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_polizas;

CREATE TABLE tbl_polizas (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  n_documento varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_grado int(11) NOT NULL,
  a varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  ruta varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_preguntas;

CREATE TABLE tbl_preguntas (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_grado int(11) NOT NULL,
  id_materia int(11) NOT NULL,
  id_tipo_pregunta int(11) NOT NULL,
  id_tema int(11) NOT NULL,
  pregunta varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  r1ok varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  r2ok varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  r3ok varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  r1no varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  r2no varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  r3no varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  r4no varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  retroalimentacion varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  imagen varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_profesiones;

CREATE TABLE tbl_profesiones (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  profesion varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_profesiones (profesion) VALUES
('ADMINISTRADORA COMERCIAL Y FINANCIERA'),
('AUXILIAR CONTABLE'),
('AUXILIAR DE ARCHIVO'),
('CONTADORA'),
('ESP EN ARCHIVISTICA'),
('ESP EN GERENCIA DE TALENTO HUMANO'),
('ESP EN NECESIDADES DE APRENDIZAJE EN LECTURA, ESCRITURA Y MATEMÁTICAS'),
('INGENIERA AMBIENTAL Y SANITARIA'),
('INGENIERA DE ALIMENTOS'),
('INGENIERA DE MINAS'),
('INGENIERA INDUSTRIAL'),
('INGENIERO INDUSTRIAL'),
('LICENCIADA EN EDUCACIÓN BASICA'),
('LICENCIADA EN IDIOMAS MODERNOS'),
('LICENCIADA EN LENGUAS EXTRANJERAS INGLÉS - FRANCÉS'),
('LICENCIADO EN INFORMÁTICA Y TECNOLOGÍA'),
('MG EN ADMINISTRACIÓN Y PLANIFICACIÓN EDUCATIVA'),
('MG EN AMBIENTES EDUCATIVOS MEDIADOS POR TIC'),
('MG EN DERECHOS HUMANOS'),
('MG EN EDUCACIÓN'),
('MG EN GESTIÓN DE LA TECNOLOGÍA DUCATIVA'),
('MG EN LINGÜÍSTICA'),
('MG EN TECNOLOGÍA EDUCATIVA Y COMPETENCIAS DIGITALES'),
('PSICÓLOGA'),
('PSICÓLOGO CLINICO'),
('PRUEBA'),
('ADMINISTRADORA DE EMPRESAS'),
('ADMINISTRADOR DE EMPRESAS'),
('LICENCIADA EN MATEMATICAS Y ESTADISTICA'),
('NA'),
('AUXILIAR ADMINISTRATIVA'),
('ADMINISTRADORA EN SALUD'),
('PRACTICANTE UNIVERSITARIO');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_seg_psi_cierre;

CREATE TABLE tbl_seg_psi_cierre (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_valoracion int(11) NOT NULL,
  id_psicologo int(11) NOT NULL,
  id_agendamiento int(11) NOT NULL DEFAULT 0,
  observaciones varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  motivo varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  recomendaciones varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  remitido varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  motivo_remision varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  fecha date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_seg_psi_val;

CREATE TABLE tbl_seg_psi_val (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  n_documento varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_psicologo int(11) NOT NULL,
  id_solicita int(11) NOT NULL,
  id_empleado int(11) NOT NULL,
  id_agendamiento int(11) NOT NULL DEFAULT 0,
  piar varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  motivo varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  nivel_biologico varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  nivel_intelectual varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  nivel_motor varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  autonomia varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  nivel_lenguaje varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  nivel_social varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  personalidad varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  nivel_escolar varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  contexto_socio_fam varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  observaciones varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  fecha date NOT NULL,
  fecha_primer_seg date NOT NULL,
  hora varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_sentencias_procesos;

CREATE TABLE tbl_sentencias_procesos (
  id int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  utilizaJoin varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  campos varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  tablas varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  joinTablas varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  condiciones varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  agrupaciones varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  ordenamientos varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  modificaciones varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  condicionesAgrupaciones varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  inserciones varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_sentencias_procesos (nombre, utilizaJoin, campos, tablas, joinTablas, condiciones, agrupaciones, ordenamientos, modificaciones, condicionesAgrupaciones, inserciones) VALUES
('máximo registro en matricula', 'NO', 'SELECT IFNULL(max(m.idmatricula), 0) maxid ', 'FROM tbl_estudiantes e, tbl_matriculas m ', '', 'WHERE e.id = m.id_estudiante AND e.n_documento = |_documento*| ', '', '', '', '', ''),
('grados', 'NO', 'SELECT * ', 'FROM tbl_grados ', '', 'WHERE id > 1 ', '', '', '', '', ''),
('buscar datos iniciales', 'NO', 'SELECT e.acudiente_1, e.email_acudiente_1, e.ciudad, e.telefono_acudiente_1 ', 'FROM tbl_estudiantes e ', '', 'WHERE e.n_documento = |_documento*| ', '', '', '', '', ''),
('se valida que sea antiguo', 'NO', 'SELECT *, (YEAR(NOW()) - YEAR(fecha_ingreso)) diferencia, YEAR(now()) actual ', 'FROM tbl_matriculas ', '', 'WHERE id = _maxid* ', '', '', '', '', ''),
('grado', 'NO', 'SELECT * ', 'FROM tbl_grados ', '', 'WHERE id = _idGrado* ', '', '', '', '', ''),
('datos estudiante0', 'NO', 'SELECT m.estado, m.id_grado, e.nombres, e.apellidos, e.telefono_estudiante, e.email_institucional, e.estado rh, e.acudiente_1, e.email_acudiente_1, e.direccion, e.telefono_acudiente_1, e.documento_responsable, td.id, td.tipo_documento, e.ciudad, e.actividad_extra, e.genero, e.documento_responsable, e.parentesco_acudiente_1 ', 'FROM tbl_estudiantes e, tbl_matriculas m, tbl_tipos_documento td  ', '', 'WHERE e.id = m.id_estudiante AND e.tipo_documento = td.id AND e.n_documento = |_documento*| AND m.id = _maxid* ', '', '', '', '', ''),
('datos entrevista', 'NO', 'SELECT *, ifnull(id, 0) id1 ', 'FROM tbl_entrevistas ', '', 'WHERE documento = |_documento*| ', '', '', '', '', ''),
('datos tbl_pre_matricula', 'NO', 'SELECT *, ifnull(id, 0) id1 ', 'FROM tbl_pre_matriculas ', '', 'WHERE documento_est = |_documento*| AND año < _fanio* ', '', '', '', '', ''),
('datos tbl_pre_matricula1', 'NO', 'SELECT *, ifnull(id, 0) id1 ', 'FROM tbl_pre_matriculas ', '', 'WHERE documento_est = |_documento*| AND año = _fanio* ', '', '', '', '', ''),
('datos tbl_entrevistas', 'NO', 'SELECT * ', 'FROM tbl_entrevistas ', '', 'WHERE documento_est = |_documento*| AND fecha >= |2024-10-07| ', '', '', '', '', ''),
('validar codigo pre tbl_matriculas documento', 'NO', 'SELECT COUNT(1) ct, email_pre_mat ', 'FROM tbl_cod_pre_tbl_matriculas ', '', 'WHERE identificacion = |_documento*| AND codigo = |_codigo*| ', 'GROUP BY email_pre_mat ', '', '', '', ''),
('evaluacion de validacion', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_validaciones ', '', 'WHERE documento_est = |_documento*| AND año = _fanio* ', '', '', '', '', ''),
('grado maximo a validar', 'NO', 'SELECT g.id, g.grado ', 'FROM (SELECT MAX(id_grado) id_grado FROM tbl_validaciones WHERE documento_est = |_documento*| AND fecha_programacion like |%_fanio*%|) v, tbl_grados g ', '', 'WHERE v.id_grado = g.id ', '', '', '', '', ''),
('grado maximo aprobado', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_validaciones ', '', 'WHERE documento_est = |_documento*| AND resultado = |APROBADO| AND id_grado = _max_idgrado* ', '', '', '', '', ''),
('evaluacion presaberes finalizada', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_respuestas ', '', 'WHERE identificacion = |_documento*| AND a = _fanio1* AND estado = |FINALIZADA| ', '', '', '', '', ''),
('valida no entrevista no evaluacion', 'NO', 'SELECT * ', 'FROM tbl_estudiantes_sin_ee ', '', 'WHERE n_documento = |_documento*| ', '', '', '', '', ''),
('rango tbl_matriculas ordinaria', 'NO', 'SELECT f1, f2 ', 'FROM tbl_parametros ', '', 'WHERE parametro = |mat_ordinarias| ', '', '', '', '', ''),
('rango tbl_matriculas extra ordinaria', 'NO', 'SELECT f1, f2 ', 'FROM tbl_parametros ', '', 'WHERE parametro = |mat_extraordinarias| ', '', '', '', '', ''),
('valida estudiante bloqueado', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_estudiantes_bloqueados ', '', 'WHERE n_documento = |_documento*| ', '', '', '', '', ''),
('tipos documento', 'NO', 'SELECT * ', 'FROM tbl_tipos_documento ', '', '', '', '', '', '', ''),
('medios llegada', 'NO', 'SELECT * ', 'FROM tbl_medios_llegada ', '', '', '', '', '', '', ''),
('update tbl_pre_matricula', 'NO', '', 'UPDATE tbl_pre_matriculas ', '', 'WHERE documento_est = |_documento*| AND año = _añoMatricula* ', '', '', 'SET id_grado = _idGrado*, nombres_est = |_nombres*|, apellidos_est = |_apellidos*|, fecha = |_fecha2*|, actividad_extra = |_extra*|,  nombre_a = |_nombreA*|, celular_a = |_celA*|, email_a = |_emailA*|, ciudad_a = |_ciudadA*|, id_medio = _medio* ', '', ''),
('insert tbl_pre_matricula', 'NO', '', 'INSERT INTO tbl_pre_matriculas ', '', '', '', '', '', '', '(id_empleado, id_grado, documento_est, nombres_est, apellidos_est, fecha, actividad_extra, nombre_a, celular_a, email_a, ciudad_a, entrevista, eval, id_medio, año) VALUES (18, _idGrado*, |_documento*|, |_nombres*|, |_apellidos*|, |_fecha2*|, |_extra*|, |_nombreA*|, |_celA*|, |_emailA*|, |_ciudadA*|, |NO|, 0, _medio*, _añoMatricula*) '),
('existe registro en tbl_pre_matricula', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_pre_matriculas ', '', 'WHERE documento_est = |_documento*| AND año = _añoMatricula* ', '', '', '', '', ''),
('existe registro en estudiantes', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_estudiantes ', '', 'WHERE n_documento = |_documento*| ', '', '', '', '', ''),
('UPDATE tbl_estudiantes', 'NO', '', 'UPDATE tbl_estudiantes ', '', 'WHERE n_documento = |_documento*| ', '', '', 'SET apellidos = |_apellidos*|, nombres = |_nombres*|, genero = |_genero*|, tipo_documento = _tdoc*, telefono_estudiante = |_telefonoE*|, actividad_extra = |_extra*|, email_acudiente_1 = |_emailA*|, acudiente_1 = |_nombreA*|, telefono_acudiente_1 = |_celA*|, parentesco_acudiente_1 = |_parentesco1*|, fecha_datos = |_fecha2*|, documento_responsable = |_documentoA*|, ciudad = |_ciudadA*|, a_tbl_matriculas = _añoMatricula* ', '', ''),
('insert estudiantes', 'NO', '', 'INSERT INTO tbl_estudiantes ', '', '', '', '', '', '', '(apellidos, nombres, genero, tipo_documento, n_documento, ciudad, telefono_estudiante, actividad_extra, email_acudiente_1, acudiente_1, telefono_acudiente_1, parentesco_acudiente_1, fecha_datos, documento_responsable, a_matricula) VALUES (|_apellidos*|, |_nombres*|, |_genero*|, _tdoc*, |_documento*|, |_ciudadA*|, |_telefonoE*|, |_extra*|, |_emailA*|, |_nombreA*|, |_celA*|, |_parentesco1*|, |_fecha2*|, |_documentoA*|, _añoMatricula*) '),
('consulta directorio', 'NO', 'SELECT e.id, e.nombres, e.apellidos, e.dependencia, e.email, e.celular, e.cargo, IFNULL(e.infografia, \'\') infografia, \r\nCASE e.perfil WHEN \'TU\' THEN \'SI\' WHEN \'SU\' THEN \'SI\' WHEN \'TU_AW\' THEN \'SI\' WHEN \'ST_PU\' THEN \'SI\' \r\nWHEN \'AR\' THEN \'SI\' WHEN \'FI\' THEN \'SI\' WHEN \'PS\' THEN \'SI\' ELSE \'NO\' END perfil ', 'FROM tbl_empleados e ', '', 'WHERE e.estado = |_activo*| AND e.id != 18 ', '', 'ORDER BY e.id ASC ', '', '', ''),
('grado estudiante', 'NO', 'SELECT id_grado ', 'FROM tbl_matriculas ', '', 'WHERE id = (SELECT MAX(idMatricula) idmax FROM tbl_matriculas WHERE id_estudiante = (SELECT id FROM tbl_estudiantes WHERE n_documento = |_ndoc*|))', '', '', '', '', ''),
('incrementos convenio pago', 'NO', 'SELECT * ', 'FROM tbl_cp ', '', 'WHERE convenio = |_convenio*| ', '', '', '', '', ''),
('valor pago icfes', 'NO', 'SELECT * ', 'FROM _tabla* ', '', 'WHERE id_grado = 0 AND a = _a* ', '', '', '', '', ''),
('valor pago', 'NO', 'SELECT * ', 'FROM _tabla* ', '', 'WHERE id_grado = _idgrado* AND a = _a* ', '', '', '', '', ''),
('incrementos pse', 'NO', 'SELECT * ', 'FROM tbl_incrementos ', '', 'WHERE tipo = |_PSE*| ', '', '', '', '', ''),
('incrementos', 'NO', 'SELECT * ', 'FROM tbl_incrementos ', '', 'WHERE tipo = |_tipo*| ', '', '', '', '', ''),
('valor gateway', 'NO', 'SELECT ifnull(val_fijo_gateway, 0) val_gateway, ct_actual ', 'FROM tbl_gateway ', '', 'WHERE estado = |_estado*| AND id_convenio = (SELECT id FROM tbl_cp WHERE convenio = |_convenio*|) ', '', '', '', '', ''),
('validacion presaberes', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_respuestas ', '', 'WHERE identificacion = |_documento*| AND respuesta = |_NA*| AND a = _fanio* ', '', '', '', '', ''),
('valida ct preguntas abiertas', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_respuestas ', '', 'WHERE identificacion = |_documento*| AND a = _fanio* AND estado = |_estado*| ', '', '', '', '', ''),
('valida ct preguntas cargadas', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_respuestas ', '', 'WHERE identificacion = |_documento*| AND a = _fanio* ', '', '', '', '', ''),
('valida preguntas grado sm', 'NO', 'SELECT g.id, g.grado, e.origen ', 'FROM tbl_estudiantes_eval_admision e, tbl_grados g ', '', 'WHERE e.id_grado = g.id AND e.n_documento = |_documento*| ', '', '', '', '', ''),
('valida ct preguntas grado', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_preguntas ', '', 'WHERE id_grado = _idgra* ', '', '', '', '', ''),
('consulta pregunta', 'NO', 'SELECT * ', 'FROM tbl_preguntas ', '', 'WHERE id = _idpreg* ', '', '', '', '', ''),
('nombre y grado presaberes', 'NO', 'SELECT e.*, g.grado ', 'FROM tbl_estudiantes_eval_admision e, tbl_grados g ', '', 'WHERE e.id_grado = g.id AND e.n_documento = |_documento*| ', '', '', '', '', ''),
('temas pensamiento bio', 'NO', 'SELECT DISTINCT tp.id, tp.tema ', 'FROM tbl_preguntas p, tbl_temas_preguntas tp ', '', 'WHERE p.id_tema = tp.id AND p.id_grado = _idgrado* AND p.id_materia = _idmateria* ', '', '', '', '', ''),
('preguntas por tema bio', 'NO', 'SELECT id ', 'FROM tbl_preguntas ', '', 'WHERE id_tema = _idtema* AND id_grado = _idgrado* AND id_materia = _idmateria* ', '', '', '', '', ''),
('ct preguntas por tema bio', 'NO', 'SELECT ct_preguntas ', 'FROM tbl_temas_preguntas ', '', 'WHERE id_grado = _idgrado* AND id_materia = _idmateria* AND id = _id* ', '', '', '', '', ''),
('temas pensamiento soc', 'NO', 'SELECT DISTINCT tp.id, tp.tema ', 'FROM tbl_preguntas p, tbl_temas_preguntas tp ', '', 'WHERE p.id_tema = tp.id AND p.id_grado = _idgrado* AND p.id_materia = _idmateria* ', '', '', '', '', ''),
('preguntas por tema soc', 'NO', 'SELECT id ', 'FROM tbl_preguntas ', '', 'WHERE id_tema = _idtema* AND id_grado = _idgrado* AND id_materia = _idmateria* ', '', '', '', '', ''),
('ct preguntas por tema soc', 'NO', 'SELECT ct_preguntas ', 'FROM tbl_temas_preguntas ', '', 'WHERE id_grado = _idgrado* AND id_materia = _idmateria* AND id = _id* ', '', '', '', '', ''),
('temas pensamiento num', 'NO', 'SELECT DISTINCT tp.id, tp.tema ', 'FROM tbl_preguntas p, tbl_temas_preguntas tp ', '', 'WHERE p.id_tema = tp.id AND p.id_grado = _idgrado* AND p.id_materia = _idmateria* ', '', '', '', '', ''),
('preguntas por tema num', 'NO', 'SELECT id ', 'FROM tbl_preguntas ', '', 'WHERE id_tema = _idtema* AND id_grado = _idgrado* AND id_materia = _idmateria* ', '', '', '', '', ''),
('ct preguntas por tema num', 'NO', 'SELECT ct_preguntas ', 'FROM tbl_temas_preguntas ', '', 'WHERE id_grado = _idgrado* AND id_materia = _idmateria* AND id = _id* ', '', '', '', '', ''),
('temas pensamiento esp', 'NO', 'SELECT DISTINCT tp.id, tp.tema ', 'FROM tbl_preguntas p, tbl_temas_preguntas tp ', '', 'WHERE p.id_tema = tp.id AND p.id_grado = _idgrado* AND p.id_materia = _idmateria* ', '', '', '', '', ''),
('preguntas por tema esp', 'NO', 'SELECT id ', 'FROM tbl_preguntas ', '', 'WHERE id_tema = _idtema* AND id_grado = _idgrado* AND id_materia = _idmateria* ', '', '', '', '', ''),
('ct preguntas por tema esp', 'NO', 'SELECT ct_preguntas ', 'FROM tbl_temas_preguntas ', '', 'WHERE id_grado = _idgrado* AND id_materia = _idmateria* AND id = _id* ', '', '', '', '', ''),
('temas pensamiento ing', 'NO', 'SELECT DISTINCT tp.id, tp.tema ', 'FROM tbl_preguntas p, tbl_temas_preguntas tp ', '', 'WHERE p.id_tema = tp.id AND p.id_grado = _idgrado* AND p.id_materia = _idmateria* ', '', '', '', '', ''),
('preguntas por tema ing', 'NO', 'SELECT id ', 'FROM tbl_preguntas ', '', 'WHERE id_tema = _idtema* AND id_grado = _idgrado* AND id_materia = _idmateria* ', '', '', '', '', ''),
('ct preguntas por tema ing', 'NO', 'SELECT ct_preguntas ', 'FROM tbl_temas_preguntas ', '', 'WHERE id_grado = _idgrado* AND id_materia = _idmateria* AND id = _id* ', '', '', '', '', ''),
('temas pensamiento tec', 'NO', 'SELECT DISTINCT tp.id, tp.tema ', 'FROM tbl_preguntas p, tbl_temas_preguntas tp ', '', 'WHERE p.id_tema = tp.id AND p.id_grado = _idgrado* AND p.id_materia = _idmateria* ', '', '', '', '', ''),
('preguntas por tema tec', 'NO', 'SELECT id ', 'FROM tbl_preguntas ', '', 'WHERE id_tema = _idtema* AND id_grado = _idgrado* AND id_materia = _idmateria* ', '', '', '', '', ''),
('ct preguntas por tema tec', 'NO', 'SELECT ct_preguntas ', 'FROM tbl_temas_preguntas ', '', 'WHERE id_grado = _idgrado* AND id_materia = _idmateria* AND id = _id* ', '', '', '', '', ''),
('temas pensamiento fis', 'NO', 'SELECT DISTINCT tp.id, tp.tema ', 'FROM tbl_preguntas p, tbl_temas_preguntas tp ', '', 'WHERE p.id_tema = tp.id AND p.id_grado = _idgrado* AND p.id_materia = _idmateria* ', '', '', '', '', ''),
('preguntas por tema fis', 'NO', 'SELECT id ', 'FROM tbl_preguntas ', '', 'WHERE id_tema = _idtema* AND id_grado = _idgrado* AND id_materia = _idmateria* ', '', '', '', '', ''),
('ct preguntas por tema fis', 'NO', 'SELECT ct_preguntas ', 'FROM tbl_temas_preguntas ', '', 'WHERE id_grado = _idgrado* AND id_materia = _idmateria* AND id = _id* ', '', '', '', '', ''),
('conteos ok', 'NO', 'SELECT COUNT(1) ct_ok, identificacion ', 'FROM tbl_respuestas ', '', 'WHERE resultado = |_resultado*| AND identificacion = |_documento*| AND a = _a* ', 'GROUP BY identificacion ', '', '', '', ''),
('conteos no', 'NO', 'SELECT COUNT(1) ct_no, identificacion ', 'FROM tbl_respuestas ', '', 'WHERE resultado = |_resultado*| AND identificacion = |_documento*| AND a = _a* ', 'GROUP BY identificacion ', '', '', '', ''),
('conteos na', 'NO', 'SELECT COUNT(1) ct_na, identificacion ', 'FROM tbl_respuestas ', '', 'WHERE resultado = |_resultado*| AND identificacion = |_documento*| AND a = _a* ', 'GROUP BY identificacion ', '', '', '', ''),
('valida si hay registros en tbl_respuestas', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_respuestas ', '', 'WHERE identificacion = |_documento*| AND a = _a* ', '', '', '', '', ''),
('consulta pensamiento', 'NO', 'SELECT id_materia ', 'FROM tbl_preguntas ', '', 'WHERE id = _id* ', '', '', '', '', ''),
('insert tbl_respuestas', 'NO', '', 'INSERT INTO tbl_respuestas ', '', '', '', '', '', '', '(id_grado, id_materia, id_pregunta, a, identificacion, respuesta, resultado, estado) VALUES (_idgrado*, _idpen*, _idpregunta*, _a*, |_documento*|, |_respuesta*|, |_resultado*|, |_estado*|)'),
('valida respuestas na', 'NO', 'SELECT * ', 'FROM tbl_respuestas ', '', 'WHERE resultado = |_resultado*| AND identificacion = |_documento*| AND a = _a* ', '', '', '', '', ''),
('actualizar respuesta presaberes', 'NO', '', 'UPDATE tbl_respuestas ', '', 'WHERE id_pregunta = _idpreg* AND identificacion = |_documento*| AND a = _a* ', '', '', 'SET respuesta = |_respuesta*|, resultado = |_resultado*| ', '', ''),
('nombre estudiante', 'NO', 'SELECT e.id, e.nombres, e.apellidos ', 'FROM tbl_estudiantes e ', '', 'WHERE e.n_documento = |_documento*| ', '', '', '', '', ''),
('conteos no num', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_respuestas r, tbl_preguntas p ', '', 'WHERE r.id_pregunta = p.id AND r.resultado = |_resultado*| AND r.identificacion = |_documento*| AND r.a = _a* AND r.id_materia = 5 ', '', '', '', '', ''),
('conteos no bio', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_respuestas r, tbl_preguntas p ', '', 'WHERE r.id_pregunta = p.id AND r.resultado = |_resultado*| AND r.identificacion = |_documento*| AND r.a = _a* AND r.id_materia = 1 ', '', '', '', '', ''),
('conteos no soc', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_respuestas r, tbl_preguntas p ', '', 'WHERE r.id_pregunta = p.id AND r.resultado = |_resultado*| AND r.identificacion = |_documento*| AND r.a = _a* AND r.id_materia = 4 ', '', '', '', '', ''),
('conteos no esp', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_respuestas r, tbl_preguntas p ', '', 'WHERE r.id_pregunta = p.id AND r.resultado = |_resultado*| AND r.identificacion = |_documento*| AND r.a = _a* AND r.id_materia = 6 ', '', '', '', '', ''),
('conteos no ing', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_respuestas r, tbl_preguntas p ', '', 'WHERE r.id_pregunta = p.id AND r.resultado = |_resultado*| AND r.identificacion = |_documento*| AND r.a = _a* AND r.id_materia = 7 ', '', '', '', '', ''),
('conteos no tec', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_respuestas r, tbl_preguntas p ', '', 'WHERE r.id_pregunta = p.id AND r.resultado = |_resultado*| AND r.identificacion = |_documento*| AND r.a = _a* AND r.id_materia = 9 ', '', '', '', '', ''),
('conteos no fis', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_respuestas r, tbl_preguntas p ', '', 'WHERE r.id_pregunta = p.id AND r.resultado = |_resultado*| AND r.identificacion = |_documento*| AND r.a = _a* AND r.id_materia = 11 ', '', '', '', '', ''),
('retroalimentacion no num', 'NO', 'SELECT DISTINCT p.retroalimentacion ', 'FROM tbl_respuestas r, tbl_preguntas p ', '', 'WHERE r.id_pregunta = p.id AND r.resultado = |_resultado*| AND r.identificacion = |_documento*| AND r.a = _a* AND r.id_materia = _idmateria* ', '', '', '', '', ''),
('retroalimentacion no bio', 'NO', 'SELECT DISTINCT p.retroalimentacion ', 'FROM tbl_respuestas r, tbl_preguntas p ', '', 'WHERE r.id_pregunta = p.id AND r.resultado = |_resultado*| AND r.identificacion = |_documento*| AND r.a = _a* AND r.id_materia = _idmateria* ', '', '', '', '', ''),
('retroalimentacion no soc', 'NO', 'SELECT DISTINCT p.retroalimentacion ', 'FROM tbl_respuestas r, tbl_preguntas p ', '', 'WHERE r.id_pregunta = p.id AND r.resultado = |_resultado*| AND r.identificacion = |_documento*| AND r.a = _a* AND r.id_materia = _idmateria* ', '', '', '', '', ''),
('retroalimentacion no esp', 'NO', 'SELECT DISTINCT p.retroalimentacion ', 'FROM tbl_respuestas r, tbl_preguntas p ', '', 'WHERE r.id_pregunta = p.id AND r.resultado = |_resultado*| AND r.identificacion = |_documento*| AND r.a = _a* AND r.id_materia = _idmateria* ', '', '', '', '', ''),
('retroalimentacion no ing', 'NO', 'SELECT DISTINCT p.retroalimentacion ', 'FROM tbl_respuestas r, tbl_preguntas p ', '', 'WHERE r.id_pregunta = p.id AND r.resultado = |_resultado*| AND r.identificacion = |_documento*| AND r.a = _a* AND r.id_materia = _idmateria* ', '', '', '', '', ''),
('retroalimentacion no tec', 'NO', 'SELECT DISTINCT p.retroalimentacion ', 'FROM tbl_respuestas r, tbl_preguntas p ', '', 'WHERE r.id_pregunta = p.id AND r.resultado = |_resultado*| AND r.identificacion = |_documento*| AND r.a = _a* AND r.id_materia = _idmateria* ', '', '', '', '', ''),
('retroalimentacion no fis', 'NO', 'SELECT DISTINCT p.retroalimentacion ', 'FROM tbl_respuestas r, tbl_preguntas p ', '', 'WHERE r.id_pregunta = p.id AND r.resultado = |_resultado*| AND r.identificacion = |_documento*| AND r.a = _a* AND r.id_materia = _idmateria* ', '', '', '', '', ''),
('conteos ok por pensamiento', 'NO', 'SELECT COUNT(1) ct_ok, identificacion, id_materia ', 'FROM tbl_respuestas ', '', 'WHERE resultado = |_resultado*| AND identificacion = |_documento*| AND a = _a* ', 'GROUP BY identificacion, id_materia ', '', '', '', ''),
('conteos no por pensamiento', 'NO', 'SELECT COUNT(1) ct_no, identificacion, id_materia ', 'FROM tbl_respuestas ', '', 'WHERE resultado = |_resultado*| AND identificacion = |_documento*| AND a = _a* ', 'GROUP BY identificacion, id_materia ', '', '', '', ''),
('conteos na por pensamiento', 'NO', 'SELECT COUNT(1) ct_na, identificacion, id_materia ', 'FROM tbl_respuestas ', '', 'WHERE resultado = |_resultado*| AND identificacion = |_documento*| AND a = _a* ', 'GROUP BY identificacion, id_materia ', '', '', '', ''),
('resultado preguntas', 'NO', 'SELECT m.materia, m.pensamiento, p.pregunta, r.respuesta, r.resultado, case r.resultado when |_resultado*| then |_muyBien*| else p.retroalimentacion end comentarios, substring(p.imagen, 7) ruta ', 'FROM tbl_respuestas r, tbl_preguntas p, materias m ', '', 'WHERE r.id_pregunta = p.id AND r.id_materia = m.id AND r.a = _a* AND r.identificacion = |_documento*| ', '', '', '', '', ''),
('valida preguntas grado', 'NO', 'SELECT g.id, g.grado ', 'FROM tbl_estudiantes e, tbl_matriculas m, tbl_grados g ', '', 'WHERE e.id = m.id_estudiante AND m.id_grado = g.id AND e.n_documento = |_documento*| AND m.n_tbl_matriculas like _a* AND m.estado IN (|_estado*|, |_estado1*|) ', '', '', '', '', ''),
('estudiantes activos', 'NO', 'SELECT COUNT(1) ct ', 'FROM tbl_matriculas ', '', 'WHERE n_tbl_matriculas like _a* and estado = |_estado*| ', '', '', '', '', ''),
('autorizados para estados financieros', 'NO', 'SELECT * ', 'FROM tbl_empleados ', '', 'WHERE email = |_usuario*| AND n_documento = |_pass*| AND estado = |_estado*| ', '', '', '', '', ''),
('grado documento', 'NO', 'SELECT e.id, e.nombres, e.apellidos, m.id_grado, g.grado ', 'FROM tbl_estudiantes e, tbl_matriculas m, tbl_grados g ', '', 'WHERE e.id = m.id_estudiante AND m.id_grado = g.id AND e.n_documento = |_documento*| AND m.estado IN (|_estado*|, |_estado1*|) AND m.n_tbl_matriculas like _a* ', '', '', '', '', '');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_solicitud_seguimientos;

CREATE TABLE tbl_solicitud_seguimientos (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  solicitud_por varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_stickers_virtuales;

CREATE TABLE tbl_stickers_virtuales (
  id int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  documento varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  a int(11) UNSIGNED NOT NULL,
  grado int(2) UNSIGNED NOT NULL,
  nombres varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  apellidos varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  ciudad varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  departamento varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  direccion varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  celular varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_temas_preguntas;

CREATE TABLE tbl_temas_preguntas (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_grado int(11) NOT NULL,
  id_materia int(11) NOT NULL,
  tema varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  ct_preguntas int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_temas_preguntas (id_grado, id_materia, tema, ct_preguntas) VALUES
(-1, -1, '  SELECCIONE TEMA', -1),
(0, 0, ' OTRO', 0);

UPDATE tbl_temas_preguntas SET id = -1 WHERE id = 1;
UPDATE tbl_temas_preguntas SET id = 0 WHERE id = 2;

ALTER TABLE tbl_temas_preguntas
MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

INSERT INTO tbl_temas_preguntas (id_grado, id_materia, tema, ct_preguntas) VALUES
(8, 5, 'OPERACIONES CON FRACCIONES', 2),
(9, 5, 'SERIES Y SUCESIONES', 2),
(9, 5, 'REGLA DE TRES SIMPLE', 2),
(8, 5, 'RECONOCE LAS FRACCIONES', 2),
(10, 5, 'DESCOMPOSICIÓN EN FACTORES PRIMOS', 1),
(10, 5, 'MCM Y MCD', 2),
(8, 5, 'OPERACIONES CON NÚMEROS RACIONALES', 2),
(10, 5, 'SOLUCION ECUACIONES 1ER GRADO', 2),
(9, 5, 'POTENCIACIÓN RADICACIÓN Y LOGARITMACIÓN', 2),
(8, 5, 'ÁREAS Y PERÍMETROS', 2),
(8, 5, 'RAZONAMIENTO LÓGICO', 2),
(10, 59, 'RAZONAMIENTO ALGEBRAICO', 2),
(10, 5, 'PRODUCTOS Y COCIENTES NOTABLES', 2),
(9, 5, 'REGLA DE TRES COMPUESTA', 2),
(10, 5, 'FACTORIZACIÓN', 2),
(10, 5, 'ÁREAS Y VOLÚMENES', 2),
(8, 5, 'CONVERSIÓN DE UNIDADES', 2),
(9, 5, 'REPRESENTACIÓN DE PUNTOS EN LA RECTA', 2),
(10, 5, 'TEOREMA DE PITÁGORAS', 2),
(10, 5, 'MEDIDAS ESTADÍSTICAS', 2),
(8, 5, 'PORCENTAJES', 2),
(8, 5, 'RAZONES Y PROPORCIONES', 2),
(8, 5, 'ANÁLISIS ESTADÍSTICO', 2),
(8, 5, 'PROBABILIDAD', 2),
(9, 5, 'ÁREAS Y PERÍMETROS', 2),
(9, 5, 'RAZONAMIENTO LÓGICO', 2),
(9, 5, 'RECONOCE LAS FRACCIONES', 2),
(9, 5, 'ANÁLISIS ESTADÍSTICO Y PROBABILIDAD', 2),
(91, 5, 'TRASLACIÓN Y ROTACIÓN', 2),
(9, 5, 'SOLUCIÓN DE ECUACIONES LINEALES', 2),
(101, 5, 'ÁREAS Y PERÍMETROS', 2),
(101, 5, 'SERIES Y SUCESIONES', 2),
(10, 5, 'RAZONAMIENTO LÓGICO', 2),
(2, 5, 'COLORES', 2),
(2, 5, 'NOCIÓN ESPACIAL', 5),
(2, 5, 'CONTEO', 2),
(2, 5, 'SUMA', 2),
(2, 5, 'FIGURAS GEOMÉTRICAS', 2),
(2, 5, 'NÚMEROS', 5),
(2, 5, 'PENSAMIENTO LÓGICO', 2),
(3, 5, 'COLORES', 2),
(3, 5, 'NOCIÓN ESPACIAL', 2),
(3, 5, 'CONTEO', 2),
(3, 5, 'SUMA', 2),
(3, 5, 'FIGURAS GEOMÉTRICAS', 2),
(3, 5, 'NÚMEROS DE 100 EN 100 HASTA 1000', 2),
(3, 5, 'RESTAS', 2),
(3, 5, 'PENSAMIENTO LÓGICO', 2),
(4, 5, 'NÚMEROS NATURALES', 1),
(4, 5, 'OPERACIONES CON NÚMEROS NATURALES', 5),
(4, 5, 'FIGURAS PLANAS', 2),
(4, 5, 'UNIDADES DE MEDIDA', 2),
(4, 5, 'ESTADÍSTICA', 2),
(5, 5, 'TIEMPO', 2),
(5, 5, 'NÚMEROS NATURALES', 2),
(5, 5, 'OPERACIONES CON NÚMEROS NATURALES', 4),
(5, 5, 'SOLUCIÓN DE PROBLEMAS', 3),
(6, 5, 'TIEMPO', 2),
(6, 5, 'NÚMEROS NATURALES', 2),
(6, 5, 'OPERACIONES CON NÚMEROS NATURALES', 4),
(6, 5, 'SOLUCIÓN DE PROBLEMAS', 3),
(7, 7, 'ACTIVIDADES COTIDIANAS Y PASATIEMPOS', 2),
(7, 7, 'PREGUNTAS DE INFORMACIÓN BÁSICA', 3),
(7, 7, 'LA HORA Y NUMEROS', 2),
(7, 7, 'ADJETIVOS: SINÓNIMOS Y ANTÓNIMOS', 3),
(7, 7, 'EXPRESIONES PARA HABLAR DE ACCIONES PASADAS', 3),
(7, 7, 'VOCABULARIO RELACIONADO CON LUGARES Y CLIMA', 2),
(6, 5, 'PROBABILIDAD', 2),
(5, 5, 'PROBABILIDAD', 2),
(8, 7, 'EXPRESIONES RELACIONADAS CON RUTINAS DIARIAS', 3),
(8, 7, 'PAÍSES Y NACIONALIDADES', 2),
(8, 7, 'CARACTERÍSTICAS BÁSICAS DE PERSONAS, COSAS Y LUGARES', 4),
(8, 7, 'EXPRESIONES PARA SALUDAR', 3),
(8, 7, 'EXPRESIONES PARA PREGUNTAR', 3),
(9, 7, 'COMPARACIONES Y CONTRASTES', 4),
(9, 7, 'EXPRESIONES RELACIONADAS CON LA CONSERVACIÓN DEL MEDIO AMBIENTE', 3),
(9, 7, 'ESTADOS DE ÁNIMO', 2),
(9, 7, 'SUGERENCIAS Y RECOMENDACIONES', 4),
(9, 7, 'DESCRIPCIÓN DE EXPERIENCIAS PASADAS', 4),
(9, 7, 'DESCRIPCIÓN DE SITUACIONES Y EVENTOS', 4),
(10, 7, 'EXPRESIONES PARA OPINAR Y DAR RAZONES', 3),
(10, 7, 'FORMULAR Y RESPONDER PREGUNTAS SOBRE UN TEMA', 4),
(10, 7, 'EXPRESIONES PARA PROPONER O MOSTRAR UNA SOLUCIÓN', 2),
(10, 7, 'EXPRESAR SUEÑOS O PLANES FUTUROS', 3),
(10, 7, 'VOCABULARIO RELACIONADO CON FENÓMENOS SOCIALES', 4),
(10, 7, 'EXPRESIONES IDIOMÁTICAS', 4),
(11, 7, 'EXPRESIONES PARA OPINAR SOBRE TEMAS SOCIALES', 3),
(11, 7, 'EXPRESIONES DE VENTAJAS Y DESVENTAJAS', 3),
(11, 7, 'EXPRESIONES PARA CITAR', 3),
(11, 7, 'DAR Y SOLICITAR INFORMACIÓN SOBRE TEMAS DE INTERÉS GENERAL', 4),
(11, 7, 'DAR RECOMENDACIONES SOBRE TEMAS DE INTERÉS GENERAL', 4),
(11, 7, 'EXPRESIONES DE CONTRASTE Y ADICIÓN', 3),
(12, 7, 'EXPRESIONES CON ACUERDOS Y DESACUERDOS', 3),
(12, 7, 'EXPRESIONES PARA INICIAR, MANTENER Y TERMINAR UNA CONVERSACIÓN', 4),
(12, 7, 'EXPRESIONES PARA SOLICITAR ACLARACIÓN', 3),
(12, 7, 'EXPRESIONES DE CAUSA Y EFECTO', 3),
(12, 7, 'EXPRESIONES PARA HABLAR SOBRE COSTUMBRES', 3),
(12, 7, 'EXPRESIONES PARA HABLAR SOBRE CONSECUENCIAS', 3),
(8, 9, 'CORRIENTE ELÉCTRICA', 4),
(8, 9, 'MAGNITUDES ELÉCTRICAS', 3),
(8, 9, 'COMPONENTES ELECTRÓNICOS', 5),
(10, 9, 'SISTEMAS DE NUMERACIÓN', 2),
(10, 9, 'OPERADORES LÓGICOS', 4),
(10, 9, 'HOJAS DE CÁLCULO', 2),
(11, 9, 'PROGRAMACIÓN', 5),
(4, 9, 'HISTORIA Y EVOLUCIÓN DE LA TECNOLOGÍA', 2),
(4, 9, 'INVENTOS E INNOVACIONES TECNOLÓGICAS', 2),
(4, 9, 'SISTEMAS TECNOLÓGICOS', 2),
(4, 9, 'HERRAMIENTAS OFIMÁTICAS', 3),
(5, 9, 'FUENTES DE ENREGÍA', 2),
(5, 9, 'MATERIAS PRIMAS', 2),
(5, 9, 'HERRAMIENTAS INFORMÁTICAS', 2),
(5, 9, 'SEÑALES PREVENTIVAS REGLAMENTARIAS E INFORMATIVAS', 2),
(5, 9, 'POWERPOINT Y EXCEL', 3),
(6, 9, 'MICROSOFT (EXCEL, POWERPOINT, WORD)', 3),
(6, 9, 'OFIMÁTICA', 2),
(6, 9, 'SISTEMAS TECNOLÓGICOS', 2),
(6, 9, 'HERRAMIENTAS TECNOLÓGICAS', 2),
(6, 9, 'TIPOS DE ENERGÍA', 2),
(6, 9, 'FUENTES DE ENERGÍA RENOVABLES Y NO RENOVABLES', 2),
(6, 9, 'HARDWARE Y SOFTWARE', 2),
(7, 6, 'INTERPRETACIÓN TEXTUAL', 5),
(7, 6, 'EXPRESIÓN GRAMATICAL', 5),
(7, 6, 'PRODUCCIÓN TEXTUAL', 2),
(8, 6, 'INTERPRETACIÓN TEXTUAL', 5),
(8, 6, 'EXPRESIÓN GRAMATICAL', 5),
(8, 6, 'PRODUCCIÓN TEXTUAL', 2),
(9, 6, 'INTERPRETACIÓN TEXTUAL', 5),
(9, 6, 'EXPRESIÓN GRAMATICAL', 5),
(9, 6, 'PRODUCCIÓN TEXTUAL', 2),
(10, 6, 'INTERPRETACIÓN TEXTUAL', 5),
(10, 6, 'EXPRESIÓN GRAMATICAL', 5),
(10, 6, 'PRODUCCIÓN TEXTUAL', 3),
(11, 15, 'INTERPRETACIÓN TEXTUAL', 5),
(11, 15, 'EXPRESIÓN GRAMATICAL', 4),
(11, 15, 'PRODUCCIÓN TEXTUAL', 3),
(12, 15, 'LECTURA CRÍTICA', 6),
(12, 15, 'EXPRESIÓN GRAMATICAL', 5),
(12, 15, 'PRODUCCIÓN TEXTUAL', 3),
(2, 6, 'VOCALES', 2),
(2, 6, 'CONSONANTE (MAYÚSCULAS Y MINÚSCULAS)', 2),
(2, 6, 'PRECEPCIÓN VISUAL Y AUDITIVA (SILABAS)', 2),
(2, 6, 'RELACIÓN PALABRA DIBUJO', 3),
(2, 6, 'COMPRESIÓN LECTORA', 5),
(2, 6, 'ORACIONES', 2),
(2, 6, 'FORMANDO PALABRAS', 4),
(2, 6, 'ESCRITURA Y ORTOGRAFÍA', 2),
(3, 6, 'PRODUCCIÓN TEXTUAL', 2),
(3, 6, 'EXPRESIÓN GRAMATICAL', 5),
(3, 6, 'INTERPRETACIÓN TEXTUAL', 4),
(4, 6, 'INTERPRETACIÓN TEXTUAL', 3),
(4, 6, 'EXPRESIÓN GRAMATICAL', 6),
(4, 6, 'PRODUCCIÓN TEXTUAL', 1),
(5, 6, 'INTERPRETACIÓN TEXTUAL', 4),
(5, 6, 'PRODUCCIÓN TEXTUAL', 3),
(5, 6, 'EXPRESIÓN GRAMATICAL', 3),
(6, 6, 'INTERPRETACIÓN TEXTUAL', 4),
(6, 6, 'EXPRESIÓN GRAMATICAL', 4),
(6, 6, 'PRODUCCIÓN TEXTUAL', 2),
(7, 5, 'VOLÚMENES Y CUERPOS GEOMÉTRICOS', 2),
(7, 5, 'ANÁLISIS DE SITUACIONES PROBLEMÁTICAS', 2),
(7, 5, 'PROCESOS PROBABILÍSTICOS DE PRIMER ORDDEN SITUACIONAL', 2),
(7, 5, 'MEDIDAS Y PARÁMETROS, APLICANDO LA SITUACIÓN PROBLEMÁTICA', 2),
(7, 5, 'OPERACIONES UNIVERSALES', 2),
(11, 5, 'FUNCIÓN LINEAL Y AFIN', 2),
(11, 5, 'PENDIENTE DE LA RECTA', 2),
(11, 5, 'CÁLCULO ANALÍTICO DEL PUNTO DE CORTE DE SISTEMAS LINEALES', 2),
(11, 5, 'RACIONALIZACIÓN', 2),
(11, 5, 'IDENTIFICACIÓN DE LA PARÁBOLA BASADOS EN LA FORMA CANÓNICA', 2),
(11, 5, 'CONVERSIÓN DE PARÁBOLAS DE FORMA CANÓNICA A FORMA GENERAL', 2),
(11, 5, 'DISCRIMINANTE', 2),
(11, 5, 'ANÁLISIS DE GRÁFICAS Y COMPONENTES DE LA PARÁBOLA', 2),
(11, 5, 'VOLÚMENES Y CUERPOS GEOMÉTRICOS', 2),
(11, 5, 'PROCESOS PROBABILÍSTICOS Y ALEATORIOS', 2),
(12, 5, 'ANÁLISIS DE FUNCIONES TRIGONOMÉTRICAS', 6),
(12, 5, 'SITUACIONES PROBLEMÁTICAS EN DONDE INTERVIENE EL TRIÁNGULO RECTÁNGULO', 3),
(12, 5, 'APLICACIÓN GENERALIZADA DE LA LEY DEL SENO', 2),
(12, 5, 'APLICACIÓN GENERALIZADA DE LA LEY DEL COSENO', 2),
(12, 5, 'APLICACIÓN GENERALIZADA DE LA LEY DE LA TANGENTE', 2),
(12, 5, 'PROCESOS PROBABILÍSTICOS Y ALEATORIOS', 2),
(12, 5, 'FIGURAS PLANAS Y VOLÚMENES', 2),
(12, 11, 'MOVIMIENTO UNIFORME', 3),
(12, 11, 'MOVIMIENTO ACELERADO', 3),
(12, 11, 'CAÍDA LIBRE', 4),
(7, 9, 'TECNOLOGIA Y SOCIEDAD', 5),
(7, 9, 'MATERIALES Y ESTRUCTURAS', 3),
(7, 9, 'APLICACIONES INFORMÁTICAS', 3),
(9, 9, 'SOLUCIÓN DE PROBLEMAS CON TECNOLOGÍA', 4),
(9, 9, 'INFORMACIÓN Y COMUNICACIÓN', 3),
(9, 9, 'RIESGOS EN EL USO DE LAS TIC', 3),
(12, 9, 'NATURALEZA Y EVOLUCIÓN DE LA TECNOLOGÍA', 3),
(12, 9, 'LA WEB', 4),
(12, 9, 'DISEÑO GRÁFICO', 3),
(12, 9, 'PROGRAMACIÓN WEB: HTML Y CSS', 5),
(3, 1, 'CONOCIMIENTOS BÁSICOS SOBRE ELECTRICIDAD', 1),
(3, 9, 'INVENTOS E INNOVACIONES TECNOLÓGICAS', 1),
(3, 9, 'HERRAMIENTAS OFIMÁTICAS', 5),
(3, 9, '¿QUÉ SON LOS ARTEFACTOS TECNOLÓGICOS?', 3),
(3, 9, 'LAS SEÑALES DE TRÁNSITO', 1),
(4, 9, '¿QUÉ ES MULTIMEDIA?', 1),
(3, 7, 'SALUDOS Y DESPEDIDA', 3),
(3, 7, 'LA FAMILIA', 3),
(3, 7, 'PARTES DEL CUERPO', 3),
(3, 7, 'PREGUNTAS SENCILLAS SOBRE EL ENTORNO, USANDO WHAT', 2),
(4, 7, 'VOCABULARIO: DÍAS DE LA SEMANA', 3),
(4, 7, 'RUTINA DIARIA', 4),
(4, 7, 'PREGUNTAS SENCILLAS USANDO WHAT, WHERE Y WHO CON RELACIÓN A ANIMALES Y SU ENTORNO', 4),
(5, 7, 'SELF INTRODUCCIÓN', 3),
(5, 7, 'FRUITS AND VEGETABLES VOCABULARY', 3),
(5, 7, 'PRESENT PROGRESSIVE', 3),
(5, 7, 'SEASONS, WEATHER AND CLOTHES', 3),
(5, 7, 'SPORTS VOCABULARY', 3),
(6, 7, 'PROFESIONES Y ACTIVIDADES', 3),
(6, 7, 'EXPRESIONES PARA DISCULPARSE', 3),
(6, 7, 'EXPRESIONES PARA REFERIRSE A CANTIDADES', 3),
(6, 7, 'PREFERENCIAS Y GUSTOS', 3),
(6, 7, 'SENTIMIENTOS Y EMOCIONES', 3),
(3, 1, 'CONOCIMIENTOS BÁSICOS SOBRE LOS SENTIDOS HUMANOS', 2),
(3, 1, 'CONOCIMIENTOS BÁSICOS SOBRE MEDIDAS DE LONGITUD', 1),
(3, 1, 'CONOCIMIENTOS BÁSICOS SOBRE CARACTERÍSTICAS DE LOS ANIMALES', 4),
(3, 1, 'CONOCIMIENTOS BÁSICOS SOBRE CARACTERÍSTICAS DE LAS PLANTAS', 1),
(3, 1, 'CONOCIMIENTOS BÁSICOS SOBRE CARACTERÍSTICAS DEL CUERPO HUMANO', 1),
(4, 1, 'CONOCIMIENTOS BÁSICOS SOBRE LOS PLANETAS Y EL UNIVERSO', 3),
(4, 1, 'CONOCIMIENTOS BÁSICOS SOBRE EL AGUA Y SU IMPORTANCIA', 2),
(4, 1, 'CONOCIMIENTOS BÁSICOS SOBRE CARACTERÍSTICAS DE LAS PLANTAS', 2),
(4, 1, 'CONOCIMIENTOS BÁSICOS SOBRE CICLO DE VIDA DE LOS SERES VIVOS', 2),
(4, 1, 'CONOCIMIENTOS BÁSICOS SOBRE FUERZA Y ENERGÍA', 1),
(5, 1, 'CARACTERÍSTICAS DE LAS PLANTAS', 1),
(5, 1, 'ESTADO DE LA MATERIA', 2),
(5, 1, 'CARACTERÍSTICAS DE LA MATERIA', 1),
(5, 1, 'LOS RECURSOS NATURALES', 2),
(5, 1, 'EL CUERPO HUMANO', 3),
(5, 1, 'ECOSISTEMAS', 1),
(6, 1, 'MÁQUINAS SIMPLES Y COMPUESTAS', 1),
(6, 1, 'FUERZA', 1),
(6, 1, 'LA MATERIA', 4),
(6, 1, 'LA CÉLULA', 3),
(6, 1, 'ECOSISTEMAS', 1),
(7, 1, 'ECOSISTEMAS', 3),
(7, 1, 'FUERZA', 2),
(7, 1, 'EL SONIDO', 1),
(7, 1, 'LA ELECTRICIDAD', 2),
(7, 1, 'REPRODUCCIÓN DE PLANTAS', 1),
(7, 1, 'METABOLISMO HUMANO', 2),
(8, 1, 'LA CÉLULA', 4),
(8, 1, 'LA MATERIA', 1),
(8, 1, 'MÉTODO CIENTÍFICO', 5),
(9, 1, 'LA MATERIA', 1),
(9, 1, 'EL ÁTOMO', 1),
(9, 1, 'LA TABLA PERIÓDICA', 1),
(9, 1, 'EL CUERPO HUMANO', 11),
(9, 1, 'MOVIMIENTO', 1),
(10, 1, 'FUNCIÓN CELULAR', 3),
(10, 1, 'TIPOS DE MOVIMIENTO', 1),
(10, 1, 'ESCALAS DE TEMPERATURA', 2),
(10, 1, 'TEORÍA Y LEYES DE LOS GASES', 2),
(10, 1, 'ENLACES QUÍMICOS', 2),
(11, 10, 'LA MATERIA', 2),
(11, 10, 'LA TABLA PERIÓDICA', 5),
(11, 10, 'ECUACIONES QUÍMICAS', 1),
(11, 10, 'SOLUCIONES QUÍMICAS', 4),
(12, 10, 'PROPIEDADES FÍSICAS Y QUÍMICAS DE LA MATERIA', 3),
(12, 10, 'CONFIGURACIÓN ELECTRÓNICA', 1),
(12, 10, 'CINÉTICA DE LOS GASES', 1),
(12, 10, 'CINÉTICA DE LAS SOLUCIONES QUÍMICAS', 1),
(12, 10, 'ESCALAS DE TEMPERATURA', 1),
(12, 10, 'CONVERSIÓN DE UNIDADES', 1),
(12, 10, 'ENLACES QUÍMICOS', 2),
(11, 11, 'CONCEPTO DE ENERGÍA Y CLASES', 3),
(11, 11, 'CONCEPTO DE TRABAJO Y POTENCIA', 3),
(11, 11, 'TRANSFORMACIONES DE LA ENERGÍA', 3),
(11, 11, 'FUENTES DE ENERGÍA', 3),
(11, 11, 'CONVERSIONES DE UNIDADES', 3),
(12, 12, 'ECONOMÍA', 5),
(12, 12, 'POLÍTICA', 5),
(10, 4, 'REVOLUCIONES, PROCESOS DE CAMBIO Y ESTADOS NACIÓN LATINOAMERICANOS', 2),
(10, 4, 'EL PODER POLÍTICO', 2),
(10, 4, 'CONSTITUCIÓN POLÍTICA COLOMBIANA 1991', 2),
(10, 4, 'IMPERIALIAMO COLONIALISMO', 2),
(10, 4, 'COLOMBIA SIGLO XIX ESTADO NACIÓN Y EL MUNDO EN EL SIGLO XX', 2),
(9, 4, 'ANTROPOLOGÍA', 1),
(9, 4, 'SOCIOLOGÍA', 4),
(9, 4, 'HISTORIA', 5),
(6, 4, 'GEOGRAFÍA', 6),
(6, 4, 'SOCIOLOGÍA', 4),
(7, 4, 'ANTROPOLOGÍA', 4),
(7, 4, 'HISTORIA', 1),
(7, 4, 'SOCIOLOGÍA', 5),
(11, 12, 'EL MUNDO EN EL SIGLO XX', 2),
(11, 12, 'AMÉRICA LATINA EN EL SIGLO XX Y MOVIMIENTOS POPULARES EN LATINOAMERICANOS', 2),
(11, 12, 'COLOMBIA EN EL SIGLO XX', 2),
(11, 12, 'COLOMBIA COMO PAÍS Y ESTADO', 2),
(11, 12, 'DERECHOS HUMANOS Y PARTICIPACIÓN CIUDADANA EN COLOMBIA', 2),
(8, 4, 'ANTROPOLOGÍA', 3),
(8, 4, 'HISTORIA', 4),
(8, 4, 'GEOGRAFÍA', 3),
(4, 4, 'SOCIOLOGÍA', 4),
(4, 4, 'HISTORIA', 1),
(4, 4, 'GEOGRAFÍA', 4),
(5, 4, 'ANTROPOLOGÍA', 1),
(5, 4, 'GEOGRAFÍA', 9),
(3, 4, 'SOCIOLOGÍA', 4),
(3, 4, 'GEOGRAFÍA', 6),
(19, 0, 'HTML5', 22),
(19, 0, 'CSS3', 10),
(19, 0, 'JAVASCRIPT', 23),
(19, 0, 'HTML5CSS3', 15),
(19, 0, 'JQUERY', 20),
(20, 0, 'PHP', 50),
(20, 0, 'MYSQL', 40);

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_temas_preguntas_num;

CREATE TABLE tbl_temas_preguntas_num (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_grado int(11) NOT NULL,
  id_materia int(11) NOT NULL,
  tema varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  ct_preguntas int(4) NOT NULL,
  componente varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  retro varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_temp;

CREATE TABLE tbl_temp (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  c1 varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  v1 int(11) NOT NULL,
  C2 varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_temp1;

CREATE TABLE tbl_temp1 (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  t1 varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_tipos_agenda;

CREATE TABLE tbl_tipos_agenda (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  tipo_agenda varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_tipos_agenda (tipo_agenda) VALUES
(' Seleccione');

UPDATE tbl_tipos_agenda SET id = 0 WHERE id = 1;

ALTER TABLE tbl_tipos_agenda
MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

INSERT INTO tbl_tipos_agenda (tipo_agenda) VALUES
('ACOMPAÑAMIENTO'),
('DIRECCION GRADO'),
('INDUCCION'),
('REUNION ACADEMICA'),
('REUNION ADMINISTRATIVA'),
('REUNION EQUIPO CREATIVO'),
('REUNION EVENTOS'),
('REUNION FINANCIERA'),
('REUNION GIU'),
('REUNION PENSAMIENTO'),
('REUNION PRACTICAS UNIVERSITARIAS'),
('REUNION PROYECTOS'),
('REUNION PSICOLOGIA'),
('REUNION SISTEMAS'),
('TUTORIA'),
('VALORACION'),
('CIERRE VALORACION'),
('ENTREVISTA'),
('SEGUIMIENTO');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_tipo_preguntas;

CREATE TABLE tbl_tipo_preguntas (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  tipo_pregunta varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_tipo_preguntas (tipo_pregunta) VALUES
('Seleccione tipo pregunta'),
('Respuesta corta'),
('Selección sencilla'),
('Selección múltiple 2'),
('Selección múltiple 3');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_tp;

CREATE TABLE tbl_tp (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  tipo_persona varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_tp (tipo_persona) VALUES
(' SELECCIONE');

UPDATE tbl_tp SET id = -1 WHERE id = 1;

ALTER TABLE tbl_tp
MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

INSERT INTO tbl_tp (tipo_persona) VALUES
('NATURAL'),
('JURIDICA');

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_usuarios_domain;

CREATE TABLE tbl_usuarios_domain (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  usuario varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_palabras varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  fecha_registro date NOT NULL,
  ultimo_id_cambiado int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_usuarios_domain_i;

CREATE TABLE tbl_usuarios_domain_i (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  usuario varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_palabras varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  fecha_registro date NOT NULL,
  ultimo_id_cambiado int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_usuarios_domain_palabras;

CREATE TABLE tbl_usuarios_domain_palabras (
  usuario varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_palabra varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_usuarios_domain_palabras_i;

CREATE TABLE tbl_usuarios_domain_palabras_i (
  usuario varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  id_palabra varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_usu_preguntas;

CREATE TABLE tbl_usu_preguntas (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_empleado int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_usu_preguntas (id_empleado) VALUES
(9),
(10),
(12),
(14),
(18),
(20),
(24),
(25),
(26),
(27),
(50),
(16),
(19),
(34),
(11);

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_asistente_virtual_comprobantes_pago;

CREATE TABLE tbl_asistente_virtual_comprobantes_pago (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  documento varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  a int(11) UNSIGNED NOT NULL,
  tipo varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL COMMENT 'deuda, matrícula',
  ruta varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
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
  paso varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  descripcion varchar(100) NOT NULL,
  paso_numero int(11) UNSIGNED NOT NULL,
  etiqueta_intencion varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
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
  documento_estudiante varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  a int(4) UNSIGNED NOT NULL,
  proceso_iniciado int(2) UNSIGNED NOT NULL DEFAULT 1,
  paso varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT '1',
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
  apellidos varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  nombres varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  genero varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  tipo_documento varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  n_documento varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  fecha_nacimiento date DEFAULT NULL,
  expedicion varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  ciudad varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  direccion varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  direccion_estudiante varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  telefono_estudiante varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  email_institucional varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT 'NA',
  actividad_extra varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT 'No Registra',
  email_acudiente_1 varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  email_acudiente_2 varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  acudiente_1 varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  acudiente_2 varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  telefono_acudiente_1 varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  telefono_acudiente_2 varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  parentesco_acudiente_1 varchar(10) DEFAULT 'NA',
  parentesco_acudiente_2 varchar(10) DEFAULT 'NA',
  rh varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT '--',
  password varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  mensaje varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  fecha_datos date NOT NULL,
  documento_responsable varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
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

UPDATE tbl_estudiantes SET id = -1 WHERE n_documento = '93974541';
UPDATE tbl_estudiantes SET id = -2 WHERE n_documento = '93974542';
UPDATE tbl_estudiantes SET id = -3 WHERE n_documento = '93974543';
UPDATE tbl_estudiantes SET id = -4 WHERE n_documento = '93974544';

ALTER TABLE tbl_estudiantes
MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

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
  n_matricula varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  fecha_ingreso date DEFAULT NULL,
  estado varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT 'pre_solicitud',
  id_estudiante int(11) NOT NULL,
  id_grado int(2) NOT NULL,
  estado_grado varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  grupo varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO tbl_matriculas (n_matricula, fecha_ingreso, estado, id_estudiante, id_grado, estado_grado, grupo) VALUES
('-1-2025-4G', '2025-01-01', 'aprobado', -4, 4, 'ant nuevo', 'A'),
('-2-2025-4G', '2025-01-01', 'aprobado', -3, 4, 'ant nuevo con deuda', 'A'),
('-3-2024-4G', '2024-01-01', 'aprobado', -2, 4, 'ant con deuda', 'A'),
('-4-2024-4G', '2024-01-01', 'aprobado', -1, 4, 'ant', 'A')
;

UPDATE tbl_matriculas SET id = -1 WHERE id_estudiante = -1;
UPDATE tbl_matriculas SET id = -2 WHERE id_estudiante = -2;
UPDATE tbl_matriculas SET id = -3 WHERE id_estudiante = -3;
UPDATE tbl_matriculas SET id = -4 WHERE id_estudiante = -4;

ALTER TABLE tbl_matriculas
MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

/*######################################################################################################*/

DROP TABLE IF EXISTS tbl_tipos_documento;

CREATE TABLE tbl_tipos_documento (
  id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  tipo_documento varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
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
  grado varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
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
  documento_est varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  nombres_est varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  apellidos_est varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  fecha date NOT NULL,
  actividad_extra varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  nombre_a varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  celular_a varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  email_a varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  ciudad_a varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  observaciones varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  entrevista varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  observaciones_ent varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  admitido int(2) NOT NULL DEFAULT 0,
  eval int(2) NOT NULL DEFAULT 0,
  id_medio int(11) DEFAULT NULL,
  interesado varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
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
  hora varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  documento_est varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  nombre_est varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  generar_contrato varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

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
  documento_estudiante varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  periodo_ingreso int(11) NOT NULL DEFAULT 0,
  a int(11) NOT NULL DEFAULT 0,
  documento_acudiente varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  deuda_anterior int(11) NOT NULL DEFAULT 0,
  matricula_ocp int(11) NOT NULL DEFAULT 0,
  valor_pension_mes int(11) NOT NULL DEFAULT 0,
  total_pension_anual int(11) NOT NULL DEFAULT 0,
  cantidad_pensiones int(11) NOT NULL DEFAULT 0,
  derechos_grado int(11) NOT NULL DEFAULT 0,
  icfes int(11) NOT NULL DEFAULT 0,
  total_pagar_anual int(11) NOT NULL DEFAULT 0,
  pago_deuda int(11) NOT NULL DEFAULT 0,
  pago_matricula varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  pago_icfes varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  pago_derechos_grado varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
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
  documento varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  a int(11) UNSIGNED NOT NULL,
  tipo varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  ruta varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
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
  medio varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
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
('NA', 'NA', 'NA', 'NA', 'NA', 0, 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA', 'NA');

UPDATE tbl_empleados SET id = 0 WHERE n_documento = 0;

ALTER TABLE tbl_empleados
MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

INSERT INTO tbl_empleados (nombres, apellidos, email, pc, perfil, n_documento, dependencia, skype, celular, celular_what, cargo, profesion, descripcion, foto, nombre_corto, infografia, rh, estado) VALUES
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