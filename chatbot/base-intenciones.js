const BASE_INTENCIONES = [
    {//Saludo
        etiqueta: "saludo",
        claves: ["hola", "buenos días", "buenas", "hey", "buenas tardes", "buenas noches"],
        respuesta: "¡Hola! Soy tu asistente de admisiones. Es un gusto asistirlo/a en el proceso."
    },
    {//menu inicial
        etiqueta: "menu_inicial",
        claves: ["admisiones", "iniciar admisiones", "quiero matricular", "iniciar matrícula", "nueva matrícula", "matrícula"],
        respuesta: "Selecciona una opción para comenzar:",
        accion: "mostrar_menu_botones",
        botones: [
            {
                texto: "Comenzar proceso de admisión",
                valor: "iniciar_admision",
                tipo: "intencion",
                destino: "validar_documento"
            },
            {
                texto: "Ver calendario",
                valor: "descargar_calendario",
                tipo: "d_pdf",
                url: "https://unicab.org/calendario/calendario_2026_f.pdf"
            },
            {
                texto: "Ver listado de documentos requeridos",
                valor: "descargar_listado_documentos",
                tipo: "d_pdf",
                url: "https://unicab.org/assets/descargas/listado_documentos_1.pdf"
            },
            {
                texto: "Ver costos colegio regular",
                valor: "descargar_costos",
                tipo: "d_pdf",
                url: "https://unicab.org/assets/descargas/costos/Educacion_Regular_CIRCULAR_No_20_DE_18_DE_NOVIEMBRE_DE_2025.pdf"
            },
            {
                texto: "Ver costos educación ciclos",
                valor: "descargar_costos",
                tipo: "d_pdf",
                url: "https://unicab.org/assets/descargas/costos/Educacion_por_Ciclos_CIRCULAR_No_21_DE_18_DE_NOVIEMBRE_DE_2025.pdf"
            }
        ]
    },
    {//validar documento
        etiqueta: "validar_documento",
        claves: [
            "validación de documento", 
            "validar documento", 
            "validar identificación", 
            "validación de identificación"
        ],
        respuesta: "Ingresa el número de documento del estudiante a matricular.",
        accion: "validar_documento",
        url: "http://localhost:90/avmeeuu/avmeeuu/api/av_validar_documento.php", // ← Cambia por tu URL real
        mensaje_espera: "Validando documento...",
        mensaje_exito: "✅ Documento válido. Puedes continuar con el proceso.",
        mensaje_error: "❌ El documento ingresado no es válido. Por favor, verifica e inténtalo de nuevo."
    },


    // ######### 1 Antiguo sin Deuda ##########
    {//mostrar datos actuales ant sd
        etiqueta: "datos_actuales_ant_sd",
        claves: [
            "datos actuales antiguo"
        ],
        respuesta: "Estos son los datos que actualmente se registran en nuestro sistema:",
        accion: "datos_actuales_ant_sd",
        url: "http://localhost:90/avmeeuu/avmeeuu/api/av_validar_documento.php",
        botones: [
            { 
                texto: "Actualizar datos", //Si 
                valor: "actualizar_datos", 
                tipo: "intencion", 
                destino: "formulario_inicial_ant_sd" 
            }
        ]
    },
    {//formulario inicial antiguo sd web service
        etiqueta: "formulario_inicial_ant_sd",
        claves: [
            "cargar datos iniciales", 
            "formulario inicial con datos", 
            "datos cargados del estudiante", 
            "información inicial cargada"
        ],
        respuesta: "Por favor, revisa y completa la información solicitada:",
        accion: "formulario_inicial_ant_sd",
        url: "http://localhost:90/avmeeuu/avmeeuu/api/av_validar_documento.php"
    },
    {//matrícula antiguo sd
        etiqueta: "costos_matricula_ant_sd",
        claves: ["matrícula", "costo matrícula", "pagar matrícula"], 
        respuesta: "Los costos de matrícula para el grado |X| son:",
        accion: "costos_matricula_ant_sd",
        botones: [
            { 
                texto: "Pagar matrícula", 
                valor: "pagar_matricula", 
                tipo: "intencion", 
                destino: "opciones_pago_matricula_antiguo_sd" 
            },
            { 
                texto: "Subir comprobante de pago", 
                valor: "subir_comprobante", 
                tipo: "intencion", 
                destino: "comprobante_matricula_ant_sd" 
            }
        ]
    },
    {//opciones pago matrícula sd
        etiqueta: "opciones_pago_matricula_antiguo_sd",
        claves: ["opciones de pago matrícula", "formas de pago matrícula"],
        respuesta: "Selecciona una opción de pago para la matrícula de",
        accion: "opciones_pago_matricula_antiguo_sd",
        botones: [
            { 
                texto: "Pago a través de Mi Pago Amigo Banco Caja Social", 
                valor: "mi_pago_amigo", 
                tipo: "servicio", 
                url: "https://www.mipagoamigo.com/MPA_WebSite/ServicePayments/StartPayment?id=3555&searchedCategoryId=&searchedAgreementName=UNICAB%20CORPORACION%20EDUCATIVA" 
            },
            { 
                texto: "Cuenta Banco Caja Social", 
                valor: "cuenta_caja_social", 
                tipo: "servicio", 
                url: "https://unicab.org/assets/img/cuenta_corriente_cajasocial.jpg" 
            },
            { 
                texto: "Cuenta Banco Av Villas", 
                valor: "cuenta_av_villas", 
                tipo: "servicio", 
                url: "https://unicab.org/assets/img/cuenta_corriente_avvillas.jpg" 
            },
            { 
                texto: "Link de pago a través de Epayco", 
                valor: "link_pago_epayco", 
                tipo: "servicio", 
                url: "pagoMatricula.php" 
            },
            { 
                texto: "Subir comprobante de pago", 
                valor: "subir_comprobante", 
                tipo: "intencion", 
                destino: "comprobante_matricula_ant_sd" 
            }
        ]
    },
    {//comprobante matrícula antiguo sd
        etiqueta: "comprobante_matricula_ant_sd",
        claves: [
            "subir comprobante matrícula",
            "enviar comprobante matrícula",
            "adjuntar comprobante matrícula",
            "cargar comprobante matrícula"
        ],
        respuesta: "Por favor, adjunta tu comprobante de pago matrícula por valor de",
        accion: "comprobante_matricula_ant_sd",
        tipos: ["pdf", "png", "jpg", "jpeg"],
        mensaje_espera: "Subiendo archivo...",
        mensaje_exito: "✅ Comprobante recibido. Tu pago está en proceso de validación.",
        mensaje_error: "❌ Error al subir el archivo. Asegúrate de que sea PDF, PNG o JPG y que no supere 5 MB.",
        // 🔹 NUEVO: botón para cambiar medio de pago
        botones: [
            {
            texto: "Cambiar medio de pago",
            tipo: "intencion",
            destino: "opciones_pago_matricula_antiguo_sd"
            }
        ]
    },
    {//validando comprobante matrícula antiguo sd
        etiqueta: "validando_comprobante_matricula_ant_sd",
        claves: [
            "validacion comprobante matrícula",
            "validar comprobante matrícula"
        ],
        respuesta: "✅ Comprobante recibido. Tu pago está en proceso de validación. Una vez validado, se enviará un correo al email del acudiente.",
        accion: "validando_comprobante_matricula_ant_sd"
    },
    {//documentos finales ant sd
        etiqueta: "documentos_finales_ant_sd",
        claves: [
            "documentos finales antiguo"
        ],
        respuesta: "Estos son los documentos que se deben subir:",
        accion: "documentos_finales_ant_sd",
        tipos: ["pdf"],
        botones: [
            {
            texto: "Subir documentos y completar datos",
            tipo: "intencion",
            destino: "formulario_final_antiguo_sd"
            }
        ]
    },
    {//formulario final antiguo sd web service
        etiqueta: "formulario_final_antiguo_sd",
        claves: [
            "cargar datos finales", 
            "formulario final con datos", 
            "información final cargada"
        ],
        respuesta: "Por favor, revisa y completa la información solicitada:",
        accion: "formulario_final_antiguo_sd",
        url: "http://localhost:90/avmeeuu/avmeeuu/api/av_validar_documento.php"
    },
    {//validando documentos antiguo sd
        etiqueta: "validando_documentos_ant_sd",
        claves: [
            "validacion comprobante matrícula",
            "validar comprobante matrícula"
        ],
        respuesta: "✅ Documentos recibidos. Documentos en proceso de validación.",
        accion: "validando_documentos_ant_sd"
    },
    {//Mensaje final
        etiqueta: "resumen_ant_sd",
        claves: ["final admisión", "proceso finalizado", "terminar admisión", "admisión completada"],
        respuesta: "",
        accion: "resumen_ant_sd",
        imagen: "chatbot/img/final2.png"
    },


    // ######### 2 Antiguo con Deuda ##########
    {//deuda pendiente antiguo cd
        etiqueta: "valor_dueda_ant_cd",
        claves: ["deuda pendiente", "tengo deuda", "pagar deuda", "pago pendiente", "saldo pendiente"], 
        respuesta: "",
        accion: "valor_dueda_ant_cd",
        botones: [
            { 
                texto: "Pagar deuda", 
                valor: "pagar_deuda", 
                tipo: "intencion", 
                destino: "opciones_pago_deuda_antiguo" 
            },
            { 
                texto: "Subir comprobante de pago", 
                valor: "subir_comprobante", 
                tipo: "intencion", 
                destino: "comprobante_deuda_ant_cd" 
            }
        ]
    },
    {//opciones pago deuda antiguo cd
        etiqueta: "opciones_pago_deuda_antiguo",
        claves: ["opciones de pago deuda", "formas de pago deuda"],
        respuesta: "Selecciona una opción de pago para la deuda de",
        accion: "opciones_pago_deuda_antiguo",
        botones: [
            { 
                texto: "Pago a través de Mi Pago Amigo Banco Caja Social", 
                valor: "mi_pago_amigo", 
                tipo: "servicio", 
                url: "https://www.mipagoamigo.com/MPA_WebSite/ServicePayments/StartPayment?id=3555&searchedCategoryId=&searchedAgreementName=UNICAB%20CORPORACION%20EDUCATIVA" 
            },
            { 
                texto: "Cuenta Banco Caja Social", 
                valor: "cuenta_caja_social", 
                tipo: "servicio", 
                url: "https://unicab.org/assets/img/cuenta_corriente_cajasocial.jpg" 
            },
            { 
                texto: "Cuenta Banco Av Villas", 
                valor: "cuenta_av_villas", 
                tipo: "servicio", 
                url: "https://unicab.org/assets/img/cuenta_corriente_avvillas.jpg" 
            },
            { 
                texto: "Link de pago a través de Epayco", 
                valor: "link_pago_epayco", 
                tipo: "servicio", 
                url: "pagoDeuda.php" 
            },
            { 
                texto: "Subir comprobante de pago", 
                valor: "subir_comprobante", 
                tipo: "intencion", 
                destino: "comprobante_deuda_ant_cd" 
            }
        ]
    },
    {//comprobante deuda antiguo cd
        etiqueta: "comprobante_deuda_ant_cd",
        claves: [
            "subir comprobante deuda",
            "enviar comprobante deuda",
            "adjuntar comprobante deuda",
            "cargar comprobante deuda"
        ],
        respuesta: "Por favor, adjunta tu comprobante de pago deuda por valor de",
        accion: "comprobante_deuda_ant_cd",
        tipos: ["pdf", "png", "jpg", "jpeg"],
        mensaje_espera: "Subiendo archivo...",
        mensaje_exito: "✅ Comprobante recibido. Tu pago está en proceso de validación.",
        mensaje_error: "❌ Error al subir el archivo. Asegúrate de que sea PDF, PNG o JPG y que no supere 5 MB.",
        // 🔹 NUEVO: botón para cambiar medio de pago
        botones: [
            {
            texto: "Cambiar medio de pago",
            tipo: "intencion",
            destino: "opciones_pago_deuda_antiguo"
            }
        ]
    },
    {//validando comprobante deuda antiguo cd
        etiqueta: "validando_comprobante_deuda_ant_cd",
        claves: [
            "validacion comprobante deuda",
            "validar comprobante deuda"
        ],
        respuesta: "✅ Comprobante recibido. Tu pago está en proceso de validación. Una vez validado, se enviará un correo al email del acudiente.",
        accion: "validando_comprobante_deuda_ant_cd"
    },
    {//mostrar datos actuales ant cd
        etiqueta: "datos_actuales_ant_cd",
        claves: [
            "datos actuales antiguo"
        ],
        respuesta: "Estos son los datos que actualmente se registran en nuestro sistema:",
        accion: "datos_actuales_ant_cd",
        url: "http://localhost:90/avmeeuu/avmeeuu/api/av_validar_documento.php",
        botones: [
            { 
                texto: "Actualizar datos", //Si 
                valor: "actualizar_datos", 
                tipo: "intencion", 
                destino: "formulario_inicial_ant_cd" 
            }/*,
            { 
                texto: "No", 
                valor: "no_actualizar_datos", 
                tipo: "intencion", 
                destino: "costos_matricula_ant_cd" 
            }*/
        ]
    },
    {//formulario inicial antiguo cd web service
        etiqueta: "formulario_inicial_ant_cd",
        claves: [
            "cargar datos iniciales", 
            "formulario inicial con datos", 
            "datos cargados del estudiante", 
            "información inicial cargada"
        ],
        respuesta: "Por favor, revisa y completa la información solicitada:",
        accion: "formulario_inicial_ant_cd",
        url: "http://localhost:90/avmeeuu/avmeeuu/api/av_validar_documento.php"
    },
    {//matrícula antiguo cd
        etiqueta: "costos_matricula_ant_cd",
        claves: ["matrícula", "costo matrícula", "pagar matrícula"], 
        respuesta: "Los costos de matrícula para el grado |X| son:",
        accion: "costos_matricula_ant_cd",
        botones: [
            { 
                texto: "Pagar matrícula", 
                valor: "pagar_matricula", 
                tipo: "intencion", 
                destino: "opciones_pago_matricula_antiguo_cd" 
            },
            { 
                texto: "Subir comprobante de pago", 
                valor: "subir_comprobante", 
                tipo: "intencion", 
                destino: "comprobante_matricula_ant_cd" 
            }
        ]
    },
    {//opciones pago matrícula cd
        etiqueta: "opciones_pago_matricula_antiguo_cd",
        claves: ["opciones de pago matrícula", "formas de pago matrícula"],
        respuesta: "Selecciona una opción de pago para la matrícula de",
        accion: "opciones_pago_matricula_antiguo_cd",
        botones: [
            { 
                texto: "Pago a través de Mi Pago Amigo Banco Caja Social", 
                valor: "mi_pago_amigo", 
                tipo: "servicio", 
                url: "https://www.mipagoamigo.com/MPA_WebSite/ServicePayments/StartPayment?id=3555&searchedCategoryId=&searchedAgreementName=UNICAB%20CORPORACION%20EDUCATIVA" 
            },
            { 
                texto: "Cuenta Banco Caja Social", 
                valor: "cuenta_caja_social", 
                tipo: "servicio", 
                url: "https://unicab.org/assets/img/cuenta_corriente_cajasocial.jpg" 
            },
            { 
                texto: "Cuenta Banco Av Villas", 
                valor: "cuenta_av_villas", 
                tipo: "servicio", 
                url: "https://unicab.org/assets/img/cuenta_corriente_avvillas.jpg" 
            },
            { 
                texto: "Link de pago a través de Epayco", 
                valor: "link_pago_epayco", 
                tipo: "servicio", 
                url: "pagoMatricula.php" 
            },
            { 
                texto: "Subir comprobante de pago", 
                valor: "subir_comprobante", 
                tipo: "intencion", 
                destino: "comprobante_matricula_ant_cd" 
            }
        ]
    },
    {//comprobante matrícula antiguo cd
        etiqueta: "comprobante_matricula_ant_cd",
        claves: [
            "subir comprobante matrícula",
            "enviar comprobante matrícula",
            "adjuntar comprobante matrícula",
            "cargar comprobante matrícula"
        ],
        respuesta: "Por favor, adjunta tu comprobante de pago matrícula por valor de",
        accion: "comprobante_matricula_ant_cd",
        tipos: ["pdf", "png", "jpg", "jpeg"],
        mensaje_espera: "Subiendo archivo...",
        mensaje_exito: "✅ Comprobante recibido. Tu pago está en proceso de validación.",
        mensaje_error: "❌ Error al subir el archivo. Asegúrate de que sea PDF, PNG o JPG y que no supere 5 MB.",
        // 🔹 NUEVO: botón para cambiar medio de pago
        botones: [
            {
            texto: "Cambiar medio de pago",
            tipo: "intencion",
            destino: "opciones_pago_matricula_antiguo_cd"
            }
        ]
    },
    {//validando comprobante matrícula antiguo cd
        etiqueta: "validando_comprobante_matricula_ant_cd",
        claves: [
            "validacion comprobante matrícula",
            "validar comprobante matrícula"
        ],
        respuesta: "✅ Comprobante recibido. Tu pago está en proceso de validación. Una vez validado, se enviará un correo al email del acudiente.",
        accion: "validando_comprobante_matricula_ant_cd"
    },
    {//documentos finales ant cd
        etiqueta: "documentos_finales_ant_cd",
        claves: [
            "documentos finales antiguo"
        ],
        respuesta: "Estos son los documentos que se deben subir:",
        accion: "documentos_finales_ant_cd",
        tipos: ["pdf"],
        botones: [
            {
            texto: "Subir documentos y completar datos",
            tipo: "intencion",
            destino: "formulario_final_antiguo_cd"
            }
        ]
    },
    {//formulario final antiguo cd web service
        etiqueta: "formulario_final_antiguo_cd",
        claves: [
            "cargar datos finales", 
            "formulario final con datos", 
            "información final cargada"
        ],
        respuesta: "Por favor, revisa y completa la información solicitada:",
        accion: "formulario_final_antiguo_cd",
        url: "http://localhost:90/avmeeuu/avmeeuu/api/av_validar_documento.php"
    },
    {//validando documentos antiguo cd
        etiqueta: "validando_documentos_ant_cd",
        claves: [
            "validacion comprobante matrícula",
            "validar comprobante matrícula"
        ],
        respuesta: "✅ Documentos recibidos. Documentos en proceso de validación.",
        accion: "validando_documentos_ant_cd"
    },
    {//Mensaje final
        etiqueta: "resumen_ant_cd",
        claves: ["final admisión", "proceso finalizado", "terminar admisión", "admisión completada"],
        respuesta: "",
        accion: "resumen_ant_cd",
        imagen: "chatbot/img/final2.png"
    },


    
    // ######### 3 Antiguo Nuevo con Deuda ##########
    {//deuda pendiente antiguo nuevo cd
        etiqueta: "valor_dueda_ant_nuevo_cd",
        claves: ["deuda pendiente", "tengo deuda", "pagar deuda", "pago pendiente", "saldo pendiente"], 
        respuesta: "",
        accion: "valor_dueda_ant_nuevo_cd",
        //boton_pagar_deuda: "Pagar deuda",
        //destino: "opciones_pago",
        botones: [
            { 
                texto: "Pagar deuda", 
                valor: "pagar_deuda", 
                tipo: "intencion", 
                destino: "opciones_pago_deuda_antiguo_nuevo" 
            },
            { 
                texto: "Subir comprobante de pago", 
                valor: "subir_comprobante", 
                tipo: "intencion", 
                destino: "comprobante_deuda_ant_nuevo_cd" 
            }
        ]
    },
    {//opciones pago deuda antiguo nuevo cd
        etiqueta: "opciones_pago_deuda_antiguo_nuevo",
        claves: ["opciones de pago deuda", "formas de pago deuda"], // No necesita palabras clave, se activa por botón
        respuesta: "Selecciona una opción de pago para la deuda de",
        accion: "opciones_pago_deuda_antiguo_nuevo",
        botones: [
            { 
                texto: "Pago a través de Mi Pago Amigo Banco Caja Social", 
                valor: "mi_pago_amigo", 
                tipo: "servicio", 
                url: "https://www.mipagoamigo.com/MPA_WebSite/ServicePayments/StartPayment?id=3555&searchedCategoryId=&searchedAgreementName=UNICAB%20CORPORACION%20EDUCATIVA" 
            },
            { 
                texto: "Cuenta Banco Caja Social", 
                valor: "cuenta_caja_social", 
                tipo: "servicio", 
                url: "https://unicab.org/assets/img/cuenta_corriente_cajasocial.jpg" 
            },
            { 
                texto: "Cuenta Banco Av Villas", 
                valor: "cuenta_av_villas", 
                tipo: "servicio", 
                url: "https://unicab.org/assets/img/cuenta_corriente_avvillas.jpg" 
            },
            { 
                texto: "Link de pago a través de Epayco", 
                valor: "link_pago_epayco", 
                tipo: "servicio", 
                url: "pagoDeuda.php" 
            },
            { 
                texto: "Subir comprobante de pago", 
                valor: "subir_comprobante", 
                tipo: "intencion", 
                destino: "comprobante_deuda_ant_nuevo_cd" 
            }
        ]
    },
    {//comprobante deuda antiguo nuevo cd
        etiqueta: "comprobante_deuda_ant_nuevo_cd",
        claves: [
            "subir comprobante deuda",
            "enviar comprobante deuda",
            "adjuntar comprobante deuda",
            "cargar comprobante deuda"
        ],
        respuesta: "Por favor, adjunta tu comprobante de pago deuda por valor de",
        accion: "comprobante_deuda_ant_nuevo_cd",
        tipos: ["pdf", "png", "jpg", "jpeg"],
        mensaje_espera: "Subiendo archivo...",
        mensaje_exito: "✅ Comprobante recibido. Tu pago está en proceso de validación.",
        mensaje_error: "❌ Error al subir el archivo. Asegúrate de que sea PDF, PNG o JPG y que no supere 5 MB.",
        // 🔹 NUEVO: botón para cambiar medio de pago
        botones: [
            {
            texto: "Cambiar medio de pago",
            tipo: "intencion",
            destino: "opciones_pago_deuda_antiguo_nuevo"
            }
        ]
    },
    {//validando comprobante deuda antiguo nuevo cd
        etiqueta: "validando_comprobante_deuda_ant_nuevo_cd",
        claves: [
            "validacion comprobante deuda",
            "validar comprobante deuda"
        ],
        respuesta: "✅ Comprobante recibido. Tu pago está en proceso de validación. Una vez validado, se enviará un correo al email del acudiente.",
        accion: "validando_comprobante_deuda_ant_nuevo_cd"
    },
    {//mostrar datos actuales ant nuevo cd
        etiqueta: "datos_actuales_ant_nuevo_cd",
        claves: [
            "datos actuales antiguo nuevo"
        ],
        respuesta: "Estos son los datos que actualmente se registran en nuestro sistema:",
        accion: "datos_actuales_ant_nuevo_cd",
        url: "http://localhost:990/avmeeuu/avmeeuu/api/av_validar_documento.php",
        botones: [
            { 
                texto: "Actualizar datos", //Si 
                valor: "actualizar_datos", 
                tipo: "intencion", 
                destino: "formulario_inicial_ant_nuevo_cd" 
            },
            { 
                texto: "No", 
                valor: "no_actualizar_datos", 
                tipo: "intencion", 
                destino: "evaluacion_admision_ant_nuevo_cd" 
            }
        ]
    },
    {//formulario inicial antiguo nuevo cd web service
        etiqueta: "formulario_inicial_ant_nuevo_cd",
        claves: [
            "cargar datos iniciales", 
            "formulario inicial con datos", 
            "datos cargados del estudiante", 
            "información inicial cargada"
        ],
        respuesta: "Por favor, revisa y completa la información solicitada:",
        accion: "formulario_inicial_ant_nuevo_cd",
        url: "http://localhost:90/avmeeuu/avmeeuu/api/av_validar_documento.php" // ← Tu API real
    },
    {//botón evaluación admisión ant nuevo cd
        etiqueta: "evaluacion_admision_ant_nuevo_cd",
        claves: [
            "evaluación admisión antiguo nuevo"
        ],
        respuesta: "Es necesario que presentes una evaluación de admisión para el grado:",
        accion: "evaluacion_admision_ant_nuevo_cd",
        botones: [
            { 
                texto: "Link Evaluación Admisión",
                valor: "link_evaluacion_admision", 
                tipo: "servicio", 
                url: ":https//unicab.org/homeunicabpro/business/org/pages/evaluacionPresaberes_sm.php" 
            }
        ]
    },
    {//opciones entrevista ant nuevo cd
        etiqueta: "entrevista_ant_nuevo_cd",
        claves: [
            "opciones entrevista antiguo nuevo"
        ],
        url: "http://localhost:90/avmeeuu/avmeeuu/api/av_opciones_entrevista.php",
        respuesta: "Es necesario que presentes una entrevista. Selecciona un día y hora para la entrevista:",
        accion: "entrevista_ant_nuevo_cd"
    },
    {//reprogramar entrevista antiguo nuevo cd
        etiqueta: "reprogramar_entrevista_ant_nuevo_cd",
        claves: [
            "reprogramar entrevista antiguo nuevo"
        ],
        respuesta: "",
        accion: "reprogramar_entrevista_ant_nuevo_cd",
        botones: [
            {
            texto: "Reprogramar entrevista",
            tipo: "intencion",
            destino: "entrevista_ant_nuevo_cd"
            }
        ]
    },
    {//matrícula antiguo nuevo cd
        etiqueta: "costos_matricula_ant_nuevo_cd",
        claves: ["matrícula", "costo matrícula", "pagar matrícula"], 
        respuesta: "Los costos de matrícula para el grado |X| son:",
        accion: "costos_matricula_ant_nuevo_cd",
        botones: [
            { 
                texto: "Pagar matrícula", 
                valor: "pagar_matricula", 
                tipo: "intencion", 
                destino: "opciones_pago_matricula_antiguo_nuevo_cd" 
            },
            { 
                texto: "Subir comprobante de pago", 
                valor: "subir_comprobante", 
                tipo: "intencion", 
                destino: "comprobante_matricula_ant_nuevo_cd" 
            }
        ]
    },
    {//opciones pago matrícula antiguo nuevo cd
        etiqueta: "opciones_pago_matricula_antiguo_nuevo_cd",
        claves: ["opciones de pago matrícula", "formas de pago matrícula"], // No necesita palabras clave, se activa por botón
        respuesta: "Selecciona una opción de pago para la matrícula de",
        accion: "opciones_pago_matricula_antiguo_nuevo_cd",
        botones: [
            { 
                texto: "Pago a través de Mi Pago Amigo Banco Caja Social", 
                valor: "mi_pago_amigo", 
                tipo: "servicio", 
                url: "https://www.mipagoamigo.com/MPA_WebSite/ServicePayments/StartPayment?id=3555&searchedCategoryId=&searchedAgreementName=UNICAB%20CORPORACION%20EDUCATIVA" 
            },
            { 
                texto: "Cuenta Banco Caja Social", 
                valor: "cuenta_caja_social", 
                tipo: "servicio", 
                url: "https://unicab.org/assets/img/cuenta_corriente_cajasocial.jpg" 
            },
            { 
                texto: "Cuenta Banco Av Villas", 
                valor: "cuenta_av_villas", 
                tipo: "servicio", 
                url: "https://unicab.org/assets/img/cuenta_corriente_avvillas.jpg" 
            },
            { 
                texto: "Link de pago a través de Epayco", 
                valor: "link_pago_epayco", 
                tipo: "servicio", 
                url: "pagoMatricula.php" 
            },
            { 
                texto: "Subir comprobante de pago", 
                valor: "subir_comprobante", 
                tipo: "intencion", 
                destino: "comprobante_matricula_ant_nuevo_cd" 
            }
        ]
    },
    {//comprobante matrícula antiguo nuevo cd
        etiqueta: "comprobante_matricula_ant_nuevo_cd",
        claves: [
            "subir comprobante matrícula",
            "enviar comprobante matrícula",
            "adjuntar comprobante matrícula",
            "cargar comprobante matrícula"
        ],
        respuesta: "Por favor, adjunta tu comprobante de pago matrícula por valor de",
        accion: "comprobante_matricula_ant_nuevo_cd",
        tipos: ["pdf", "png", "jpg", "jpeg"],
        mensaje_espera: "Subiendo archivo...",
        mensaje_exito: "✅ Comprobante recibido. Tu pago está en proceso de validación.",
        mensaje_error: "❌ Error al subir el archivo. Asegúrate de que sea PDF, PNG o JPG y que no supere 5 MB.",
        // 🔹 NUEVO: botón para cambiar medio de pago
        botones: [
            {
            texto: "Cambiar medio de pago",
            tipo: "intencion",
            destino: "opciones_pago_matricula_antiguo_nuevo_cd"
            }
        ]
    },
    {//validando comprobante matrícula antiguo nuevo cd
        etiqueta: "validando_comprobante_matricula_ant_nuevo_cd",
        claves: [
            "validacion comprobante matrícula",
            "validar comprobante matrícula"
        ],
        respuesta: "✅ Comprobante recibido. Tu pago está en proceso de validación. Una vez validado, se enviará un correo al email del acudiente.",
        accion: "validando_comprobante_matricula_ant_nuevo_cd"
    },
    {//documentos finales ant nuevo cd
        etiqueta: "documentos_finales_ant_nuevo_cd",
        claves: [
            "documentos finales antiguo nuevo"
        ],
        respuesta: "Estos son los documentos que se deben subir:",
        accion: "documentos_finales_ant_nuevo_cd",
        tipos: ["pdf"],
        botones: [
            {
            texto: "Subir documentos y completar datos",
            tipo: "intencion",
            destino: "formulario_final_antiguo_nuevo_cd"
            }
        ]
    },
    {//formulario final antiguo nuevo cd web service
        etiqueta: "formulario_final_antiguo_nuevo_cd",
        claves: [
            "cargar datos finales", 
            "formulario final con datos", 
            "información final cargada"
        ],
        respuesta: "Por favor, revisa y completa la información solicitada:",
        accion: "formulario_final_antiguo_nuevo_cd",
        url: "http://localhost:90/avmeeuu/avmeeuu/api/av_validar_documento.php" // ← Tu API real
    },
    {//validando documentos antiguo nuevo cd
        etiqueta: "validando_documentos_ant_nuevo_cd",
        claves: [
            "validacion comprobante matrícula",
            "validar comprobante matrícula"
        ],
        respuesta: "✅ Documentos recibidos. Documentos en proceso de validación.",
        accion: "validando_documentos_ant_nuevo_cd"
    },
    {//Mensaje final
        etiqueta: "resumen_ant_nuevo_cd",
        claves: ["final admisión", "proceso finalizado", "terminar admisión", "admisión completada"],
        respuesta: "",
        accion: "resumen_ant_nuevo_cd",
        imagen: "chatbot/img/final2.png"
    },


    // ######### 4 Antiguo Nuevo sin Deuda ##########
    {//mostrar datos actuales ant nuevo sd
        etiqueta: "datos_actuales_ant_nuevo_sd",
        claves: [
            "datos actuales antiguo nuevo"
        ],
        respuesta: "Estos son los datos que actualmente se registran en nuestro sistema:",
        accion: "datos_actuales_ant_nuevo_sd",
        url: "http://localhost:90/avmeeuu/avmeeuu/api/av_validar_documento.php",
        botones: [
            { 
                texto: "Actualizar datos", //Si 
                valor: "actualizar_datos", 
                tipo: "intencion", 
                destino: "formulario_inicial_ant_nuevo_sd" 
            },
            { 
                texto: "No", 
                valor: "no_actualizar_datos", 
                tipo: "intencion", 
                destino: "evaluacion_admision_ant_nuevo_sd" 
            }
        ]
    },
    {//formulario inicial antiguo nuevo sd web service
        etiqueta: "formulario_inicial_ant_nuevo_sd",
        claves: [
            "cargar datos iniciales", 
            "formulario inicial con datos", 
            "datos cargados del estudiante", 
            "información inicial cargada"
        ],
        respuesta: "Por favor, revisa y completa la información solicitada:",
        accion: "formulario_inicial_ant_nuevo_sd",
        url: "http://localhost:90/avmeeuu/avmeeuu/api/av_validar_documento.php"
    },
    {//botón evaluación admisión ant nuevo sd
        etiqueta: "evaluacion_admision_ant_nuevo_sd",
        claves: [
            "evaluación admisión antiguo nuevo"
        ],
        respuesta: "Es necesario que presentes una evaluación de admisión para el grado:",
        accion: "evaluacion_admision_ant_nuevo_sd",
        botones: [
            { 
                texto: "Link Evaluación Admisión",
                valor: "link_evaluacion_admision", 
                tipo: "servicio", 
                url: "http://localhost:90/avmeeuu/avmeeuu/api/evaluacionPresaberes_sm.php" 
            }
        ]
    },
    {//opciones entrevista ant nuevo sd
        etiqueta: "entrevista_ant_nuevo_sd",
        claves: [
            "opciones entrevista antiguo nuevo"
        ],
        url: "http://localhost:90/avmeeuu/avmeeuu/api/av_opciones_entrevista.php",
        respuesta: "Es necesario que presentes una entrevista. Selecciona un día y hora para la entrevista:",
        accion: "entrevista_ant_nuevo_sd"
    },
    {//reprogramar entrevista antiguo nuevo sd
        etiqueta: "reprogramar_entrevista_ant_nuevo_sd",
        claves: [
            "reprogramar entrevista antiguo nuevo"
        ],
        respuesta: "",
        accion: "reprogramar_entrevista_ant_nuevo_sd",
        botones: [
            {
            texto: "Reprogramar entrevista",
            tipo: "intencion",
            destino: "entrevista_ant_nuevo_sd"
            }
        ]
    },
    {//matrícula antiguo nuevo sd
        etiqueta: "costos_matricula_ant_nuevo_sd",
        claves: ["matrícula", "costo matrícula", "pagar matrícula"], 
        respuesta: "Los costos de matrícula para el grado |X| son:",
        accion: "costos_matricula_ant_nuevo_sd",
        botones: [
            { 
                texto: "Pagar matrícula", 
                valor: "pagar_matricula", 
                tipo: "intencion", 
                destino: "opciones_pago_matricula_antiguo_nuevo_sd" 
            },
            { 
                texto: "Subir comprobante de pago", 
                valor: "subir_comprobante", 
                tipo: "intencion", 
                destino: "comprobante_matricula_ant_nuevo_sd" 
            }
        ]
    },
    {//opciones pago matrícula antiguo nuevo sd
        etiqueta: "opciones_pago_matricula_antiguo_nuevo_sd",
        claves: ["opciones de pago matrícula", "formas de pago matrícula"], // No necesita palabras clave, se activa por botón
        respuesta: "Selecciona una opción de pago para la matrícula de",
        accion: "opciones_pago_matricula_antiguo_nuevo_sd",
        botones: [
            { 
                texto: "Pago a través de Mi Pago Amigo Banco Caja Social", 
                valor: "mi_pago_amigo", 
                tipo: "servicio", 
                url: "https://www.mipagoamigo.com/MPA_WebSite/ServicePayments/StartPayment?id=3555&searchedCategoryId=&searchedAgreementName=UNICAB%20CORPORACION%20EDUCATIVA" 
            },
            { 
                texto: "Cuenta Banco Caja Social", 
                valor: "cuenta_caja_social", 
                tipo: "servicio", 
                url: "https://unicab.org/assets/img/cuenta_corriente_cajasocial.jpg" 
            },
            { 
                texto: "Cuenta Banco Av Villas", 
                valor: "cuenta_av_villas", 
                tipo: "servicio", 
                url: "https://unicab.org/assets/img/cuenta_corriente_avvillas.jpg" 
            },
            { 
                texto: "Link de pago a través de Epayco", 
                valor: "link_pago_epayco", 
                tipo: "servicio", 
                url: "pagoMatricula.php" 
            },
            { 
                texto: "Subir comprobante de pago", 
                valor: "subir_comprobante", 
                tipo: "intencion", 
                destino: "comprobante_matricula_ant_nuevo_sd" 
            }
        ]
    },
    {//comprobante matrícula antiguo nuevo sd
        etiqueta: "comprobante_matricula_ant_nuevo_sd",
        claves: [
            "subir comprobante matrícula",
            "enviar comprobante matrícula",
            "adjuntar comprobante matrícula",
            "cargar comprobante matrícula"
        ],
        respuesta: "Por favor, adjunta tu comprobante de pago matrícula por valor de",
        accion: "comprobante_matricula_ant_nuevo_sd",
        tipos: ["pdf", "png", "jpg", "jpeg"],
        mensaje_espera: "Subiendo archivo...",
        mensaje_exito: "✅ Comprobante recibido. Tu pago está en proceso de validación.",
        mensaje_error: "❌ Error al subir el archivo. Asegúrate de que sea PDF, PNG o JPG y que no supere 5 MB.",
        // 🔹 NUEVO: botón para cambiar medio de pago
        botones: [
            {
            texto: "Cambiar medio de pago",
            tipo: "intencion",
            destino: "opciones_pago_matricula_antiguo_nuevo_sd"
            }
        ]
    },
    {//validando comprobante matrícula antiguo nuevo sd
        etiqueta: "validando_comprobante_matricula_ant_nuevo_sd",
        claves: [
            "validacion comprobante matrícula",
            "validar comprobante matrícula"
        ],
        respuesta: "✅ Comprobante recibido. Tu pago está en proceso de validación. Una vez validado, se enviará un correo al email del acudiente.",
        accion: "validando_comprobante_matricula_ant_nuevo_sd"
    },
    {//documentos finales ant nuevo sd
        etiqueta: "documentos_finales_ant_nuevo_sd",
        claves: [
            "documentos finales antiguo nuevo"
        ],
        respuesta: "Estos son los documentos que se deben subir:",
        accion: "documentos_finales_ant_nuevo_sd",
        tipos: ["pdf"],
        botones: [
            {
            texto: "Subir documentos y completar datos",
            tipo: "intencion",
            destino: "formulario_final_antiguo_nuevo_sd"
            }
        ]
    },
    {//formulario final antiguo nuevo sd web service
        etiqueta: "formulario_final_antiguo_nuevo_sd",
        claves: [
            "cargar datos finales", 
            "formulario final con datos", 
            "información final cargada"
        ],
        respuesta: "Por favor, revisa y completa la información solicitada:",
        accion: "formulario_final_antiguo_nuevo_sd",
        url: "http://localhost:90/avmeeuu/avmeeuu/api/av_validar_documento.php" 
    },
    {//validando documentos antiguo nuevo sd
        etiqueta: "validando_documentos_ant_nuevo_sd",
        claves: [
            "validacion comprobante matrícula",
            "validar comprobante matrícula"
        ],
        respuesta: "✅ Documentos recibidos. Documentos en proceso de validación.",
        accion: "validando_documentos_ant_nuevo_sd"
    },
    {//Mensaje final
        etiqueta: "resumen_ant_nuevo_sd",
        claves: ["final admisión", "proceso finalizado", "terminar admisión", "admisión completada"],
        respuesta: "",
        accion: "resumen_ant_nuevo_sd",
        imagen: "chatbot/img/final2.png"
    },


    // ######### 5 Nuevo ##########
    {//formulario inicial nuevo
        etiqueta: "formulario_inicial_nuevo",
        claves: [
            "cargar datos iniciales", 
            "formulario inicial nuevo"
        ],
        respuesta: "Te damos la bienvenida a formar parte de nuestro ecosistema de educación. Por favor, completa la información solicitada:",
        accion: "formulario_inicial_nuevo",
        url: "http://localhost:90/avmeeuu/avmeeuu/api/av_validar_documento.php"
    },
    {//botón evaluación nuevo
        etiqueta: "evaluacion_admision_nuevo",
        claves: [
            "evaluación admisión nuevo"
        ],
        respuesta: "Es necesario que presentes una evaluación de admisión para el grado:",
        accion: "evaluacion_admision_nuevo",
        botones: [
            { 
                texto: "Link Evaluación Admisión",
                valor: "link_evaluacion_admision", 
                tipo: "servicio", 
                url: "https://unicab.org/homeunicabpro/business/org/pages/evaluacionPresaberes_sm.php" 
            }
        ]
    },
    {//opciones entrevista nuevo
        etiqueta: "entrevista_nuevo",
        claves: [
            "opciones entrevista nuevo"
        ],
        url: "http://localhost:90/avmeeuu/avmeeuu/api/av_opciones_entrevista.php",
        respuesta: "Es necesario que presentes una entrevista. Selecciona un día y hora para la entrevista:",
        accion: "entrevista_nuevo"
    },
    {//reprogramar entrevista nuevo
        etiqueta: "reprogramar_entrevista_nuevo",
        claves: [
            "reprogramar entrevista nuevo"
        ],
        respuesta: "",
        accion: "reprogramar_entrevista_nuevo",
        botones: [
            {
            texto: "Reprogramar entrevista",
            tipo: "intencion",
            destino: "entrevista_nuevo"
            }
        ]
    },
    {//matrícula nuevo
        etiqueta: "costos_matricula_nuevo",
        claves: ["matrícula", "costo matrícula", "pagar matrícula"], 
        respuesta: "Los costos de matrícula para el grado |X| son:",
        accion: "costos_matricula_nuevo",
        botones: [
            { 
                texto: "Pagar matrícula", 
                valor: "pagar_matricula", 
                tipo: "intencion", 
                destino: "opciones_pago_matricula_nuevo" 
            },
            { 
                texto: "Subir comprobante de pago", 
                valor: "subir_comprobante", 
                tipo: "intencion", 
                destino: "comprobante_matricula_nuevo" 
            }
        ]
    },
    {//opciones pago matrícula nuevo
        etiqueta: "opciones_pago_matricula_nuevo",
        claves: ["opciones de pago matrícula", "formas de pago matrícula"], // No necesita palabras clave, se activa por botón
        respuesta: "Selecciona una opción de pago para la matrícula de",
        accion: "opciones_pago_matricula_nuevo",
        botones: [
            { 
                texto: "Pago a través de Mi Pago Amigo Banco Caja Social", 
                valor: "mi_pago_amigo", 
                tipo: "servicio", 
                url: "https://www.mipagoamigo.com/MPA_WebSite/ServicePayments/StartPayment?id=3555&searchedCategoryId=&searchedAgreementName=UNICAB%20CORPORACION%20EDUCATIVA" 
            },
            { 
                texto: "Cuenta Banco Caja Social", 
                valor: "cuenta_caja_social", 
                tipo: "servicio", 
                url: "https://unicab.org/assets/img/cuenta_corriente_cajasocial.jpg" 
            },
            { 
                texto: "Cuenta Banco Av Villas", 
                valor: "cuenta_av_villas", 
                tipo: "servicio", 
                url: "https://unicab.org/assets/img/cuenta_corriente_avvillas.jpg" 
            },
            { 
                texto: "Link de pago a través de Epayco", 
                valor: "link_pago_epayco", 
                tipo: "servicio", 
                url: "pagoMatricula.php" 
            },
            { 
                texto: "Subir comprobante de pago", 
                valor: "subir_comprobante", 
                tipo: "intencion", 
                destino: "comprobante_matricula_nuevo" 
            }
        ]
    },
    {//comprobante matrícula nuevo
        etiqueta: "comprobante_matricula_nuevo",
        claves: [
            "subir comprobante matrícula",
            "enviar comprobante matrícula",
            "adjuntar comprobante matrícula",
            "cargar comprobante matrícula"
        ],
        respuesta: "Por favor, adjunta tu comprobante de pago matrícula por valor de",
        accion: "comprobante_matricula_nuevo",
        tipos: ["pdf", "png", "jpg", "jpeg"],
        mensaje_espera: "Subiendo archivo...",
        mensaje_exito: "✅ Comprobante recibido. Tu pago está en proceso de validación.",
        mensaje_error: "❌ Error al subir el archivo. Asegúrate de que sea PDF, PNG o JPG y que no supere 5 MB.",
        // 🔹 NUEVO: botón para cambiar medio de pago
        botones: [
            {
            texto: "Cambiar medio de pago",
            tipo: "intencion",
            destino: "opciones_pago_matricula_nuevo"
            }
        ]
    },
    {//validando comprobante matrícula nuevo
        etiqueta: "validando_comprobante_matricula_nuevo",
        claves: [
            "validacion comprobante matrícula",
            "validar comprobante matrícula"
        ],
        respuesta: "✅ Comprobante recibido. Tu pago está en proceso de validación. Una vez validado, se enviará un correo al email del acudiente.",
        accion: "validando_comprobante_matricula_nuevo"
    },
    {//documentos finales nuevo
        etiqueta: "documentos_finales_nuevo",
        claves: [
            "documentos finales nuevo"
        ],
        respuesta: "Estos son los documentos que se deben subir:",
        accion: "documentos_finales_nuevo",
        tipos: ["pdf"],
        botones: [
            {
            texto: "Subir documentos y completar datos",
            tipo: "intencion",
            destino: "formulario_final_nuevo"
            }
        ]
    },
    {//formulario final nuevo web service
        etiqueta: "formulario_final_nuevo",
        claves: [
            "cargar datos finales", 
            "formulario final con datos", 
            "información final cargada"
        ],
        respuesta: "Por favor, revisa y completa la información solicitada:",
        accion: "formulario_final_nuevo",
        url: "http://localhost:90/avmeeuu/avmeeuu/api/av_validar_documento.php" 
    },
    {//validando documentos nuevo
        etiqueta: "validando_documentos_nuevo",
        claves: [
            "validacion comprobante matrícula",
            "validar comprobante matrícula"
        ],
        respuesta: "✅ Documentos recibidos. Documentos en proceso de validación.",
        accion: "validando_documentos_nuevo"
    },
    {//Mensaje final
        etiqueta: "resumen_nuevo",
        claves: ["final admisión", "proceso finalizado", "terminar admisión", "admisión completada"],
        respuesta: "",
        accion: "resumen_nuevo",
        imagen: "chatbot/img/final2.png"
    },


    {//formulario final para cargar documentos inválidos
        etiqueta: "formulario_final_documentos_invalidos",
        claves: [
            "cargar datos finales", 
            "formulario final con datos", 
            "información final cargada"
        ],
        respuesta: "Por favor, sube los siguientes documentos:",
        accion: "formulario_final_documentos_invalidos",
        url: "http://localhost:90/avmeeuu/avmeeuu/api/av_validar_documento.php"
    },


    {//formulario inicial
        etiqueta: "formulario_inicial",
        claves: [
            "formulario inicial", 
            "datos iniciales del estudiante", 
            "información inicial"
        ],
        respuesta: "Por favor, completa los siguientes datos:",
        accion: "formulario_inicial",
        campos: [
            // Paso 1: Datos del estudiante
            {
                seccion: "Paso 1 - DATOS COMPLEMENTARIOS DEL ESTUDIANTE",
                campos: [
                    { nombre: "apellidos", etiqueta: "Apellidos", tipo: "text" },
                    { nombre: "nombres", etiqueta: "Nombres", tipo: "text" },
                    { 
                        nombre: "grado", 
                        etiqueta: "Selecciona el grado a que ingresas", 
                        tipo: "select", 
                        opciones: [
                            { valor: "Cuarto", texto: "Cuarto" },
                            { valor: "Quinto", texto: "Quinto" },
                            { valor: "Sexto", texto: "Sexto" }
                        ]
                    },
                    { nombre: "telefono", etiqueta: "Número telefónico", tipo: "text" },
                    { nombre: "correo", etiqueta: "Correo electrónico", tipo: "email" },
                    { nombre: "confirmar_correo", etiqueta: "Confirmar correo electrónico", tipo: "email" },
                    { 
                        nombre: "medio_llegada", 
                        etiqueta: "Selecciona el medio de llegada", 
                        tipo: "select", 
                        opciones: [
                            { valor: "PAGINA WEB UNICAB", texto: "PÁGINA WEB UNICAB" },
                            { valor: "REDES SOCIALES", texto: "REDES SOCIALES" },
                            { valor: "REFERRAL", texto: "REFERRAL" }
                        ]
                    },
                    { 
                        nombre: "genero", 
                        etiqueta: "Género", 
                        tipo: "select", 
                        opciones: [
                            { valor: "MASCULINO", texto: "MASCULINO" },
                            { valor: "FEMENINO", texto: "FEMENINO" },
                            { valor: "OTRO", texto: "OTRO" }
                        ]
                    },
                    { nombre: "factor_rh", etiqueta: "Factor RH", tipo: "text" },
                    { nombre: "actividad_extra", etiqueta: "Actividad extra", tipo: "text" }
                ]
            },
            // Paso 2: Situación socio-económica
            {
                seccion: "Paso 2 - SITUACIÓN SOCIO-ECONÓMICA",
                campos: [
                    { 
                        nombre: "motivo_matricula", 
                        etiqueta: "Motivo para matricular", 
                        tipo: "textarea", 
                        placeholder: "Máximo 2000 caracteres. Ej: Mi hijo necesita educación virtual por razones económicas...",
                        rows: 8
                    }
                ]
            },
            // Paso 3: Datos del acudiente
            {
                seccion: "Paso 3 - DATOS COMPLEMENTARIOS DEL ACUDIENTE",
                campos: [
                    { nombre: "nombre_acudiente", etiqueta: "Nombre", tipo: "text" },
                    { nombre: "documento_acudiente", etiqueta: "Documento", tipo: "text" },
                    { nombre: "celular_acudiente", etiqueta: "Celular", tipo: "text" },
                    { nombre: "correo_acudiente", etiqueta: "Correo electrónico acudiente", tipo: "email" },
                    { nombre: "confirmar_correo_acudiente", etiqueta: "Confirmar correo electrónico acudiente", tipo: "email" },
                    { 
                        nombre: "parentesco", 
                        etiqueta: "Parentesco", 
                        tipo: "select", 
                        opciones: [
                            { valor: "MADRE", texto: "MADRE" },
                            { valor: "PADRE", texto: "PADRE" },
                            { valor: "TÍO/A", texto: "TÍO/A" },
                            { valor: "ABUELO/A", texto: "ABUELO/A" }
                        ]
                    }
                ]
            }
        ],
        boton_enviar: "Enviar datos",
        mensaje_exito: "✅ Datos recibidos correctamente.",
        mensaje_error: "❌ Error: Por favor completa todos los campos."
    },
    {//costo
        etiqueta: "preguntar_costo",
        claves: ["cuánto cuesta", "precio", "costo", "dinero", "matrícula"],
        respuesta: "La matrícula tiene un costo de $200. Puedes pagarlo en una sola cuota o en 3, 6 o 12 mensualidades."
    },
    {//horario
        etiqueta: "preguntar_horario",
        claves: ["horario", "clases", "a qué hora", "cuándo son", "tiempo", "inicio", "finaliza"],
        respuesta: "Las clases son de lunes a viernes, de 8:00 a.m. a 2:00 p.m. La plataforma está disponible 24/7."
    },
    {//despedida
        etiqueta: "despedida",
        claves: ["gracias", "adiós", "chao", "hasta luego", "ya terminé", "listo"],
        respuesta: "Gracias a ti. Un asesor se contactará contigo pronto. ¡Que tengas un buen día!"
    },
    {//pago
        etiqueta: "preguntar_pago",
        claves: ["pago", "cuotas", "formas de pago", "método de pago", "pagar"],
        respuesta: "El costo de matrícula es $200. Selecciona una opción de pago:",
        botones: [
            { texto: "Opción 1: Pago único", valor: "pago_unico" },
            { texto: "Opción 2: 3 cuotas", valor: "pago_3_cuotas" },
            { texto: "Opción 3: 6 cuotas", valor: "pago_6_cuotas" }
        ]
    },
    {//datos complementarios
        etiqueta: "datos_complementarios",
        claves: ["datos adicionales", "información adicional", "completar datos", "más datos", "datos complementarios", "actualizar info"],
        respuesta: "Por favor, completa los siguientes datos:",
        accion: "mostrar_formulario",
        campos: [
            {
                nombre: "fecha_nacimiento",
                etiqueta: "Fecha de nacimiento",
                tipo: "date"
            },
            {
                nombre: "genero",
                etiqueta: "Género",
                tipo: "select",
                opciones: [
                    { valor: "masculino", texto: "Masculino" },
                    { valor: "femenino", texto: "Femenino" },
                    { valor: "otro", texto: "Otro" }
                ]
            },
            {
                nombre: "direccion",
                etiqueta: "Dirección",
                tipo: "text",
                placeholder: "Calle 123 # 45-67"
            },
            {
                nombre: "ciudad",
                etiqueta: "Ciudad",
                tipo: "text",
                placeholder: "Ej: Bogotá"
            }
        ],
        boton_enviar: "Enviar datos",
        mensaje_exito: "✅ Datos recibidos correctamente.",
        mensaje_error: "❌ Error: Por favor completa todos los campos."
    },
    {//descargar calendario
        etiqueta: "descargar_calendario",
        claves: [
            "descargar calendario", 
            "calendario de matrículas", 
            "calendario escolar", 
            "horario de inscripciones", 
            "cuándo es la matrícula", 
            "fechas importantes"
        ],
        respuesta: "Aquí tienes el calendario de matrículas. Haz clic en el botón para descargarlo.",
        accion: "abrir_pdf_externo",
        url: "https://unicab.org/calendario/calendario_2025.pdf",
        nombre_archivo: "Calendario de Matrículas 2025"
    },
    {//descargar documentos
        etiqueta: "descargar_documentos",
        claves: [
            "descargar documentos", 
            "documentos importantes", 
            "costos y manual", 
            "pdf de matrícula", 
            "información general", 
            "material institucional",
            "descargar costos",
            "descargar manual"
        ],
        respuesta: "Aquí tienes los documentos importantes del colegio:",
        accion: "descargar_multiples_pdfs",
        documentos: [
            {
                nombre: "Costos de Matrícula",
                url: "https://unicab.org/calendario/calendario_2025.pdf",
                color: "#007bff"
            },
            {
                nombre: "Manual de Convivencia",
                url: "https://unicab.org/calendario/calendario_2025.pdf",
                color: "#28a745"
            }
        ]
    },
    {// no entiendo
        etiqueta: "no_entendido",
        claves: [],
        respuesta: "No entendí tu mensaje. Por favor, puedes decirlo de otra forma. Ejemplo: 'Quiero matricular a mi hijo'."
    }
];