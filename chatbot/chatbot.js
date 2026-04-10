document.addEventListener("DOMContentLoaded", () => {
    const asistenteFullscreen = document.getElementById("asistente-fullscreen");
    const seccionChat = document.getElementById("seccion-chat");
    const entradaChat = document.getElementById("entrada-chat");
    const btnEnviar = document.getElementById("btn-enviar-chat");
    const chatMensajes = document.getElementById("chat-mensajes");
    const parrafoInicial = document.getElementById("p-inicial");
    const header1 = document.getElementById("header1");
    const header2 = document.getElementById("header2");
    let cc = 0;
    let deuda = 0;
    let matricula = 0;
    let paso = "";
    let a = 0;
    let etiqueta_intencion = "";
    let nombre_estudiante = "";
    let grado = "";
    let estado = "";
    let control_antiguos = 0;
    let meet_psicologo = "http://meet.google.com/uqq-iusq-umf";
    let con_nota_receso =  false;
    let nota_receso = "A partir del 12 de Diciembre hasta el 18 de Enero hay receso. Los procesos de validación de comprobantes de pago y documentos quedan suspendidos por este tiempo.";

    const date = new Date();
    const day = String(date.getDate()).padStart(2, '0');
    const month = date.getMonth();
    let month1 = "";
    const year = date.getFullYear();
    let year1 = year;
    if ((month + 1) >= 10) {
        year1++;
    }
    if ((month + 1) < 10) {
        month1 = "0" + (month + 1);
    }

    const fecha = year + "" + (month + 1) + "" + day; 
    const fecha2 = year + "-" + month1 + "-" + day; 
    let referencia_pago = "";
    let referencia_pago_m = "";
    let admitido = 0;
    let entrevista = "NO";
    let cierre1P = fecha;
    let cierre2P = fecha;
    let intentos_programacion_entrevista = 0;

    // Delegación para inputs y textareas
    document.addEventListener("input", (e) => {
        if (!e.target.hasAttribute("data-validar")) return;

        const tipo = e.target.getAttribute("data-validar");
        const id = e.target.id;
        const desc = e.target.getAttribute("data-desc");

        if (tipo === "texto") validar_texto(id, desc);
        if (tipo === "texto1") validar_texto1(id, desc);
        if (tipo === "rh") validar_rh(id, desc);
        if (tipo === "numero") validar_numero(id, desc);
        if (tipo === "email") validar_email(id, desc);

        // aquí SÍ llamamos al validador global una sola vez
        habilitarBoton(sonTodosValidos());
    });

    // Delegación para selects
    document.addEventListener("change", (e) => {
        if (e.target.getAttribute("data-validar") === "select") {
            const id = e.target.id;
            const desc = e.target.getAttribute("data-desc");
            if (e.target.value === "0") {
                mostrarError(`Seleccione una opción para ${desc}`, id);
            } else {
                ocultarError(id);
            }
        }

        // aquí SÍ llamamos al validador global una sola vez
        habilitarBoton(sonTodosValidos());
    });

    // Estado global
    let datosIniciales = {};

    // Función: Iniciar asistente
    window.iniciarAsistente = () => {
        asistenteFullscreen.style.display = "block";
        document.querySelector(".bot-inicio-inline").style.display = "none";

        agregarMensaje("Unibot", {
            respuesta: "¡Hola! Soy tu asistente de admisiones. Es un gusto asistirlo/a en el proceso.",
            botones: null // No hay botones aquí
        });

        // Mostrar menú inicial
        const respuestaCompleta = encontrarIntencion("iniciar admisiones");
        //console.log(respuestaCompleta);
        agregarMensaje("Unibot", respuestaCompleta);

        parrafoInicial.innerHTML = "Recuerda que si ya has iniciado el proceso de admisión, después de ingresar el número del documento del estudiante, será dirigido al paso en dónde quedaste por última vez.";
        parrafoInicial.style.color = "#0070C0";
        parrafoInicial.style.fontWeight = "bold";
        parrafoInicial.style.display = "none";

        header1.style.display = "none";
        header2.style.display = "flex";

        // Cambiar a sección de chat
        seccionChat.classList.add("activa");
    };

    // Evento: Enviar mensaje en chat
    btnEnviar.addEventListener("click", enviarMensaje);
    entradaChat.addEventListener("keypress", (e) => {
        if (e.key === "Enter") enviarMensaje();
    });

    // Función: Enviar mensaje
    function enviarMensaje() {
        const mensaje = entradaChat.value.trim();
        if (!mensaje) return;

        // Mostrar mensaje del usuario
        agregarMensaje("user", mensaje);

        // Obtener respuesta del bot
        const respuestaCompleta = encontrarIntencion(mensaje);
        agregarMensaje("Unibot", respuestaCompleta);

        // Limpiar entrada y hacer scroll
        entradaChat.value = "";
        chatMensajes.scrollTop = chatMensajes.scrollHeight;
    }

    // Función: Agregar mensaje al chat (con soporte para texto, botones y subida de archivos)
    function agregarMensaje(tipo, contenido) {        
        const contenedor = document.createElement("div");
        contenedor.style.margin = "6px 0";

        if (tipo === "user") {
            const msg = document.createElement("p");
            msg.className = "user-msg";
            msg.innerHTML = `<strong>Tú:</strong> ${contenido}`;
            //msg.style.textAlign = "right"; // ← Alinea a la derecha
            msg.style.marginLeft = "auto"; // ← Empuja a la derecha
            contenedor.appendChild(msg);
        } else {
            let respuesta = "";
            let botones = null;
            let accion = null;
            let url = null;
            let tipos = [];
            let campos = [];
            let documentos = [];
            let mensajeEspera = "Subiendo...";
            let mensajeExito = "Archivo subido correctamente.";
            let mensajeError = "Error al subir el archivo.";

            if (typeof contenido === 'object' && contenido !== null) {
                respuesta = contenido.respuesta || "";
                botones = contenido.botones || null;
                accion = contenido.accion || null;
                url = contenido.url || null;
                tipos = contenido.tipos || [];
                campos = contenido.campos || [];
                documentos = contenido.documentos || [];
                boton_enviar = contenido.boton_enviar || "Enviar";
                mensajeEspera = contenido.mensaje_espera || mensajeEspera;
                mensajeExito = contenido.mensaje_exito || mensajeExito;
                mensajeError = contenido.mensaje_error || mensajeError;
            } else {
                respuesta = contenido;
            }

            // Mensaje del bot
            if(respuesta != "") {
                const msg = document.createElement("p");
                msg.className = "bot-msg";
                if(respuesta == "Selecciona una opción de pago para la deuda de") {
                    respuesta = respuesta + " <span style='color: red;'><strong>" + formatoCadenaNumero(deuda) + "</strong></span>";
                }
                else if(respuesta == "Por favor, adjunta tu comprobante de pago deuda por valor de") {
                    respuesta = respuesta + " <span style='color: red;'><strong>" + formatoCadenaNumero(deuda) + "</strong></span>.";
                    //respuesta = respuesta + " El nombre del archivo debe tener la siguiente forma <span style='color: blue;'>documentoEstudiante-añomesdia-deuda</span> Ej: <span style='color: blue;'>9397532-20251010-deuda</span>";
                    //respuesta = respuesta + " ... y se permiten archivos pdf, png y jpg con un peso máximo de 5MB.";
                    respuesta = respuesta + "<ul><li>El nombre del archivo debe tener la siguiente forma <span style='color: #0B77B3;'><strong>documentoEstudiante-añomesdia-deuda</strong></span></li><li>Ej: <span style='color: #0B77B3;'><strong>9397532-20251010-deuda</strong></span></li>";
                    respuesta = respuesta + "<li>Y se permiten archivos pdf, png y jpg con un peso máximo de 5MB.</li></ul>";
                }
                else if(respuesta == "Es necesario que presentes una evaluación de admisión para el grado:") {
                    respuesta = respuesta + " " + grado;
                }
                else if(respuesta == "Selecciona una opción de pago para la matrícula de") {
                    respuesta = respuesta + " <span style='color: #0B77B3;'><strong>" + formatoCadenaNumero(matricula) + "</strong></span>";
                }
                else if(respuesta == "Por favor, adjunta tu comprobante de pago matrícula por valor de") {
                    respuesta = respuesta + " <span style='color: #0B77B3;'><strong>" + formatoCadenaNumero(matricula) + "</strong></span>.";
                    respuesta = respuesta + "<ul><li>El nombre del archivo debe tener la siguiente forma <span style='color: #0B77B3;'><strong>documentoEstudiante-añoMatrícula-pp</strong></span></li><li>Ej: <span style='color: #0B77B3;'><strong>9397532-2026-pp</strong></span></li>";
                    respuesta = respuesta + "<li>Y se permiten archivos pdf, png y jpg con un peso máximo de 5MB.</li></ul>";
                }
                msg.innerHTML = `<strong>Unibot:</strong> ${respuesta}`;
                contenedor.appendChild(msg);
            }

            // --- Mostrar menú con botones ---
            if (accion === "mostrar_menu_botones" && Array.isArray(contenido.botones)) {
                chatMensajes.innerHTML = "";
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach(btn => {
                    const color = btn.tipo === "d_pdf" ? "#FF9805" : "#0B77B3";
                    const boton = crearBoton(btn.tipo, color, btn.texto);

                    // Comportamiento al hacer clic
                    boton.onclick = () => {
                        if (btn.tipo === "intencion" && btn.destino) {
                            // Buscar la intención destino
                            const intencionDestino = BASE_INTENCIONES.find(i => i.etiqueta === btn.destino); //esto busca por etiqueta
                            if (intencionDestino) {
                                agregarMensaje("Unibot", { ...intencionDestino }); //esto saca una copia de la intencion
                            } else {
                                agregarMensaje("Unibot", "No se encontró el proceso solicitado.");
                            }
                        } else if (btn.tipo === "d_pdf" && btn.url) {
                            window.open(btn.url, '_blank');
                        }
                    };

                    botonera.appendChild(boton);
                });

                contenedor.appendChild(botonera);

                //const estadoDiv = estadoValidacion("comprobante pago matrícula");
                //const estadoDiv = estadoValidacion("documentos matrícula");
                //const estadoDiv = estadoEntrevista(entrevista, admitido);
                //contenedor.appendChild(estadoDiv);
                //const intencion = BASE_INTENCIONES.find(i => i.etiqueta === "documentos_finales_nuevo");
                //const intencion = BASE_INTENCIONES.find(i => i.etiqueta === "reprogramar_entrevista_nuevo");
                //const intencion = BASE_INTENCIONES.find(i => i.etiqueta === "evaluacion_admision_ant_nuevo_cd");
                //if (intencion) agregarMensaje("Unibot", intencion);
            }

            // --- Validar documento ---
            if (accion === "validar_documento" && contenido.url) {
                chatMensajes.innerHTML = "";
                const form = document.createElement("div");
                form.style.marginTop = "10px";
                form.style.marginLeft = "auto";
                form.style.maxWidth = "80%";
                form.style.padding = "15px";
                form.style.border = "1px solid #ddd";
                form.style.borderRadius = "8px";
                form.style.backgroundColor = "#f9f9f9";

                const label = document.createElement("label");
                label.textContent = "Ingresa el documento sin puntos ni espacios:";
                label.style.display = "block";
                label.style.marginBottom = "6px";
                label.style.fontSize = "14px";
                label.style.color = "#333";
                form.appendChild(label);

                const input = document.createElement("input");
                input.type = "text";
                input.name = "documento";
                input.id = "documento";
                input.setAttribute("data-validar", "numero");
                input.setAttribute("data-desc", "documento");
                input.placeholder = "Número de documento...";
                input.style.width = "100%";
                input.style.padding = "8px";
                input.style.border = "1px solid #ccc";
                input.style.borderRadius = "6px";
                input.style.fontSize = "14px";
                input.style.marginBottom = "10px";
                //input.value = cc;

                const boton = crearBoton("proceso", "#28A745", "Validar documento");
                boton.type = "submit";

                form.appendChild(input);
                form.appendChild(boton);

                // Alerta de error
                const alerta = document.createElement("div");
                alerta.className = "alert alert-danger";
                alerta.role = "alert";
                alerta.id = "alert";
                alerta.style.display = "none"; // Oculto inicialmente
                alerta.innerHTML = `
                    <pp>
                        ⚠️
                        <span>: </span>
                        <label id="pdesc"></label>
                        <input type="text" class="alert alert-danger" style="width: 20px; display: none;" id="txtvacio" value="0">
                    </pp>
                `;
                form.appendChild(alerta);

                contenedor.appendChild(form);

                // Manejar validación
                boton.onclick = () => {
                    const documento = input.value.trim();
                    cc = documento;
                    //console.log(cc);
                    if (!documento) {
                        alert("Ingresa el número de documento del estudiante a matricular.");
                        return;
                    }

                    // Mostrar mensaje de espera
                    agregarMensaje("Unibot", contenido.mensaje_espera);

                    // Enviar al web service
                    //console.log(JSON.stringify({ documento: documento }));
                    fetch(contenido.url, {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ documento: documento })
                    })
                    //.then(r => r.json()) // ← Texto → Objeto
                    .then(async r => {
                        const text = await r.text(); // lee la respuesta como texto crudo
                        //console.log(text); // aquí verás lo que realmente devolvió el servidor
                        try {
                            const data = JSON.parse(text); // intenta parsear a JSON
                            return data;
                        } catch (e) {
                            //console.log("⚠️ La respuesta no es JSON válido:");
                            throw e; // lanza el error para que caiga en el catch
                        }
                    })
                    .then(data => {
                        console.log(data);                        
                        if (data.status == "success") {
                            a = data.año_matricula;
                            paso = data.paso;
                            estado = data.estado;
                            control_antiguos = data.control_antiguos;
                            nombre_estudiante = data.nombres + " " + data.apellidos;
                            referencia_pago = cc + "-" + fecha + "-deuda";
                            referencia_pago_m = cc + "-" + year1 + "-pp";
                            etiqueta_intencion = data.etiqueta_intencion;
                            grado = data.grado_matricular;
                            matricula = data.pp;
                            admitido = data.admitido;
                            entrevista = data.entrevista;
                            cierre1P = data.cierre1P;
                            cierre2P = data.cierre2P;
                            intentos_programacion_entrevista = parseInt(data.intentos_programacion_entrevista);
                            $("#s-nombre").html(nombre_estudiante + " - " + cc);

                            let control_matricula = 0;
                            //const id_gra = data.grados[0].id_gra;

                            if (data.bloqueado == "SI") {
                                control_matricula = 1;
                                agregarMensaje("Unibot", "Documento restringido. Por favor comunícate con Rectoría o Secretaría Académica");	
                            }
                            
                            if (control_matricula == 0) {
                                if (data.mat_ordinaria == "AUN NO") {
                                    control_matricula = 1;
                                    agregarMensaje("Unibot", "Las matrículas ordinarias van desde el " + data.mat_ordinaria_desde + " hasta el " + data.mat_ordinaria_hasta);
                                }
                                else if (data.mat_ordinaria == "SI") {
                                    control_matricula = 0;
                                }
                                else if (data.mat_ordinaria == "NO") {
                                    if(data.mat_extraordinaria == "AUN NO") {
                                        control_matricula = 1;
                                        agregarMensaje("Unibot", "Las matrículas extraordinarias van desde el " + data.mat_extraordinaria_desde + " hasta el " + data.mat_extraordinaria_hasta);
                                    }
                                    else if(data.mat_extraordinaria == "SI") {
                                        control_matricula = 0;
                                    }
                                    else if(data.mat_extraordinaria == "NO") {
                                        control_matricula = 1;
                                        agregarMensaje("Unibot", "Las matrículas extraordinarias van desde el " + data.mat_extraordinaria_desde + " hasta el " + data.mat_extraordinaria_hasta);
                                    }
                                }
                            }            		    
                            
                            if (control_matricula == 0) {
                                if (data.control_documentos_invalidos == "1" && data.tipos.length > 0) {
                                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === "formulario_final_documentos_invalidos");
                                    if (intencion) agregarMensaje("Unibot", intencion);

                                    if (paso == "1.4") {
                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant5.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "2.4") {
                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant_deu8.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "3.6") {
                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant_nue_deu10.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "4.6") {
                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant_nue7.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "5.6") {
                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/nue6.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                }
                                else if (data.control_antiguos == 2) {//Antiguo nuevo
                                    agregarMensaje("Unibot", "¡Qué gusto tenerte con nostros nuevamente " + data.nombres + " " + data.apellidos + ". Como te ausentaste por más de un año, tu proceso de matrícula es como estudiante <span style='color: blue;'><strong>Nuevo</strong></span>.");
                                    if(data.deuda_pendiente > 0) {//con deuda
                                        deuda = data.deuda_pendiente;
                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant_nue_deu1.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);

                                        //Se valida el paso
                                        if (paso == "3.1.1") {
                                            //agregarMensaje("Unibot", "Nuestro sistema ha detectado que tienes una deuda pendiente por valor de <span style='color: red;'><strong>" + formatoCadenaNumero(data.deuda_pendiente) + "</strong></span>. Para continuar es necesario ponerte al día con la dueda.");
                                            let respuesta = "Nuestro sistema ha detectado que tienes deuda pendiente por valor de <span style='color: red;'><strong>" + formatoCadenaNumero(data.deuda_pendiente) + "</strong></span> con éste detalle: <ul>";
                                            
                                            if(data.deuda_año_anterior > 0) {
                                                respuesta += "<li>Deuda último año por valor de <span style='color: red; font-weight: bold;'>" + formatoCadenaNumero(data.deuda_año_anterior) + "</span></li>";
                                            }                                            
                                            
                                            if(data.deudas.length > 0) {
                                                for (let i = 0; i < data.deudas.length; i++) {
                                                    respuesta += "<li>Año " + data.deudas[i].a + "  por valor de <span style='color: red; font-weight: bold;'>" + formatoCadenaNumero(data.deudas[i].deuda) + "</span></li>";
                                                }
                                            }
                                            respuesta += "</ul>Para continuar es necesario ponerte al día con la dueda total." 
                                            agregarMensaje("Unibot", respuesta);

                                            /*agregarMensaje("Unibot", {
                                                respuesta: "Nuestro sistema ha detectado que tienes una deuda pendiente por valor de <span style='color: red;'><strong>$" + Number(data.deuda_pendiente).toLocaleString('es-CO') + "</strong></span>. Para continuar es necesario ponerte al día con la dueda.",
                                                accion: "mostrar_boton_pagar_deuda",
                                                boton_pagar_deuda: "Pagar deuda",
                                                destino: "opciones_pago" // ← esta es la clave
                                            });*/
                                            //const botonPago = BASE_INTENCIONES.find(i => i.etiqueta === btn.destino); //esto busca por etiqueta
                                            //const botonPago = encontrarIntencion("deuda pendiente"); //esto busca por claves
                                            //agregarMensaje("Unibot", botonPago);
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === "valor_dueda_ant_nuevo_cd");
                                            if (intencion) agregarMensaje("Unibot", intencion);
                                        }
                                        else if (paso == "3.1.1.1") {
                                            //agregarMensaje("Unibot", "Nuestro sistema ha detectado que tienes una deuda pendiente por valor de <span style='color: red;'><strong>" + formatoCadenaNumero(data.deuda_pendiente) + "</strong></span>. Para continuar es necesario ponerte al día con la dueda.");
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);
                                        }
                                        else if (paso == "3.1.1.2" && data.validacion_comprobante_deuda == 1) {
                                            //Se consume web service de cambio de paso
                                            let msgControl = "paso 3.1.1.2 terminado";
                                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                                method: 'POST',
                                                headers: { 'Content-Type': 'application/json' },
                                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                            })
                                            .then(r => r.json()) // ← Texto → Objeto
                                            .then(data_cp => {
                                                if (data_cp.status == "success") {
                                                    paso = data_cp.siguiente_paso;
                                                    etiqueta_intencion = data_cp.etiqueta_intencion;
                                                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                    if (intencion) agregarMensaje("Unibot", intencion);
                                                }
                                            });
                                            
                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue_deu5.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "3.1.1.2") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue_deu3.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "3.2" || paso == "3.2.1") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue_deu5.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "3.3" && data.evaluacionPresaberes == "SI") {
                                            //Se consume web service de cambio de paso
                                            let msgControl = "paso 3.3 terminado";
                                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                                method: 'POST',
                                                headers: { 'Content-Type': 'application/json' },
                                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                            })
                                            .then(r => r.json()) // ← Texto → Objeto
                                            .then(data_cp => {
                                                if (data_cp.status == "success") {
                                                    paso = data_cp.siguiente_paso;
                                                    etiqueta_intencion = data_cp.etiqueta_intencion;
                                                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                    if (intencion) agregarMensaje("Unibot", intencion);
                                                }
                                            });
                                            
                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue_deu7.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "3.3") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue_deu6.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "3.4" && data.programoEntrevista == "SI" && data.entrevista == "SI" && data.admitido == 1) {
                                            let msgControl = "paso 3.4 terminado";
                                            //Se consume web service de cambio de paso
                                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                                method: 'POST',
                                                headers: { 'Content-Type': 'application/json' },
                                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                            })
                                            .then(r => r.json()) // ← Texto → Objeto
                                            .then(data_cp => {
                                                if (data_cp.status == "success") {
                                                    paso = data_cp.siguiente_paso;
                                                    etiqueta_intencion = data_cp.etiqueta_intencion;

                                                    let respuesta = "Los costos de matrícula para el grado " + data.grado_matricular + " son: <ul><li>Matrícula <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.matricula) + "</span></li><li>Otros Cobros Periódicos <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.ocp) + "</span></li><li>Pensión <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.pension) + "</span></li><li>Total <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.pp) + "</span></li></ul>";
                                            
                                                    let intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                    intencion.respuesta = respuesta;
                                                    if (intencion) agregarMensaje("Unibot", intencion);
                                                }
                                            });

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue_deu8.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "3.4" && data.programoEntrevista == "SI") {
                                            let respuesta = admitido == "1" ? "Su entrevista está programada para el día: " + data.fechaEntrevista + " " + data.horaEntrevista + ". Link de la entrevista: <a href='" + meet_psicologo + "' target='_blank'>" + meet_psicologo + "</a>" : "";
                                            
                                            let intencion = BASE_INTENCIONES.find(i => i.etiqueta === "reprogramar_entrevista_ant_nuevo_cd");
                                            intencion.respuesta = respuesta;
                                            if (intencion) agregarMensaje("Unibot", intencion);
                                        }
                                        else if (paso == "3.4") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue_deu7.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "3.5") {
                                            let respuesta = "Los costos de matrícula para el grado " + data.grado_matricular + " son: <ul><li>Matrícula <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.matricula) + "</span></li><li>Otros Cobros Periódicos <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.ocp) + "</span></li><li>Pensión <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.pension) + "</span></li><li>Total <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.pp) + "</span></li></ul>";
                                            
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            intencion.respuesta = respuesta;
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue_deu8.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if ((paso == "3.5.1" || paso == "3.5.2") && data.validacion_comprobante_matricula == 0) {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue_deu9.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "3.5.2" && data.validacion_comprobante_matricula == 1) {
                                            //Se consume web service de cambio de paso
                                            let msgControl = "paso 3.5.2 terminado";
                                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                                method: 'POST',
                                                headers: { 'Content-Type': 'application/json' },
                                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                            })
                                            .then(r => r.json()) // ← Texto → Objeto
                                            .then(data_cp => {
                                                if (data_cp.status == "success") {
                                                    paso = data_cp.siguiente_paso;
                                                    etiqueta_intencion = data_cp.etiqueta_intencion;
                                                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                    if (intencion) agregarMensaje("Unibot", intencion);
                                                }
                                            });
                                            
                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue_deu10.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "3.6") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue_deu10.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "3.6.1" && data.validacion_documentos_finales_matricula == 1) {
                                            //Se consume web service de cambio de paso
                                            let msgControl = "paso 3.6.1 terminado";
                                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                                method: 'POST',
                                                headers: { 'Content-Type': 'application/json' },
                                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                            })
                                            .then(r => r.json()) // ← Texto → Objeto
                                            .then(data_cp => {
                                                if (data_cp.status == "success") {
                                                    paso = data_cp.siguiente_paso;
                                                    etiqueta_intencion = data_cp.etiqueta_intencion;
                                                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                    if (intencion) agregarMensaje("Unibot", intencion);
                                                }
                                            });

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue_deu12.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "3.6.1") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue_deu11.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "3.7") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue_deu12.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        
                                    }
                                    else {//sin deuda
                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant_nue1.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);

                                        if (paso == "4.1" || paso == "4.2") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue2.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "4.3" && data.evaluacionPresaberes == "SI") {
                                            //Se consume web service de cambio de paso
                                            let msgControl = "paso 4.3 terminado";
                                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                                method: 'POST',
                                                headers: { 'Content-Type': 'application/json' },
                                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                            })
                                            .then(r => r.json()) // ← Texto → Objeto
                                            .then(data_cp => {
                                                if (data_cp.status == "success") {
                                                    paso = data_cp.siguiente_paso;
                                                    etiqueta_intencion = data_cp.etiqueta_intencion;
                                                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                    if (intencion) agregarMensaje("Unibot", intencion);
                                                }
                                            });
                                            
                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue4.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "4.3") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue3.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "4.4" && data.programoEntrevista == "SI" && data.entrevista == "SI" && data.admitido == 1) {
                                            let msgControl = "paso 4.4 terminado";
                                            //Se consume web service de cambio de paso
                                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                                method: 'POST',
                                                headers: { 'Content-Type': 'application/json' },
                                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                            })
                                            .then(r => r.json())
                                            .then(data_cp => {
                                                if (data_cp.status == "success") {
                                                    paso = data_cp.siguiente_paso;
                                                    etiqueta_intencion = data_cp.etiqueta_intencion;

                                                    let respuesta = "Los costos de matrícula para el grado " + data.grado_matricular + " son: <ul><li>Matrícula <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.matricula) + "</span></li><li>Otros Cobros Periódicos <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.ocp) + "</span></li><li>Pensión <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.pension) + "</span></li><li>Total <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.pp) + "</span></li></ul>";
                                            
                                                    let intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                    intencion.respuesta = respuesta;
                                                    if (intencion) agregarMensaje("Unibot", intencion);
                                                }
                                            });

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue5.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "4.4" && data.programoEntrevista == "SI") {
                                            let respuesta = admitido == "1" ? "Su entrevista está programada para el día: " + data.fechaEntrevista + " " + data.horaEntrevista + ". Link de la entrevista: <a href='" + meet_psicologo + "' target='_blank'>" + meet_psicologo + "</a>" : "";
                                            
                                            let intencion = BASE_INTENCIONES.find(i => i.etiqueta === "reprogramar_entrevista_ant_nuevo_sd");
                                            intencion.respuesta = respuesta;
                                            if (intencion) agregarMensaje("Unibot", intencion);
                                        }
                                        else if (paso == "4.4") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue4.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "4.5") {
                                            let respuesta = "Los costos de matrícula para el grado " + data.grado_matricular + " son: <ul><li>Matrícula <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.matricula) + "</span></li><li>Otros Cobros Periódicos <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.ocp) + "</span></li><li>Pensión <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.pension) + "</span></li><li>Total <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.pp) + "</span></li></ul>";
                                            
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            intencion.respuesta = respuesta;
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue5.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if ((paso == "4.5.1" || paso == "4.5.2") && data.validacion_comprobante_matricula == 0) {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue6.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "4.5.2" && data.validacion_comprobante_matricula == 1) {
                                            //Se consume web service de cambio de paso
                                            let msgControl = "paso 4.5.2 terminado";
                                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                                method: 'POST',
                                                headers: { 'Content-Type': 'application/json' },
                                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                            })
                                            .then(r => r.json()) // ← Texto → Objeto
                                            .then(data_cp => {
                                                if (data_cp.status == "success") {
                                                    paso = data_cp.siguiente_paso;
                                                    etiqueta_intencion = data_cp.etiqueta_intencion;
                                                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                    if (intencion) agregarMensaje("Unibot", intencion);
                                                }
                                            });
                                            
                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue7.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "4.6") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue7.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "4.6.1" && data.validacion_documentos_finales_matricula == 1) {
                                            //Se consume web service de cambio de paso
                                            let msgControl = "paso 4.6.1 terminado";
                                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                                method: 'POST',
                                                headers: { 'Content-Type': 'application/json' },
                                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                            })
                                            .then(r => r.json())
                                            .then(data_cp => {
                                                if (data_cp.status == "success") {
                                                    paso = data_cp.siguiente_paso;
                                                    etiqueta_intencion = data_cp.etiqueta_intencion;
                                                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                    if (intencion) agregarMensaje("Unibot", intencion);
                                                }
                                            });

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nu9.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "4.6.1") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue8.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "4.7") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue9.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                    }
                                }
                                else if (data.control_antiguos == 1) {//Antiguo
                                    agregarMensaje("Unibot", "¡Qué gusto tenerte con nostros nuevamente " + data.nombres + " " + data.apellidos + ".");
                                    if(data.deuda_pendiente > 0) {
                                        deuda = data.deuda_pendiente;
                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant_deu1.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);

                                        //Se valida el paso
                                        if (paso == "2.1") {
                                            let msgControl = "paso 2.1 terminado";
                                            //Se consume web service de cambio de paso
                                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                                method: 'POST',
                                                headers: { 'Content-Type': 'application/json' },
                                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                            })
                                            .then(r => r.json()) // ← Texto → Objeto
                                            .then(data => {
                                                if (data.status == "success") {
                                                    paso = data.siguiente_paso;
                                                    etiqueta_intencion = data.etiqueta_intencion;
                                                    const intencionComprobante = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                    if (intencionComprobante) agregarMensaje("Unibot", intencionComprobante);
                                                }
                                            });                                        
                                        }
                                        else if (paso == "2.1.1") {
                                            //agregarMensaje("Unibot", "Nuestro sistema ha detectado que tienes una deuda pendiente por valor de <span style='color: red;'><strong>" + formatoCadenaNumero(data.deuda_pendiente) + "</strong></span>. Para continuar es necesario ponerte al día con la dueda.");
                                            let respuesta = "Nuestro sistema ha detectado que tienes deuda pendiente por valor de <span style='color: red;'><strong>" + formatoCadenaNumero(data.deuda_pendiente) + "</strong></span> con éste detalle: <ul>";
                                            
                                            if(data.deuda_año_anterior > 0) {
                                                respuesta += "<li>Deuda último año por valor de <span style='color: red; font-weight: bold;'>" + formatoCadenaNumero(data.deuda_año_anterior) + "</span></li>";
                                            }                                            
                                            
                                            if(data.deudas.length > 0) {
                                                for (let i = 0; i < data.deudas.length; i++) {
                                                    respuesta += "<li>Año " + data.deudas[i].a + "  por valor de <span style='color: red; font-weight: bold;'>" + formatoCadenaNumero(data.deudas[i].deuda) + "</span></li>";
                                                }
                                            }
                                            respuesta += "</ul>Para continuar es necesario ponerte al día con la dueda total." 
                                            agregarMensaje("Unibot", respuesta);
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === "valor_dueda_ant_cd");
                                            if (intencion) agregarMensaje("Unibot", intencion);
                                        }
                                        else if (paso == "2.1.1.1") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);
                                        }
                                        else if (paso == "2.1.1.2" && data.validacion_comprobante_deuda == 1) {
                                            //Se consume web service de cambio de paso
                                            let msgControl = "paso 2.1.1.2 terminado";
                                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                                method: 'POST',
                                                headers: { 'Content-Type': 'application/json' },
                                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                            })
                                            .then(r => r.json())
                                            .then(data_cp => {
                                                if (data_cp.status == "success") {
                                                    paso = data_cp.siguiente_paso;
                                                    etiqueta_intencion = data_cp.etiqueta_intencion;
                                                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                    if (intencion) agregarMensaje("Unibot", intencion);
                                                }
                                            });
                                            
                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_deu5.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "2.1.1.2") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_deu3.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "2.2" || paso == "2.2.1") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_deu5.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "2.3") {
                                            let respuesta = "Los costos de matrícula para el grado " + data.grado_matricular + " son: <ul><li>Matrícula <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.matricula) + "</span></li><li>Otros Cobros Periódicos <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.ocp) + "</span></li><li>Pensión <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.pension) + "</span></li><li>Total <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.pp) + "</span></li></ul>";
                                            
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            intencion.respuesta = respuesta;
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_deu6.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if ((paso == "2.3.1" || paso == "2.3.2") && data.validacion_comprobante_matricula == 0) {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_deu7.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "2.3.2" && data.validacion_comprobante_matricula == 1) {
                                            //Se consume web service de cambio de paso
                                            let msgControl = "paso 2.3.2 terminado";
                                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                                method: 'POST',
                                                headers: { 'Content-Type': 'application/json' },
                                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                            })
                                            .then(r => r.json())
                                            .then(data_cp => {
                                                if (data_cp.status == "success") {
                                                    paso = data_cp.siguiente_paso;
                                                    etiqueta_intencion = data_cp.etiqueta_intencion;
                                                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                    if (intencion) agregarMensaje("Unibot", intencion);
                                                }
                                            });
                                            
                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_deu8.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "2.4") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_deu8.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "2.4.1" && data.validacion_documentos_finales_matricula == 1) {
                                            //Se consume web service de cambio de paso
                                            let msgControl = "paso 2.4.1 terminado";
                                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                                method: 'POST',
                                                headers: { 'Content-Type': 'application/json' },
                                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                            })
                                            .then(r => r.json())
                                            .then(data_cp => {
                                                if (data_cp.status == "success") {
                                                    paso = data_cp.siguiente_paso;
                                                    etiqueta_intencion = data_cp.etiqueta_intencion;
                                                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                    if (intencion) agregarMensaje("Unibot", intencion);
                                                }
                                            });

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_deu10.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "2.4.1") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_deu9.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "2.5") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_deu10.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                    }
                                    else {//sin deuda
                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant2.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);

                                        //Se valida el paso
                                        if (paso == "1.2" || paso == "1.2.1") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant2.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "1.3") {
                                            let respuesta = "Los costos de matrícula para el grado " + data.grado_matricular + " son: <ul><li>Matrícula <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.matricula) + "</span></li><li>Otros Cobros Periódicos <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.ocp) + "</span></li><li>Pensión <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.pension) + "</span></li><li>Total <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.pp) + "</span></li></ul>";
                                            
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            intencion.respuesta = respuesta;
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant3.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if ((paso == "1.3.1" || paso == "1.3.2") && data.validacion_comprobante_matricula == 0) {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant4.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "1.3.2" && data.validacion_comprobante_matricula == 1) {
                                            //Se consume web service de cambio de paso
                                            let msgControl = "paso 1.3.2 terminado";
                                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                                method: 'POST',
                                                headers: { 'Content-Type': 'application/json' },
                                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                            })
                                            .then(r => r.json())
                                            .then(data_cp => {
                                                if (data_cp.status == "success") {
                                                    paso = data_cp.siguiente_paso;
                                                    etiqueta_intencion = data_cp.etiqueta_intencion;
                                                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                    if (intencion) agregarMensaje("Unibot", intencion);
                                                }
                                            });
                                            
                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant5.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "1.4") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant5.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "1.4.1" && data.validacion_documentos_finales_matricula == 1) {
                                            //Se consume web service de cambio de paso
                                            let msgControl = "paso 1.4.1 terminado";
                                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                                method: 'POST',
                                                headers: { 'Content-Type': 'application/json' },
                                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                            })
                                            .then(r => r.json())
                                            .then(data_cp => {
                                                if (data_cp.status == "success") {
                                                    paso = data_cp.siguiente_paso;
                                                    etiqueta_intencion = data_cp.etiqueta_intencion;
                                                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                    if (intencion) agregarMensaje("Unibot", intencion);
                                                }
                                            });

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant7.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "1.4.1") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant6.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                        else if (paso == "1.5") {
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant7.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                    }
                                }
                                else if (data.estado == "activo") {
                                    if (paso == "1.4.1" && data.validacion_documentos_finales_matricula == 1) {
                                        //Se consume web service de cambio de paso
                                        let msgControl = "paso 1.4.1 terminado";
                                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                            method: 'POST',
                                            headers: { 'Content-Type': 'application/json' },
                                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                        })
                                        .then(r => r.json())
                                        .then(data_cp => {
                                            if (data_cp.status == "success") {
                                                paso = data_cp.siguiente_paso;
                                                etiqueta_intencion = data_cp.etiqueta_intencion;
                                                const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                if (intencion) agregarMensaje("Unibot", intencion);
                                            }
                                        });

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant7.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "1.4.1") {
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        if (intencion) agregarMensaje("Unibot", intencion);

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant6.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "1.5") {
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        if (intencion) agregarMensaje("Unibot", intencion);

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant7.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "2.4.1" && data.validacion_documentos_finales_matricula == 1) {
                                        //Se consume web service de cambio de paso
                                        let msgControl = "paso 2.4.1 terminado";
                                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                            method: 'POST',
                                            headers: { 'Content-Type': 'application/json' },
                                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                        })
                                        .then(r => r.json())
                                        .then(data_cp => {
                                            if (data_cp.status == "success") {
                                                paso = data_cp.siguiente_paso;
                                                etiqueta_intencion = data_cp.etiqueta_intencion;
                                                const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                if (intencion) agregarMensaje("Unibot", intencion);
                                            }
                                        });

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant_deu10.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "2.4.1") {
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        if (intencion) agregarMensaje("Unibot", intencion);

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant_deu9.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "2.5") {
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        if (intencion) agregarMensaje("Unibot", intencion);

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant_deu10.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "3.6.1" && data.validacion_documentos_finales_matricula == 1) {
                                        //Se consume web service de cambio de paso
                                        let msgControl = "paso 3.6.1 terminado";
                                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                            method: 'POST',
                                            headers: { 'Content-Type': 'application/json' },
                                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                        })
                                        .then(r => r.json()) // ← Texto → Objeto
                                        .then(data_cp => {
                                            if (data_cp.status == "success") {
                                                paso = data_cp.siguiente_paso;
                                                etiqueta_intencion = data_cp.etiqueta_intencion;
                                                const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                if (intencion) agregarMensaje("Unibot", intencion);
                                            }
                                        });

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant_nue_deu12.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "3.6.1") {
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        if (intencion) agregarMensaje("Unibot", intencion);

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant_nue_deu11.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "3.7") {
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        if (intencion) agregarMensaje("Unibot", intencion);

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant_nue_deu12.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "4.6.1" && data.validacion_documentos_finales_matricula == 1) {
                                        //Se consume web service de cambio de paso
                                        let msgControl = "paso 4.6.1 terminado";
                                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                            method: 'POST',
                                            headers: { 'Content-Type': 'application/json' },
                                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                        })
                                        .then(r => r.json())
                                        .then(data_cp => {
                                            if (data_cp.status == "success") {
                                                paso = data_cp.siguiente_paso;
                                                etiqueta_intencion = data_cp.etiqueta_intencion;
                                                const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                if (intencion) agregarMensaje("Unibot", intencion);
                                            }
                                        });

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant_nu9.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "4.6.1") {
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        if (intencion) agregarMensaje("Unibot", intencion);

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant_nue8.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "4.7") {
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        if (intencion) agregarMensaje("Unibot", intencion);

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/ant_nue9.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "5.6.1" && data.validacion_documentos_finales_matricula == 1) {
                                        //Se consume web service de cambio de paso
                                        let msgControl = "paso 5.6.1 terminado";
                                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                            method: 'POST',
                                            headers: { 'Content-Type': 'application/json' },
                                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                        })
                                        .then(r => r.json())
                                        .then(data_cp => {
                                            if (data_cp.status == "success") {
                                                paso = data_cp.siguiente_paso;
                                                etiqueta_intencion = data_cp.etiqueta_intencion;
                                                const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                if (intencion) agregarMensaje("Unibot", intencion);
                                            }
                                        });

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/nue8.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "5.6.1") {
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        if (intencion) agregarMensaje("Unibot", intencion);

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/nue7.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "5.7") {
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        if (intencion) agregarMensaje("Unibot", intencion);

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/nue8.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else {
                                        let r_grado = data.grados[0].gra;
                                        //alert(r_grado);
                                        let r_idgrado = data.grados[0].id_gra;
                                        agregarMensaje("Unibot", "Este documento se encuentra activo en el grado " + r_grado + ".");
                                    }                                    
                                }
                                /*else if(data.estado == "solicitud" || data.estado == "pre_solicitud") {
                                    let r_grado = data.grados[0].gra;
                                    //alert(r_grado);
                                    let r_idgrado = data.grados[0].id_gra;
                                    $("#ctr_estado").val(1);
                                    
                                    $("#msgdocumento").html("Este documento ya tiene una solicitud de matrícula en el grado " + r_grado + ".");
                                }*/
                                else if (data.estado == "reprobado") {
                                    let r_grado = data.grados[0].gra;
                                    let r_idgrado = data.grados[0].id_gra;
                                    //$("#register_grado").val(r_idgrado);
                                    agregarMensaje("Unibot", "Estudiante antiguo, puede iniciar proceso de matícula para el grado " + r_grado + ".");
                                }
                                else if (data.estado == "aprobado") {
                                    let r_grado = data.grados[0].gra;
                                    let r_idgrado = data.grados[0].id_gra;
                                    //$("#register_grado").val(r_idgrado);
                                    agregarMensaje("Unibot", "Estudiante antiguo, puede iniciar proceso de matícula para el grado " + r_grado + ".");
                                }
                                else if (data.estado == "retirado") {
                                    agregarMensaje("Unibot", "Este documento se encuentra Retirado en este momento. Comunícate con Secretaría Académica.");
                                }
                                else if (data.estado == "nuevo" || data.estado == "nuevo_pre_solicitud" || data.estado == "nuevo_solicitud") { 
                                    agregarMensaje("Unibot", "Te damos la bienvenida a formar parte de nuestro ecosistema de educación.");
                                    
                                    if (paso == "5.1" || paso == "5.2") {
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === "formulario_inicial_nuevo");
                                        if (intencion) agregarMensaje("Unibot", intencion);

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/nue1.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "5.3" && data.evaluacionPresaberes == "SI") {
                                        //Se consume web service de cambio de paso
                                        let msgControl = "paso 5.3 terminado";
                                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                            method: 'POST',
                                            headers: { 'Content-Type': 'application/json' },
                                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                        })
                                        .then(r => r.json()) // ← Texto → Objeto
                                        .then(data_cp => {
                                            if (data_cp.status == "success") {
                                                paso = data_cp.siguiente_paso;
                                                etiqueta_intencion = data_cp.etiqueta_intencion;
                                                const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                if (intencion) agregarMensaje("Unibot", intencion);
                                            }
                                        });
                                        
                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/nue3.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "5.3") {
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        if (intencion) agregarMensaje("Unibot", intencion);

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/nue2.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "5.4" && data.programoEntrevista == "SI" && data.entrevista == "SI" && data.admitido == 1) {
                                        let msgControl = "paso 5.4 terminado";
                                        //Se consume web service de cambio de paso
                                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                            method: 'POST',
                                            headers: { 'Content-Type': 'application/json' },
                                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                        })
                                        .then(r => r.json())
                                        .then(data_cp => {
                                            if (data_cp.status == "success") {
                                                paso = data_cp.siguiente_paso;
                                                etiqueta_intencion = data_cp.etiqueta_intencion;

                                                let respuesta = "Los costos de matrícula para el grado " + data.grado_matricular + " son: <ul><li>Matrícula <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.matricula) + "</span></li><li>Otros Cobros Periódicos <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.ocp) + "</span></li><li>Pensión <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.pension) + "</span></li><li>Total <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.pp) + "</span></li></ul>";
                                        
                                                let intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                intencion.respuesta = respuesta;
                                                if (intencion) agregarMensaje("Unibot", intencion);
                                            }
                                        });

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/nue4.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "5.4" && data.programoEntrevista == "SI") {
                                        let respuesta = admitido == "1" ? "Su entrevista está programada para el día: " + data.fechaEntrevista + " " + data.horaEntrevista + ". Link de la entrevista: <a href='" + meet_psicologo + "' target='_blank'>" + meet_psicologo + "</a>" : "";
                                        
                                        let intencion = BASE_INTENCIONES.find(i => i.etiqueta === "reprogramar_entrevista_nuevo");
                                        intencion.respuesta = respuesta;
                                        if (intencion) agregarMensaje("Unibot", intencion);
                                    }
                                    else if (paso == "5.4") {
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        if (intencion) agregarMensaje("Unibot", intencion);

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/nue3.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "5.5") {
                                        let respuesta = "Los costos de matrícula para el grado " + data.grado_matricular + " son: <ul><li>Matrícula <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.matricula) + "</span></li><li>Otros Cobros Periódicos <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.ocp) + "</span></li><li>Pensión <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.pension) + "</span></li><li>Total <span style='color: #0B77B3; font-weight: bold;'>" + formatoCadenaNumero(data.pp) + "</span></li></ul>";
                                        
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        intencion.respuesta = respuesta;
                                        if (intencion) agregarMensaje("Unibot", intencion);

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/nue4.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if ((paso == "5.5.1" || paso == "5.5.2") && data.validacion_comprobante_matricula == 0) {
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        if (intencion) agregarMensaje("Unibot", intencion);

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/nue5.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "5.5.2" && data.validacion_comprobante_matricula == 1) {
                                        //Se consume web service de cambio de paso
                                        let msgControl = "paso 5.5.2 terminado";
                                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                            method: 'POST',
                                            headers: { 'Content-Type': 'application/json' },
                                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                        })
                                        .then(r => r.json()) // ← Texto → Objeto
                                        .then(data_cp => {
                                            if (data_cp.status == "success") {
                                                paso = data_cp.siguiente_paso;
                                                etiqueta_intencion = data_cp.etiqueta_intencion;
                                                const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                if (intencion) agregarMensaje("Unibot", intencion);
                                            }
                                        });
                                        
                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/nue6.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "5.6") {
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        if (intencion) agregarMensaje("Unibot", intencion);

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/nue6.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "5.6.1" && data.validacion_documentos_finales_matricula == 1) {
                                        //Se consume web service de cambio de paso
                                        let msgControl = "paso 5.6.1 terminado";
                                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                            method: 'POST',
                                            headers: { 'Content-Type': 'application/json' },
                                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                        })
                                        .then(r => r.json())
                                        .then(data_cp => {
                                            if (data_cp.status == "success") {
                                                paso = data_cp.siguiente_paso;
                                                etiqueta_intencion = data_cp.etiqueta_intencion;
                                                const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                if (intencion) agregarMensaje("Unibot", intencion);
                                            }
                                        });

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/nue8.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "5.6.1") {
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        if (intencion) agregarMensaje("Unibot", intencion);

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/nue7.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                    else if (paso == "5.7") {
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        if (intencion) agregarMensaje("Unibot", intencion);

                                        //imagen con pasos resumen
                                        const divPasos = document.getElementById("div-pasos");
                                        divPasos.innerHTML = "";
                                        const imgPasos = document.createElement("img");
                                        imgPasos.style.width = "100%";
                                        imgPasos.src = "chatbot/img/nue8.jpg";
                                        imgPasos.alt = "Click";
                                        divPasos.appendChild(imgPasos);
                                    }
                                }
                                else if (data.estado == "inactivo") {
                                    agregarMensaje("Unibot", "Este documento se encuentra inactivo en este momento. Comunícate con Secretaría Académica.");
                                }
                                else {
                                    agregarMensaje("Unibot", "No se pudo procesar la solicitud de matrícula para éste documento. Comunícate con Secretaría Académica.");
                                }
                            }

                            //agregarMensaje("Unibot", contenido.mensaje_exito);
                            // Opcional: desbloquear siguiente paso
                            //agregarMensaje("Unibot", "¿En qué más puedo ayudarte?");
                        } else {
                            agregarMensaje("Unibot", contenido.mensaje_error);
                        }
                    })
                    /*.catch(err => {
                        console.log("Error al conectar con el servicio:", err);
                        agregarMensaje("Unibot", "⚠️ No fue posible conectar con el sistema de validación. Intenta más tarde.");
                    })*/;
                };
            }


            //######### 1 Antiguo sin Deuda #######
            // --- Datos actuales antiguo sd---
            if (accion === "datos_actuales_ant_sd" && contenido.url) {
                chatMensajes.innerHTML = "";

                // Mensaje de carga
                const contenedorCarga = document.createElement("div");
                //contenedorCarga.textContent = "📄 Cargando datos del estudiante...";
                contenedorCarga.style.padding = "12px";
                contenedorCarga.style.background = "#f0f0f0";
                contenedorCarga.style.borderRadius = "6px";
                contenedorCarga.style.margin = "10px auto";
                contenedor.appendChild(contenedorCarga);

                // Llamada al web service
                fetch(contenido.url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ documento: cc })
                })
                .then(r => r.json())
                .then(datos => {
                    if (datos.status !== "success") {
                        agregarMensaje("Unibot", "❌ No se pudo cargar la información del estudiante.");
                        return;
                    }                    
                    contenedor.removeChild(contenedorCarga);

                    const d = datos;
                    let grado = "";
                    if (d.grados.length > 0) {
                        grado = d.grados[0].gra;
                    }

                    // Bloque visual con datos
                    const cont = document.createElement("div");
                    cont.style.background = "#fff";
                    cont.style.border = "1px solid #ccc";
                    cont.style.borderRadius = "10px";
                    cont.style.padding = "15px";
                    cont.style.margin = "10px auto";
                    cont.style.maxWidth = "90%";
                    cont.style.lineHeight = "1.4";

                    let rh = d.rh.replace("mas", "+");
                    rh = rh.replace("menos", "-");

                    //<div><strong>Grado:</strong> ${d.grados?.[0]?.gra || ""}</div>

                    cont.innerHTML = `
                        <div style="font-weight:700;padding:6px 10px;margin-bottom:8px;border-top:3px solid #ff9805;border-bottom:3px solid #ff9805">
                            DATOS COMPLEMENTARIOS DEL ESTUDIANTE
                        </div>
                        <div><strong>Apellidos:</strong> ${d.apellidos}</div>
                        <div><strong>Nombres:</strong> ${d.nombres}</div>
                        <div><strong>Grado:</strong> ${grado}</div>
                        <div><strong>Tipo de documento:</strong> ${d.tdoc}</div>
                        <div><strong>Teléfono:</strong> ${d.tel}</div>
                        <div><strong>Correo:</strong> ${d.email}</div>
                        <div><strong>Factor RH:</strong> ${rh}</div>
                        <div><strong>Medio de llegada:</strong> ${d.medio}</div>
                        <div><strong>Actividad extra:</strong> ${d.actividad_extra}</div>
                        <div><strong>Género:</strong> ${d.genero}</div>
                        <br>
                        <div style="font-weight:700;padding:6px 10px;margin-bottom:8px;border-top:3px solid #ff9805;border-bottom:3px solid #ff9805">
                            CONDICIÓN SOCIO-ECONÓMICA: ${d.situacion_se}
                        </div>
                        <br>
                        <div style="font-weight:700;padding:6px 10px;margin-bottom:8px;border-top:3px solid #ff9805;border-bottom:3px solid #ff9805">
                            DATOS DEL ACUDIENTE
                        </div>
                        <div><strong>Nombre:</strong> ${d.acudiente}</div>
                        <div><strong>Documento:</strong> ${d.docA}</div>
                        <div><strong>Dirección:</strong> ${d.direccion}</div>
                        <div><strong>Celular:</strong> ${d.telA}</div>
                        <div><strong>Correo:</strong> ${d.emailA}</div>
                        <div><strong>Parentesco:</strong> ${d.parentesco_acudiente_1}</div>
                    `;
                    contenedor.appendChild(cont);

                    const msg1 = document.createElement("p");
                    msg1.style.alignSelf = "flex-start";
                    msg1.style.background = "#e3f2fd";
                    msg1.style.color = "#000";
                    //msg1.style.marginRight = "auto";
                    //msg1.style.margin = "6px 0";
                    //msg1.style.padding = "10px 14px";
                    //msg1.style.borderRadius = "18px";
                    //msg1.style.maxWidth = "80%";
                    //msg1.style.lineHeight = "1.5";
                    //msg1.style.wordWrap = "break-word";
                    msg1.className += "bot-msg";
                    if (grado == "" || grado == "Ninguno") {
                        msg1.innerHTML = "<strong>Unibot:</strong> Necesitas actualizar los datos registrados y seleccionar un grado.";
                    }
                    else {
                        msg1.innerHTML = "<strong>Unibot:</strong> Revisa y actualiza los datos registrados.";
                    }                    
                    contenedor.appendChild(msg1);
                    
                    // Botones (tu misma lógica)
                    const botonera = document.createElement("div");
                    botonera.style.display = "flex";
                    botonera.style.flexDirection = "column";
                    botonera.style.gap = "10px";
                    botonera.style.marginTop = "10px";
                    botonera.style.marginLeft = "auto";
                    botonera.style.maxWidth = "80%";

                    contenido.botones.forEach((btn, index) => {
                        const boton = crearBoton("intencion", "#0B77B3", btn.texto);

                        boton.onclick = () => {
                            const destino = BASE_INTENCIONES.find(i => i.etiqueta === btn.destino);
                            if (destino) agregarMensaje("Unibot", destino);
                        };

                        if ((grado == "" || grado == "Ninguno") && index == 1) {
                            //No se agrega el botón No
                        }
                        else {
                            botonera.appendChild(boton);
                        }
                        
                    });

                    contenedor.appendChild(botonera);
                })
                .catch(err => {
                    console.log("Error al cargar datos:", err);
                    agregarMensaje("Unibot", "❌ No fue posible conectar con el sistema.");
                });
            }

            // --- Formulario datos actuales antiguo sd ---
            if (accion === "formulario_inicial_ant_sd" && contenido.url) {
                chatMensajes.innerHTML = "";
                const contenedorCarga = document.createElement("div");
                contenedorCarga.style.marginTop = "10px";
                contenedorCarga.style.padding = "15px";
                contenedorCarga.style.border = "1px solid #ddd";
                contenedorCarga.style.borderRadius = "8px";
                contenedorCarga.style.backgroundColor = "#f9f9f9";
                contenedorCarga.style.textAlign = "center";

                const mensajeCarga = document.createElement("p");
                mensajeCarga.textContent = "Cargando información...";
                mensajeCarga.style.fontStyle = "italic";
                mensajeCarga.style.color = "#555";
                contenedorCarga.appendChild(mensajeCarga);

                const spinner = document.createElement("div");
                spinner.innerHTML = "⏳";
                spinner.style.fontSize = "24px";
                contenedorCarga.appendChild(spinner);

                contenedor.appendChild(contenedorCarga);
                chatMensajes.scrollTop = chatMensajes.scrollHeight;

                if (!cc) {
                    alert("Ingresa el número de documento del estudiante a matricular.");
                    return;
                }

                fetch(contenido.url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ documento: cc })
                })
                .then(r => r.json())
                .then(datos => {
                    if (datos.status !== "success") {
                        agregarMensaje("Unibot", "❌ No se pudo cargar la información del estudiante.");
                        return;
                    }

                    let seleccioneGrado = false;
                    if (datos.estado == "antiguo_pre_solicitud" || datos.control_antiguos == 1) {
                        seleccioneGrado = true;
                    }

                    // Remover mensaje de carga
                    contenedor.removeChild(contenedorCarga);

                    // Generar formulario con datos prellenados
                    generarFormularioConDatos(datos, contenedor, seleccioneGrado);
                    habilitarBoton(sonTodosValidos());
                })
                .catch(err => {
                    console.log("Error al cargar datos:", err);
                    agregarMensaje("Unibot", "❌ No fue posible conectar con el sistema.");
                });
            }

            // --- Costos matrícula antiguo sd ---
            if (accion === "costos_matricula_ant_sd") {
                chatMensajes.innerHTML = "";
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach(btn => {
                    const boton = crearBoton("intencion", "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        if (btn.destino == "opciones_pago_matricula_antiguo_sd") {
                            const intencionOpcionesPago = BASE_INTENCIONES.find(i => i.etiqueta === "opciones_pago_matricula_antiguo_sd");
                            if (intencionOpcionesPago) agregarMensaje("Unibot", intencionOpcionesPago);                        
                        }
                        else if (btn.destino == "comprobante_matricula_ant_sd") {
                            const intencionComprobante = BASE_INTENCIONES.find(i => i.etiqueta === "comprobante_matricula_ant_sd");
                            if (intencionComprobante) agregarMensaje("Unibot", intencionComprobante);
                        }
                    };
                    botonera.appendChild(boton);
                });
                contenedor.appendChild(botonera);

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/ant3.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }

            // --- Opciones pago matrícula antiguo sd ---
            if (accion === "opciones_pago_matricula_antiguo_sd" && contenido.botones) {
                chatMensajes.innerHTML = "";
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach(btn => {
                    const boton = crearBoton(btn.tipo, "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        if (btn.tipo == "servicio") {
                            if (btn.valor == "link_pago_epayco") {
                                redirigirPOST('pagoMatricula.php', {
                                    documento: cc,
                                    valor: matricula,
                                    referencia: referencia_pago_m,
                                    concepto: "Matrícula"
                                });
                            }
                            else {                                
                                window.open(btn.url, "_blank");
                            }
                        }
                        else if (btn.destino == "comprobante_matricula_ant_sd") {
                            const intencionComprobante = BASE_INTENCIONES.find(i => i.etiqueta === "comprobante_matricula_ant_sd");
                            if (intencionComprobante) agregarMensaje("Unibot", intencionComprobante);                                                    
                        }
                    };
                    botonera.appendChild(boton);
                });
                contenedor.appendChild(botonera);
            }

            // --- Comprobante matrícula antiguo sd ---
            if (accion === "comprobante_matricula_ant_sd" && tipos.length > 0) {
                chatMensajes.innerHTML = "";
                const form = document.createElement("div");
                form.style.marginTop = "10px";
                form.style.marginLeft = "auto";
                form.style.maxWidth = "80%";
                form.style.padding = "10px";
                form.style.border = "1px solid #ddd";
                form.style.borderRadius = "8px";
                form.style.backgroundColor = "#f9f9f9";
                form.style.gap = "10px";
                form.style.display = "flex";
                form.style.flexDirection = "column";

                const input = document.createElement("input");
                input.type = "file";
                input.id = "input-archivo-" + Date.now();
                input.accept = tipos.map(t => t === "pdf" ? ".pdf" : "image/" + t).join(",");
                input.style.display = "none";

                const label = document.createElement("label");
                label.htmlFor = input.id;
                label.style.padding = "12px 16px";
                //label.style.backgroundColor = "#C75EA3";
                label.style.backgroundColor = "#FF9805";
                label.style.color = "white";
                //label.style.borderRadius = "8px";
                label.style.borderRadius = "8px 0px 0px 0px";
                label.style.cursor = "pointer";
                label.style.fontSize = "14px";
                label.style.fontWeight = "600";
                label.style.display = "flex";
                label.style.alignItems = "center";
                label.style.gap = "10px";

                // Icono input (imagen)
                const iconoInput = document.createElement("img");
                iconoInput.style.width = "30px";
                iconoInput.style.height = "30px";
                iconoInput.style.borderRadius = "4px";
                iconoInput.src = "chatbot/img/subir_pdf1.png";
                iconoInput.alt = "Subir";

                label.appendChild(iconoInput);

                // Texto input
                const textoInput = document.createElement("span");
                textoInput.textContent = " Seleccionar comprobante";
                textoInput.style.fontWeight = "600";
                textoInput.style.flexGrow = "1";
                textoInput.style.color = "white";

                label.appendChild(textoInput);

                const archivoTexto = document.createElement("span");
                archivoTexto.style.marginLeft = "10px";
                archivoTexto.style.fontSize = "13px";
                archivoTexto.style.color = "#555";

                const botonCambiarPago = crearBoton("proceso", "#0B77B3", contenido.botones[0].texto);

                // Acción del botón → abre la intención "opciones_pago_deuda"
                botonCambiarPago.onclick = () => {
                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === "opciones_pago_matricula_antiguo_sd");
                    if (intencion) agregarMensaje("Unibot", intencion);
                };

                input.addEventListener("change", function(e) {
                    const file = e.target.files[0];
                    if (!file) return;

                    // Validar tipo
                    const ext = file.name.split(".").pop().toLowerCase();
                    if (!tipos.includes(ext)) {
                        alert(mensajeError);
                        return;
                    }

                    //Se valida que el documento del nombre del archivo sea el correcto
                    const doc = file.name.split("-").shift();
                    console.log(doc);
                    if (doc != cc) {
                        alert("El documento que aparece en el nombre del comprobante no corresponde con el número de documento del estudiante. Ejemplo de nombre de comprobante: 9999999-2026-pp.pdf");
                        return;
                    }

                    // Validar tamaño (máx 5MB)
                    if (file.size > 5 * 1024 * 1024) {
                        alert("El archivo es muy grande. Máximo 5 MB.");
                        return;
                    }

                    archivoTexto.textContent = file.name;

                    // Mostrar mensaje de espera
                    agregarMensaje("Unibot", mensajeEspera);

                    // Enviar archivo
                    const formData = new FormData();
                    formData.append("comprobante_matricula", file);
                    formData.append("valor", matricula);

                    fetch('http://localhost:90/avmeeuu/avmeeuu/api/subir_comprobante_matricula.php', {
                        method: 'POST',
                        body: formData
                    })
                    //.then(r => r.json())
                    .then(async r => {
                        const text = await r.text(); // lee la respuesta como texto crudo
                        console.log(text); // aquí verás lo que realmente devolvió el servidor
                        try {
                            const data = JSON.parse(text); // intenta parsear a JSON
                            return data;
                        } catch (e) {
                            //console.log("⚠️ La respuesta no es JSON válido:");
                            throw e; // lanza el error para que caiga en el catch
                        }
                    })
                    .then(data => {
                        if (data.status == "success") {
                            let msgControl = "paso 1.3 terminado";
                            //Se consume web service de cambio de paso
                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/json' },
                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                            })
                            .then(r => r.json())
                            .then(data => {
                                if (data.status == "success") {
                                    paso = data.siguiente_paso;
                                    etiqueta_intencion = data.etiqueta_intencion;
                                    let msgControl = "paso 1.3.1 terminado";
                                    //Se consume web service de cambio de paso
                                    fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                        method: 'POST',
                                        headers: { 'Content-Type': 'application/json' },
                                        body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                    })
                                    .then(r => r.json())
                                    .then(data => {
                                        if (data.status == "success") {
                                            paso = data.siguiente_paso;
                                            etiqueta_intencion = data.etiqueta_intencion;
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant5.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                    });
                                }
                            });
                            
                        }
                        else {
                            agregarMensaje("Unibot", mensajeError + " " + data.mensaje);
                        }
                    })
                    .catch(err => {
                        console.log("❌ Error general:", err);
                        agregarMensaje("Unibot", mensajeError);
                    });
                });

                form.appendChild(input);
                form.appendChild(label);
                form.appendChild(archivoTexto);
                form.appendChild(botonCambiarPago);
                contenedor.appendChild(form);
            }

            // --- validación comprobante matrícula antiguo sd ---
            if (accion === "validando_comprobante_matricula_ant_sd") {
                chatMensajes.innerHTML = "";
                
                // Crear tarjeta amarilla de estado
                /*const estadoDiv = document.createElement("div");
                estadoDiv.textContent = "Estado validación comprobante pago matrícula: PENDIENTE";
                estadoDiv.style.backgroundColor = "#ffc107"; // Amarillo
                estadoDiv.style.color = "#fff";
                estadoDiv.style.fontWeight = "600";
                estadoDiv.style.borderRadius = "6px";
                estadoDiv.style.padding = "10px 20px";
                estadoDiv.style.textAlign = "center";
                estadoDiv.style.margin = "10px auto";
                estadoDiv.style.width = "fit-content";
                estadoDiv.style.boxShadow = "0 2px 4px rgba(0,0,0,0.2)";*/
                const estadoDiv = estadoValidacion("comprobante pago matrícula");
                contenedor.appendChild(estadoDiv);
            }

            // --- Documentos finales antiguo sd ---
            if (accion === "documentos_finales_ant_sd") {
                chatMensajes.innerHTML = "";

                // Bloque visual con datos
                const cont = document.createElement("div");
                cont.style.background = "#fff";
                cont.style.border = "1px solid #ccc";
                cont.style.borderRadius = "10px";
                cont.style.padding = "15px";
                cont.style.margin = "10px auto";
                cont.style.maxWidth = "90%";
                cont.style.lineHeight = "1.4";

                cont.innerHTML = `
                    <div style="font-weight:700;padding:6px 10px;margin-bottom:8px;border-top:3px solid #ff9805;border-bottom:3px solid #ff9805">
                        LISTADO DE DOCUMENTOS
                    </div>
                    <div style="color: red;"><strong>Nota: Todos los documentos deben ser en pdf. Tener en cuenta que si todos los documentos no están debidamente cargados, serán rechazados y su proceso se demorará varios días más. La revisión podría tardar hasta 8 días hábiles.</strong></div><br>
                    <div>1. Contrato de matrícula, Pagaré y consentimiento informado <span style="font-weight: bold;">firmados</span>. <mark class="mi-resaltado">El pagaré debe estar autenticado en notaría.</mark> (El contrato y el pagaré se enviaron al correo del acudiente cuando se validó el comprobante de matrícula).</div><br>
                    <div>2. Documento de identidad del estudiante (registro civil para menores de 7 años; tarjeta de identidad entre 7 y 17 años y cédula de ciudadanía para mayores de 18 años). <span style="color: red;">Solo si cambió.</span></div><br>
                    <div>3. Documento de identidad del acudiente, (misma persona que firma el contrato). <span style="color: red;">Solo si cambió.</span></div><br>
                    <div>4. Paz y salvo año lectivo anterior.</div><br>
                    <div>5. Fotografía reciente del estudiante.</div><br>
                    <div>6. Certificado de afiliación a E.P.S del estudiante.</div><br>
                    <div>7. Certificado de actividad extracurricular. <span style="color: red;">Solo si cambió.</span></div><br>
                    <div>8. <mark class="mi-resaltado">Para estudiantes nuevos:</mark> <span style="color: white; background: orange;">Primaria:</span> Certificado final de calificaciones año anterior. <span style="color: white; background: purple;">Bachillerato:</span> Todos los certificados finales de calificaciones desde quinto de primaria hasta el último año cursado.</div><br>
                    <div>9. Carnet de vacunación al día, con esquema completo incluyendo refuerzos. Tener en cuenta la siguiente tabla:
                        <table>
                            <thead>
                                <tr>
                                    <th>EDAD</th><th>VACUNA</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>9 a 17 AÑOS</td><td>VPH</td>
                                </tr>
                                <tr>
                                    <td>6 a 15 AÑOS</td><td>SARAMPIÓN, RUBEOLA</td>
                                </tr>
                                <tr>
                                    <td>9 MESES a 19 AÑOS</td><td>FIEBRE AMARILLA</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                `;
                contenedor.appendChild(cont);
                asegurarScrollArriba(chatMensajes);

                // Botones (tu misma lógica)
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach((btn, index) => {
                    const boton = crearBoton("intencion", "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        const destino = BASE_INTENCIONES.find(i => i.etiqueta === btn.destino);
                        if (destino) agregarMensaje("Unibot", destino);
                    };

                    botonera.appendChild(boton);
                    
                });

                contenedor.appendChild(botonera);
                asegurarScrollArriba(chatMensajes);
            }

            // --- Formulario final antiguo sd ---
            if (accion === "formulario_final_antiguo_sd" && contenido.url) {
                chatMensajes.innerHTML = "";
                const contenedorCarga = document.createElement("div");
                contenedorCarga.style.marginTop = "10px";
                contenedorCarga.style.padding = "15px";
                contenedorCarga.style.border = "1px solid #ddd";
                contenedorCarga.style.borderRadius = "8px";
                contenedorCarga.style.backgroundColor = "#f9f9f9";
                contenedorCarga.style.textAlign = "center";

                const mensajeCarga = document.createElement("p");
                mensajeCarga.textContent = "Cargando información...";
                mensajeCarga.style.fontStyle = "italic";
                mensajeCarga.style.color = "#555";
                contenedorCarga.appendChild(mensajeCarga);

                const spinner = document.createElement("div");
                spinner.innerHTML = "⏳";
                spinner.style.fontSize = "24px";
                contenedorCarga.appendChild(spinner);

                contenedor.appendChild(contenedorCarga);
                chatMensajes.scrollTop = chatMensajes.scrollHeight;

                if (!cc) {
                    alert("Ingresa el número de documento del estudiante a matricular.");
                    return;
                }

                fetch(contenido.url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ documento: cc })
                })
                .then(r => r.json())
                .then(datos => {
                    if (datos.status !== "success") {
                        agregarMensaje("Unibot", "❌ No se pudo cargar la información del estudiante.");
                        return;
                    }

                    // Remover mensaje de carga
                    contenedor.removeChild(contenedorCarga);

                    // Generar formulario con datos prellenados
                    generarFormularioFinalConDatos(datos, contenedor);
                    habilitarBoton(sonTodosValidos());
                })
                .catch(err => {
                    console.log("Error al cargar datos:", err);
                    agregarMensaje("Unibot", "❌ No fue posible conectar con el sistema.");
                });
            }

            // --- validación documentos antiguo sd ---
            if (accion === "validando_documentos_ant_sd") {
                chatMensajes.innerHTML = "";
                
                // Crear tarjeta amarilla de estado
                /*const estadoDiv = document.createElement("div");
                estadoDiv.textContent = "Estado validación documentos matrícula: PENDIENTE";
                estadoDiv.style.backgroundColor = "#ffc107"; // Amarillo
                estadoDiv.style.color = "#fff";
                estadoDiv.style.fontWeight = "600";
                estadoDiv.style.borderRadius = "6px";
                estadoDiv.style.padding = "10px 20px";
                estadoDiv.style.textAlign = "center";
                estadoDiv.style.margin = "10px auto";
                estadoDiv.style.width = "fit-content";
                estadoDiv.style.boxShadow = "0 2px 4px rgba(0,0,0,0.2)";*/
                const estadoDiv = estadoValidacion("documentos matrícula");
                contenedor.appendChild(estadoDiv);
            }

            if (accion === "resumen_ant_sd") {
                chatMensajes.innerHTML = "";

                // Imagen final
                const imgFinal = document.createElement("img");
                imgFinal.src = contenido.imagen;
                imgFinal.alt = "Proceso de admisión completado";
                //imgFinal.style.width = "80%";
                imgFinal.classList.add("imgFinal");
                /*imgFinal.style.maxWidth = "600px";*/
                imgFinal.style.borderRadius = "16px";
                imgFinal.style.boxShadow = "0 0 20px rgba(0,0,0,0.2)";
                //imgFinal.style.animation = "zoomIn 1.5s ease-in-out";
                imgFinal.style.animation = "fadeIn 2s ease-in-out";

                contenedor.appendChild(imgFinal);

                // Estilos animación minimalista
                const style = document.createElement("style");
                style.textContent = `
                    @keyframes fadeIn {
                        from { opacity: 0; transform: scale(0.97); }
                        to { opacity: 1; transform: scale(1); }
                    }
                    @keyframes fadeUp {
                        from { opacity: 0; transform: translateY(20px); }
                        to { opacity: 1; transform: translateY(0); }
                    }
                `;
                document.head.appendChild(style);

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/ant7.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }


            //######### 2 Antiguo con Deuda #######
            // --- Valor deuda antiguo cd---
            if (accion === "valor_dueda_ant_cd") {
                //chatMensajes.innerHTML = "";
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach(btn => {
                    const boton = crearBoton(btn.tipo, "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        if (btn.destino == "opciones_pago_deuda_antiguo") {
                            const intencionOpcionesPago = BASE_INTENCIONES.find(i => i.etiqueta === "opciones_pago_deuda_antiguo");
                            if (intencionOpcionesPago) agregarMensaje("Unibot", intencionOpcionesPago);                        
                        }
                        else if (btn.destino == "comprobante_deuda_ant_cd") {
                            let msgControl = "paso 2.1.1 terminado";
                            //Se consume web service de cambio de paso
                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/json' },
                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                            })
                            .then(r => r.json()) // ← Texto → Objeto
                            .then(data => {
                                if (data.status == "success") {
                                    paso = data.siguiente_paso;
                                    etiqueta_intencion = data.etiqueta_intencion;
                                    const intencionComprobante = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                    if (intencionComprobante) agregarMensaje("Unibot", intencionComprobante);
                                }
                            });
                        }
                    };
                    botonera.appendChild(boton);
                });
                contenedor.appendChild(botonera);
            }

            // --- Opciones pago deuda antiguo cd---
            if (accion === "opciones_pago_deuda_antiguo" && contenido.botones) {
                chatMensajes.innerHTML = "";
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach(btn => {
                    const boton = crearBoton(btn.tipo, "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        if (btn.tipo == "servicio") {
                            if (btn.valor == "link_pago_epayco") {
                                redirigirPOST('pagoDeuda.php', {
                                    documento: cc,
                                    valor: deuda,
                                    referencia: referencia_pago,
                                    concepto: "Deuda"
                                });
                            }
                            else {                                
                                window.open(btn.url, "_blank");
                            }
                        }
                        else if (btn.destino == "comprobante_deuda_ant_cd") {
                            let msgControl = "paso 2.1.1 terminado";
                            //Se consume web service de cambio de paso
                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/json' },
                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                            })
                            .then(r => r.json())
                            .then(data => {
                                if (data.status == "success") {
                                    paso = data.siguiente_paso;
                                    etiqueta_intencion = data.etiqueta_intencion;
                                    const intencionComprobante = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                    if (intencionComprobante) agregarMensaje("Unibot", intencionComprobante);
                                }
                            });                                                    
                        }
                    };
                    botonera.appendChild(boton);
                    //contenedor.appendChild(botonera);
                });
                contenedor.appendChild(botonera);
            }

            // --- Comprobante deuda antiguo cd---
            if (accion === "comprobante_deuda_ant_cd" && tipos.length > 0) {
                chatMensajes.innerHTML = "";
                const form = document.createElement("div");
                form.style.marginTop = "10px";
                form.style.marginLeft = "auto";
                form.style.maxWidth = "80%";
                form.style.padding = "10px";
                form.style.border = "1px solid #ddd";
                form.style.borderRadius = "8px";
                form.style.backgroundColor = "#f9f9f9";
                form.style.gap = "10px";
                form.style.display = "flex";
                form.style.flexDirection = "column";

                const input = document.createElement("input");
                input.type = "file";
                input.id = "input-archivo-" + Date.now();
                input.accept = tipos.map(t => t === "pdf" ? ".pdf" : "image/" + t).join(",");
                input.style.display = "none";

                const label = document.createElement("label");
                label.htmlFor = input.id;
                //label.textContent = "📤 Seleccionar comprobante";
                label.style.padding = "12px 16px";
                label.style.backgroundColor = "#FF9805";
                //label.style.backgroundColor = "#C75EA3";
                label.style.color = "white";
                label.style.borderRadius = "8px 0px 0px 0px";
                label.style.cursor = "pointer";
                //label.style.display = "inline-block";
                label.style.fontSize = "14px";
                label.style.fontWeight = "600";
                label.style.display = "flex";
                label.style.alignItems = "center";
                label.style.gap = "10px";

                // Icono input (imagen)
                const iconoInput = document.createElement("img");
                iconoInput.style.width = "30px";
                iconoInput.style.height = "30px";
                iconoInput.style.borderRadius = "4px";
                iconoInput.src = "chatbot/img/subir_pdf1.png";
                iconoInput.alt = "Subir";

                label.appendChild(iconoInput);

                // Texto input
                const textoInput = document.createElement("span");
                textoInput.textContent = " Seleccionar comprobante";
                textoInput.style.fontWeight = "600";
                textoInput.style.flexGrow = "1";
                textoInput.style.color = "white";

                label.appendChild(textoInput);

                const archivoTexto = document.createElement("span");
                archivoTexto.style.marginLeft = "10px";
                archivoTexto.style.fontSize = "13px";
                archivoTexto.style.color = "#555";

                // --- Nuevo botón "Cambiar medio de pago" ---
                const botonCambiarPago = crearBoton(contenido.botones[0].tipo, "#0B77B3", contenido.botones[0].texto);

                // Acción del botón → abre la intención "opciones_pago_deuda"
                botonCambiarPago.onclick = () => {
                    //Se debe devolver un paso
                    let msgControl = "paso 2.1.1.1 pendiente";
                    //Se consume web service de cambio de paso
                    fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso_anterior.php", {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                    })
                    .then(r => r.json())
                    .then(data => {
                        console.log(data);
                        if (data.status == "success") {
                            paso = data.paso_anterior;
                            //etiqueta_intencion = data.etiqueta_intencion;
                            const anterior = BASE_INTENCIONES.find(i => i.etiqueta === "opciones_pago_deuda_antiguo");
                            if (anterior) agregarMensaje("Unibot", anterior);
                        }
                    });
                };

                input.addEventListener("change", function(e) {
                    const file = e.target.files[0];
                    if (!file) return;

                    // Validar tipo
                    const ext = file.name.split(".").pop().toLowerCase();
                    if (!tipos.includes(ext)) {
                        alert(mensajeError);
                        return;
                    }

                    //Se valida que el documento del nombre del archivo sea el correcto
                    const doc = file.name.split("-").shift();
                    console.log(doc);
                    if (doc != cc) {
                        alert("El documento que aparece en el nombre del comprobante no corresponde con el número de documento del estudiante. Ejemplo de nombre de comprobante: 9999999-20251105-deuda.pdf");
                        return;
                    }

                    // Validar tamaño (máx 5MB)
                    if (file.size > 5 * 1024 * 1024) {
                        alert("El archivo es muy grande. Máximo 5 MB.");
                        return;
                    }

                    archivoTexto.textContent = file.name;

                    // Mostrar mensaje de espera
                    agregarMensaje("Unibot", mensajeEspera);

                    // Enviar archivo
                    const formData = new FormData();
                    formData.append("comprobante_deuda", file);
                    formData.append("valor", deuda);

                    fetch('http://localhost:90/avmeeuu/avmeeuu/api/subir_comprobante_deuda.php', {
                        method: 'POST',
                        body: formData
                    })
                    //.then(r => r.json())
                    .then(async r => {
                        const text = await r.text(); // lee la respuesta como texto crudo
                        console.log(text); // aquí verás lo que realmente devolvió el servidor
                        try {
                            const data = JSON.parse(text); // intenta parsear a JSON
                            return data;
                        } catch (e) {
                            //console.error("⚠️ La respuesta no es JSON válido:");
                            throw e; // lanza el error para que caiga en el catch
                        }
                    })
                    .then(data => {
                        if (data.status == "success") {
                            //agregarMensaje("Unibot", mensajeExito);

                            let msgControl = "paso 2.1.1.1 terminado";
                            //Se consume web service de cambio de paso
                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/json' },
                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                            })
                            .then(r => r.json()) // ← Texto → Objeto
                            .then(data => {
                                if (data.status == "success") {
                                    paso = data.siguiente_paso;
                                    etiqueta_intencion = data.etiqueta_intencion;
                                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                    if (intencion) agregarMensaje("Unibot", intencion);

                                    //imagen con pasos resumen
                                    const divPasos = document.getElementById("div-pasos");
                                    divPasos.innerHTML = "";
                                    const imgPasos = document.createElement("img");
                                    imgPasos.style.width = "100%";
                                    imgPasos.src = "chatbot/img/ant_deu3.jpg";
                                    imgPasos.alt = "Click";
                                    divPasos.appendChild(imgPasos);
                                }
                            });
                            
                        }
                        else {
                            agregarMensaje("Unibot", mensajeError + " " + data.mensaje);
                        }
                    })
                    .catch(err => {
                        console.log("❌ Error general:", err);
                        agregarMensaje("Unibot", mensajeError);
                    });
                });

                form.appendChild(input);
                form.appendChild(label);
                form.appendChild(archivoTexto);
                form.appendChild(botonCambiarPago);
                contenedor.appendChild(form);
            }

            // --- validación comprobante deuda antiguo cd---
            if (accion === "validando_comprobante_deuda_ant_cd") {
                chatMensajes.innerHTML = "";
                
                // Crear tarjeta amarilla de estado
                const estadoDiv = estadoValidacion("comprobante pago deuda");
                contenedor.appendChild(estadoDiv);
            }

            // --- Datos actuales antiguo cd---
            if (accion === "datos_actuales_ant_cd" && contenido.url) {
                chatMensajes.innerHTML = "";

                // Mensaje de carga
                const contenedorCarga = document.createElement("div");
                //contenedorCarga.textContent = "📄 Cargando datos del estudiante...";
                contenedorCarga.style.padding = "12px";
                contenedorCarga.style.background = "#f0f0f0";
                contenedorCarga.style.borderRadius = "6px";
                contenedorCarga.style.margin = "10px auto";
                contenedor.appendChild(contenedorCarga);

                // Llamada al web service
                fetch(contenido.url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ documento: cc })
                })
                .then(r => r.json())
                .then(datos => {
                    if (datos.status !== "success") {
                        agregarMensaje("Unibot", "❌ No se pudo cargar la información del estudiante.");
                        return;
                    }                    
                    contenedor.removeChild(contenedorCarga);

                    const d = datos;
                    let grado = "";
                    if (d.grados.length > 0) {
                        grado = d.grados[0].gra;
                    }

                    // Bloque visual con datos
                    const cont = document.createElement("div");
                    cont.style.background = "#fff";
                    cont.style.border = "1px solid #ccc";
                    cont.style.borderRadius = "10px";
                    cont.style.padding = "15px";
                    cont.style.margin = "10px auto";
                    cont.style.maxWidth = "90%";
                    cont.style.lineHeight = "1.4";

                    let rh = d.rh.replace("mas", "+");
                    rh = rh.replace("menos", "-");

                    //<div><strong>Grado:</strong> ${d.grados?.[0]?.gra || ""}</div>

                    cont.innerHTML = `
                        <div style="font-weight:700;padding:6px 10px;margin-bottom:8px;border-top:3px solid #ff9805;border-bottom:3px solid #ff9805">
                            DATOS COMPLEMENTARIOS DEL ESTUDIANTE
                        </div>
                        <div><strong>Apellidos:</strong> ${d.apellidos}</div>
                        <div><strong>Nombres:</strong> ${d.nombres}</div>
                        <div><strong>Grado:</strong> ${grado}</div>
                        <div><strong>Tipo de documento:</strong> ${d.tdoc}</div>
                        <div><strong>Teléfono:</strong> ${d.tel}</div>
                        <div><strong>Correo:</strong> ${d.email}</div>
                        <div><strong>Factor RH:</strong> ${rh}</div>
                        <div><strong>Medio de llegada:</strong> ${d.medio}</div>
                        <div><strong>Actividad extra:</strong> ${d.actividad_extra}</div>
                        <div><strong>Género:</strong> ${d.genero}</div>
                        <br>
                        <div style="font-weight:700;padding:6px 10px;margin-bottom:8px;border-top:3px solid #ff9805;border-bottom:3px solid #ff9805">
                            CONDICIÓN SOCIO-ECONÓMICA: ${d.situacion_se}
                        </div>
                        <br>
                        <div style="font-weight:700;padding:6px 10px;margin-bottom:8px;border-top:3px solid #ff9805;border-bottom:3px solid #ff9805">
                            DATOS DEL ACUDIENTE
                        </div>
                        <div><strong>Nombre:</strong> ${d.acudiente}</div>
                        <div><strong>Documento:</strong> ${d.docA}</div>
                        <div><strong>Dirección:</strong> ${d.direccion}</div>
                        <div><strong>Celular:</strong> ${d.telA}</div>
                        <div><strong>Correo:</strong> ${d.emailA}</div>
                        <div><strong>Parentesco:</strong> ${d.parentesco_acudiente_1}</div>
                    `;
                    contenedor.appendChild(cont);

                    const msg1 = document.createElement("p");
                    msg1.style.alignSelf = "flex-start";
                    msg1.style.background = "#e3f2fd";
                    msg1.style.color = "#000";
                    //msg1.style.marginRight = "auto";
                    //msg1.style.margin = "6px 0";
                    //msg1.style.padding = "10px 14px";
                    //msg1.style.borderRadius = "18px";
                    //msg1.style.maxWidth = "80%";
                    //msg1.style.lineHeight = "1.5";
                    //msg1.style.wordWrap = "break-word";
                    msg1.className += "bot-msg";
                    if (grado == "" || grado == "Ninguno") {
                        msg1.innerHTML = "<strong>Unibot:</strong> Necesitas actualizar los datos registrados y seleccionar un grado.";
                    }
                    else {
                        msg1.innerHTML = "<strong>Unibot:</strong> Revisa y actualiza los datos registrados.";
                    }                    
                    contenedor.appendChild(msg1);
                    
                    // Botones (tu misma lógica)
                    const botonera = document.createElement("div");
                    botonera.style.display = "flex";
                    botonera.style.flexDirection = "column";
                    botonera.style.gap = "10px";
                    botonera.style.marginTop = "10px";
                    botonera.style.marginLeft = "auto";
                    botonera.style.maxWidth = "80%";

                    contenido.botones.forEach((btn, index) => {
                        const boton = crearBoton("intencion", "#0B77B3", btn.texto);

                        boton.onclick = () => {
                            const destino = BASE_INTENCIONES.find(i => i.etiqueta === btn.destino);
                            if (destino) agregarMensaje("Unibot", destino);
                        };

                        if ((grado == "" || grado == "Ninguno") && index == 1) {
                            //No se agrega el botón No
                        }
                        else {
                            botonera.appendChild(boton);
                        }
                        
                    });

                    contenedor.appendChild(botonera);
                })
                .catch(err => {
                    console.log("Error al cargar datos:", err);
                    agregarMensaje("Unibot", "❌ No fue posible conectar con el sistema.");
                });
            }

            // --- Formulario datos actuales antiguo cd ---
            if (accion === "formulario_inicial_ant_cd" && contenido.url) {
                chatMensajes.innerHTML = "";
                const contenedorCarga = document.createElement("div");
                contenedorCarga.style.marginTop = "10px";
                contenedorCarga.style.padding = "15px";
                contenedorCarga.style.border = "1px solid #ddd";
                contenedorCarga.style.borderRadius = "8px";
                contenedorCarga.style.backgroundColor = "#f9f9f9";
                contenedorCarga.style.textAlign = "center";

                const mensajeCarga = document.createElement("p");
                mensajeCarga.textContent = "Cargando información...";
                mensajeCarga.style.fontStyle = "italic";
                mensajeCarga.style.color = "#555";
                contenedorCarga.appendChild(mensajeCarga);

                const spinner = document.createElement("div");
                spinner.innerHTML = "⏳";
                spinner.style.fontSize = "24px";
                contenedorCarga.appendChild(spinner);

                contenedor.appendChild(contenedorCarga);
                chatMensajes.scrollTop = chatMensajes.scrollHeight;

                if (!cc) {
                    alert("Ingresa el número de documento del estudiante a matricular.");
                    return;
                }

                fetch(contenido.url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ documento: cc })
                })
                .then(r => r.json())
                .then(datos => {
                    if (datos.status !== "success") {
                        agregarMensaje("Unibot", "❌ No se pudo cargar la información del estudiante.");
                        return;
                    }

                    let seleccioneGrado = false;
                    if (datos.estado == "antiguo_pre_solicitud" || datos.control_antiguos == 1) {
                        seleccioneGrado = true;
                    }

                    // Remover mensaje de carga
                    contenedor.removeChild(contenedorCarga);

                    // Generar formulario con datos prellenados
                    generarFormularioConDatos(datos, contenedor, seleccioneGrado);
                    habilitarBoton(sonTodosValidos());
                })
                .catch(err => {
                    console.error("Error al cargar datos:", err);
                    agregarMensaje("Unibot", "❌ No fue posible conectar con el sistema.");
                });
            }

            // --- Costos matrícula antiguo cd ---
            if (accion === "costos_matricula_ant_cd") {
                chatMensajes.innerHTML = "";
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach(btn => {
                    const boton = crearBoton("intencion", "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        if (btn.destino == "opciones_pago_matricula_antiguo_cd") {
                            const intencionOpcionesPago = BASE_INTENCIONES.find(i => i.etiqueta === "opciones_pago_matricula_antiguo_cd");
                            if (intencionOpcionesPago) agregarMensaje("Unibot", intencionOpcionesPago);                        
                        }
                        else if (btn.destino == "comprobante_matricula_ant_cd") {
                            const intencionComprobante = BASE_INTENCIONES.find(i => i.etiqueta === "comprobante_matricula_ant_cd");
                            if (intencionComprobante) agregarMensaje("Unibot", intencionComprobante);
                        }
                    };
                    botonera.appendChild(boton);
                });
                contenedor.appendChild(botonera);

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/ant_deu6.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }

            // --- Opciones pago matrícula antiguo cd ---
            if (accion === "opciones_pago_matricula_antiguo_cd" && contenido.botones) {
                chatMensajes.innerHTML = "";
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach(btn => {
                    const boton = crearBoton(btn.tipo, "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        if (btn.tipo == "servicio") {
                            if (btn.valor == "link_pago_epayco") {
                                redirigirPOST('pagoMatricula.php', {
                                    documento: cc,
                                    valor: matricula,
                                    referencia: referencia_pago_m,
                                    concepto: "Matrícula"
                                });
                            }
                            else {                                
                                window.open(btn.url, "_blank");
                            }
                        }
                        else if (btn.destino == "comprobante_matricula_ant_cd") {
                            const intencionComprobante = BASE_INTENCIONES.find(i => i.etiqueta === "comprobante_matricula_ant_cd");
                            if (intencionComprobante) agregarMensaje("Unibot", intencionComprobante);                                                    
                        }
                    };
                    botonera.appendChild(boton);
                });
                contenedor.appendChild(botonera);
            }

            // --- Comprobante matrícula antiguo cd ---
            if (accion === "comprobante_matricula_ant_cd" && tipos.length > 0) {
                chatMensajes.innerHTML = "";
                const form = document.createElement("div");
                form.style.marginTop = "10px";
                form.style.marginLeft = "auto";
                form.style.maxWidth = "80%";
                form.style.padding = "10px";
                form.style.border = "1px solid #ddd";
                form.style.borderRadius = "8px";
                form.style.backgroundColor = "#f9f9f9";
                form.style.gap = "10px";
                form.style.display = "flex";
                form.style.flexDirection = "column";

                const input = document.createElement("input");
                input.type = "file";
                input.id = "input-archivo-" + Date.now();
                input.accept = tipos.map(t => t === "pdf" ? ".pdf" : "image/" + t).join(",");
                input.style.display = "none";

                const label = document.createElement("label");
                label.htmlFor = input.id;
                label.style.padding = "12px 16px";
                //label.style.backgroundColor = "#C75EA3";
                label.style.backgroundColor = "#FF9805";
                label.style.color = "white";
                label.style.borderRadius = "8px 0px 0px 0px";
                label.style.cursor = "pointer";
                label.style.fontSize = "14px";
                label.style.fontWeight = "600";
                label.style.display = "flex";
                label.style.alignItems = "center";
                label.style.gap = "10px";

                // Icono input (imagen)
                const iconoInput = document.createElement("img");
                iconoInput.style.width = "30px";
                iconoInput.style.height = "30px";
                iconoInput.style.borderRadius = "4px";
                iconoInput.src = "chatbot/img/subir_pdf1.png";
                iconoInput.alt = "Subir";

                label.appendChild(iconoInput);

                // Texto input
                const textoInput = document.createElement("span");
                textoInput.textContent = " Seleccionar comprobante";
                textoInput.style.fontWeight = "600";
                textoInput.style.flexGrow = "1";
                textoInput.style.color = "white";

                label.appendChild(textoInput);

                const archivoTexto = document.createElement("span");
                archivoTexto.style.marginLeft = "10px";
                archivoTexto.style.fontSize = "13px";
                archivoTexto.style.color = "#555";

                const botonCambiarPago = crearBoton("proceso", "#0B77B3", contenido.botones[0].texto);

                // Acción del botón → abre la intención "opciones_pago_deuda"
                botonCambiarPago.onclick = () => {
                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === "opciones_pago_matricula_antiguo_cd");
                    if (intencion) agregarMensaje("Unibot", intencion);
                };

                input.addEventListener("change", function(e) {
                    const file = e.target.files[0];
                    if (!file) return;

                    // Validar tipo
                    const ext = file.name.split(".").pop().toLowerCase();
                    if (!tipos.includes(ext)) {
                        alert(mensajeError);
                        return;
                    }

                    //Se valida que el documento del nombre del archivo sea el correcto
                    const doc = file.name.split("-").shift();
                    console.log(doc);
                    if (doc != cc) {
                        alert("El documento que aparece en el nombre del comprobante no corresponde con el número de documento del estudiante. Ejemplo de nombre de comprobante: 9999999-2026-pp.pdf");
                        return;
                    }

                    // Validar tamaño (máx 5MB)
                    if (file.size > 5 * 1024 * 1024) {
                        alert("El archivo es muy grande. Máximo 5 MB.");
                        return;
                    }

                    archivoTexto.textContent = file.name;

                    // Mostrar mensaje de espera
                    agregarMensaje("Unibot", mensajeEspera);

                    // Enviar archivo
                    const formData = new FormData();
                    formData.append("comprobante_matricula", file);
                    formData.append("valor", matricula);

                    fetch('http://localhost:90/avmeeuu/avmeeuu/api/subir_comprobante_matricula.php', {
                        method: 'POST',
                        body: formData
                    })
                    //.then(r => r.json())
                    .then(async r => {
                        const text = await r.text(); // lee la respuesta como texto crudo
                        console.log(text); // aquí verás lo que realmente devolvió el servidor
                        try {
                            const data = JSON.parse(text); // intenta parsear a JSON
                            return data;
                        } catch (e) {
                            //console.log("⚠️ La respuesta no es JSON válido:");
                            throw e; // lanza el error para que caiga en el catch
                        }
                    })
                    .then(data => {
                        if (data.status == "success") {
                            let msgControl = "paso 2.3 terminado";
                            //Se consume web service de cambio de paso
                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/json' },
                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                            })
                            .then(r => r.json())
                            .then(data => {
                                if (data.status == "success") {
                                    paso = data.siguiente_paso;
                                    etiqueta_intencion = data.etiqueta_intencion;
                                    let msgControl = "paso 2.3.1 terminado";
                                    //Se consume web service de cambio de paso
                                    fetch("http://localhost:90/avmeeuu/avmeeuu/api//av_update_paso.php", {
                                        method: 'POST',
                                        headers: { 'Content-Type': 'application/json' },
                                        body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                    })
                                    .then(r => r.json())
                                    .then(data => {
                                        if (data.status == "success") {
                                            paso = data.siguiente_paso;
                                            etiqueta_intencion = data.etiqueta_intencion;
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_deu7.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                    });
                                }
                            });
                            
                        }
                        else {
                            agregarMensaje("Unibot", mensajeError + " " + data.mensaje);
                        }
                    })
                    .catch(err => {
                        console.log("❌ Error general:", err);
                        agregarMensaje("Unibot", mensajeError);
                    });
                });

                form.appendChild(input);
                form.appendChild(label);
                form.appendChild(archivoTexto);
                form.appendChild(botonCambiarPago);
                contenedor.appendChild(form);
            }

            // --- validación comprobante matrícula antiguo cd ---
            if (accion === "validando_comprobante_matricula_ant_cd") {
                chatMensajes.innerHTML = "";
                
                // Crear tarjeta amarilla de estado
                const estadoDiv = estadoValidacion("comprobante pago matrícula");
                contenedor.appendChild(estadoDiv);
            }

            // --- Documentos finales antiguo cd ---
            if (accion === "documentos_finales_ant_cd") {
                chatMensajes.innerHTML = "";

                // Bloque visual con datos
                const cont = document.createElement("div");
                cont.style.background = "#fff";
                cont.style.border = "1px solid #ccc";
                cont.style.borderRadius = "10px";
                cont.style.padding = "15px";
                cont.style.margin = "10px auto";
                cont.style.maxWidth = "90%";
                cont.style.lineHeight = "1.4";

                cont.innerHTML = `
                    <div style="font-weight:700;padding:6px 10px;margin-bottom:8px;border-top:3px solid #ff9805;border-bottom:3px solid #ff9805">
                        LISTADO DE DOCUMENTOS
                    </div>
                    <div style="color: red;"><strong>Nota: Todos los documentos deben ser en pdf. Tener en cuenta que si todos los documentos no están debidamente cargados, serán rechazados y su proceso se demorará varios días más. La revisión podría tardar hasta 8 días hábiles.</strong></div><br>
                    <div>1. Contrato de matrícula, Pagaré y consentimiento informado <span style="font-weight: bold;">firmados</span>. <mark class="mi-resaltado">El pagaré debe estar autenticado en notaría.</mark> (El contrato y el pagaré se enviaron al correo del acudiente cuando se validó el comprobante de matrícula).</div><br>
                    <div>2. Documento de identidad del estudiante (registro civil para menores de 7 años; tarjeta de identidad entre 7 y 17 años y cédula de ciudadanía para mayores de 18 años). <span style="color: red;">Solo si cambió.</span></div><br>
                    <div>3. Documento de identidad del acudiente, (misma persona que firma el contrato). <span style="color: red;">Solo si cambió.</span></div><br>
                    <div>4. Paz y salvo año lectivo anterior.</div><br>
                    <div>5. Fotografía reciente del estudiante.</div><br>
                    <div>6. Certificado de afiliación a E.P.S del estudiante.</div><br>
                    <div>7. Certificado de actividad extracurricular. <span style="color: red;">Solo si cambió.</span></div><br>
                    <div>8. <mark class="mi-resaltado">Para estudiantes nuevos:</mark> <span style="color: white; background: orange;">Primaria:</span> Certificado final de calificaciones año anterior. <span style="color: white; background: purple;">Bachillerato:</span> Todos los certificados finales de calificaciones desde quinto de primaria hasta el último año cursado.</div><br>
                    <div>9. Carnet de vacunación al día, con esquema completo incluyendo refuerzos. Tener en cuenta la siguiente tabla:
                        <table>
                            <thead>
                                <tr>
                                    <th>EDAD</th><th>VACUNA</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>9 a 17 AÑOS</td><td>VPH</td>
                                </tr>
                                <tr>
                                    <td>6 a 15 AÑOS</td><td>SARAMPIÓN, RUBEOLA</td>
                                </tr>
                                <tr>
                                    <td>9 MESES a 19 AÑOS</td><td>FIEBRE AMARILLA</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                `;
                contenedor.appendChild(cont);
                asegurarScrollArriba(chatMensajes);

                // Botones (tu misma lógica)
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach((btn, index) => {
                    const boton = crearBoton("intencion", "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        const destino = BASE_INTENCIONES.find(i => i.etiqueta === btn.destino);
                        if (destino) agregarMensaje("Unibot", destino);
                    };

                    botonera.appendChild(boton);
                    
                });

                contenedor.appendChild(botonera);
                asegurarScrollArriba(chatMensajes);
            }

            // --- Formulario final antiguo cd ---
            if (accion === "formulario_final_antiguo_cd" && contenido.url) {
                chatMensajes.innerHTML = "";
                const contenedorCarga = document.createElement("div");
                contenedorCarga.style.marginTop = "10px";
                contenedorCarga.style.padding = "15px";
                contenedorCarga.style.border = "1px solid #ddd";
                contenedorCarga.style.borderRadius = "8px";
                contenedorCarga.style.backgroundColor = "#f9f9f9";
                contenedorCarga.style.textAlign = "center";

                const mensajeCarga = document.createElement("p");
                mensajeCarga.textContent = "Cargando información...";
                mensajeCarga.style.fontStyle = "italic";
                mensajeCarga.style.color = "#555";
                contenedorCarga.appendChild(mensajeCarga);

                const spinner = document.createElement("div");
                spinner.innerHTML = "⏳";
                spinner.style.fontSize = "24px";
                contenedorCarga.appendChild(spinner);

                contenedor.appendChild(contenedorCarga);
                chatMensajes.scrollTop = chatMensajes.scrollHeight;

                if (!cc) {
                    alert("Ingresa el número de documento del estudiante a matricular.");
                    return;
                }

                fetch(contenido.url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ documento: cc })
                })
                .then(r => r.json())
                .then(datos => {
                    if (datos.status !== "success") {
                        agregarMensaje("Unibot", "❌ No se pudo cargar la información del estudiante.");
                        return;
                    }

                    // Remover mensaje de carga
                    contenedor.removeChild(contenedorCarga);

                    // Generar formulario con datos prellenados
                    generarFormularioFinalConDatos(datos, contenedor);
                    habilitarBoton(sonTodosValidos());
                })
                .catch(err => {
                    console.log("Error al cargar datos:", err);
                    agregarMensaje("Unibot", "❌ No fue posible conectar con el sistema.");
                });
            }

            // --- validación documentos antiguo cd ---
            if (accion === "validando_documentos_ant_cd") {
                chatMensajes.innerHTML = "";
                
                // Crear tarjeta amarilla de estado
                const estadoDiv = estadoValidacion("documentos matrícula");
                contenedor.appendChild(estadoDiv);
            }

            if (accion === "resumen_ant_cd") {
                chatMensajes.innerHTML = "";

                // Imagen final
                const imgFinal = document.createElement("img");
                imgFinal.src = contenido.imagen;
                imgFinal.alt = "Proceso de admisión completado";
                //imgFinal.style.width = "80%";
                /*imgFinal.style.maxWidth = "600px";*/
                imgFinal.classList.add("imgFinal");
                imgFinal.style.borderRadius = "16px";
                imgFinal.style.boxShadow = "0 0 20px rgba(0,0,0,0.2)";
                //imgFinal.style.animation = "zoomIn 1.5s ease-in-out";
                imgFinal.style.animation = "fadeIn 2s ease-in-out";

                contenedor.appendChild(imgFinal);

                // Estilos animación minimalista
                const style = document.createElement("style");
                style.textContent = `
                    @keyframes fadeIn {
                        from { opacity: 0; transform: scale(0.97); }
                        to { opacity: 1; transform: scale(1); }
                    }
                    @keyframes fadeUp {
                        from { opacity: 0; transform: translateY(20px); }
                        to { opacity: 1; transform: translateY(0); }
                    }
                `;
                document.head.appendChild(style);

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/ant_deu10.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }


            //######### 3 Antiguo Nuevo con Deuda #######
            // --- Valor deuda antiguo nuevo cd---
            if (accion === "valor_dueda_ant_nuevo_cd") {
                //chatMensajes.innerHTML = "";
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach(btn => {
                    const boton = crearBoton(btn.tipo, "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        if (btn.destino == "opciones_pago_deuda_antiguo_nuevo") {
                            const intencionOpcionesPago = BASE_INTENCIONES.find(i => i.etiqueta === "opciones_pago_deuda_antiguo_nuevo");
                            if (intencionOpcionesPago) agregarMensaje("Unibot", intencionOpcionesPago);                        
                        }
                        else if (btn.destino == "comprobante_deuda_ant_nuevo_cd") {
                            let msgControl = "paso 3.1.1 terminado";
                            //Se consume web service de cambio de paso
                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/json' },
                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                            })
                            .then(r => r.json()) // ← Texto → Objeto
                            .then(data => {
                                if (data.status == "success") {
                                    paso = data.siguiente_paso;
                                    etiqueta_intencion = data.etiqueta_intencion;
                                    const intencionComprobante = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                    if (intencionComprobante) agregarMensaje("Unibot", intencionComprobante);
                                }
                            });
                        }
                    };
                    botonera.appendChild(boton);
                });
                contenedor.appendChild(botonera);
            }

            // --- Opciones pago deuda antiguo nuevo cd---
            if (accion === "opciones_pago_deuda_antiguo_nuevo" && contenido.botones) {
                chatMensajes.innerHTML = "";
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach(btn => {
                    const boton = crearBoton(btn.tipo, "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        if (btn.tipo == "servicio") {
                            if (btn.valor == "link_pago_epayco") {
                                redirigirPOST('pagoDeuda.php', {
                                    documento: cc,
                                    valor: deuda,
                                    referencia: referencia_pago,
                                    concepto: "Deuda"
                                });
                            }
                            else {                                
                                window.open(btn.url, "_blank");
                            }
                        }
                        else if (btn.destino == "comprobante_deuda_ant_nuevo_cd") {
                            let msgControl = "paso 3.1.1 terminado";
                            //Se consume web service de cambio de paso
                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/json' },
                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                            })
                            .then(r => r.json()) // ← Texto → Objeto
                            .then(data => {
                                if (data.status == "success") {
                                    paso = data.siguiente_paso;
                                    etiqueta_intencion = data.etiqueta_intencion;
                                    const intencionComprobante = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                    if (intencionComprobante) agregarMensaje("Unibot", intencionComprobante);
                                }
                            });                                                    
                        }
                    };
                    botonera.appendChild(boton);
                    //contenedor.appendChild(botonera);
                });
                contenedor.appendChild(botonera);
            }

            // --- Comprobante deuda antiguo nuevo cd---
            if (accion === "comprobante_deuda_ant_nuevo_cd" && tipos.length > 0) {
                chatMensajes.innerHTML = "";
                const form = document.createElement("div");
                form.style.marginTop = "10px";
                form.style.marginLeft = "auto";
                form.style.maxWidth = "80%";
                form.style.padding = "10px";
                form.style.border = "1px solid #ddd";
                form.style.borderRadius = "8px";
                form.style.backgroundColor = "#f9f9f9";
                form.style.gap = "10px";
                form.style.display = "flex";
                form.style.flexDirection = "column";

                const input = document.createElement("input");
                input.type = "file";
                input.id = "input-archivo-" + Date.now();
                input.accept = tipos.map(t => t === "pdf" ? ".pdf" : "image/" + t).join(",");
                input.style.display = "none";

                const label = document.createElement("label");
                label.htmlFor = input.id;
                //label.textContent = "📤 Seleccionar comprobante";
                label.style.padding = "12px 16px";
                label.style.backgroundColor = "#FF9805";
                //label.style.backgroundColor = "#C75EA3";
                label.style.color = "white";
                label.style.borderRadius = "8px 0px 0px 0px";
                label.style.cursor = "pointer";
                //label.style.display = "inline-block";
                label.style.fontSize = "14px";
                label.style.fontWeight = "600";
                label.style.display = "flex";
                label.style.alignItems = "center";
                label.style.gap = "10px";

                // Icono input (imagen)
                const iconoInput = document.createElement("img");
                iconoInput.style.width = "30px";
                iconoInput.style.height = "30px";
                iconoInput.style.borderRadius = "4px";
                iconoInput.src = "chatbot/img/subir_pdf1.png";
                iconoInput.alt = "Subir";

                label.appendChild(iconoInput);

                // Texto input
                const textoInput = document.createElement("span");
                textoInput.textContent = " Seleccionar comprobante";
                textoInput.style.fontWeight = "600";
                textoInput.style.flexGrow = "1";
                textoInput.style.color = "white";

                label.appendChild(textoInput);

                const archivoTexto = document.createElement("span");
                archivoTexto.style.marginLeft = "10px";
                archivoTexto.style.fontSize = "13px";
                archivoTexto.style.color = "#555";

                // --- Nuevo botón "Cambiar medio de pago" ---
                const botonCambiarPago = crearBoton(contenido.botones[0].tipo, "#0B77B3", contenido.botones[0].texto);

                // Acción del botón → abre la intención "opciones_pago_deuda"
                botonCambiarPago.onclick = () => {
                    //Se debe devolver un paso
                    let msgControl = "paso 3.1.1.1 pendiente";
                    //Se consume web service de cambio de paso
                    fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso_anterior.php", {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                    })
                    .then(r => r.json()) // ← Texto → Objeto
                    .then(data => {
                        if (data.status == "success") {
                            paso = data.paso_anterior;
                            etiqueta_intencion = data.etiqueta_intencion;
                            const anterior = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                            if (anterior) agregarMensaje("Unibot", anterior);
                        }
                    });
                };

                input.addEventListener("change", function(e) {
                    const file = e.target.files[0];
                    if (!file) return;

                    // Validar tipo
                    const ext = file.name.split(".").pop().toLowerCase();
                    if (!tipos.includes(ext)) {
                        alert(mensajeError);
                        return;
                    }

                    //Se valida que el documento del nombre del archivo sea el correcto
                    const doc = file.name.split("-").shift();
                    console.log(doc);
                    if (doc != cc) {
                        alert("El documento que aparece en el nombre del comprobante no corresponde con el número de documento del estudiante. Ejemplo de nombre de comprobante: 9999999-20251105-deuda.pdf");
                        return;
                    }

                    // Validar tamaño (máx 5MB)
                    if (file.size > 5 * 1024 * 1024) {
                        alert("El archivo es muy grande. Máximo 5 MB.");
                        return;
                    }

                    archivoTexto.textContent = file.name;

                    // Mostrar mensaje de espera
                    agregarMensaje("Unibot", mensajeEspera);

                    // Enviar archivo
                    const formData = new FormData();
                    formData.append("comprobante_deuda", file);
                    formData.append("valor", deuda);

                    //fetch('chatbot/subir-comprobante-deuda.php', {
                    fetch('http://localhost:90/avmeeuu/avmeeuu/api/subir_comprobante_deuda.php', {
                        method: 'POST',
                        body: formData
                    })
                    //.then(r => r.json())
                    .then(async r => {
                        const text = await r.text(); // lee la respuesta como texto crudo
                        console.log(text); // aquí verás lo que realmente devolvió el servidor
                        try {
                            const data = JSON.parse(text); // intenta parsear a JSON
                            return data;
                        } catch (e) {
                            //console.error("⚠️ La respuesta no es JSON válido:");
                            throw e; // lanza el error para que caiga en el catch
                        }
                    })
                    .then(data => {
                        //El siguiente bloque es en local
                        /*if (data.ok) {
                            let msgControl = "paso 3.1.1.1 terminado";
                            //Se consume web service de cambio de paso
                            agregarMensaje("Unibot", mensajeExito);
                        } else {
                            agregarMensaje("Unibot", mensajeError + " " + data.error);
                        }*/
                       if (data.status == "success") {
                            //agregarMensaje("Unibot", mensajeExito);

                            let msgControl = "paso 3.1.1.1 terminado";
                            //Se consume web service de cambio de paso
                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/json' },
                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                            })
                            .then(r => r.json()) // ← Texto → Objeto
                            .then(data => {
                                if (data.status == "success") {
                                    paso = data.siguiente_paso;
                                    etiqueta_intencion = data.etiqueta_intencion;
                                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                    if (intencion) agregarMensaje("Unibot", intencion);

                                    //imagen con pasos resumen
                                    const divPasos = document.getElementById("div-pasos");
                                    divPasos.innerHTML = "";
                                    const imgPasos = document.createElement("img");
                                    imgPasos.style.width = "100%";
                                    imgPasos.src = "chatbot/img/ant_nue_deu3.jpg";
                                    imgPasos.alt = "Click";
                                    divPasos.appendChild(imgPasos);
                                }
                            });
                            
                        }
                        else {
                            agregarMensaje("Unibot", mensajeError + " " + data.mensaje);
                        }
                    })
                    .catch(err => {
                        //console.error(err);
                        console.error("❌ Error general:", err);
                        agregarMensaje("Unibot", mensajeError);
                    });
                });

                // Forzar que el label active el input
                /*label.onclick = () => {
                    input.click();
                };*/

                form.appendChild(input);
                form.appendChild(label);
                form.appendChild(archivoTexto);
                form.appendChild(botonCambiarPago);
                contenedor.appendChild(form);
            }

            // --- validación comprobante deuda antiguo nuevo cd---
            if (accion === "validando_comprobante_deuda_ant_nuevo_cd") {
                chatMensajes.innerHTML = "";
                
                // Crear tarjeta amarilla de estado
                const estadoDiv = estadoValidacion("comprobante pago deuda");
                contenedor.appendChild(estadoDiv);
            }

            // --- Datos actuales antiguo nuevo cd---
            if (accion === "datos_actuales_ant_nuevo_cd" && contenido.url) {
                chatMensajes.innerHTML = "";

                // Mensaje de carga
                const contenedorCarga = document.createElement("div");
                //contenedorCarga.textContent = "📄 Cargando datos del estudiante...";
                contenedorCarga.style.padding = "12px";
                contenedorCarga.style.background = "#f0f0f0";
                contenedorCarga.style.borderRadius = "6px";
                contenedorCarga.style.margin = "10px auto";
                contenedor.appendChild(contenedorCarga);

                // Llamada al web service
                fetch(contenido.url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ documento: cc })
                })
                .then(r => r.json())
                .then(datos => {
                    if (datos.status !== "success") {
                        agregarMensaje("Unibot", "❌ No se pudo cargar la información del estudiante.");
                        return;
                    }                    
                    contenedor.removeChild(contenedorCarga);

                    const d = datos;
                    let grado = "";
                    if (d.grados.length > 0) {
                        grado = "Ninguno";
                    }
                    else {
                        grado = d.grados[0].gra;
                    }

                    // Bloque visual con datos
                    const cont = document.createElement("div");
                    cont.style.background = "#fff";
                    cont.style.border = "1px solid #ccc";
                    cont.style.borderRadius = "10px";
                    cont.style.padding = "15px";
                    cont.style.margin = "10px auto";
                    cont.style.maxWidth = "90%";
                    cont.style.lineHeight = "1.4";

                    let rh = d.rh.replace("mas", "+");
                    rh = rh.replace("menos", "-");

                    //<div><strong>Grado:</strong> ${d.grados?.[0]?.gra || ""}</div>

                    cont.innerHTML = `
                        <div style="font-weight:700;padding:6px 10px;margin-bottom:8px;border-top:3px solid #ff9805;border-bottom:3px solid #ff9805">
                            DATOS COMPLEMENTARIOS DEL ESTUDIANTE
                        </div>
                        <div><strong>Apellidos:</strong> ${d.apellidos}</div>
                        <div><strong>Nombres:</strong> ${d.nombres}</div>
                        <div><strong>Grado:</strong> ${grado}</div>
                        <div><strong>Tipo de documento:</strong> ${d.tdoc}</div>
                        <div><strong>Teléfono:</strong> ${d.tel}</div>
                        <div><strong>Correo:</strong> ${d.email}</div>
                        <div><strong>Factor RH:</strong> ${rh}</div>
                        <div><strong>Medio de llegada:</strong> ${d.medio}</div>
                        <div><strong>Actividad extra:</strong> ${d.actividad_extra}</div>
                        <div><strong>Género:</strong> ${d.genero}</div>
                        <br>
                        <div style="font-weight:700;padding:6px 10px;margin-bottom:8px;border-top:3px solid #ff9805;border-bottom:3px solid #ff9805">
                            CONDICIÓN SOCIO-ECONÓMICA: ${d.situacion_se}
                        </div>
                        <br>
                        <div style="font-weight:700;padding:6px 10px;margin-bottom:8px;border-top:3px solid #ff9805;border-bottom:3px solid #ff9805">
                            DATOS DEL ACUDIENTE
                        </div>
                        <div><strong>Nombre:</strong> ${d.acudiente}</div>
                        <div><strong>Documento:</strong> ${d.docA}</div>
                        <div><strong>Dirección:</strong> ${d.direccion}</div>
                        <div><strong>Celular:</strong> ${d.telA}</div>
                        <div><strong>Correo:</strong> ${d.emailA}</div>
                        <div><strong>Parentesco:</strong> ${d.parentesco_acudiente_1}</div>
                    `;
                    contenedor.appendChild(cont);

                    const msg1 = document.createElement("p");
                    msg1.style.alignSelf = "flex-start";
                    msg1.style.background = "#e3f2fd";
                    msg1.style.color = "#000";
                    //msg1.style.marginRight = "auto";
                    //msg1.style.margin = "6px 0";
                    //msg1.style.padding = "10px 14px";
                    //msg1.style.borderRadius = "18px";
                    //msg1.style.maxWidth = "80%";
                    //msg1.style.lineHeight = "1.5";
                    //msg1.style.wordWrap = "break-word";
                    //msg1.className += "bot-msg";
                    if (grado == "" || grado == "Ninguno") {
                        msg1.innerHTML = "<strong>Unibot:</strong> Necesitas actualizar los datos registrados y seleccionar un grado.";
                    }
                    else {
                        msg1.innerHTML = "<strong>Unibot:</strong> ¿Desea actualizarlos?";
                    }                    
                    contenedor.appendChild(msg1);
                    
                    // Botones (tu misma lógica)
                    const botonera = document.createElement("div");
                    botonera.style.display = "flex";
                    botonera.style.flexDirection = "column";
                    botonera.style.gap = "10px";
                    botonera.style.marginTop = "10px";
                    botonera.style.marginLeft = "auto";
                    botonera.style.maxWidth = "80%";

                    contenido.botones.forEach((btn, index) => {
                        const boton = crearBoton("intencion", "#0B77B3", btn.texto);

                        boton.onclick = () => {
                            const destino = BASE_INTENCIONES.find(i => i.etiqueta === btn.destino);
                            if (destino) agregarMensaje("Unibot", destino);
                        };

                        if ((grado == "" || grado == "Ninguno") && index == 1) {
                            //No se agrega el botón No
                        }
                        else {
                            botonera.appendChild(boton);
                        }
                        
                    });

                    contenedor.appendChild(botonera);
                })
                .catch(err => {
                    console.error("Error al cargar datos:", err);
                    agregarMensaje("Unibot", "❌ No fue posible conectar con el sistema.");
                });
            }

            // --- Formulario datos actuales antiguo nuevo cd ---
            if (accion === "formulario_inicial_ant_nuevo_cd" && contenido.url) {
                chatMensajes.innerHTML = "";
                const contenedorCarga = document.createElement("div");
                contenedorCarga.style.marginTop = "10px";
                contenedorCarga.style.padding = "15px";
                contenedorCarga.style.border = "1px solid #ddd";
                contenedorCarga.style.borderRadius = "8px";
                contenedorCarga.style.backgroundColor = "#f9f9f9";
                contenedorCarga.style.textAlign = "center";

                const mensajeCarga = document.createElement("p");
                mensajeCarga.textContent = "Cargando información...";
                mensajeCarga.style.fontStyle = "italic";
                mensajeCarga.style.color = "#555";
                contenedorCarga.appendChild(mensajeCarga);

                const spinner = document.createElement("div");
                spinner.innerHTML = "⏳";
                spinner.style.fontSize = "24px";
                contenedorCarga.appendChild(spinner);

                contenedor.appendChild(contenedorCarga);
                chatMensajes.scrollTop = chatMensajes.scrollHeight;

                if (!cc) {
                    alert("Ingresa el número de documento del estudiante a matricular.");
                    return;
                }

                fetch(contenido.url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ documento: cc })
                })
                .then(r => r.json())
                .then(datos => {
                    if (datos.status !== "success") {
                        agregarMensaje("Unibot", "❌ No se pudo cargar la información del estudiante.");
                        return;
                    }

                    let seleccioneGrado = true;
                    if (datos.estado == "nuevo" || datos.control_antiguos == 2) {
                        seleccioneGrado = false;
                    }

                    // Remover mensaje de carga
                    contenedor.removeChild(contenedorCarga);

                    // Generar formulario con datos prellenados
                    generarFormularioConDatos(datos, contenedor, seleccioneGrado);
                    habilitarBoton(sonTodosValidos());
                })
                .catch(err => {
                    console.error("Error al cargar datos:", err);
                    agregarMensaje("Unibot", "❌ No fue posible conectar con el sistema.");
                });
            }

            // --- Evaluación admisión antiguo nuevo cd---
            if (accion === "evaluacion_admision_ant_nuevo_cd") {
                chatMensajes.innerHTML = "";

                // Botones (tu misma lógica)
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach((btn, index) => {
                    const boton = crearBoton(btn.tipo, "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        window.open(btn.url, '_blank');
                    };

                    botonera.appendChild(boton);                    
                });

                contenedor.appendChild(botonera);
                
                // Crear tarjeta amarilla de estado
                const estadoDiv = estadoValidacion("Estado evaluación admisión");
                contenedor.appendChild(estadoDiv);

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/ant_nue_deu6.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }

            // Opciones de entrevista (día y hora) antiguo nuevo cd
            if (accion === "entrevista_ant_nuevo_cd" && contenido.url) {
                chatMensajes.innerHTML = "";
                
                // Llamar al web service
                fetch(contenido.url)
                .then(r => r.json())
                .then(data => {
                    // Quitar el mensaje de carga
                    //contenedor.removeChild(contenedorCarga);

                    if (data.status !== "success" || !data.botones) {
                        agregarMensaje("Unibot", "❌ No se pudieron cargar los horarios.");
                        return;
                    }

                    // Crear los botones dinámicamente
                    const botonera = document.createElement("div");
                    //botonera.style.display = "flex";
                    //botonera.style.flexDirection = "column";
                    botonera.style.display = "grid";
                    botonera.style.gridTemplateColumns = "repeat(3, 1fr)";
                    botonera.style.gap = "10px";
                    botonera.style.marginTop = "10px";
                    botonera.style.marginLeft = "auto";
                    botonera.style.maxWidth = "100%";

                    data.botones.forEach(btn => {
                        const boton = crearBoton(btn.tipo, "#28A745", btn.texto);

                        boton.onclick = () => {
                            // Desactivar el botón y mostrar carga
                            boton.disabled = true;
                            boton.innerHTML = `
                                <img src="chatbot/img/subiendo.gif" 
                                    alt="Cargando" 
                                    style="width: 20%; vertical-align: middle; margin-right: 8px;">
                                Enviando...
                            `;
                            boton.style.opacity = "0.7";
                            boton.style.cursor = "not-allowed";
                            
                            // Aquí se procesa la selección del horario
                            let valor = btn.valor.split("|");
                            const datos = {
                                idpsi: data.idpsi,
                                psicologo: data.psicologo,
                                cel_psi: data.celular_psi,
                                meet_psi: data.meet_psi,
                                documento_est: cc,
                                fecha_ent: valor[0],
                                hora_ent: valor[1]
                            };

                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_programar_entrevista.php", {
                                method: "POST",
                                headers: { "Content-Type": "application/json" },
                                body: JSON.stringify(datos)
                            })
                            .then(r => r.json())
                            .then(resp => {
                                if (resp.status === "success") {
                                    let correo = resp.mensaje_entrevista.split("_");
                                    let respuesta = "✅ Entrevista agendada exitosamente. Se envío un correo con toda la información a " + correo[1];

                                    let intencion = BASE_INTENCIONES.find(i => i.etiqueta === "reprogramar_entrevista_ant_nuevo_cd");
                                    intencion.respuesta = respuesta;
                                    if (intencion) agregarMensaje("Unibot", intencion);
                                    //agregarMensaje("Unibot", "✅ Entrevista agendada exitosamente.");
                                } else {
                                    let respuesta = "❌ Agenda ocupada para esa fecha y hora. Selecciona otra opción.";

                                    let intencion = BASE_INTENCIONES.find(i => i.etiqueta === "entrevista_ant_nuevo_cd");
                                    intencion.respuesta = respuesta;
                                    if (intencion) agregarMensaje("Unibot", intencion);
                                    //agregarMensaje("Unibot", "❌ Agenda ocupada para esa fecha y hora. Selecciona otra opción.");
                                }
                            })
                            .catch(err => {
                                console.log(err);
                                agregarMensaje("Unibot", "⚠️ Error de conexión con el servidor.");
                            });
                        };

                        botonera.appendChild(boton);
                    });

                    contenedor.appendChild(botonera);

                    // Mostrar la tarjeta amarilla con estado
                    const estadoDiv = estadoEntrevista(entrevista, admitido);

                    contenedor.appendChild(estadoDiv);
                })
                .catch(() => {
                    agregarMensaje("Unibot", "❌ No fue posible conectar con el sistema.");
                });

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/ant_nue_deu7.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }

            // Reprogramar entrevista (día y hora) antiguo nuevo cd
            if (accion === "reprogramar_entrevista_ant_nuevo_cd") {
                chatMensajes.innerHTML = "";
                
                if (intentos_programacion_entrevista < 3 && entrevista == "NO") {
                    const botonera = document.createElement("div");
                    botonera.style.display = "flex";
                    botonera.style.flexDirection = "column";
                    botonera.style.gap = "10px";
                    botonera.style.marginTop = "10px";
                    botonera.style.marginLeft = "auto";
                    botonera.style.maxWidth = "80%";

                    contenido.botones.forEach(btn => {
                        const boton = crearBoton(btn.tipo, "#0B77B3", btn.texto);

                        boton.onclick = () => {
                            if (btn.tipo === "intencion" && btn.destino) {
                                const intencionDestino = BASE_INTENCIONES.find(i => i.etiqueta === btn.destino);
                                if (intencionDestino) {
                                    agregarMensaje("Unibot", intencionDestino);
                                } 
                            } 
                        };

                        botonera.appendChild(boton);
                    });

                    contenedor.appendChild(botonera);
                }

                // Mostrar la tarjeta amarilla con estado
                const estadoDiv = estadoEntrevista(entrevista, admitido);
                contenedor.appendChild(estadoDiv);

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/ant_nue_deu7.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }

            // --- Costos matrícula antiguo nuevo cd---
            if (accion === "costos_matricula_ant_nuevo_cd") {
                chatMensajes.innerHTML = "";
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach(btn => {
                    const boton = crearBoton("intencion", "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        if (btn.destino == "opciones_pago_matricula_antiguo_nuevo_cd") {
                            const intencionOpcionesPago = BASE_INTENCIONES.find(i => i.etiqueta === "opciones_pago_matricula_antiguo_nuevo_cd");
                            if (intencionOpcionesPago) agregarMensaje("Unibot", intencionOpcionesPago);                        
                        }
                        else if (btn.destino == "comprobante_matricula_ant_nuevo_cd") {
                            const intencionComprobante = BASE_INTENCIONES.find(i => i.etiqueta === "comprobante_matricula_ant_nuevo_cd");
                            if (intencionComprobante) agregarMensaje("Unibot", intencionComprobante);
                        }
                    };
                    botonera.appendChild(boton);
                });
                contenedor.appendChild(botonera);

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/ant_nue_deu8.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }

            // --- Opciones pago matrícula antiguo nuevo cd---
            if (accion === "opciones_pago_matricula_antiguo_nuevo_cd" && contenido.botones) {
                chatMensajes.innerHTML = "";
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach(btn => {
                    const boton = crearBoton(btn.tipo, "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        if (btn.tipo == "servicio") {
                            if (btn.valor == "link_pago_epayco") {
                                redirigirPOST('pagoMatricula.php', {
                                    documento: cc,
                                    valor: matricula,
                                    referencia: referencia_pago_m,
                                    concepto: "Matrícula"
                                });
                            }
                            else {                                
                                window.open(btn.url, "_blank");
                            }
                        }
                        else if (btn.destino == "comprobante_matricula_ant_nuevo_cd") {
                            const intencionComprobante = BASE_INTENCIONES.find(i => i.etiqueta === "comprobante_matricula_ant_nuevo_cd");
                            if (intencionComprobante) agregarMensaje("Unibot", intencionComprobante);                                                    
                        }
                    };
                    botonera.appendChild(boton);
                });
                contenedor.appendChild(botonera);
            }

            // --- Comprobante matrícula antiguo nuevo cd---
            if (accion === "comprobante_matricula_ant_nuevo_cd" && tipos.length > 0) {
                chatMensajes.innerHTML = "";
                const form = document.createElement("div");
                form.style.marginTop = "10px";
                form.style.marginLeft = "auto";
                form.style.maxWidth = "80%";
                form.style.padding = "10px";
                form.style.border = "1px solid #ddd";
                form.style.borderRadius = "8px";
                form.style.backgroundColor = "#f9f9f9";
                form.style.gap = "10px";
                form.style.display = "flex";
                form.style.flexDirection = "column";

                const input = document.createElement("input");
                input.type = "file";
                input.id = "input-archivo-" + Date.now();
                input.accept = tipos.map(t => t === "pdf" ? ".pdf" : "image/" + t).join(",");
                input.style.display = "none";

                const label = document.createElement("label");
                label.htmlFor = input.id;
                label.style.padding = "12px 16px";
                //label.style.backgroundColor = "#C75EA3";
                label.style.backgroundColor = "#FF9805";
                label.style.color = "white";
                label.style.borderRadius = "8px 0px 0px 0px";
                label.style.cursor = "pointer";
                label.style.fontSize = "14px";
                label.style.fontWeight = "600";
                label.style.display = "flex";
                label.style.alignItems = "center";
                label.style.gap = "10px";

                // Icono input (imagen)
                const iconoInput = document.createElement("img");
                iconoInput.style.width = "30px";
                iconoInput.style.height = "30px";
                iconoInput.style.borderRadius = "4px";
                iconoInput.src = "chatbot/img/subir_pdf1.png";
                iconoInput.alt = "Subir";

                label.appendChild(iconoInput);

                // Texto input
                const textoInput = document.createElement("span");
                textoInput.textContent = " Seleccionar comprobante";
                textoInput.style.fontWeight = "600";
                textoInput.style.flexGrow = "1";
                textoInput.style.color = "white";

                label.appendChild(textoInput);

                const archivoTexto = document.createElement("span");
                archivoTexto.style.marginLeft = "10px";
                archivoTexto.style.fontSize = "13px";
                archivoTexto.style.color = "#555";

                const botonCambiarPago = crearBoton("proceso", "#0B77B3", contenido.botones[0].texto);

                // Acción del botón → abre la intención "opciones_pago_deuda"
                botonCambiarPago.onclick = () => {
                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === "opciones_pago_matricula_antiguo_nuevo_cd");
                    if (intencion) agregarMensaje("Unibot", intencion);
                };

                input.addEventListener("change", function(e) {
                    const file = e.target.files[0];
                    if (!file) return;

                    // Validar tipo
                    const ext = file.name.split(".").pop().toLowerCase();
                    if (!tipos.includes(ext)) {
                        alert(mensajeError);
                        return;
                    }

                    //Se valida que el documento del nombre del archivo sea el correcto
                    const doc = file.name.split("-").shift();
                    console.log(doc);
                    if (doc != cc) {
                        alert("El documento que aparece en el nombre del comprobante no corresponde con el número de documento del estudiante. Ejemplo de nombre de comprobante: 9999999-2026-pp.pdf");
                        return;
                    }

                    // Validar tamaño (máx 5MB)
                    if (file.size > 5 * 1024 * 1024) {
                        alert("El archivo es muy grande. Máximo 5 MB.");
                        return;
                    }

                    archivoTexto.textContent = file.name;

                    // Mostrar mensaje de espera
                    agregarMensaje("Unibot", mensajeEspera);

                    // Enviar archivo
                    const formData = new FormData();
                    formData.append("comprobante_matricula", file);
                    formData.append("valor", matricula);

                    fetch('http://localhost:90/avmeeuu/avmeeuu/api/subir_comprobante_matricula.php', {
                        method: 'POST',
                        body: formData
                    })
                    //.then(r => r.json())
                    .then(async r => {
                        const text = await r.text(); // lee la respuesta como texto crudo
                        console.log(text); // aquí verás lo que realmente devolvió el servidor
                        try {
                            const data = JSON.parse(text); // intenta parsear a JSON
                            return data;
                        } catch (e) {
                            //console.log("⚠️ La respuesta no es JSON válido:");
                            throw e; // lanza el error para que caiga en el catch
                        }
                    })
                    .then(data => {
                        if (data.status == "success") {
                            let msgControl = "paso 3.5 terminado";
                            //Se consume web service de cambio de paso
                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/json' },
                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                            })
                            .then(r => r.json())
                            .then(data => {
                                if (data.status == "success") {
                                    paso = data.siguiente_paso;
                                    etiqueta_intencion = data.etiqueta_intencion;
                                    let msgControl = "paso 3.5.1 terminado";
                                    //Se consume web service de cambio de paso
                                    fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                        method: 'POST',
                                        headers: { 'Content-Type': 'application/json' },
                                        body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                    })
                                    .then(r => r.json())
                                    .then(data => {
                                        if (data.status == "success") {
                                            paso = data.siguiente_paso;
                                            etiqueta_intencion = data.etiqueta_intencion;
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue_deu9.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                    });
                                }
                            });
                            
                        }
                        else {
                            agregarMensaje("Unibot", mensajeError + " " + data.mensaje);
                        }
                    })
                    .catch(err => {
                        console.log("❌ Error general:", err);
                        agregarMensaje("Unibot", mensajeError);
                    });
                });

                form.appendChild(input);
                form.appendChild(label);
                form.appendChild(archivoTexto);
                form.appendChild(botonCambiarPago);
                contenedor.appendChild(form);
            }

            // --- validación comprobante matrícula antiguo nuevo cd---
            if (accion === "validando_comprobante_matricula_ant_nuevo_cd") {
                chatMensajes.innerHTML = "";
                
                // Crear tarjeta amarilla de estado
                const estadoDiv = estadoValidacion("comprobante pago matrícula");
                contenedor.appendChild(estadoDiv);
            }

            // --- Documentos finales antiguo nuevo cd---
            //if (accion === "documentos_finales_ant_nuevo_cd" && contenido.url) {
            if (accion === "documentos_finales_ant_nuevo_cd") {
                chatMensajes.innerHTML = "";

                // Bloque visual con datos
                const cont = document.createElement("div");
                cont.style.background = "#fff";
                cont.style.border = "1px solid #ccc";
                cont.style.borderRadius = "10px";
                cont.style.padding = "15px";
                cont.style.margin = "10px auto";
                cont.style.maxWidth = "90%";
                cont.style.lineHeight = "1.4";

                cont.innerHTML = `
                    <div style="font-weight:700;padding:6px 10px;margin-bottom:8px;border-top:3px solid #ff9805;border-bottom:3px solid #ff9805">
                        LISTADO DE DOCUMENTOS
                    </div>
                    <div style="color: red;"><strong>Nota: Todos los documentos deben ser en pdf. Tener en cuenta que si todos los documentos no están debidamente cargados, serán rechazados y su proceso se demorará varios días más. La revisión podría tardar hasta 8 días hábiles.</strong></div><br>
                    <div>1. Contrato de matrícula, Pagaré y consentimiento informado <span style="font-weight: bold;">firmados</span>. <mark class="mi-resaltado">El pagaré debe estar autenticado en notaría.</mark> (El contrato y el pagaré se enviaron al correo del acudiente cuando se validó el comprobante de matrícula).</div><br>
                    <div>2. Documento de identidad del estudiante (registro civil para menores de 7 años; tarjeta de identidad entre 7 y 17 años y cédula de ciudadanía para mayores de 18 años). <span style="color: red;">Solo si cambió.</span></div><br>
                    <div>3. Documento de identidad del acudiente, (misma persona que firma el contrato). <span style="color: red;">Solo si cambió.</span></div><br>
                    <div>4. Paz y salvo año lectivo anterior.</div><br>
                    <div>5. Fotografía reciente del estudiante.</div><br>
                    <div>6. Certificado de afiliación a E.P.S del estudiante.</div><br>
                    <div>7. Certificado de actividad extracurricular. <span style="color: red;">Solo si cambió.</span></div><br>
                    <div>8. <mark class="mi-resaltado">Para estudiantes nuevos:</mark> <span style="color: white; background: orange;">Primaria:</span> Certificado final de calificaciones año anterior. <span style="color: white; background: purple;">Bachillerato:</span> Todos los certificados finales de calificaciones desde quinto de primaria hasta el último año cursado.</div><br>
                    <div>9. Carnet de vacunación al día, con esquema completo incluyendo refuerzos. Tener en cuenta la siguiente tabla:
                        <table>
                            <thead>
                                <tr>
                                    <th>EDAD</th><th>VACUNA</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>9 a 17 AÑOS</td><td>VPH</td>
                                </tr>
                                <tr>
                                    <td>6 a 15 AÑOS</td><td>SARAMPIÓN, RUBEOLA</td>
                                </tr>
                                <tr>
                                    <td>9 MESES a 19 AÑOS</td><td>FIEBRE AMARILLA</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                `;
                contenedor.appendChild(cont);
                asegurarScrollArriba(chatMensajes);

                /*const msg1 = document.createElement("div");
                msg1.style.alignSelf = "flex-start";
                msg1.style.background = "#e3f2fd";
                msg1.style.color = "#000";
                //msg1.style.marginRight = "auto";
                msg1.style.margin = "6px 0";
                msg1.style.padding = "10px 14px";
                msg1.style.borderRadius = "18px";
                msg1.style.maxWidth = "80%";
                msg1.style.lineHeight = "1.5";
                msg1.style.wordWrap = "break-word";
                if (grado == "" || grado == "Ninguno") {
                    msg1.innerHTML = "<strong>Unibot:</strong> Necesitas actualizar los datos registrados y seleccionar un grado.";
                }
                else {
                    msg1.innerHTML = "<strong>Unibot:</strong> ¿Desea actualizarlos?";
                }                    
                contenedor.appendChild(msg1);*/
                
                // Botones (tu misma lógica)
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach((btn, index) => {
                    const boton = crearBoton("intencion", "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        const destino = BASE_INTENCIONES.find(i => i.etiqueta === btn.destino);
                        if (destino) agregarMensaje("Unibot", destino);
                    };

                    botonera.appendChild(boton);
                    
                });

                contenedor.appendChild(botonera);
                asegurarScrollArriba(chatMensajes);
            }

            // --- Formulario final antiguo nuevo cd ---
            if (accion === "formulario_final_antiguo_nuevo_cd" && contenido.url) {
                chatMensajes.innerHTML = "";
                const contenedorCarga = document.createElement("div");
                contenedorCarga.style.marginTop = "10px";
                contenedorCarga.style.padding = "15px";
                contenedorCarga.style.border = "1px solid #ddd";
                contenedorCarga.style.borderRadius = "8px";
                contenedorCarga.style.backgroundColor = "#f9f9f9";
                contenedorCarga.style.textAlign = "center";

                const mensajeCarga = document.createElement("p");
                mensajeCarga.textContent = "Cargando información...";
                mensajeCarga.style.fontStyle = "italic";
                mensajeCarga.style.color = "#555";
                contenedorCarga.appendChild(mensajeCarga);

                const spinner = document.createElement("div");
                spinner.innerHTML = "⏳";
                spinner.style.fontSize = "24px";
                contenedorCarga.appendChild(spinner);

                contenedor.appendChild(contenedorCarga);
                chatMensajes.scrollTop = chatMensajes.scrollHeight;

                if (!cc) {
                    alert("Ingresa el número de documento del estudiante a matricular.");
                    return;
                }

                fetch(contenido.url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ documento: cc })
                })
                .then(r => r.json())
                .then(datos => {
                    if (datos.status !== "success") {
                        agregarMensaje("Unibot", "❌ No se pudo cargar la información del estudiante.");
                        return;
                    }

                    // Remover mensaje de carga
                    contenedor.removeChild(contenedorCarga);

                    // Generar formulario con datos prellenados
                    generarFormularioFinalConDatos(datos, contenedor);
                    habilitarBoton(sonTodosValidos());
                })
                .catch(err => {
                    console.log("Error al cargar datos:", err);
                    agregarMensaje("Unibot", "❌ No fue posible conectar con el sistema.");
                });
            }

            // --- validación documentos antiguo nuevo cd---
            if (accion === "validando_documentos_ant_nuevo_cd") {
                chatMensajes.innerHTML = "";
                
                // Crear tarjeta amarilla de estado
                const estadoDiv = estadoValidacion("documentos matrícula");
                contenedor.appendChild(estadoDiv);
            }

            if (accion === "resumen_ant_nuevo_cd") {
                chatMensajes.innerHTML = "";

                // Imagen final
                const imgFinal = document.createElement("img");
                imgFinal.src = contenido.imagen;
                imgFinal.alt = "Proceso de admisión completado";
                //imgFinal.style.width = "80%";
                /*imgFinal.style.maxWidth = "600px";*/
                imgFinal.classList.add("imgFinal");
                imgFinal.style.borderRadius = "16px";
                imgFinal.style.boxShadow = "0 0 20px rgba(0,0,0,0.2)";
                //imgFinal.style.animation = "zoomIn 1.5s ease-in-out";
                imgFinal.style.animation = "fadeIn 2s ease-in-out";

                contenedor.appendChild(imgFinal);

                // Estilos animación minimalista
                const style = document.createElement("style");
                style.textContent = `
                    @keyframes fadeIn {
                        from { opacity: 0; transform: scale(0.97); }
                        to { opacity: 1; transform: scale(1); }
                    }
                    @keyframes fadeUp {
                        from { opacity: 0; transform: translateY(20px); }
                        to { opacity: 1; transform: translateY(0); }
                    }
                `;
                document.head.appendChild(style);

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/ant_nue_deu12.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }


            //######### 4 Antiguo Nuevo sin Deuda #######
             // --- Datos actuales antiguo nuevo sd---
            if (accion === "datos_actuales_ant_nuevo_sd" && contenido.url) {
                chatMensajes.innerHTML = "";

                // Mensaje de carga
                const contenedorCarga = document.createElement("div");
                //contenedorCarga.textContent = "📄 Cargando datos del estudiante...";
                contenedorCarga.style.padding = "12px";
                contenedorCarga.style.background = "#f0f0f0";
                contenedorCarga.style.borderRadius = "6px";
                contenedorCarga.style.margin = "10px auto";
                contenedor.appendChild(contenedorCarga);

                // Llamada al web service
                fetch(contenido.url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ documento: cc })
                })
                .then(r => r.json())
                .then(datos => {
                    if (datos.status !== "success") {
                        agregarMensaje("Unibot", "❌ No se pudo cargar la información del estudiante.");
                        return;
                    }                    
                    contenedor.removeChild(contenedorCarga);

                    const d = datos;
                    let grado = "";
                    if (d.grados.length > 0) {
                        grado = "Ninguno";
                    }
                    else {
                        grado = d.grados[0].gra;
                    }

                    // Bloque visual con datos
                    const cont = document.createElement("div");
                    cont.style.background = "#fff";
                    cont.style.border = "1px solid #ccc";
                    cont.style.borderRadius = "10px";
                    cont.style.padding = "15px";
                    cont.style.margin = "10px auto";
                    cont.style.maxWidth = "90%";
                    cont.style.lineHeight = "1.4";

                    let rh = d.rh.replace("mas", "+");
                    rh = rh.replace("menos", "-");

                    //<div><strong>Grado:</strong> ${d.grados?.[0]?.gra || ""}</div>

                    cont.innerHTML = `
                        <div style="font-weight:700;padding:6px 10px;margin-bottom:8px;border-top:3px solid #ff9805;border-bottom:3px solid #ff9805">
                            DATOS COMPLEMENTARIOS DEL ESTUDIANTE
                        </div>
                        <div><strong>Apellidos:</strong> ${d.apellidos}</div>
                        <div><strong>Nombres:</strong> ${d.nombres}</div>
                        <div><strong>Grado:</strong> ${grado}</div>
                        <div><strong>Tipo de documento:</strong> ${d.tdoc}</div>
                        <div><strong>Teléfono:</strong> ${d.tel}</div>
                        <div><strong>Correo:</strong> ${d.email}</div>
                        <div><strong>Factor RH:</strong> ${rh}</div>
                        <div><strong>Medio de llegada:</strong> ${d.medio}</div>
                        <div><strong>Actividad extra:</strong> ${d.actividad_extra}</div>
                        <div><strong>Género:</strong> ${d.genero}</div>
                        <br>
                        <div style="font-weight:700;padding:6px 10px;margin-bottom:8px;border-top:3px solid #ff9805;border-bottom:3px solid #ff9805">
                            CONDICIÓN SOCIO-ECONÓMICA: ${d.situacion_se}
                        </div>
                        <br>
                        <div style="font-weight:700;padding:6px 10px;margin-bottom:8px;border-top:3px solid #ff9805;border-bottom:3px solid #ff9805">
                            DATOS DEL ACUDIENTE
                        </div>
                        <div><strong>Nombre:</strong> ${d.acudiente}</div>
                        <div><strong>Documento:</strong> ${d.docA}</div>
                        <div><strong>Dirección:</strong> ${d.direccion}</div>
                        <div><strong>Celular:</strong> ${d.telA}</div>
                        <div><strong>Correo:</strong> ${d.emailA}</div>
                        <div><strong>Parentesco:</strong> ${d.parentesco_acudiente_1}</div>
                    `;
                    contenedor.appendChild(cont);

                    const msg1 = document.createElement("p");
                    msg1.style.alignSelf = "flex-start";
                    msg1.style.background = "#e3f2fd";
                    msg1.style.color = "#000";
                    //msg1.style.marginRight = "auto";
                    //msg1.style.margin = "6px 0";
                    //msg1.style.padding = "10px 14px";
                    //msg1.style.borderRadius = "18px";
                    //msg1.style.maxWidth = "80%";
                    //msg1.style.lineHeight = "1.5";
                    //msg1.style.wordWrap = "break-word";
                    msg1.className += "bot-msg";
                    if (grado == "" || grado == "Ninguno") {
                        msg1.innerHTML = "<strong>Unibot:</strong> Necesitas actualizar los datos registrados y seleccionar un grado.";
                    }
                    else {
                        msg1.innerHTML = "<strong>Unibot:</strong> Revisa y actualiza los datos registrados";
                    }                    
                    contenedor.appendChild(msg1);
                    
                    // Botones (tu misma lógica)
                    const botonera = document.createElement("div");
                    botonera.style.display = "flex";
                    botonera.style.flexDirection = "column";
                    botonera.style.gap = "10px";
                    botonera.style.marginTop = "10px";
                    botonera.style.marginLeft = "auto";
                    botonera.style.maxWidth = "80%";

                    contenido.botones.forEach((btn, index) => {
                        const boton = crearBoton("intencion", "#0B77B3", btn.texto);

                        boton.onclick = () => {
                            const destino = BASE_INTENCIONES.find(i => i.etiqueta === btn.destino);
                            if (destino) agregarMensaje("Unibot", destino);
                        };

                        if ((grado == "" || grado == "Ninguno") && index == 1) {
                            //No se agrega el botón No
                        }
                        else {
                            botonera.appendChild(boton);
                        }
                        
                    });

                    contenedor.appendChild(botonera);
                })
                .catch(err => {
                    console.log("Error al cargar datos:", err);
                    agregarMensaje("Unibot", "❌ No fue posible conectar con el sistema.");
                });
            }

            // --- Formulario datos actuales antiguo nuevo sd ---
            if (accion === "formulario_inicial_ant_nuevo_sd" && contenido.url) {
                chatMensajes.innerHTML = "";
                const contenedorCarga = document.createElement("div");
                contenedorCarga.style.marginTop = "10px";
                contenedorCarga.style.padding = "15px";
                contenedorCarga.style.border = "1px solid #ddd";
                contenedorCarga.style.borderRadius = "8px";
                contenedorCarga.style.backgroundColor = "#f9f9f9";
                contenedorCarga.style.textAlign = "center";

                const mensajeCarga = document.createElement("p");
                mensajeCarga.textContent = "Cargando información...";
                mensajeCarga.style.fontStyle = "italic";
                mensajeCarga.style.color = "#555";
                contenedorCarga.appendChild(mensajeCarga);

                const spinner = document.createElement("div");
                spinner.innerHTML = "⏳";
                spinner.style.fontSize = "24px";
                contenedorCarga.appendChild(spinner);

                contenedor.appendChild(contenedorCarga);
                chatMensajes.scrollTop = chatMensajes.scrollHeight;

                if (!cc) {
                    alert("Ingresa el número de documento del estudiante a matricular.");
                    return;
                }

                fetch(contenido.url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ documento: cc })
                })
                .then(r => r.json())
                .then(datos => {
                    if (datos.status !== "success") {
                        agregarMensaje("Unibot", "❌ No se pudo cargar la información del estudiante.");
                        return;
                    }

                    let seleccioneGrado = true;
                    if (datos.estado == "nuevo" || datos.control_antiguos == 2) {
                        seleccioneGrado = false;
                    }

                    // Remover mensaje de carga
                    contenedor.removeChild(contenedorCarga);

                    // Generar formulario con datos prellenados
                    generarFormularioConDatos(datos, contenedor, seleccioneGrado);
                    habilitarBoton(sonTodosValidos());
                })
                .catch(err => {
                    console.log("Error al cargar datos:", err);
                    agregarMensaje("Unibot", "❌ No fue posible conectar con el sistema.");
                });
            }

            // --- Evaluación admisión antiguo nuevo sd---
            if (accion === "evaluacion_admision_ant_nuevo_sd") {
                chatMensajes.innerHTML = "";

                // Botones (tu misma lógica)
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach((btn, index) => {
                    const boton = crearBoton(btn.tipo, "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        window.open(btn.url, '_blank');
                    };

                    botonera.appendChild(boton);                    
                });

                contenedor.appendChild(botonera);
                
                // Crear tarjeta amarilla de estado
                const estadoDiv = estadoValidacion("Estado evaluación admisión");

                contenedor.appendChild(estadoDiv);

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/ant_nue3.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }

            // Opciones de entrevista (día y hora) antiguo nuevo sd
            if (accion === "entrevista_ant_nuevo_sd" && contenido.url) {
                chatMensajes.innerHTML = "";
                
                // Llamar al web service
                fetch(contenido.url)
                .then(r => r.json())
                .then(data => {
                    // Quitar el mensaje de carga
                    //contenedor.removeChild(contenedorCarga);

                    if (data.status !== "success" || !data.botones) {
                        agregarMensaje("Unibot", "❌ No se pudieron cargar los horarios.");
                        return;
                    }

                    // Crear los botones dinámicamente
                    const botonera = document.createElement("div");
                    //botonera.style.display = "flex";
                    //botonera.style.flexDirection = "column";
                    botonera.style.display = "grid";
                    botonera.style.gridTemplateColumns = "repeat(3, 1fr)";
                    botonera.style.gap = "10px";
                    botonera.style.marginTop = "10px";
                    botonera.style.marginLeft = "auto";
                    botonera.style.maxWidth = "100%";

                    data.botones.forEach(btn => {
                        const boton = crearBoton(btn.tipo, "#28A745", btn.texto);

                        boton.onclick = () => {
                            // Desactivar el botón y mostrar carga
                            boton.disabled = true;
                            boton.innerHTML = `
                                <img src="chatbot/img/subiendo.gif" 
                                    alt="Cargando" 
                                    style="width: 20%; vertical-align: middle; margin-right: 8px;">
                                Enviando...
                            `;
                            boton.style.opacity = "0.7";
                            boton.style.cursor = "not-allowed";

                            // Aquí se procesa la selección del horario
                            let valor = btn.valor.split("|");
                            const datos = {
                                idpsi: data.idpsi,
                                psicologo: data.psicologo,
                                cel_psi: data.celular_psi,
                                meet_psi: data.meet_psi,
                                documento_est: cc,
                                fecha_ent: valor[0],
                                hora_ent: valor[1]
                            };

                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_programar_entrevista.php", {
                                method: "POST",
                                headers: { "Content-Type": "application/json" },
                                body: JSON.stringify(datos)
                            })
                            .then(r => r.json())
                            .then(resp => {
                                if (resp.status === "success") {
                                    let correo = resp.mensaje_entrevista.split("_");
                                    let respuesta = "✅ Entrevista agendada exitosamente. Se envío un correo con toda la información a " + correo[1];

                                    let intencion = BASE_INTENCIONES.find(i => i.etiqueta === "reprogramar_entrevista_ant_nuevo_sd");
                                    intencion.respuesta = respuesta;
                                    if (intencion) agregarMensaje("Unibot", intencion);
                                    //agregarMensaje("Unibot", "✅ Entrevista agendada exitosamente.");
                                } else {
                                    let respuesta = "❌ Agenda ocupada para esa fecha y hora. Selecciona otra opción.";

                                    let intencion = BASE_INTENCIONES.find(i => i.etiqueta === "entrevista_ant_nuevo_sd");
                                    intencion.respuesta = respuesta;
                                    if (intencion) agregarMensaje("Unibot", intencion);
                                    //agregarMensaje("Unibot", "❌ Agenda ocupada para esa fecha y hora. Selecciona otra opción.");
                                }
                            })
                            .catch(err => {
                                console.log(err);
                                agregarMensaje("Unibot", "⚠️ Error de conexión con el servidor.");
                            });
                        };

                        botonera.appendChild(boton);
                    });

                    contenedor.appendChild(botonera);

                    // Mostrar la tarjeta amarilla con estado
                    const estadoDiv = estadoEntrevista(entrevista, admitido);

                    contenedor.appendChild(estadoDiv);
                })
                .catch(() => {
                    agregarMensaje("Unibot", "❌ No fue posible conectar con el sistema.");
                });

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/ant_nue4.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }

            // Reprogramar entrevista (día y hora) antiguo nuevo sd
            if (accion === "reprogramar_entrevista_ant_nuevo_sd") {
                chatMensajes.innerHTML = "";
                
                if (intentos_programacion_entrevista < 3 && entrevista == "NO") {
                    const botonera = document.createElement("div");
                    botonera.style.display = "flex";
                    botonera.style.flexDirection = "column";
                    botonera.style.gap = "10px";
                    botonera.style.marginTop = "10px";
                    botonera.style.marginLeft = "auto";
                    botonera.style.maxWidth = "80%";

                    contenido.botones.forEach(btn => {
                        const boton = crearBoton(btn.tipo, "#0B77B3", btn.texto);

                        boton.onclick = () => {
                            if (btn.tipo === "intencion" && btn.destino) {
                                const intencionDestino = BASE_INTENCIONES.find(i => i.etiqueta === btn.destino);
                                if (intencionDestino) {
                                    agregarMensaje("Unibot", intencionDestino);
                                } 
                            } 
                        };

                        botonera.appendChild(boton);
                    });

                    contenedor.appendChild(botonera);
                }

                // Mostrar la tarjeta amarilla con estado
                const estadoDiv = estadoEntrevista(entrevista, admitido);
                contenedor.appendChild(estadoDiv);

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/ant_nue4.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }

            // --- Costos matrícula antiguo nuevo sd---
            if (accion === "costos_matricula_ant_nuevo_sd") {
                chatMensajes.innerHTML = "";
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach(btn => {
                    const boton = crearBoton("intencion", "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        if (btn.destino == "opciones_pago_matricula_antiguo_nuevo_sd") {
                            const intencionOpcionesPago = BASE_INTENCIONES.find(i => i.etiqueta === "opciones_pago_matricula_antiguo_nuevo_sd");
                            if (intencionOpcionesPago) agregarMensaje("Unibot", intencionOpcionesPago);                        
                        }
                        else if (btn.destino == "comprobante_matricula_ant_nuevo_sd") {
                            const intencionComprobante = BASE_INTENCIONES.find(i => i.etiqueta === "comprobante_matricula_ant_nuevo_sd");
                            if (intencionComprobante) agregarMensaje("Unibot", intencionComprobante);
                        }
                    };
                    botonera.appendChild(boton);
                });
                contenedor.appendChild(botonera);

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/ant_nue5.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }

            // --- Opciones pago matrícula antiguo nuevo sd---
            if (accion === "opciones_pago_matricula_antiguo_nuevo_sd" && contenido.botones) {
                chatMensajes.innerHTML = "";
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach(btn => {
                    const boton = crearBoton(btn.tipo, "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        if (btn.tipo == "servicio") {
                            if (btn.valor == "link_pago_epayco") {
                                redirigirPOST('pagoMatricula.php', {
                                    documento: cc,
                                    valor: matricula,
                                    referencia: referencia_pago_m,
                                    concepto: "Matrícula"
                                });
                            }
                            else {                                
                                window.open(btn.url, "_blank");
                            }
                        }
                        else if (btn.destino == "comprobante_matricula_ant_nuevo_sd") {
                            const intencionComprobante = BASE_INTENCIONES.find(i => i.etiqueta === "comprobante_matricula_ant_nuevo_sd");
                            if (intencionComprobante) agregarMensaje("Unibot", intencionComprobante);                                                    
                        }
                    };
                    botonera.appendChild(boton);
                });
                contenedor.appendChild(botonera);
            }

            // --- Comprobante matrícula antiguo nuevo sd---
            if (accion === "comprobante_matricula_ant_nuevo_sd" && tipos.length > 0) {
                chatMensajes.innerHTML = "";
                const form = document.createElement("div");
                form.style.marginTop = "10px";
                form.style.marginLeft = "auto";
                form.style.maxWidth = "80%";
                form.style.padding = "10px";
                form.style.border = "1px solid #ddd";
                form.style.borderRadius = "8px";
                form.style.backgroundColor = "#f9f9f9";
                form.style.gap = "10px";
                form.style.display = "flex";
                form.style.flexDirection = "column";

                const input = document.createElement("input");
                input.type = "file";
                input.id = "input-archivo-" + Date.now();
                input.accept = tipos.map(t => t === "pdf" ? ".pdf" : "image/" + t).join(",");
                input.style.display = "none";

                const label = document.createElement("label");
                label.htmlFor = input.id;
                label.style.padding = "12px 16px";
                //label.style.backgroundColor = "#C75EA3";
                label.style.backgroundColor = "#FF9805";
                label.style.color = "white";
                label.style.borderRadius = "8px 0px 0px 0px";
                label.style.cursor = "pointer";
                label.style.fontSize = "14px";
                label.style.fontWeight = "600";
                label.style.display = "flex";
                label.style.alignItems = "center";
                label.style.gap = "10px";

                // Icono input (imagen)
                const iconoInput = document.createElement("img");
                iconoInput.style.width = "30px";
                iconoInput.style.height = "30px";
                iconoInput.style.borderRadius = "4px";
                iconoInput.src = "chatbot/img/subir_pdf1.png";
                iconoInput.alt = "Subir";

                label.appendChild(iconoInput);

                // Texto input
                const textoInput = document.createElement("span");
                textoInput.textContent = " Seleccionar comprobante";
                textoInput.style.fontWeight = "600";
                textoInput.style.flexGrow = "1";
                textoInput.style.color = "white";

                label.appendChild(textoInput);

                const archivoTexto = document.createElement("span");
                archivoTexto.style.marginLeft = "10px";
                archivoTexto.style.fontSize = "13px";
                archivoTexto.style.color = "#555";

                const botonCambiarPago = crearBoton("proceso", "#0B77B3", contenido.botones[0].texto);

                // Acción del botón → abre la intención "opciones_pago_deuda"
                botonCambiarPago.onclick = () => {
                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === "opciones_pago_matricula_antiguo_nuevo_sd");
                    if (intencion) agregarMensaje("Unibot", intencion);
                };

                input.addEventListener("change", function(e) {
                    const file = e.target.files[0];
                    if (!file) return;

                    // Validar tipo
                    const ext = file.name.split(".").pop().toLowerCase();
                    if (!tipos.includes(ext)) {
                        alert(mensajeError);
                        return;
                    }

                    //Se valida que el documento del nombre del archivo sea el correcto
                    const doc = file.name.split("-").shift();
                    console.log(doc);
                    if (doc != cc) {
                        alert("El documento que aparece en el nombre del comprobante no corresponde con el número de documento del estudiante. Ejemplo de nombre de comprobante: 9999999-2026-pp.pdf");
                        return;
                    }

                    // Validar tamaño (máx 5MB)
                    if (file.size > 5 * 1024 * 1024) {
                        alert("El archivo es muy grande. Máximo 5 MB.");
                        return;
                    }

                    archivoTexto.textContent = file.name;

                    // Mostrar mensaje de espera
                    agregarMensaje("Unibot", mensajeEspera);

                    // Enviar archivo
                    const formData = new FormData();
                    formData.append("comprobante_matricula", file);
                    formData.append("valor", matricula);

                    fetch('http://localhost:90/avmeeuu/avmeeuu/api/subir_comprobante_matricula.php', {
                        method: 'POST',
                        body: formData
                    })
                    //.then(r => r.json())
                    .then(async r => {
                        const text = await r.text(); // lee la respuesta como texto crudo
                        console.log(text); // aquí verás lo que realmente devolvió el servidor
                        try {
                            const data = JSON.parse(text); // intenta parsear a JSON
                            return data;
                        } catch (e) {
                            //console.log("⚠️ La respuesta no es JSON válido:");
                            throw e; // lanza el error para que caiga en el catch
                        }
                    })
                    .then(data => {
                        if (data.status == "success") {
                            let msgControl = "paso 4.5 terminado";
                            //Se consume web service de cambio de paso
                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/json' },
                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                            })
                            .then(r => r.json())
                            .then(data => {
                                if (data.status == "success") {
                                    paso = data.siguiente_paso;
                                    etiqueta_intencion = data.etiqueta_intencion;
                                    let msgControl = "paso 4.5.1 terminado";
                                    //Se consume web service de cambio de paso
                                    fetch("http://localhost:90/avmeeuu/avmeeuu/api//av_update_paso.php", {
                                        method: 'POST',
                                        headers: { 'Content-Type': 'application/json' },
                                        body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                    })
                                    .then(r => r.json())
                                    .then(data => {
                                        if (data.status == "success") {
                                            paso = data.siguiente_paso;
                                            etiqueta_intencion = data.etiqueta_intencion;
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/ant_nue6.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                    });
                                }
                            });
                            
                        }
                        else {
                            agregarMensaje("Unibot", mensajeError + " " + data.mensaje);
                        }
                    })
                    .catch(err => {
                        console.log("❌ Error general:", err);
                        agregarMensaje("Unibot", mensajeError);
                    });
                });

                form.appendChild(input);
                form.appendChild(label);
                form.appendChild(archivoTexto);
                form.appendChild(botonCambiarPago);
                contenedor.appendChild(form);
            }

            // --- validación comprobante matrícula antiguo nuevo sd---
            if (accion === "validando_comprobante_matricula_ant_nuevo_sd") {
                chatMensajes.innerHTML = "";
                
                // Crear tarjeta amarilla de estado
                const estadoDiv = estadoValidacion("comprobante pago matrícula");
                contenedor.appendChild(estadoDiv);
            }

            // --- Documentos finales antiguo nuevo sd---
            if (accion === "documentos_finales_ant_nuevo_sd") {
                chatMensajes.innerHTML = "";

                // Bloque visual con datos
                const cont = document.createElement("div");
                cont.style.background = "#fff";
                cont.style.border = "1px solid #ccc";
                cont.style.borderRadius = "10px";
                cont.style.padding = "15px";
                cont.style.margin = "10px auto";
                cont.style.maxWidth = "90%";
                cont.style.lineHeight = "1.4";

                cont.innerHTML = `
                    <div style="font-weight:700;padding:6px 10px;margin-bottom:8px;border-top:3px solid #ff9805;border-bottom:3px solid #ff9805">
                        LISTADO DE DOCUMENTOS
                    </div>
                    <div style="color: red;"><strong>Nota: Todos los documentos deben ser en pdf. Tener en cuenta que si todos los documentos no están debidamente cargados, serán rechazados y su proceso se demorará varios días más. La revisión podría tardar hasta 8 días hábiles.</strong></div><br>
                    <div>1. Contrato de matrícula, Pagaré y consentimiento informado <span style="font-weight: bold;">firmados</span>. <mark class="mi-resaltado">El pagaré debe estar autenticado en notaría.</mark> (El contrato y el pagaré se enviaron al correo del acudiente cuando se validó el comprobante de matrícula).</div><br>
                    <div>2. Documento de identidad del estudiante (registro civil para menores de 7 años; tarjeta de identidad entre 7 y 17 años y cédula de ciudadanía para mayores de 18 años). <span style="color: red;">Solo si cambió.</span></div><br>
                    <div>3. Documento de identidad del acudiente, (misma persona que firma el contrato). <span style="color: red;">Solo si cambió.</span></div><br>
                    <div>4. Paz y salvo año lectivo anterior.</div><br>
                    <div>5. Fotografía reciente del estudiante.</div><br>
                    <div>6. Certificado de afiliación a E.P.S del estudiante.</div><br>
                    <div>7. Certificado de actividad extracurricular. <span style="color: red;">Solo si cambió.</span></div><br>
                    <div>8. <mark class="mi-resaltado">Para estudiantes nuevos:</mark> <span style="color: white; background: orange;">Primaria:</span> Certificado final de calificaciones año anterior. <span style="color: white; background: purple;">Bachillerato:</span> Todos los certificados finales de calificaciones desde quinto de primaria hasta el último año cursado.</div><br>
                    <div>9. Carnet de vacunación al día, con esquema completo incluyendo refuerzos. Tener en cuenta la siguiente tabla:
                        <table>
                            <thead>
                                <tr>
                                    <th>EDAD</th><th>VACUNA</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>9 a 17 AÑOS</td><td>VPH</td>
                                </tr>
                                <tr>
                                    <td>6 a 15 AÑOS</td><td>SARAMPIÓN, RUBEOLA</td>
                                </tr>
                                <tr>
                                    <td>9 MESES a 19 AÑOS</td><td>FIEBRE AMARILLA</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                `;
                contenedor.appendChild(cont);
                asegurarScrollArriba(chatMensajes);
                
                // Botones
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach((btn, index) => {
                    const boton = crearBoton("intencion", "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        const destino = BASE_INTENCIONES.find(i => i.etiqueta === btn.destino);
                        if (destino) agregarMensaje("Unibot", destino);
                    };

                    botonera.appendChild(boton);
                    
                });

                contenedor.appendChild(botonera);
                asegurarScrollArriba(chatMensajes);
            }

            // --- Formulario final antiguo nuevo sd ---
            if (accion === "formulario_final_antiguo_nuevo_sd" && contenido.url) {
                chatMensajes.innerHTML = "";
                const contenedorCarga = document.createElement("div");
                contenedorCarga.style.marginTop = "10px";
                contenedorCarga.style.padding = "15px";
                contenedorCarga.style.border = "1px solid #ddd";
                contenedorCarga.style.borderRadius = "8px";
                contenedorCarga.style.backgroundColor = "#f9f9f9";
                contenedorCarga.style.textAlign = "center";

                const mensajeCarga = document.createElement("p");
                mensajeCarga.textContent = "Cargando información...";
                mensajeCarga.style.fontStyle = "italic";
                mensajeCarga.style.color = "#555";
                contenedorCarga.appendChild(mensajeCarga);

                const spinner = document.createElement("div");
                spinner.innerHTML = "⏳";
                spinner.style.fontSize = "24px";
                contenedorCarga.appendChild(spinner);

                contenedor.appendChild(contenedorCarga);
                chatMensajes.scrollTop = chatMensajes.scrollHeight;

                if (!cc) {
                    alert("Ingresa el número de documento del estudiante a matricular.");
                    return;
                }

                fetch(contenido.url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ documento: cc })
                })
                .then(r => r.json())
                .then(datos => {
                    if (datos.status !== "success") {
                        agregarMensaje("Unibot", "❌ No se pudo cargar la información del estudiante.");
                        return;
                    }

                    // Remover mensaje de carga
                    contenedor.removeChild(contenedorCarga);

                    // Generar formulario con datos prellenados
                    generarFormularioFinalConDatos(datos, contenedor);
                    habilitarBoton(sonTodosValidos());
                })
                .catch(err => {
                    console.log("Error al cargar datos:", err);
                    agregarMensaje("Unibot", "❌ No fue posible conectar con el sistema.");
                });
            }

            // --- validación documentos antiguo nuevo sd---
            if (accion === "validando_documentos_ant_nuevo_sd") {
                chatMensajes.innerHTML = "";
                
                // Crear tarjeta amarilla de estado
                const estadoDiv = estadoValidacion("documentos matrícula");
                contenedor.appendChild(estadoDiv);
            }

            if (accion === "resumen_ant_nuevo_sd") {
                chatMensajes.innerHTML = "";

                // Imagen final
                const imgFinal = document.createElement("img");
                imgFinal.src = contenido.imagen;
                imgFinal.alt = "Proceso de admisión completado";
                //imgFinal.style.width = "80%";
                /*imgFinal.style.maxWidth = "600px";*/
                imgFinal.classList.add("imgFinal");
                imgFinal.style.borderRadius = "16px";
                imgFinal.style.boxShadow = "0 0 20px rgba(0,0,0,0.2)";
                //imgFinal.style.animation = "zoomIn 1.5s ease-in-out";
                imgFinal.style.animation = "fadeIn 2s ease-in-out";

                contenedor.appendChild(imgFinal);

                // Estilos animación minimalista
                const style = document.createElement("style");
                style.textContent = `
                    @keyframes fadeIn {
                        from { opacity: 0; transform: scale(0.97); }
                        to { opacity: 1; transform: scale(1); }
                    }
                    @keyframes fadeUp {
                        from { opacity: 0; transform: translateY(20px); }
                        to { opacity: 1; transform: translateY(0); }
                    }
                `;
                document.head.appendChild(style);

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/ant_nue9.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }


            //######### 5 Nuevo #######
            // --- Formulario inicial nuevo ---
            if (accion === "formulario_inicial_nuevo" && contenido.url) {
                chatMensajes.innerHTML = "";
                
                const contenedorCarga = document.createElement("div");
                contenedorCarga.style.marginTop = "10px";
                contenedorCarga.style.padding = "15px";
                contenedorCarga.style.border = "1px solid #ddd";
                contenedorCarga.style.borderRadius = "8px";
                contenedorCarga.style.backgroundColor = "#f9f9f9";
                contenedorCarga.style.textAlign = "center";

                chatMensajes.scrollTop = chatMensajes.scrollHeight;

                if (!cc) {
                    alert("Ingresa el número de documento del estudiante a matricular.");
                    return;
                }
                let seleccioneGrado = false;

                // Llamada al web service
                fetch(contenido.url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ documento: cc })
                })
                .then(r => r.json())
                .then(datos => {
                    if (datos.status !== "success") {
                        agregarMensaje("Unibot", "❌ No se pudo cargar la información del estudiante.");
                        return;
                    }                    
                    //contenedor.removeChild(contenedorCarga);

                    const d = datos;
                    let grado = "";
                    if (d.grados.length > 0) {
                        grado = "Ninguno";
                    }
                    else {
                        grado = d.grados[0].gra;
                    }

                    // Generar formulario inicial
                    generarFormularioConDatos(datos, contenedor, false);
                    habilitarBoton(sonTodosValidos());                    
                })
                .catch(err => {
                    console.error("Error al cargar datos:", err);
                    agregarMensaje("Unibot", "❌ No fue posible conectar con el sistema.");
                });                
            }

            // --- Evaluación admisión nuevo ---
            if (accion === "evaluacion_admision_nuevo") {
                chatMensajes.innerHTML = "";

                // Botones (tu misma lógica)
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach((btn, index) => {
                    const boton = crearBoton(btn.tipo, "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        window.open(btn.url, '_blank');
                    };

                    botonera.appendChild(boton);                    
                });

                contenedor.appendChild(botonera);
                
                // Crear tarjeta amarilla de estado
                const estadoDiv = estadoValidacion("Estado evaluación admisión");

                contenedor.appendChild(estadoDiv);

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/nue2.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }

            // Opciones de entrevista (día y hora) nuevo
            if (accion === "entrevista_nuevo" && contenido.url) {
                chatMensajes.innerHTML = "";
                
                // Llamar al web service
                fetch(contenido.url)
                .then(r => r.json())
                .then(data => {
                    // Quitar el mensaje de carga
                    //contenedor.removeChild(contenedorCarga);

                    if (data.status !== "success" || !data.botones) {
                        agregarMensaje("Unibot", "❌ No se pudieron cargar los horarios.");
                        return;
                    }

                    // Crear los botones dinámicamente
                    const botonera = document.createElement("div");
                    //botonera.style.display = "flex";
                    //botonera.style.flexDirection = "column";
                    botonera.style.display = "grid";
                    botonera.style.gridTemplateColumns = "repeat(3, 1fr)";
                    botonera.style.gap = "10px";
                    botonera.style.marginTop = "10px";
                    botonera.style.marginLeft = "auto";
                    botonera.style.maxWidth = "100%";

                    data.botones.forEach(btn => {
                        const boton = crearBoton(btn.tipo, "#28A745", btn.texto);

                        boton.onclick = () => {
                            // Desactivar el botón y mostrar carga
                            boton.disabled = true;
                            boton.innerHTML = `
                                <img src="chatbot/img/subiendo.gif" 
                                    alt="Cargando" 
                                    style="width: 20%; vertical-align: middle; margin-right: 8px;">
                                Enviando...
                            `;
                            boton.style.opacity = "0.7";
                            boton.style.cursor = "not-allowed";

                            // Aquí se procesa la selección del horario
                            let valor = btn.valor.split("|");
                            const datos = {
                                idpsi: data.idpsi,
                                psicologo: data.psicologo,
                                cel_psi: data.celular_psi,
                                meet_psi: data.meet_psi,
                                documento_est: cc,
                                fecha_ent: valor[0],
                                hora_ent: valor[1]
                            };

                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_programar_entrevista.php", {
                                method: "POST",
                                headers: { "Content-Type": "application/json" },
                                body: JSON.stringify(datos)
                            })
                            .then(r => r.json())
                            .then(resp => {
                                if (resp.status === "success") {
                                    let correo = resp.mensaje_entrevista.split("_");
                                    let respuesta = "✅ Entrevista agendada exitosamente. Se envío un correo con toda la información a " + correo[1];

                                    let intencion = BASE_INTENCIONES.find(i => i.etiqueta === "reprogramar_entrevista_nuevo");
                                    intencion.respuesta = respuesta;
                                    if (intencion) agregarMensaje("Unibot", intencion);
                                    //agregarMensaje("Unibot", "✅ Entrevista agendada exitosamente.");
                                } else {
                                    let respuesta = "❌ Agenda ocupada para esa fecha y hora. Selecciona otra opción.";

                                    let intencion = BASE_INTENCIONES.find(i => i.etiqueta === "entrevista_nuevo");
                                    intencion.respuesta = respuesta;
                                    if (intencion) agregarMensaje("Unibot", intencion);
                                    //agregarMensaje("Unibot", "❌ Agenda ocupada para esa fecha y hora. Selecciona otra opción.");
                                }
                            })
                            .catch(err => {
                                console.log(err);
                                agregarMensaje("Unibot", "⚠️ Error de conexión con el servidor.");
                            });
                        };

                        botonera.appendChild(boton);
                    });

                    contenedor.appendChild(botonera);

                    // Mostrar la tarjeta amarilla con estado
                    const estadoDiv = estadoEntrevista(entrevista, admitido);

                    contenedor.appendChild(estadoDiv);
                })
                .catch(() => {
                    agregarMensaje("Unibot", "❌ No fue posible conectar con el sistema.");
                });

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/nue3.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }

            // Reprogramar entrevista (día y hora) nuevo
            if (accion === "reprogramar_entrevista_nuevo") {
                chatMensajes.innerHTML = "";
                
                if (intentos_programacion_entrevista < 3 && entrevista == "NO") {
                    const botonera = document.createElement("div");
                    botonera.style.display = "flex";
                    botonera.style.flexDirection = "column";
                    botonera.style.gap = "10px";
                    botonera.style.marginTop = "10px";
                    botonera.style.marginLeft = "auto";
                    botonera.style.maxWidth = "80%";

                    contenido.botones.forEach(btn => {
                        const boton = crearBoton(btn.tipo, "#0B77B3", btn.texto);

                        boton.onclick = () => {
                            if (btn.tipo === "intencion" && btn.destino) {
                                const intencionDestino = BASE_INTENCIONES.find(i => i.etiqueta === btn.destino);
                                if (intencionDestino) {
                                    agregarMensaje("Unibot", intencionDestino);
                                } 
                            } 
                        };

                        botonera.appendChild(boton);
                    });

                    contenedor.appendChild(botonera);
                }

                // Mostrar la tarjeta amarilla con estado
                const estadoDiv = estadoEntrevista(entrevista, admitido);
                contenedor.appendChild(estadoDiv);

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/nue3.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }

            // --- Costos matrícula nuevo ---
            if (accion === "costos_matricula_nuevo") {
                chatMensajes.innerHTML = "";
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach(btn => {
                    const boton = crearBoton("intencion", "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        if (btn.destino == "opciones_pago_matricula_nuevo") {
                            const intencionOpcionesPago = BASE_INTENCIONES.find(i => i.etiqueta === "opciones_pago_matricula_nuevo");
                            if (intencionOpcionesPago) agregarMensaje("Unibot", intencionOpcionesPago);                        
                        }
                        else if (btn.destino == "comprobante_matricula_nuevo") {
                            const intencionComprobante = BASE_INTENCIONES.find(i => i.etiqueta === "comprobante_matricula_nuevo");
                            if (intencionComprobante) agregarMensaje("Unibot", intencionComprobante);
                        }
                    };
                    botonera.appendChild(boton);
                });
                contenedor.appendChild(botonera);

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/nue4.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }

            // --- Opciones pago matrícula nuevo ---
            if (accion === "opciones_pago_matricula_nuevo" && contenido.botones) {
                chatMensajes.innerHTML = "";
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach(btn => {
                    const boton = crearBoton(btn.tipo, "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        if (btn.tipo == "servicio") {
                            if (btn.valor == "link_pago_epayco") {
                                redirigirPOST('pagoMatricula.php', {
                                    documento: cc,
                                    valor: matricula,
                                    referencia: referencia_pago_m,
                                    concepto: "Matrícula"
                                });
                            }
                            else {                                
                                window.open(btn.url, "_blank");
                            }
                        }
                        else if (btn.destino == "comprobante_matricula_nuevo") {
                            const intencionComprobante = BASE_INTENCIONES.find(i => i.etiqueta === "comprobante_matricula_nuevo");
                            if (intencionComprobante) agregarMensaje("Unibot", intencionComprobante);                                                    
                        }
                    };
                    botonera.appendChild(boton);
                });
                contenedor.appendChild(botonera);
            }

            // --- Comprobante matrícula nuevo ---
            if (accion === "comprobante_matricula_nuevo" && tipos.length > 0) {
                chatMensajes.innerHTML = "";
                const form = document.createElement("div");
                form.style.marginTop = "10px";
                form.style.marginLeft = "auto";
                form.style.maxWidth = "80%";
                form.style.padding = "10px";
                form.style.border = "1px solid #ddd";
                form.style.borderRadius = "8px";
                form.style.backgroundColor = "#f9f9f9";
                form.style.gap = "10px";
                form.style.display = "flex";
                form.style.flexDirection = "column";

                const input = document.createElement("input");
                input.type = "file";
                input.id = "input-archivo-" + Date.now();
                input.accept = tipos.map(t => t === "pdf" ? ".pdf" : "image/" + t).join(",");
                input.style.display = "none";

                const label = document.createElement("label");
                label.htmlFor = input.id;
                label.style.padding = "12px 16px";
                //label.style.backgroundColor = "#C75EA3";
                label.style.backgroundColor = "#FF9805";
                label.style.color = "white";
                label.style.borderRadius = "8px 0px 0px 0px";
                label.style.cursor = "pointer";
                label.style.fontSize = "14px";
                label.style.fontWeight = "600";
                label.style.display = "flex";
                label.style.alignItems = "center";
                label.style.gap = "10px";

                // Icono input (imagen)
                const iconoInput = document.createElement("img");
                iconoInput.style.width = "30px";
                iconoInput.style.height = "30px";
                iconoInput.style.borderRadius = "4px";
                iconoInput.src = "chatbot/img/subir_pdf1.png";
                iconoInput.alt = "Subir";

                label.appendChild(iconoInput);

                // Texto input
                const textoInput = document.createElement("span");
                textoInput.textContent = " Seleccionar comprobante";
                textoInput.style.fontWeight = "600";
                textoInput.style.flexGrow = "1";
                textoInput.style.color = "white";

                label.appendChild(textoInput);

                const archivoTexto = document.createElement("span");
                archivoTexto.style.marginLeft = "10px";
                archivoTexto.style.fontSize = "13px";
                archivoTexto.style.color = "#555";

                const botonCambiarPago = crearBoton("proceso", "#0B77B3", contenido.botones[0].texto);

                // Acción del botón → abre la intención "opciones_pago_deuda"
                botonCambiarPago.onclick = () => {
                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === "opciones_pago_matricula_nuevo");
                    if (intencion) agregarMensaje("Unibot", intencion);
                };

                input.addEventListener("change", function(e) {
                    const file = e.target.files[0];
                    if (!file) return;

                    // Validar tipo
                    const ext = file.name.split(".").pop().toLowerCase();
                    if (!tipos.includes(ext)) {
                        alert(mensajeError);
                        return;
                    }

                    //Se valida que el documento del nombre del archivo sea el correcto
                    const doc = file.name.split("-").shift();
                    console.log(doc);
                    if (doc != cc) {
                        alert("El documento que aparece en el nombre del comprobante no corresponde con el número de documento del estudiante. Ejemplo de nombre de comprobante: 9999999-2026-pp.pdf");
                        return;
                    }

                    // Validar tamaño (máx 5MB)
                    if (file.size > 5 * 1024 * 1024) {
                        alert("El archivo es muy grande. Máximo 5 MB.");
                        return;
                    }

                    archivoTexto.textContent = file.name;

                    // Mostrar mensaje de espera
                    agregarMensaje("Unibot", mensajeEspera);

                    // Enviar archivo
                    const formData = new FormData();
                    formData.append("comprobante_matricula", file);
                    formData.append("valor", matricula);

                    fetch('http://localhost:90/avmeeuu/avmeeuu/api/subir_comprobante_matricula.php', {
                        method: 'POST',
                        body: formData
                    })
                    //.then(r => r.json())
                    .then(async r => {
                        const text = await r.text(); // lee la respuesta como texto crudo
                        console.log(text); // aquí verás lo que realmente devolvió el servidor
                        try {
                            const data = JSON.parse(text); // intenta parsear a JSON
                            return data;
                        } catch (e) {
                            //console.log("⚠️ La respuesta no es JSON válido:");
                            throw e; // lanza el error para que caiga en el catch
                        }
                    })
                    .then(data => {
                        if (data.status == "success") {
                            let msgControl = "paso 5.5 terminado";
                            //Se consume web service de cambio de paso
                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/json' },
                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                            })
                            .then(r => r.json())
                            .then(data => {
                                if (data.status == "success") {
                                    paso = data.siguiente_paso;
                                    etiqueta_intencion = data.etiqueta_intencion;
                                    let msgControl = "paso 5.5.1 terminado";
                                    //Se consume web service de cambio de paso
                                    fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                        method: 'POST',
                                        headers: { 'Content-Type': 'application/json' },
                                        body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                    })
                                    .then(r => r.json())
                                    .then(data => {
                                        if (data.status == "success") {
                                            paso = data.siguiente_paso;
                                            etiqueta_intencion = data.etiqueta_intencion;
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);

                                            //imagen con pasos resumen
                                            const divPasos = document.getElementById("div-pasos");
                                            divPasos.innerHTML = "";
                                            const imgPasos = document.createElement("img");
                                            imgPasos.style.width = "100%";
                                            imgPasos.src = "chatbot/img/nue5.jpg";
                                            imgPasos.alt = "Click";
                                            divPasos.appendChild(imgPasos);
                                        }
                                    });
                                }
                            });
                            
                        }
                        else {
                            agregarMensaje("Unibot", mensajeError + " " + data.mensaje);
                        }
                    })
                    .catch(err => {
                        console.log("❌ Error general:", err);
                        agregarMensaje("Unibot", mensajeError);
                    });
                });

                form.appendChild(input);
                form.appendChild(label);
                form.appendChild(archivoTexto);
                form.appendChild(botonCambiarPago);
                contenedor.appendChild(form);
            }

            // --- validación comprobante matrícula nuevo ---
            if (accion === "validando_comprobante_matricula_nuevo") {
                chatMensajes.innerHTML = "";
                
                // Crear tarjeta amarilla de estado
                const estadoDiv = estadoValidacion("comprobante pago matrícula");
                contenedor.appendChild(estadoDiv);
            }

            // --- Documentos finales nuevo ---
            if (accion === "documentos_finales_nuevo") {
                chatMensajes.innerHTML = "";
                chatMensajes.scrollTop = 0;

                // Bloque visual con datos
                const cont = document.createElement("div");
                cont.style.background = "#fff";
                cont.style.border = "1px solid #ccc";
                cont.style.borderRadius = "10px";
                cont.style.padding = "15px";
                cont.style.margin = "10px auto";
                cont.style.maxWidth = "90%";
                cont.style.lineHeight = "1.4";
                
                cont.innerHTML = `
                    <div style="font-weight:700;padding:6px 10px;margin-bottom:8px;border-top:3px solid #ff9805;border-bottom:3px solid #ff9805">
                        LISTADO DE DOCUMENTOS
                    </div>
                    <div style="color: red;"><strong>Nota: Todos los documentos deben ser en pdf. Tener en cuenta que si todos los documentos no están debidamente cargados, serán rechazados y su proceso se demorará varios días más. La revisión podría tardar hasta 8 días hábiles.</strong></div><br>
                    <div>1. Contrato de matrícula, Pagaré y consentimiento informado <span style="font-weight: bold;">firmados</span>. <mark class="mi-resaltado">El pagaré debe estar autenticado en notaría.</mark> (El contrato y el pagaré se enviaron al correo del acudiente cuando se validó el comprobante de matrícula).</div><br>
                    <div>2. Documento de identidad del estudiante (registro civil para menores de 7 años; tarjeta de identidad entre 7 y 17 años y cédula de ciudadanía para mayores de 18 años). <span style="color: red;">Solo si cambió.</span></div><br>
                    <div>3. Documento de identidad del acudiente, (misma persona que firma el contrato). <span style="color: red;">Solo si cambió.</span></div><br>
                    <div>4. Paz y salvo año lectivo anterior.</div><br>
                    <div>5. Fotografía reciente del estudiante.</div><br>
                    <div>6. Certificado de afiliación a E.P.S del estudiante.</div><br>
                    <div>7. Certificado de actividad extracurricular. <span style="color: red;">Solo si cambió.</span></div><br>
                    <div>8. <mark class="mi-resaltado">Para estudiantes nuevos:</mark> <span style="color: white; background: orange;">Primaria:</span> Certificado final de calificaciones año anterior. <span style="color: white; background: purple;">Bachillerato:</span> Todos los certificados finales de calificaciones desde quinto de primaria hasta el último año cursado.</div><br>
                    <div>9. Carnet de vacunación al día, con esquema completo incluyendo refuerzos. Tener en cuenta la siguiente tabla:
                        <table>
                            <thead>
                                <tr>
                                    <th>EDAD</th><th>VACUNA</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>9 a 17 AÑOS</td><td>VPH</td>
                                </tr>
                                <tr>
                                    <td>6 a 15 AÑOS</td><td>SARAMPIÓN, RUBEOLA</td>
                                </tr>
                                <tr>
                                    <td>9 MESES a 19 AÑOS</td><td>FIEBRE AMARILLA</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                `;
                contenedor.appendChild(cont);
                asegurarScrollArriba(chatMensajes);
                
                // Botones
                const botonera = document.createElement("div");
                botonera.style.display = "flex";
                botonera.style.flexDirection = "column";
                botonera.style.gap = "10px";
                botonera.style.marginTop = "10px";
                botonera.style.marginLeft = "auto";
                botonera.style.maxWidth = "80%";

                contenido.botones.forEach((btn, index) => {
                    const boton = crearBoton("intencion", "#0B77B3", btn.texto);

                    boton.onclick = () => {
                        const destino = BASE_INTENCIONES.find(i => i.etiqueta === btn.destino);
                        if (destino) agregarMensaje("Unibot", destino);
                    };

                    botonera.appendChild(boton);
                    
                });

                contenedor.appendChild(botonera);
                asegurarScrollArriba(chatMensajes);
            }

            // --- Formulario final nuevo ---
            if (accion === "formulario_final_nuevo" && contenido.url) {
                chatMensajes.innerHTML = "";
                const contenedorCarga = document.createElement("div");
                contenedorCarga.style.marginTop = "10px";
                contenedorCarga.style.padding = "15px";
                contenedorCarga.style.border = "1px solid #ddd";
                contenedorCarga.style.borderRadius = "8px";
                contenedorCarga.style.backgroundColor = "#f9f9f9";
                contenedorCarga.style.textAlign = "center";

                const mensajeCarga = document.createElement("p");
                mensajeCarga.textContent = "Cargando información...";
                mensajeCarga.style.fontStyle = "italic";
                mensajeCarga.style.color = "#555";
                contenedorCarga.appendChild(mensajeCarga);

                const spinner = document.createElement("div");
                spinner.innerHTML = "⏳";
                spinner.style.fontSize = "24px";
                contenedorCarga.appendChild(spinner);

                contenedor.appendChild(contenedorCarga);
                chatMensajes.scrollTop = chatMensajes.scrollHeight;

                if (!cc) {
                    alert("Ingresa el número de documento del estudiante a matricular.");
                    return;
                }

                fetch(contenido.url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ documento: cc })
                })
                .then(r => r.json())
                .then(datos => {
                    if (datos.status !== "success") {
                        agregarMensaje("Unibot", "❌ No se pudo cargar la información del estudiante.");
                        return;
                    }

                    // Remover mensaje de carga
                    contenedor.removeChild(contenedorCarga);

                    // Generar formulario con datos prellenados
                    generarFormularioFinalConDatos(datos, contenedor);
                    habilitarBoton(sonTodosValidos());
                })
                .catch(err => {
                    console.log("Error al cargar datos:", err);
                    agregarMensaje("Unibot", "❌ No fue posible conectar con el sistema.");
                });
            }

            // --- validación documentos nuevo ---
            if (accion === "validando_documentos_nuevo") {
                chatMensajes.innerHTML = "";
                
                // Crear tarjeta amarilla de estado
                const estadoDiv = estadoValidacion("documentos matrícula");
                contenedor.appendChild(estadoDiv);
            }

            if (accion === "resumen_nuevo") {
                chatMensajes.innerHTML = "";

                // Imagen final
                const imgFinal = document.createElement("img");
                imgFinal.src = contenido.imagen;
                imgFinal.alt = "Proceso de admisión completado";
                //imgFinal.style.width = "80%";
                /*imgFinal.style.maxWidth = "600px";*/
                imgFinal.classList.add("imgFinal");
                imgFinal.style.borderRadius = "16px";
                imgFinal.style.boxShadow = "0 0 20px rgba(0,0,0,0.2)";
                //imgFinal.style.animation = "zoomIn 1.5s ease-in-out";
                imgFinal.style.animation = "fadeIn 2s ease-in-out";

                contenedor.appendChild(imgFinal);

                // Estilos animación minimalista
                const style = document.createElement("style");
                style.textContent = `
                    @keyframes fadeIn {
                        from { opacity: 0; transform: scale(0.97); }
                        to { opacity: 1; transform: scale(1); }
                    }
                    @keyframes fadeUp {
                        from { opacity: 0; transform: translateY(20px); }
                        to { opacity: 1; transform: translateY(0); }
                    }
                `;
                document.head.appendChild(style);

                //imagen con pasos resumen
                const divPasos = document.getElementById("div-pasos");
                divPasos.innerHTML = "";
                const imgPasos = document.createElement("img");
                imgPasos.style.width = "100%";
                imgPasos.src = "chatbot/img/nue8.jpg";
                imgPasos.alt = "Click";
                divPasos.appendChild(imgPasos);
            }



            // --- Formulario final documentos inválidos ---
            if (accion === "formulario_final_documentos_invalidos" && contenido.url) {
                chatMensajes.innerHTML = "";
                const contenedorCarga = document.createElement("div");
                contenedorCarga.style.marginTop = "10px";
                contenedorCarga.style.padding = "15px";
                contenedorCarga.style.border = "1px solid #ddd";
                contenedorCarga.style.borderRadius = "8px";
                contenedorCarga.style.backgroundColor = "#f9f9f9";
                contenedorCarga.style.textAlign = "center";

                const mensajeCarga = document.createElement("p");
                mensajeCarga.textContent = "Cargando información...";
                mensajeCarga.style.fontStyle = "italic";
                mensajeCarga.style.color = "#555";
                contenedorCarga.appendChild(mensajeCarga);

                const spinner = document.createElement("div");
                spinner.innerHTML = "⏳";
                spinner.style.fontSize = "24px";
                contenedorCarga.appendChild(spinner);

                contenedor.appendChild(contenedorCarga);
                chatMensajes.scrollTop = chatMensajes.scrollHeight;

                if (!cc) {
                    alert("Ingresa el número de documento del estudiante a matricular.");
                    return;
                }

                fetch(contenido.url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ documento: cc })
                })
                .then(r => r.json())
                .then(datos => {
                    if (datos.status !== "success") {
                        agregarMensaje("Unibot", "❌ No se pudo cargar la información del estudiante.");
                        return;
                    }

                    // Remover mensaje de carga
                    contenedor.removeChild(contenedorCarga);

                    // Generar formulario con documentos inválidos
                    generarFormularioFinalDocumentosInvalidos(datos, contenedor);
                    habilitarBoton(sonTodosValidos());
                })
                .catch(err => {
                    console.log("Error al cargar datos:", err);
                    agregarMensaje("Unibot", "❌ No fue posible conectar con el sistema.");
                });
            }




            // --- Formulario de datos complementarios ---
            if (accion === "mostrar_formulario" && Array.isArray(contenido.campos)) {
                const formContainer = document.createElement("div");
                formContainer.style.marginTop = "10px";
                formContainer.style.marginLeft = "auto";
                formContainer.style.maxWidth = "80%";
                formContainer.style.padding = "15px";
                formContainer.style.border = "1px solid #ddd";
                formContainer.style.borderRadius = "8px";
                formContainer.style.backgroundColor = "#f9f9f9";

                const form = document.createElement("form");
                form.noValidate = true;

                contenido.campos.forEach(campo => {
                    const fieldGroup = document.createElement("div");
                    fieldGroup.style.marginBottom = "12px";

                    const label = document.createElement("label");
                    label.textContent = campo.etiqueta;
                    label.style.display = "block";
                    label.style.marginBottom = "4px";
                    label.style.fontSize = "14px";
                    label.style.color = "#333";
                    fieldGroup.appendChild(label);

                    let input;

                    if (campo.tipo === "select" && Array.isArray(campo.opciones)) {
                        input = document.createElement("select");
                        input.name = campo.nombre;
                        input.style.width = "100%";
                        input.style.padding = "8px";
                        input.style.border = "1px solid #ccc";
                        input.style.borderRadius = "6px";
                        input.style.fontSize = "14px";

                        campo.opciones.forEach(opcion => {
                            const option = document.createElement("option");
                            option.value = opcion.valor;
                            option.textContent = opcion.texto;
                            input.appendChild(option);
                        });
                    } else {
                        input = document.createElement("input");
                        input.type = campo.tipo;
                        input.name = campo.nombre;
                        input.placeholder = campo.placeholder || "";
                        input.style.width = "100%";
                        input.style.padding = "8px";
                        input.style.border = "1px solid #ccc";
                        input.style.borderRadius = "6px";
                        input.style.fontSize = "14px";
                    }

                    fieldGroup.appendChild(input);
                    form.appendChild(fieldGroup);
                });

                const submitBtn = document.createElement("button");
                submitBtn.type = "submit";
                submitBtn.textContent = contenido.boton_enviar || "Enviar";
                submitBtn.style.padding = "10px 16px";
                submitBtn.style.backgroundColor = "#007bff";
                submitBtn.style.color = "white";
                submitBtn.style.border = "none";
                submitBtn.style.borderRadius = "6px";
                submitBtn.style.cursor = "pointer";
                submitBtn.style.fontSize = "14px";
                submitBtn.style.marginTop = "10px";

                form.appendChild(submitBtn);
                formContainer.appendChild(form);
                contenedor.appendChild(formContainer);

                // Manejar envío del formulario
                form.onsubmit = (e) => {
                    e.preventDefault();

                    const formData = new FormData(form);
                    const datos = {};

                    let completo = true;
                    contenido.campos.forEach(campo => {
                        const valor = formData.get(campo.nombre);
                        datos[campo.nombre] = valor;
                        if (!valor) completo = false;
                    });

                    if (!completo) {
                        agregarMensaje("Unibot", contenido.mensaje_error);
                        return;
                    }

                    // Enviar datos al servidor
                    fetch('chatbot/guardar-datos.php', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify(datos)
                    })
                    .then(r => r.json())
                    .then(data => {
                        if (data.ok) {
                            agregarMensaje("Unibot", contenido.mensaje_exito);
                        } else {
                            agregarMensaje("Unibot", contenido.mensaje_error + " (" + data.error + ")");
                        }
                    })
                    .catch(err => {
                        console.error(err);
                        agregarMensaje("Unibot", contenido.mensaje_error);
                    });

                    // Opcional: limpiar formulario
                    form.reset();
                };
            }

            // --- Abrir PDF externo ---
            if (accion === "abrir_pdf_externo" && contenido.url) {
                const contenedorDescarga = document.createElement("div");
                contenedorDescarga.style.marginTop = "10px";
                contenedorDescarga.style.marginLeft = "auto";
                contenedorDescarga.style.maxWidth = "80%";
                contenedorDescarga.style.padding = "15px";
                contenedorDescarga.style.border = "1px solid #ddd";
                contenedorDescarga.style.borderRadius = "8px";
                contenedorDescarga.style.backgroundColor = "#f0f8ff";
                contenedorDescarga.style.textAlign = "center";

                const icono = document.createElement("div");
                icono.innerHTML = "📅";
                icono.style.fontSize = "36px";
                icono.style.marginBottom = "8px";
                contenedorDescarga.appendChild(icono);

                const texto = document.createElement("p");
                texto.textContent = contenido.nombre_archivo || "Calendario de Matrículas";
                texto.style.fontWeight = "600";
                texto.style.margin = "0 0 8px 0";
                texto.style.color = "#007bff";
                contenedorDescarga.appendChild(texto);

                const boton = document.createElement("button");
                boton.textContent = "📥 Ver PDF";
                boton.style.padding = "10px 16px";
                boton.style.backgroundColor = "#007bff";
                boton.style.color = "white";
                boton.style.border = "none";
                boton.style.borderRadius = "6px";
                boton.style.cursor = "pointer";
                boton.style.fontSize = "14px";
                boton.style.width = "100%";

                boton.onclick = () => {
                    window.open(contenido.url, '_blank');
                };

                contenedorDescarga.appendChild(boton);
                contenedor.appendChild(contenedorDescarga);
            }

            // --- Descargar múltiples PDFs ---
            if (accion === "descargar_multiples_pdfs" && Array.isArray(contenido.documentos)) {
                const contenedorDocs = document.createElement("div");
                contenedorDocs.style.marginTop = "10px";
                contenedorDocs.style.marginLeft = "auto";
                contenedorDocs.style.maxWidth = "80%";
                contenedorDocs.style.padding = "15px";
                contenedorDocs.style.border = "1px solid #ddd";
                contenedorDocs.style.borderRadius = "8px";
                contenedorDocs.style.backgroundColor = "#f8f9fa";

                const titulo = document.createElement("p");
                titulo.textContent = "Documentos disponibles:";
                titulo.style.fontWeight = "600";
                titulo.style.marginBottom = "10px";
                titulo.style.color = "#333";
                contenedorDocs.appendChild(titulo);

                contenido.documentos.forEach(doc => {
                    const boton = document.createElement("button");
                    boton.textContent = `📥 ${doc.nombre}`;
                    boton.style.display = "block";
                    boton.style.width = "100%";
                    boton.style.padding = "10px 12px";
                    boton.style.backgroundColor = doc.color || "#007bff";
                    boton.style.color = "white";
                    boton.style.border = "none";
                    boton.style.borderRadius = "6px";
                    boton.style.cursor = "pointer";
                    boton.style.fontSize = "14px";
                    boton.style.marginBottom = "8px";
                    boton.style.textAlign = "left";

                    boton.onclick = () => {
                        window.open(doc.url, '_blank');
                    };

                    contenedorDocs.appendChild(boton);
                });

                contenedor.appendChild(contenedorDocs);
            }

            // --- Mostrar formulario inicial ---
            if (accion === "mostrar_formulario_inicial" && Array.isArray(contenido.campos)) {
                const formContainer = document.createElement("div");
                formContainer.style.marginTop = "10px";
                formContainer.style.marginLeft = "auto";
                formContainer.style.maxWidth = "80%";
                formContainer.style.padding = "15px";
                formContainer.style.border = "1px solid #ddd";
                formContainer.style.borderRadius = "8px";
                formContainer.style.backgroundColor = "#f9f9f9";

                const form = document.createElement("form");
                form.noValidate = true;

                contenido.campos.forEach(seccion => {
                    // Título de sección
                    const tituloSeccion = document.createElement("div");
                    tituloSeccion.style.backgroundColor = "#1e3a6d";
                    tituloSeccion.style.color = "white";
                    tituloSeccion.style.padding = "10px 15px";
                    tituloSeccion.style.marginBottom = "15px";
                    tituloSeccion.style.fontWeight = "600";
                    tituloSeccion.style.fontSize = "16px";
                    tituloSeccion.textContent = seccion.seccion;
                    form.appendChild(tituloSeccion);

                    // Campos de la sección
                    seccion.campos.forEach(campo => {
                        const fieldGroup = document.createElement("div");
                        fieldGroup.style.marginBottom = "12px";

                        const label = document.createElement("label");
                        label.textContent = campo.etiqueta;
                        label.style.display = "block";
                        label.style.marginBottom = "4px";
                        label.style.fontSize = "14px";
                        label.style.color = "#333";
                        fieldGroup.appendChild(label);

                        let input;

                        if (campo.tipo === "select" && Array.isArray(campo.opciones)) {
                            input = document.createElement("select");
                            input.name = campo.nombre;
                            input.style.width = "100%";
                            input.style.padding = "8px";
                            input.style.border = "1px solid #ccc";
                            input.style.borderRadius = "6px";
                            input.style.fontSize = "14px";

                            campo.opciones.forEach(opcion => {
                                const option = document.createElement("option");
                                option.value = opcion.valor;
                                option.textContent = opcion.texto;
                                input.appendChild(option);
                            });
                        } else if (campo.tipo === "textarea") {
                            input = document.createElement("textarea");
                            input.name = campo.nombre;
                            input.placeholder = campo.placeholder || "";
                            input.rows = campo.rows || 4;
                            input.style.width = "100%";
                            input.style.padding = "8px";
                            input.style.border = "1px solid #ccc";
                            input.style.borderRadius = "6px";
                            input.style.fontSize = "14px";
                            input.style.resize = "vertical";
                        } else {
                            input = document.createElement("input");
                            input.type = campo.tipo;
                            input.name = campo.nombre;
                            input.placeholder = campo.placeholder || "";
                            input.style.width = "100%";
                            input.style.padding = "8px";
                            input.style.border = "1px solid #ccc";
                            input.style.borderRadius = "6px";
                            input.style.fontSize = "14px";
                        }

                        fieldGroup.appendChild(input);
                        form.appendChild(fieldGroup);
                    });

                    // Separador entre secciones
                    if (seccion !== contenido.campos[contenido.campos.length - 1]) {
                        const separador = document.createElement("hr");
                        separador.style.margin = "20px 0";
                        separador.style.borderColor = "#ddd";
                        form.appendChild(separador);
                    }
                });

                const submitBtn = document.createElement("button");
                submitBtn.type = "submit";
                submitBtn.textContent = contenido.boton_enviar || "Enviar";
                submitBtn.style.padding = "10px 16px";
                submitBtn.style.backgroundColor = "#007bff";
                submitBtn.style.color = "white";
                submitBtn.style.border = "none";
                submitBtn.style.borderRadius = "6px";
                submitBtn.style.cursor = "pointer";
                submitBtn.style.fontSize = "14px";
                submitBtn.style.width = "100%";

                form.appendChild(submitBtn);
                formContainer.appendChild(form);
                contenedor.appendChild(formContainer);

                // Manejar envío del formulario
                form.onsubmit = (e) => {
                    e.preventDefault();

                    const formData = new FormData(form);
                    const datos = {};

                    let completo = true;
                    contenido.campos.forEach(seccion => {
                        seccion.campos.forEach(campo => {
                            const valor = formData.get(campo.nombre);
                            datos[campo.nombre] = valor;
                            if (!valor) completo = false;
                        });
                    });

                    if (!completo) {
                        agregarMensaje("Unibot", contenido.mensaje_error);
                        return;
                    }

                    // Enviar datos al servidor
                    fetch('chatbot/guardar-formulario-inicial.php', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify(datos)
                    })
                    .then(r => r.json())
                    .then(data => {
                        if (data.ok) {
                            agregarMensaje("Unibot", contenido.mensaje_exito);
                        } else {
                            agregarMensaje("Unibot", contenido.mensaje_error + " (" + data.error + ")");
                        }
                    })
                    .catch(err => {
                        console.error(err);
                        agregarMensaje("Unibot", contenido.mensaje_error);
                    });

                    // Opcional: limpiar formulario
                    form.reset();
                };
            }
            
        }

        chatMensajes.appendChild(contenedor);
        chatMensajes.scrollTop = chatMensajes.scrollHeight;
    }

    // Función: Encontrar intención
    function encontrarIntencion(mensaje) {
        mensaje = mensaje.toLowerCase().trim();
        let mejorPuntaje = 0;
        let mejorRespuesta = {
            respuesta: BASE_INTENCIONES.find(i => i.etiqueta === "no_entendido").respuesta,
            botones: null,
            accion: null,
            url: null,
            tipos: [],
            campos: [],
            documentos: [],
            boton_enviar: "Enviar",
            //boton_pagar_deuda: "Pagar deuda",
            mensaje_espera: "Subiendo...",
            mensaje_exito: "Archivo subido correctamente.",
            mensaje_error: "Error al subir el archivo."
        };
        
        BASE_INTENCIONES.forEach(intencion => {
            let puntaje = 0;
            intencion.claves.forEach(palabra => {
                if (mensaje.includes(palabra)) {
                    puntaje++;
                }
            });
            
            if (puntaje > mejorPuntaje) {
                mejorPuntaje = puntaje;
                mejorRespuesta = {
                    respuesta: intencion.respuesta,
                    botones: intencion.botones || null,
                    accion: intencion.accion || null,
                    url: intencion.url || null,
                    tipos: intencion.tipos || [],
                    campos: intencion.campos || [],
                    documentos: intencion.documentos || [],
                    boton_enviar: intencion.boton_enviar || "Enviar",
                    //boton_pagar_deuda: intencion.boton_pagar_deuda || "Pagar deuda",
                    mensaje_espera: intencion.mensaje_espera || "Subiendo...",
                    mensaje_exito: intencion.mensaje_exito || "Archivo subido correctamente.",
                    mensaje_error: intencion.mensaje_error || "Error al subir el archivo."
                };
            }
        });
        console.log(mejorRespuesta);
        return mejorRespuesta;
    }
    
    // Función: Guardar datos iniciales
    function guardarDatosIniciales(datos) {
        fetch('chatbot/guardar.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({
                'acudiente_nombre': datos.acudiente.acudienteNombre,
                'acudiente_correo': datos.acudiente.acudienteCorreo,
                'acudiente_telefono': datos.acudiente.acudienteTelefono,
                'tipo_estudiante': datos.estudiante.tipoEstudiante,
                'estudiante_nombres': datos.estudiante.estudianteNombres,
                'estudiante_apellidos': datos.estudiante.estudianteApellidos,
                'estudiante_documento': datos.estudiante.estudianteDocumento
            })
        }).catch(err => console.log("Error al guardar:", err));
    }

    // Función: Manejar selección de pago
    function manejarSeleccionPago(valor) {
        let respuesta = "";

        switch (valor) {
            case "pago_unico":
                respuesta = "✅ Has seleccionado: Pago único de $200. ¿Deseas proceder con el pago ahora?";
                break;
            case "pago_3_cuotas":
                respuesta = "✅ Has seleccionado: 3 cuotas de $70 cada una. Total: $210. ¿Confirmas esta opción?";
                break;
            case "pago_6_cuotas":
                respuesta = "✅ Has seleccionado: 6 cuotas de $37 cada una. Total: $222. ¿Te parece bien?";
                break;
            default:
                respuesta = "Gracias por tu selección.";
        }

        // Mostrar confirmación
        agregarMensaje("Unibot", { respuesta: respuesta });
    }

    // Generar formulario dinámico
    function generarFormularioConDatos(datos, contenedorPadre, seleccioneGrado) {
        console.log(datos);
        const formContainer = document.createElement("div");
        formContainer.style.marginTop = "10px";
        formContainer.style.maxWidth = "80%";
        formContainer.style.marginLeft = "auto";
        formContainer.style.padding = "15px";
        formContainer.style.border = "1px solid #ddd";
        formContainer.style.borderRadius = "8px";
        formContainer.style.backgroundColor = "#f9f9f9";

        const form = document.createElement("form");
        form.noValidate = true;

        // --- Paso 1: DATOS COMPLEMENTARIOS DEL ESTUDIANTE ---
        const titulo1 = document.createElement("div");
        //titulo1.style.backgroundColor = "#1e3a6d";
        //titulo1.style.color = "white";
        titulo1.style.padding = "10px 15px";
        titulo1.style.marginBottom = "15px";
        titulo1.style.fontWeight = "600";
        titulo1.style.fontSize = "16px";
        titulo1.style.borderTop = "3px solid #ff9805";
        titulo1.style.borderBottom = "3px solid #ff9805";
        titulo1.textContent = "Paso 1 - DATOS COMPLEMENTARIOS DEL ESTUDIANTE";
        form.appendChild(titulo1);

        // Campos del estudiante
        crearCampo(form, "Apellidos", "apellidos", datos.apellidos);
        crearCampo(form, "Nombres", "nombres", datos.nombres);
        
        // Extraer opciones de grados desde el JSON del servicio
        const opcionesGrados = datos.grados.map(grado => ({
            valor: grado.id_gra,
            texto: grado.gra
        }));
        const gradoSelect = crearSelect(form, "Selecciona el grado a que ingresas", "grado", opcionesGrados);
        if (seleccioneGrado) {
            gradoSelect.value = datos.grados[0]?.id_gra || "0";            
        }
        else {
            gradoSelect.value = "0";
            gradoSelect.classList.add("is-invalid");
            gradoSelect.style.border = "2px solid red";
            gradoSelect.style.setProperty('border', '2px solid #dc3545', 'important');
        }        

        // Extraer opciones de documentos desde el JSON del servicio
        const opcionesTiposDocumentos = datos.documentos.map(documento => ({
            valor: documento.id_td,
            texto: documento.td
        }));
        const tdSelect = crearSelect(form, "Selecciona el tipo de documento", "td", opcionesTiposDocumentos);
        tdSelect.value = datos.id_tdoc ?? "0";

        crearCampo(form, "Número telefónico", "telefono", datos.tel);
        crearCampo(form, "Correo electrónico", "correo", datos.email);
        crearCampo(form, "Confirmar correo electrónico", "confirmar_correo", datos.email);

        let rh = datos.rh.replace("mas", "+");
        rh = rh.replace("menos", "-");
        rh = rh.replace("negativo", "-");
        rh = rh.replace("positivo", "+");
        crearCampo(form, "Factor RH", "factor_rh", rh);
                
        // Extraer medios de llegada desde el JSON del servicio
        const opcionesMedios = datos.medios.map(medio => ({
            valor: medio.id_medio,
            texto: medio.medio
        }));
        const mediosSelect = crearSelect(form, "Selecciona el medio de llegada", "medio_llegada", opcionesMedios);
        mediosSelect.value = datos.id_medio ?? "0";

        crearCampo(form, "Actividad extra", "actividad_extra", datos.actividad_extra);

        // Extraer géneros desde el JSON del servicio
        const opcionesGeneros = datos.generos.map(genero => ({
            valor: genero.genero,
            texto: genero.genero
        }));
        const generoSelect = crearSelect(form, "Selecciona el género", "genero", opcionesGeneros);
        generoSelect.value = datos.genero ?? "0";

        // Separador
        const separador1 = document.createElement("hr");
        separador1.style.margin = "20px 0";
        separador1.style.borderColor = "#ddd";
        form.appendChild(separador1);

        // --- Paso 2: SITUACIÓN SOCIO-ECONÓMICA ---
        const titulo2 = document.createElement("div");
        //titulo2.style.backgroundColor = "#1e3a6d";
        //titulo2.style.color = "white";
        titulo2.style.padding = "10px 15px";
        titulo2.style.marginBottom = "15px";
        titulo2.style.fontWeight = "600";
        titulo2.style.fontSize = "16px";
        titulo2.style.borderTop = "3px solid #ff9805";
        titulo2.style.borderBottom = "3px solid #ff9805";
        titulo2.innerHTML = `Paso 2 - CONDICIÓN SOCIO-ECONÓMICA<br>
        <pp><strong>La condición socioeconómica especial</strong> se refiere a situaciones que impiden a estudiantes 
        de diversas edades asistir presencialmente, como: deportistas, artistas, emprendedores, familias itinerantes, 
        personas con problemas de salud, amantes de la tecnología. Se debe presentar una certificación que demuestre la condición.</pp>`;
        form.appendChild(titulo2);

        crearTextarea(form, "Condición socio-económica", "situacion_se", datos.situacion_se);

        // Separador
        const separador2 = document.createElement("hr");
        separador2.style.margin = "20px 0";
        separador2.style.borderColor = "#ddd";
        form.appendChild(separador2);

        // --- Paso 3: DATOS COMPLEMENTARIOS DEL ACUDIENTE ---
        const titulo3 = document.createElement("div");
        //titulo3.style.backgroundColor = "#1e3a6d";
        //titulo3.style.color = "white";
        titulo3.style.padding = "10px 15px";
        titulo3.style.marginBottom = "15px";
        titulo3.style.fontWeight = "600";
        titulo3.style.fontSize = "16px";
        titulo3.style.borderTop = "3px solid #ff9805";
        titulo3.style.borderBottom = "3px solid #ff9805";
        titulo3.textContent = "Paso 3 - DATOS COMPLEMENTARIOS DEL ACUDIENTE";
        form.appendChild(titulo3);

        crearCampo(form, "Nombre", "nombre_acudiente", datos.acudiente);
        crearCampo(form, "Documento", "documento_acudiente", datos.docA);
        crearCampo(form, "Dirección", "direccion_acudiente", datos.direccion);
        crearCampo(form, "Celular", "celular_acudiente", datos.telA);
        crearCampo(form, "Correo electrónico acudiente", "correo_acudiente", datos.emailA);
        crearCampo(form, "Confirmar correo electrónico acudiente", "confirmar_correo_acudiente", datos.emailA);

        // Extraer parentescos desde el JSON del servicio
        const opcionesParentescos = datos.parentescos.map(parentesco => ({
            valor: parentesco.parentesco,
            texto: parentesco.parentesco
        }));
        const parentescoSelect = crearSelect(form, "Selecciona el parentesco", "parentesco", opcionesParentescos);
        parentescoSelect.value = datos.parentesco_acudiente_1 ?? "0";

        // Botón enviar
        const submitBtn = crearBoton("intencion", "#28A745", "Enviar datos");
        submitBtn.type = "submit";
        form.appendChild(submitBtn);

        // Alerta de error
        const alerta = document.createElement("div");
        alerta.className = "alert alert-danger";
        alerta.role = "alert";
        alerta.id = "alert";
        alerta.style.display = "none"; // Oculto inicialmente
        alerta.innerHTML = `
            <pp>
                ⚠️
                <span>: </span>
                <label id="pdesc"></label>
                <input type="text" class="alert alert-danger" style="width: 20px; display: none;" id="txtvacio" value="0">
            </pp>
        `;
        form.appendChild(alerta);

        formContainer.appendChild(form);
        contenedorPadre.appendChild(formContainer);        

        // Manejar envío
        form.onsubmit = (e) => {
            e.preventDefault();

            // Desactivar el botón y mostrar carga
            submitBtn.disabled = true;
            submitBtn.innerHTML = `
                <img src="chatbot/img/subiendo.gif" 
                    alt="Cargando" 
                    style="width: 20%; vertical-align: middle; margin-right: 8px;">
                Enviando, por favor espera...
            `;
            submitBtn.style.opacity = "0.7";
            submitBtn.style.cursor = "not-allowed";

            const selectTd = document.getElementById('td');
            const selectedOption = selectTd.options[selectTd.selectedIndex];
            const textoSeleccionado = selectedOption.text;

            const formData = new FormData(form);
            formData.append('td_text', textoSeleccionado);
            formData.append('documento', cc);
            formData.append('estado', estado);
            formData.append('control_antiguos', control_antiguos);
            const datosForm = {};
            let completo = true;

            for (let [key, value] of formData.entries()) {
                const input = form.querySelector(`[name="${key}"]`);

                datosForm[key] = value;

                //if (!value) completo = false;
                if (!value.trim()) completo = false;

                // 🔥 Validación especial para campos email
                if (input && input.type === "email") {

                    // Si el valor es NA → no es un email válido
                    if (value.toUpperCase() === "NA") {
                        completo = false;
                        mostrarError(`No es un patrón de correo válido para ${input.getAttribute("data-desc")}`, input.id);
                        //console.warn(`Email inválido (NA no permitido): ${key}`);
                    }

                    // Validación formal de correo
                    const regexEmail = /^[_-\w.]+@[a-z]+\.[a-z.]{2,6}$/;

                    if (!regexEmail.test(value)) {
                        completo = false;
                        mostrarError(`No es un patrón de correo válido para ${input.getAttribute("data-desc")}`, input.id);
                        //console.warn(`Email con formato inválido: ${key}`);
                    }
                }
            }
            console.log(datosForm);

            // Validar selects con valor "0"
            const selects = form.querySelectorAll("select");
            let selectsValidos = true;

            selects.forEach(sel => {
                if (sel.value === "0") {
                    selectsValidos = false;
                    // Marca visualmente el error (opcional)
                    sel.classList.add("is-invalid");

                    // Muestra mensaje nativo de validación
                    sel.setCustomValidity("Por favor selecciona una opción válida.");
                    sel.reportValidity();
                } else {
                    sel.classList.remove("is-invalid");
                    sel.setCustomValidity("");
                }
            });

            if (!completo || !selectsValidos) {
                // Restaurar el botón tras finalizar la petición
                submitBtn.disabled = false;
                submitBtn.textContent = "Enviar datos y documentos";
                submitBtn.style.opacity = "1";
                submitBtn.style.cursor = "pointer";
                agregarMensaje("Unibot", "❌ Por favor completa todos los campos.");
                return;
            }

            //fetch('chatbot/guardar-formulario-inicial.php', {
            fetch('http://localhost:90/avmeeuu/avmeeuu/api/av_pre_admisiones1_nuevos.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(datosForm)
            })
            .then(r => r.json())
            .then(data => {
                if (data.status == "success") {
                    console.log(data);
                    grado = data.grado;
                    agregarMensaje("Unibot", data.mensaje);
                    //Se consume web service de cambio de paso
                    if (paso == "1.2") {
                        let msgControl = "paso 1.2 terminado";
                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                        })
                        .then(r => r.json())
                        .then(data1 => {
                            if (data1.status == "success") {
                                paso = data1.siguiente_paso;
                                etiqueta_intencion = data1.etiqueta_intencion;
                                
                                //Se consume web service de cambio de paso
                                let msgControl = "paso 1.2.1 terminado";
                                fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                    method: 'POST',
                                    headers: { 'Content-Type': 'application/json' },
                                    body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                })
                                .then(r => r.json())
                                .then(data1 => {
                                    if (data1.status == "success") {
                                        paso = data1.siguiente_paso;
                                        etiqueta_intencion = data1.etiqueta_intencion;
                                        let respuesta = "Los costos de matrícula para el grado " + grado + " son: Matrícula <span style='color: blue;'>" + formatoCadenaNumero(data.matricula) + "</span>, Otros Cobros Periódicos <span style='color: blue;'>" + formatoCadenaNumero(data.ocp) + "</span> y Pensión <span style='color: blue;'>" + formatoCadenaNumero(data.pension) + "</span>; para un total de <span style='color: blue;'>" + formatoCadenaNumero(data.pp) + "</span>.";
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        intencion.respuesta = respuesta;
                                        if (intencion) agregarMensaje("Unibot", intencion);
                                    }
                                });
                            }
                        });
                    }
                    else if (paso == "2.2") {
                        let msgControl = "paso 2.2 terminado";
                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                        })
                        .then(r => r.json())
                        .then(data1 => {
                            if (data1.status == "success") {
                                paso = data1.siguiente_paso;
                                etiqueta_intencion = data1.etiqueta_intencion;
                                
                                //Se consume web service de cambio de paso
                                let msgControl = "paso 2.2.1 terminado";
                                fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                    method: 'POST',
                                    headers: { 'Content-Type': 'application/json' },
                                    body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                })
                                .then(r => r.json())
                                .then(data1 => {
                                    if (data1.status == "success") {
                                        paso = data1.siguiente_paso;
                                        etiqueta_intencion = data1.etiqueta_intencion;
                                        let respuesta = "Los costos de matrícula para el grado " + grado + " son: Matrícula <span style='color: blue;'>" + formatoCadenaNumero(data.matricula) + "</span>, Otros Cobros Periódicos <span style='color: blue;'>" + formatoCadenaNumero(data.ocp) + "</span> y Pensión <span style='color: blue;'>" + formatoCadenaNumero(data.pension) + "</span>; para un total de <span style='color: blue;'>" + formatoCadenaNumero(data.pp) + "</span>.";
                                        const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                        intencion.respuesta = respuesta;
                                        if (intencion) agregarMensaje("Unibot", intencion);
                                    }
                                });
                            }
                        });
                    }
                    else if (paso == "3.2") {
                        let msgControl = "paso 3.2 terminado";
                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                        })
                        .then(r => r.json()) // ← Texto → Objeto
                        .then(data1 => {
                            if (data1.status == "success") {
                                paso = data1.siguiente_paso;
                                etiqueta_intencion = data1.etiqueta_intencion;
                                
                                //Se consume web service de cambio de paso
                                let msgControl = "paso 3.2.1 terminado";
                                fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                    method: 'POST',
                                    headers: { 'Content-Type': 'application/json' },
                                    body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                })
                                .then(r => r.json()) // ← Texto → Objeto
                                .then(data2 => {
                                    if (data2.status == "success") {
                                        paso = data2.siguiente_paso;
                                        etiqueta_intencion = data2.etiqueta_intencion;

                                        //Se valida que no sea ciclos o primero
                                        if (data.id_grado == 2 || data.id_grado > 12) {
                                            let msgControl = "paso 3.3 terminado";
                                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                                method: 'POST',
                                                headers: { 'Content-Type': 'application/json' },
                                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                            })
                                            .then(r => r.json())
                                            .then(data3 => {
                                                if (data3.status == "success") {
                                                    paso = data3.siguiente_paso;
                                                    etiqueta_intencion = data3.etiqueta_intencion;

                                                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                    if (intencion) agregarMensaje("Unibot", intencion);
                                                }
                                            });
                                        }
                                        else {                                    
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);
                                        }
                                    }
                                });
                            }
                        });
                    }
                    else if (paso == "4.2") {
                        let msgControl = "paso 4.2 terminado";
                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                        })
                        .then(r => r.json()) // ← Texto → Objeto
                        .then(data1 => {
                            if (data1.status == "success") {
                                paso = data1.siguiente_paso;
                                etiqueta_intencion = data1.etiqueta_intencion;
                                
                                //Se consume web service de cambio de paso
                                let msgControl = "paso 4.2.1 terminado";
                                fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                    method: 'POST',
                                    headers: { 'Content-Type': 'application/json' },
                                    body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                })
                                .then(r => r.json()) // ← Texto → Objeto
                                .then(data2 => {
                                    if (data2.status == "success") {
                                        paso = data2.siguiente_paso;
                                        etiqueta_intencion = data2.etiqueta_intencion;

                                        //Se valida que no sea ciclos o primero
                                        if (data.id_grado == 2 || data.id_grado > 12) {
                                            let msgControl = "paso 4.3 terminado";
                                            fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                                                method: 'POST',
                                                headers: { 'Content-Type': 'application/json' },
                                                body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                            })
                                            .then(r => r.json())
                                            .then(data3 => {
                                                if (data3.status == "success") {
                                                    paso = data3.siguiente_paso;
                                                    etiqueta_intencion = data3.etiqueta_intencion;

                                                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                                    if (intencion) agregarMensaje("Unibot", intencion);
                                                }
                                            });
                                        }
                                        else {                                    
                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);
                                        }
                                    }
                                });
                            }
                        });
                    }
                    else if (paso == "5.2") {
                        let msgControl = "paso 5.2 terminado";
                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                        })
                        .then(r => r.json())
                        .then(data1 => {
                            if (data1.status == "success") {
                                paso = data1.siguiente_paso;
                                etiqueta_intencion = data1.etiqueta_intencion;

                                //Se valida que no sea ciclos o primero
                                if (data.id_grado == 2 || data.id_grado > 12) {
                                    let msgControl = "paso 5.3 terminado";
                                    fetch("http://localhost:90/avmeeuu/avmeeuu/api//av_update_paso.php", {
                                        method: 'POST',
                                        headers: { 'Content-Type': 'application/json' },
                                        body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                                    })
                                    .then(r => r.json())
                                    .then(data2 => {
                                        if (data2.status == "success") {
                                            paso = data2.siguiente_paso;
                                            etiqueta_intencion = data2.etiqueta_intencion;

                                            const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                            if (intencion) agregarMensaje("Unibot", intencion);
                                        }
                                    });
                                }
                                else {                                    
                                    const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                    if (intencion) agregarMensaje("Unibot", intencion);
                                }                                
                            }
                        });
                    }
                    
                } else {
                    // Restaurar el botón tras finalizar la petición
                    submitBtn.disabled = false;
                    submitBtn.textContent = "Enviar datos y documentos";
                    submitBtn.style.opacity = "1";
                    submitBtn.style.cursor = "pointer";
                    agregarMensaje("Unibot", data.mensaje);
                }
            })
            .catch((err) => {
                // Restaurar el botón tras finalizar la petición
                submitBtn.disabled = false;
                submitBtn.textContent = "Enviar datos y documentos";
                submitBtn.style.opacity = "1";
                submitBtn.style.cursor = "pointer";
                console.log(err);
                agregarMensaje("Unibot", "❌ No fue posible conectar con el servidor.");
            });

            //form.reset();
        };
    }

    // Generar formulario final dinámico
    function generarFormularioFinalConDatos(datos, contenedorPadre) {
        console.log(datos);
        const formContainer = document.createElement("div");
        formContainer.style.marginTop = "10px";
        formContainer.style.maxWidth = "80%";
        formContainer.style.marginLeft = "auto";
        formContainer.style.padding = "15px";
        formContainer.style.border = "1px solid #ddd";
        formContainer.style.borderRadius = "8px";
        formContainer.style.backgroundColor = "#f9f9f9";

        const form = document.createElement("form");
        form.noValidate = true;

        // --- Paso 1: DATOS FINALES DEL ESTUDIANTE ---
        const titulo1 = document.createElement("div");
        //titulo1.style.backgroundColor = "#1e3a6d";
        //titulo1.style.color = "white";
        titulo1.style.padding = "10px 15px";
        titulo1.style.marginBottom = "15px";
        titulo1.style.fontWeight = "600";
        titulo1.style.fontSize = "16px";
        titulo1.style.borderTop = "3px solid #ff9805";
        titulo1.style.borderBottom = "3px solid #ff9805";
        titulo1.textContent = "Paso 1 - DATOS FINALES DEL ESTUDIANTE";
        form.appendChild(titulo1);

        // Campos del estudiante
        crearCampoReadOnly(form, "Apellidos", "apellidos", datos.apellidos);
        crearCampoReadOnly(form, "Nombres", "nombres", datos.nombres);
        crearCampoReadOnly(form, "Grado al que ingresas", "grado", datos.grado_matricular);
        crearCampoHidden(form, "idGrado", datos.id_grado_matricular);

        crearCampoReadOnly(form, "Tipo documento de identidad", "tipo_documento", datos.id_tdoc);
        crearCampoReadOnly(form, "Correo electrónico", "email", datos.email);
        crearCampoReadOnly(form, "Número telefónico", "telefono", datos.tel);
        crearCampo(form, "Lugar expedición documento", "expedicion", datos.expedicion);
        crearCampo(form, "Fecha de nacimiento (yyyy-mm-dd)", "fecha_nacimiento", datos.fecha_nacimiento);
        crearCampo(form, "Dirección de residencia", "direccion", datos.direccion_estudiante);
        crearCampo(form, "Ciudad de Residencia", "ciudad", datos.ciudad);

        // --- Paso 2: INFORMACIÓN DEL ACUDIENTE ---
        const titulo2 = document.createElement("div");
        //titulo2.style.backgroundColor = "#1e3a6d";
        //titulo2.style.color = "white";
        titulo2.style.padding = "10px 15px";
        titulo2.style.marginBottom = "15px";
        titulo2.style.fontWeight = "600";
        titulo2.style.fontSize = "16px";
        titulo2.style.borderTop = "3px solid #ff9805";
        titulo2.style.borderBottom = "3px solid #ff9805";
        titulo2.textContent = "Paso 2 - INFORMACIÓN DEL ACUDIENTE";
        form.appendChild(titulo2);

        crearCampoReadOnly(form, "Nombres", "nombreA", datos.acudiente);
        crearCampoReadOnly(form, "Documento", "documentoA", datos.documento_responsable);
        crearCampo(form, "Dirección de residencia", "direccionA", datos.direccion);
        crearCampoReadOnly(form, "Celular", "celularA", datos.telA);
        crearCampoReadOnly(form, "Correo electrónico", "correoA", datos.emailA);
        
        // --- Paso 3: SUBE EL CONTRATO DE MATRÍCULA Y PAGARÉ ---
        const titulo3 = document.createElement("div");
        //titulo3.style.backgroundColor = "#1e3a6d";
        //titulo3.style.color = "white";
        titulo3.style.padding = "10px 15px";
        titulo3.style.marginBottom = "15px";
        titulo3.style.fontWeight = "600";
        titulo3.style.fontSize = "16px";
        titulo3.style.borderTop = "3px solid #ff9805";
        titulo3.style.borderBottom = "3px solid #ff9805";
        titulo3.textContent = "Paso 3 - SUBE EL CONTRATO DE MATRÍCULA Y PAGARÉ";
        form.appendChild(titulo3);

        crearCampoArchivo(form, "Adjunta el contrato diligenciado y firmado", "contrato", true);
        crearCampoArchivo(form, "Adjunta el pagaré diligenciado, firmado y autenticado en notaría", "pagare", true);

        // --- Paso 4: SUBE LOS SIGUIENTES DOCUMENTOS DEL ESTUDIANTE ---
        const titulo4 = document.createElement("div");
        //titulo4.style.backgroundColor = "#1e3a6d";
        //titulo4.style.color = "white";
        titulo4.style.padding = "10px 15px";
        titulo4.style.marginBottom = "15px";
        titulo4.style.fontWeight = "600";
        titulo4.style.fontSize = "16px";
        titulo4.style.borderTop = "3px solid #ff9805";
        titulo4.style.borderBottom = "3px solid #ff9805";
        titulo4.textContent = "Paso 4 - SUBE LOS SIGUIENTES DOCUMENTOS DEL ESTUDIANTE";
        form.appendChild(titulo4);

        if (datos.estado == "nuevo") {
            crearCampoArchivo(form, "Adjunta el documento de identidad del estudiante <span style='background: yellow; color: red;'>(solo si cambió)</span>", "documento_estudiante", true);
            crearCampoArchivo(form, "Adjunta el certificado de actividad extracurricular <span style='background: yellow; color: red;'>(solo si cambió)</span>", "actividad_extra", true);
        }
        else {
            crearCampoArchivo(form, "Adjunta el documento de identidad del estudiante <span style='background: yellow; color: red;'>(solo si cambió)</span>", "documento_estudiante", false);
            crearCampoArchivo(form, "Adjunta el certificado de actividad extracurricular <span style='background: yellow; color: red;'>(solo si cambió)</span>", "actividad_extra", false);        
        }
        crearCampoArchivo(form, "Adjunta una fotografía reciente del estudiante", "foto", true);
        crearCampoArchivo(form, "Adjunta el certificado de la EPS", "eps", true);
        crearCampoArchivo(form, "Adjunta carnet de vacunación al día, con esquema completo incluyendo refuerzos", "vacunas", true);

        // --- Paso 5: SUBE LOS SIGUIENTES DOCUMENTOS ACADÉMICOS DEL ESTUDIANTE ---
        const titulo5 = document.createElement("div");
        //titulo5.style.backgroundColor = "#1e3a6d";
        //titulo5.style.color = "white";
        titulo5.style.padding = "10px 15px";
        titulo5.style.marginBottom = "15px";
        titulo5.style.fontWeight = "600";
        titulo5.style.fontSize = "16px";
        titulo5.style.borderTop = "3px solid #ff9805";
        titulo5.style.borderBottom = "3px solid #ff9805";
        titulo5.textContent = "Paso 5 - SUBE LOS SIGUIENTES DOCUMENTOS ACADÉMICOS DEL ESTUDIANTE";
        form.appendChild(titulo5);

        crearCampoArchivo(form, "Adjunta el paz y salvo del año lectivo anterior", "paz_salvo", true);

        const _grados = ["ninguno", "Primero", "Segundo", "Tercero", "Cuarto", "Quinto", "Sexto", "Séptimo", "Octavo", "Noveno", "Décimo", "UnDécimo"];
        if(datos.estado == "nuevo" || datos.control_antiguos == 2) {
            //Esto faltaba... para nuevos
            crearCampoArchivo(form, "Adjunta el retiro del SIMAT", "retiro_SIMAT", true);
            crearCampoArchivo(form, "Adjunta el certificado de buena conducta u boservador", "buena_conducta", true);

            if(datos.id_grado_matricular > 2 && datos.id_grado_matricular < 7) {//Esto faltaba... certificados del año anterior para primaria
                crearCampoArchivo(form, "Adjunta certificado final calificaciones grado " + _grados[datos.id_grado_matricular - 2], "calificaciones" + (datos.id_grado_matricular - 2), true);
            }
            else if(datos.id_grado_matricular >= 7 && datos.id_grado_matricular < 13) {
                for (let i = 5; i < datos.id_grado_matricular - 1; i++) {
                    crearCampoArchivo(form, "Adjunta certificado final calificaciones grado " + _grados[i], "calificaciones" + i, true);
                }
            }
            else if(datos.id_grado_matricular == 14) {
                crearCampoArchivo(form, "Adjunta certificado final calificaciones grado Tercero", "calificaciones3", true);
            }
            else if(datos.id_grado_matricular == 15) {
                crearCampoArchivo(form, "Adjunta certificado final calificaciones grado Quinto", "calificaciones5", true);
            }
            else if(datos.id_grado_matricular == 16) {
                crearCampoArchivo(form, "Adjunta certificado final calificaciones grado Séptimo", "calificaciones7", true);
            }
            else if(datos.id_grado_matricular == 17) {
                crearCampoArchivo(form, "Adjunta certificado final calificaciones grado Noveno", "calificaciones9", true);
            }
            else if(datos.id_grado_matricular == 18) {
                crearCampoArchivo(form, "Adjunta certificado final calificaciones grado Décimo", "calificaciones10", true);
            }
            else {
                if(datos.id_grado_matricular >= 3) {
                    crearCampoArchivo(form, "Adjunta certificado final calificaciones grado " + _grados[datos.id_grado_matricular - 2], "calificaciones" + (datos.id_grado_matricular - 2), true);
                }
            }

            // ########################## se agregan los certificados de notas de periodos anteriores ######################################
            if(fecha2 > cierre2P) {
                crearCampoArchivo(form, "Adjunta certificado de calificaciones primer periodo ", "calificaciones_1P", true);
                crearCampoArchivo(form, "Adjunta certificado de calificaciones segundo periodo ", "calificaciones_2P", true);
            }
            else if(fecha2 > cierre1P) {
                crearCampoArchivo(form, "Adjunta certificado de calificaciones primer periodo ", "calificaciones_1P", true);
            }
            // #############################################################################################################################
        }       

        // --- Paso 6: SUBE LOS SIGUIENTES DOCUMENTOS DEL ACUDIENTE---
        const titulo6 = document.createElement("div");
        //titulo6.style.backgroundColor = "#1e3a6d";
        //titulo6.style.color = "white";
        titulo6.style.padding = "10px 15px";
        titulo6.style.marginBottom = "15px";
        titulo6.style.fontWeight = "600";
        titulo6.style.fontSize = "16px";
        titulo6.style.borderTop = "3px solid #ff9805";
        titulo6.style.borderBottom = "3px solid #ff9805";
        titulo6.textContent = "Paso 6 - SUBE LOS SIGUIENTES DOCUMENTOS DEL ACUDIENTE";
        form.appendChild(titulo6);

        if (datos.estado == "nuevo") {
            crearCampoArchivo(form, "Adjunta el documento de identidad del acudiente <span style='background: yellow; color: red;'>(solo si cambió)</span>", "documento_acudiente", true);
        }
        else {
            crearCampoArchivo(form, "Adjunta el documento de identidad del acudiente <span style='background: yellow; color: red;'>(solo si cambió)</span>", "documento_acudiente", false);
        }

        // Botón enviar
        /*const submitBtn = document.createElement("button");
        submitBtn.type = "submit";
        submitBtn.textContent = "Enviar datos y documentos";
        submitBtn.style.padding = "10px 16px";
        submitBtn.style.backgroundColor = "#218838";
        submitBtn.style.color = "white";
        submitBtn.style.border = "none";
        submitBtn.style.borderRadius = "6px";
        submitBtn.style.cursor = "pointer";
        submitBtn.style.fontSize = "14px";
        submitBtn.style.width = "100%";*/
        const submitBtn = crearBoton("intencion", "#28A745", "Enviar datos y documentos");
        submitBtn.type = "submit";
        form.appendChild(submitBtn);

        // Alerta de error
        const alerta = document.createElement("div");
        alerta.className = "alert alert-danger";
        alerta.role = "alert";
        alerta.id = "alert";
        alerta.style.display = "none"; // Oculto inicialmente
        alerta.innerHTML = `
            <pp>
                ⚠️
                <span>: </span>
                <label id="pdesc"></label>
                <input type="text" class="alert alert-danger" style="width: 20px; display: none;" id="txtvacio" value="0">
            </pp>
        `;
        form.appendChild(alerta);

        formContainer.appendChild(form);
        contenedorPadre.appendChild(formContainer);        

        // Manejar envío
        form.onsubmit = (e) => {
            e.preventDefault();

            // Desactivar el botón y mostrar carga
            submitBtn.disabled = true;
            submitBtn.innerHTML = `
                <img src="chatbot/img/subiendo.gif" 
                    alt="Cargando" 
                    style="width: 20%; vertical-align: middle; margin-right: 8px;">
                Enviando, por favor espera...
            `;
            submitBtn.style.opacity = "0.7";
            submitBtn.style.cursor = "not-allowed";

            const formData = new FormData(form);
            formData.append('documento', cc);
            formData.append('estado', estado);
            formData.append('control_antiguos', control_antiguos);
            let completo = true;

            for (let [key, value] of formData.entries()) {
                // Si es un campo tipo archivo
                if (value instanceof File) {
                    const inputFile = form.querySelector(`[name="${key}"]`);
                    const esRequerido = inputFile.hasAttribute("required");

                    if (esRequerido && (!value || !value.name)) {
                        completo = false;
                        console.warn(`Archivo requerido no seleccionado: ${key}`);
                    }
                }
                // Si es un select
                else if (form.querySelector(`[name="${key}"]`)?.tagName === "SELECT") {
                    const val = String(value || "").trim();
                    if (val === "0" || val === "") {
                        completo = false;
                        console.warn(`Select incompleto: ${key}`);
                    }
                }
                // Si es texto, número, email, etc.
                else {
                    const val = String(value || "").trim();
                    if (!val) {
                        completo = false;
                        console.warn(`Campo vacío: ${key}`);
                    }
                }

            }
            console.log(Object.fromEntries(formData.entries()));

            // Validación general
            if (!completo) {
                // Restaurar el botón tras finalizar la petición
                submitBtn.disabled = false;
                submitBtn.textContent = "Enviar datos y documentos";
                submitBtn.style.opacity = "1";
                submitBtn.style.cursor = "pointer";
                agregarMensaje("Unibot", "❌ Por favor completa todos los campos y documentos obligatorios antes de continuar. Los documentos obligatorios son aquellos que NO TIENEN el texo <span style='background: yellow; color: red;'>(solo si cambió)</span>. <strong>PARA ESTUDIANTES NUEVOS TODOS LOS ARCHIVOS SON OBLIGAGORIOS.</strong>");
                return;
            }

            //fetch('chatbot/guardar-formulario-inicial.php', {
            fetch('http://localhost:90/avmeeuu/avmeeuu/api/subir_documentos_finales.php', {
                method: 'POST',
                body: formData
            })
            .then(r => r.json())
            .then(data => {
                console.log(data);
                if (data.status == "success") {                    
                    agregarMensaje("Unibot", data.mensaje);
                    //Se consume web service de cambio de paso
                    if (paso == "1.4") {
                        let msgControl = "paso 1.4 terminado";
                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                        })
                        .then(r => r.json())
                        .then(data => {
                            if (data.status == "success") {
                                paso = data.siguiente_paso;
                                etiqueta_intencion = data.etiqueta_intencion;
                                const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                if (intencion) agregarMensaje("Unibot", intencion);

                                //imagen con pasos resumen
                                const divPasos = document.getElementById("div-pasos");
                                divPasos.innerHTML = "";
                                const imgPasos = document.createElement("img");
                                imgPasos.style.width = "100%";
                                imgPasos.src = "chatbot/img/ant6.jpg";
                                imgPasos.alt = "Click";
                                divPasos.appendChild(imgPasos);
                            }
                        });
                    }
                    else if (paso == "2.4") {
                        let msgControl = "paso 2.4 terminado";
                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                        })
                        .then(r => r.json())
                        .then(data => {
                            if (data.status == "success") {
                                paso = data.siguiente_paso;
                                etiqueta_intencion = data.etiqueta_intencion;
                                const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                if (intencion) agregarMensaje("Unibot", intencion);

                                //imagen con pasos resumen
                                const divPasos = document.getElementById("div-pasos");
                                divPasos.innerHTML = "";
                                const imgPasos = document.createElement("img");
                                imgPasos.style.width = "100%";
                                imgPasos.src = "chatbot/img/ant_deu9.jpg";
                                imgPasos.alt = "Click";
                                divPasos.appendChild(imgPasos);
                            }
                        });
                    }
                    else if (paso == "3.6") {
                        let msgControl = "paso 3.6 terminado";
                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                        })
                        .then(r => r.json()) // ← Texto → Objeto
                        .then(data => {
                            if (data.status == "success") {
                                paso = data.siguiente_paso;
                                etiqueta_intencion = data.etiqueta_intencion;
                                const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                if (intencion) agregarMensaje("Unibot", intencion);

                                //imagen con pasos resumen
                                const divPasos = document.getElementById("div-pasos");
                                divPasos.innerHTML = "";
                                const imgPasos = document.createElement("img");
                                imgPasos.style.width = "100%";
                                imgPasos.src = "chatbot/img/ant_nue_deu11.jpg";
                                imgPasos.alt = "Click";
                                divPasos.appendChild(imgPasos);
                            }
                        });
                    }
                    else if (paso == "4.6") {
                        let msgControl = "paso 4.6 terminado";
                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                        })
                        .then(r => r.json()) // ← Texto → Objeto
                        .then(data => {
                            if (data.status == "success") {
                                paso = data.siguiente_paso;
                                etiqueta_intencion = data.etiqueta_intencion;
                                const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                if (intencion) agregarMensaje("Unibot", intencion);

                                //imagen con pasos resumen
                                const divPasos = document.getElementById("div-pasos");
                                divPasos.innerHTML = "";
                                const imgPasos = document.createElement("img");
                                imgPasos.style.width = "100%";
                                imgPasos.src = "chatbot/img/ant_nue8.jpg";
                                imgPasos.alt = "Click";
                                divPasos.appendChild(imgPasos);
                            }
                        });
                    }
                    else if (paso == "5.6") {
                        let msgControl = "paso 5.6 terminado";
                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                        })
                        .then(r => r.json())
                        .then(data => {
                            if (data.status == "success") {
                                paso = data.siguiente_paso;
                                etiqueta_intencion = data.etiqueta_intencion;
                                const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                if (intencion) agregarMensaje("Unibot", intencion);

                                //imagen con pasos resumen
                                const divPasos = document.getElementById("div-pasos");
                                divPasos.innerHTML = "";
                                const imgPasos = document.createElement("img");
                                imgPasos.style.width = "100%";
                                imgPasos.src = "chatbot/img/nue7.jpg";
                                imgPasos.alt = "Click";
                                divPasos.appendChild(imgPasos);
                            }
                        });
                    }
                } else {
                    // Restaurar el botón tras finalizar la petición
                    submitBtn.disabled = false;
                    submitBtn.textContent = "Enviar datos y documentos";
                    submitBtn.style.opacity = "1";
                    submitBtn.style.cursor = "pointer";
                    agregarMensaje("Unibot", data.mensaje);
                }
            })
            .catch((err) => {
                // Restaurar el botón tras finalizar la petición
                submitBtn.disabled = false;
                submitBtn.textContent = "Enviar datos y documentos";
                submitBtn.style.opacity = "1";
                submitBtn.style.cursor = "pointer";
                console.log(err);
                agregarMensaje("Unibot", "❌ No fue posible conectar con el servidor.");
            });

            //form.reset();
        };
    }

    // Generar formulario dinámico para cargar documentos inválidos
    function generarFormularioFinalDocumentosInvalidos(datos, contenedorPadre) {
        console.log(datos);
        const formContainer = document.createElement("div");
        formContainer.style.marginTop = "10px";
        formContainer.style.maxWidth = "80%";
        formContainer.style.marginLeft = "auto";
        formContainer.style.padding = "15px";
        formContainer.style.border = "1px solid #ddd";
        formContainer.style.borderRadius = "8px";
        formContainer.style.backgroundColor = "#f9f9f9";

        const form = document.createElement("form");
        form.noValidate = true;

        // --- Paso 1: DATOS FINALES DEL ESTUDIANTE ---
        const titulo1 = document.createElement("div");
        //titulo1.style.backgroundColor = "#1e3a6d";
        //titulo1.style.color = "white";
        titulo1.style.padding = "10px 15px";
        titulo1.style.marginBottom = "15px";
        titulo1.style.fontWeight = "600";
        titulo1.style.fontSize = "16px";
        titulo1.style.borderTop = "3px solid #ff9805";
        titulo1.style.borderBottom = "3px solid #ff9805";
        titulo1.textContent = "Paso 1 - DATOS FINALES DEL ESTUDIANTE";
        form.appendChild(titulo1);

        // Campos del estudiante
        crearCampoReadOnly(form, "Apellidos", "apellidos", datos.apellidos);
        crearCampoReadOnly(form, "Nombres", "nombres", datos.nombres);
        crearCampoReadOnly(form, "Grado al que ingresas", "grado", datos.grado_matricular);
        crearCampoHidden(form, "idGrado", datos.id_grado_matricular);
        crearCampoHidden(form, "Correo electrónico", "correoA", datos.emailA);

        // --- Paso 2: SUBE LOS SIGUIENTES DOCUMENTOS ---
        const titulo2 = document.createElement("div");
        //titulo2.style.backgroundColor = "#1e3a6d";
        //titulo2.style.color = "white";
        titulo2.style.padding = "10px 15px";
        titulo2.style.marginBottom = "15px";
        titulo2.style.fontWeight = "600";
        titulo2.style.fontSize = "16px";
        titulo2.style.borderTop = "3px solid #ff9805";
        titulo2.style.borderBottom = "3px solid #ff9805";
        titulo2.textContent = "Paso 2 - SUBE LOS SIGUIENTES DOCUMENTOS";
        form.appendChild(titulo2);

        if(datos.control_documentos_invalidos == "1" && datos.tipos.length > 0) {
            for (let i = 0; i < datos.tipos.length; i++) {
                crearCampoArchivo(form, datos.tipos[i].etiqueta, datos.tipos[i].nombre, true);
            }
        }       

        // Botón enviar
        /*const submitBtn = document.createElement("button");
        submitBtn.type = "submit";
        submitBtn.textContent = "Enviar datos y documentos";
        submitBtn.style.padding = "10px 16px";
        submitBtn.style.backgroundColor = "#218838";
        submitBtn.style.color = "white";
        submitBtn.style.border = "none";
        submitBtn.style.borderRadius = "6px";
        submitBtn.style.cursor = "pointer";
        submitBtn.style.fontSize = "14px";
        submitBtn.style.width = "100%";*/
        const submitBtn = crearBoton("intencion", "#28A745", "Enviar datos y documentos");
        submitBtn.type = "submit";
        form.appendChild(submitBtn);

        // Alerta de error
        const alerta = document.createElement("div");
        alerta.className = "alert alert-danger";
        alerta.role = "alert";
        alerta.id = "alert";
        alerta.style.display = "none"; // Oculto inicialmente
        alerta.innerHTML = `
            <pp>
                ⚠️
                <span>: </span>
                <label id="pdesc"></label>
                <input type="text" class="alert alert-danger" style="width: 20px; display: none;" id="txtvacio" value="0">
            </pp>
        `;
        form.appendChild(alerta);

        formContainer.appendChild(form);
        contenedorPadre.appendChild(formContainer);        

        // Manejar envío
        form.onsubmit = (e) => {
            e.preventDefault();

            // Desactivar el botón y mostrar carga
            submitBtn.disabled = true;
            submitBtn.innerHTML = `
                <img src="chatbot/img/subiendo.gif" 
                    alt="Cargando" 
                    style="width: 20%; vertical-align: middle; margin-right: 8px;">
                Enviando, por favor espera...
            `;
            submitBtn.style.opacity = "0.7";
            submitBtn.style.cursor = "not-allowed";

            const formData = new FormData(form);
            formData.append('documento', cc);
            formData.append('estado', estado);
            formData.append('control_antiguos', control_antiguos);
            let completo = true;

            for (let [key, value] of formData.entries()) {
                // Si es un campo tipo archivo
                if (value instanceof File) {
                    const inputFile = form.querySelector(`[name="${key}"]`);
                    const esRequerido = inputFile.hasAttribute("required");

                    if (esRequerido && (!value || !value.name)) {
                        completo = false;
                        console.warn(`Archivo requerido no seleccionado: ${key}`);
                    }
                }
                // Si es un select
                else if (form.querySelector(`[name="${key}"]`)?.tagName === "SELECT") {
                    const val = String(value || "").trim();
                    if (val === "0" || val === "") {
                        completo = false;
                        console.warn(`Select incompleto: ${key}`);
                    }
                }
                // Si es texto, número, email, etc.
                else {
                    const val = String(value || "").trim();
                    if (!val) {
                        completo = false;
                        console.warn(`Campo vacío: ${key}`);
                    }
                }

            }
            console.log(Object.fromEntries(formData.entries()));

            // Validación general
            if (!completo) {
                // Restaurar el botón tras finalizar la petición
                submitBtn.disabled = false;
                submitBtn.textContent = "Enviar datos y documentos";
                submitBtn.style.opacity = "1";
                submitBtn.style.cursor = "pointer";
                agregarMensaje("Unibot", "❌ Por favor completa todos los campos y documentos obligatorios antes de continuar. Los documentos obligatorios son aquellos que NO TIENEN el texo <span style='background: yellow; color: red;'>(solo si cambió)</span>");
                return;
            }

            //fetch('chatbot/guardar-formulario-inicial.php', {
            fetch('http://localhost:90/avmeeuu/avmeeuu/api/subir_documentos_finales_invalidos.php', {
                method: 'POST',
                body: formData
            })
            .then(r => r.json())
            .then(data => {
                console.log(data);
                if (data.status == "success") {                    
                    agregarMensaje("Unibot", data.mensaje);
                    //Se consume web service de cambio de paso
                    if (paso == "1.4") {
                        let msgControl = "paso 1.4 terminado";
                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                        })
                        .then(r => r.json())
                        .then(data => {
                            if (data.status == "success") {
                                paso = data.siguiente_paso;
                                etiqueta_intencion = data.etiqueta_intencion;
                                const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                if (intencion) agregarMensaje("Unibot", intencion);

                                //imagen con pasos resumen
                                const divPasos = document.getElementById("div-pasos");
                                divPasos.innerHTML = "";
                                const imgPasos = document.createElement("img");
                                imgPasos.style.width = "100%";
                                imgPasos.src = "chatbot/img/ant6.jpg";
                                imgPasos.alt = "Click";
                                divPasos.appendChild(imgPasos);
                            }
                        });
                    }
                    else if (paso == "2.4") {
                        let msgControl = "paso 2.4 terminado";
                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                        })
                        .then(r => r.json())
                        .then(data => {
                            if (data.status == "success") {
                                paso = data.siguiente_paso;
                                etiqueta_intencion = data.etiqueta_intencion;
                                const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                if (intencion) agregarMensaje("Unibot", intencion);

                                //imagen con pasos resumen
                                const divPasos = document.getElementById("div-pasos");
                                divPasos.innerHTML = "";
                                const imgPasos = document.createElement("img");
                                imgPasos.style.width = "100%";
                                imgPasos.src = "chatbot/img/ant_deu9.jpg";
                                imgPasos.alt = "Click";
                                divPasos.appendChild(imgPasos);
                            }
                        });
                    }
                    else if (paso == "3.6") {
                        let msgControl = "paso 3.6 terminado";
                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                        })
                        .then(r => r.json()) // ← Texto → Objeto
                        .then(data => {
                            if (data.status == "success") {
                                paso = data.siguiente_paso;
                                etiqueta_intencion = data.etiqueta_intencion;
                                const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                if (intencion) agregarMensaje("Unibot", intencion);

                                //imagen con pasos resumen
                                const divPasos = document.getElementById("div-pasos");
                                divPasos.innerHTML = "";
                                const imgPasos = document.createElement("img");
                                imgPasos.style.width = "100%";
                                imgPasos.src = "chatbot/img/ant_nue_deu11.jpg";
                                imgPasos.alt = "Click";
                                divPasos.appendChild(imgPasos);
                            }
                        });
                    }
                    else if (paso == "4.6") {
                        let msgControl = "paso 4.6 terminado";
                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                        })
                        .then(r => r.json()) // ← Texto → Objeto
                        .then(data => {
                            if (data.status == "success") {
                                paso = data.siguiente_paso;
                                etiqueta_intencion = data.etiqueta_intencion;
                                const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                if (intencion) agregarMensaje("Unibot", intencion);

                                //imagen con pasos resumen
                                const divPasos = document.getElementById("div-pasos");
                                divPasos.innerHTML = "";
                                const imgPasos = document.createElement("img");
                                imgPasos.style.width = "100%";
                                imgPasos.src = "chatbot/img/ant_nue8.jpg";
                                imgPasos.alt = "Click";
                                divPasos.appendChild(imgPasos);
                            }
                        });
                    }
                    else if (paso == "5.6") {
                        let msgControl = "paso 5.6 terminado";
                        fetch("http://localhost:90/avmeeuu/avmeeuu/api/av_update_paso.php", {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({ documento: cc, a: a, paso: paso, msgControl: msgControl })
                        })
                        .then(r => r.json())
                        .then(data => {
                            if (data.status == "success") {
                                paso = data.siguiente_paso;
                                etiqueta_intencion = data.etiqueta_intencion;
                                const intencion = BASE_INTENCIONES.find(i => i.etiqueta === etiqueta_intencion);
                                if (intencion) agregarMensaje("Unibot", intencion);

                                //imagen con pasos resumen
                                const divPasos = document.getElementById("div-pasos");
                                divPasos.innerHTML = "";
                                const imgPasos = document.createElement("img");
                                imgPasos.style.width = "100%";
                                imgPasos.src = "chatbot/img/nue7.jpg";
                                imgPasos.alt = "Click";
                                divPasos.appendChild(imgPasos);
                            }
                        });
                    }
                } else {
                    // Restaurar el botón tras finalizar la petición
                    submitBtn.disabled = false;
                    submitBtn.textContent = "Enviar datos y documentos";
                    submitBtn.style.opacity = "1";
                    submitBtn.style.cursor = "pointer";
                    agregarMensaje("Unibot", data.mensaje);
                }
            })
            .catch((err) => {
                // Restaurar el botón tras finalizar la petición
                submitBtn.disabled = false;
                submitBtn.textContent = "Enviar datos y documentos";
                submitBtn.style.opacity = "1";
                submitBtn.style.cursor = "pointer";
                console.log(err);
                agregarMensaje("Unibot", "❌ No fue posible conectar con el servidor.");
            });

            //form.reset();
        };
    }

    function crearCampo(form, etiqueta, nombre, valor) {
        const fieldGroup = document.createElement("div");
        fieldGroup.style.marginBottom = "12px";

        const label = document.createElement("label");
        label.textContent = etiqueta;
        label.style.display = "block";
        label.style.marginBottom = "4px";
        label.style.fontSize = "14px";
        label.style.color = "#333";
        fieldGroup.appendChild(label);

        let input;

        if (["correo", "confirmar_correo", "correo_acudiente", "confirmar_correo_acudiente"].includes(nombre)) {
            input = document.createElement("input");
            input.type = "email";
            input.setAttribute("data-validar", "email");
        } else if (["telefono", "telA", "celular_acudiente", "documento_acudiente", "docA"].includes(nombre)) {
            input = document.createElement("input");
            input.type = "number";
            input.setAttribute("data-validar", "numero");
        } else {
            input = document.createElement("input");
            input.type = "text";
            if (nombre == "direccion_acudiente") {
                input.setAttribute("data-validar", "texto1");
            }
            else if (nombre == "fecha_nacimiento") {
                input.setAttribute("data-validar", "texto1");
            }
            else if (nombre == "direccion" || nombre == "direccionA") {
                input.setAttribute("data-validar", "texto1");
            }
            else if (nombre == "factor_rh") {
                input.setAttribute("data-validar", "rh");
            }
            else {
                input.setAttribute("data-validar", "texto");
            }            
        }

        input.name = nombre;
        input.id = nombre;
        input.value = valor || "";
        input.setAttribute("data-desc", etiqueta);
        input.setAttribute("required", "true");

        input.style.width = "100%";
        input.style.padding = "8px";
        //input.style.border = "1px solid #ccc";
        //input.style.borderRadius = "6px";
        input.classList.add("form-control");
        //input.style.fontSize = "14px";

        fieldGroup.appendChild(input);
        form.appendChild(fieldGroup);

        return input;
    }

    function crearCampoReadOnly(form, etiqueta, nombre, valor) {
        const fieldGroup = document.createElement("div");
        fieldGroup.style.marginBottom = "12px";

        const label = document.createElement("label");
        label.textContent = etiqueta;
        label.style.display = "block";
        label.style.marginBottom = "4px";
        label.style.fontSize = "14px";
        label.style.color = "#333";
        fieldGroup.appendChild(label);

        let input;

        if (["correo", "confirmar_correo", "correo_acudiente", "confirmar_correo_acudiente"].includes(nombre)) {
            input = document.createElement("input");
            input.type = "email";
            input.setAttribute("data-validar", "email");
        } else if (["telefono", "telA", "celular_acudiente", "documento_acudiente", "docA"].includes(nombre)) {
            input = document.createElement("input");
            input.type = "number";
            input.setAttribute("data-validar", "numero");
        } else {
            input = document.createElement("input");
            input.type = "text";
            input.setAttribute("data-validar", "texto");
        }

        input.name = nombre;
        input.id = nombre;
        input.value = valor || "";
        input.setAttribute("data-desc", etiqueta);
        input.setAttribute("required", "true");
        input.setAttribute("readonly", "true");

        input.style.width = "100%";
        input.style.padding = "8px";
        //input.style.border = "1px solid #ccc";
        //input.style.borderRadius = "6px";
        input.classList.add("form-control");
        //input.style.fontSize = "14px";

        fieldGroup.appendChild(input);
        form.appendChild(fieldGroup);

        return input;
    }

    function crearCampoHidden(form, nombre, valor) {
        const fieldGroup = document.createElement("div");
        fieldGroup.style.marginBottom = "12px";

        let input;

        input = document.createElement("input");
        input.type = "hidden";
        input.setAttribute("data-validar", "texto");

        input.name = nombre;
        input.id = nombre;
        input.value = valor || "";
        
        fieldGroup.appendChild(input);
        form.appendChild(fieldGroup);

        return input;
    }

    function crearSelect(form, etiqueta, nombre, opciones) {
        const fieldGroup = document.createElement("div");
        fieldGroup.style.marginBottom = "12px";

        const label = document.createElement("label");
        if (etiqueta == "Selecciona el grado a que ingresas") {
            label.innerHTML = etiqueta + ` (<span style='background: yellow; color: red;'>
            Si selecciona algún Ciclo, que corresponde a educación para jóvenes 
            en extra edad y adultos, por favor tener en cuenta el 
            <a href="https://unicab.org/assets/descargas/Decreto_3011_de_1997.pdf" target="_blank">Decreto 3011 de 1997</a> que reglamenta esta educación.</span>)`;
        }
        else {
            label.textContent = etiqueta;
        }        
        label.style.display = "block";
        label.style.marginBottom = "4px";
        label.style.fontSize = "14px";
        label.style.color = "#333";
        fieldGroup.appendChild(label);

        const select = document.createElement("select");
        select.name = nombre;
        select.id = nombre;
        select.setAttribute("data-validar", "select");
        select.setAttribute("data-desc", etiqueta);

        select.style.width = "100%";
        select.style.padding = "8px";
        //select.style.border = "1px solid #ccc";
        //select.style.borderRadius = "6px";
        select.classList.add("form-control");
        //select.style.fontSize = "14px";

        const opcionDefault = document.createElement("option");
        opcionDefault.value = "0";
        opcionDefault.textContent = "Seleccione...";
        select.appendChild(opcionDefault);

        opciones.forEach(opcion => {
            const option = document.createElement("option");
            option.value = opcion.valor;
            option.textContent = opcion.texto;
            select.appendChild(option);
        });

        fieldGroup.appendChild(select);
        form.appendChild(fieldGroup);

        return select;
    }

    function crearTextarea(form, etiqueta, nombre, valor) {
        const fieldGroup = document.createElement("div");
        fieldGroup.style.marginBottom = "12px";

        const label = document.createElement("label");
        label.textContent = etiqueta;
        label.style.display = "block";
        label.style.marginBottom = "4px";
        label.style.fontSize = "14px";
        label.style.color = "#333";
        fieldGroup.appendChild(label);

        const textarea = document.createElement("textarea");
        textarea.name = nombre;
        textarea.id = nombre;
        textarea.value = valor || "";
        textarea.style.width = "100%";
        textarea.style.minHeight = "80px";
        textarea.style.padding = "8px";
        textarea.style.border = "1px solid #ccc";
        textarea.style.borderRadius = "6px";
        textarea.style.fontSize = "14px";

        // Aquí solo marcamos qué tipo de validación aplicar
        textarea.setAttribute("data-validar", "texto");
        textarea.setAttribute("data-desc", etiqueta);
        textarea.setAttribute("required", "true");

        fieldGroup.appendChild(textarea);
        form.appendChild(fieldGroup);

        return textarea;
    }

    //function crearCampoArchivo(form, etiqueta, nombre, tiposPermitidos = ["pdf", "png", "jpg", "jpeg"], required) {
    function crearCampoArchivo(form, etiqueta, nombre, required) {
        const fieldGroup = document.createElement("div");
        fieldGroup.style.marginBottom = "12px";

        // Crear input file
        const input = document.createElement("input");
        input.type = "file";
        input.name = nombre;
        input.id = nombre;
        input.classList.add("form-control");
        input.setAttribute("data-desc", etiqueta);
        if (required) input.setAttribute("required", "true");

        //input.accept = tiposPermitidos.map(t => t === "pdf" ? ".pdf" : "image/" + t).join(",");
        input.accept = ".pdf";
        input.style.display = "none";

        // Estilos coherentes con tu diseño
        input.style.width = "100%";
        input.style.padding = "6px";
        //input.style.fontSize = "14px";

        const label = document.createElement("label");
        label.htmlFor = input.id;
        //label.textContent = etiqueta;
        label.style.padding = "12px 16px";
        //label.style.backgroundColor = "#C75EA3";
        label.style.backgroundColor = "#FF9805";
        label.style.color = "white";
        label.style.borderRadius = "8px 0px 0px 0px";
        label.style.cursor = "pointer";
        label.style.fontSize = "14px";
        label.style.fontWeight = "600";
        label.style.display = "flex";
        label.style.alignItems = "center";
        label.style.gap = "10px";

        // Icono input (imagen)
        const iconoInput = document.createElement("img");
        iconoInput.style.width = "30px";
        iconoInput.style.height = "30px";
        iconoInput.style.borderRadius = "4px";
        iconoInput.src = "chatbot/img/subir_pdf1.png";
        iconoInput.alt = "Subir";

        label.appendChild(iconoInput);

        // Texto input
        const textoInput = document.createElement("span");
        //textoInput.textContent = " Seleccionar comprobante";
        textoInput.innerHTML = etiqueta;        
        textoInput.style.fontWeight = "600";
        textoInput.style.flexGrow = "1";
        textoInput.style.color = "white";

        label.appendChild(textoInput);

        const archivoTexto = document.createElement("span");
        archivoTexto.style.marginLeft = "10px";
        archivoTexto.style.fontSize = "13px";
        archivoTexto.style.color = "#555";

        // Validación básica al seleccionar
        input.addEventListener("change", function (e) {
            const file = e.target.files[0];
            if (!file) return;

            const ext = file.name.split(".").pop().toLowerCase();
            if (ext !== "pdf") {
                alert("❌ Tipo de archivo no permitido. Solo se admite formato PDF.");
                input.value = ""; // Limpia el campo
                return;
            }

            if (file.size > 10 * 1024 * 1024) {
                alert("❌ El archivo supera el tamaño máximo de 10 MB.");
                input.value = "";
            }

            archivoTexto.textContent = file.name;

            // Mostrar mensaje de espera
            //agregarMensaje("Unibot", mensajeEspera);
        });

        fieldGroup.appendChild(input);
        fieldGroup.appendChild(label);
        fieldGroup.appendChild(archivoTexto);

        form.appendChild(fieldGroup);

        return input;
    }


    // --- VALIDACIÓN DE TEXTO (sin caracteres especiales) ---
    function validar_texto(id, desc) {
        let id_obj = "#" + id;
        const input = document.getElementById(id);
        const patron = /[-_'"\<\>\~\^\*\$\!\¡\#\%\&\¿\?\/\=\+\|,;:\(\)\{\}\[\]\\]{1,}/;
        //const valor = input.value;
        //console.log("validar_texto");
        
        let val = String($(id_obj).val()).match(patron);
        if(val == null) {
            if ($(id_obj).val().trim() == "") {
                input.setCustomValidity("El campo se debe llenar");
                mostrarError(`El campo ${desc} se debe llenar`, id);
                return false;
            } else {
                input.setCustomValidity("");
                ocultarError(id);
                return true;
            }
        }
        else {
            input.setCustomValidity("Ha ingresado caracteres inválidos");
            let texto = "Ha ingresado alguno de los siguientes caracteres no válidos para " + desc + ": ";
            texto += "- _ \' \" < > ~ ^ * $ ! ¡ # % & ¿ ? /= + , ; : ( ) { } [ ] \\";
            mostrarError(texto, id);
            return false;
        }

        //input.setCustomValidity("");
        //ocultarError(id);
        //return true;
    }

    function validar_texto1(id, desc) {
        let id_obj = "#" + id;
        const input = document.getElementById(id);
        const patron = /[_'"\<\>\~\^\*\$\!\¡\#\%\&\¿\?\/\=\+\|,;:\(\)\{\}\[\]\\]{1,}/;
        //const valor = input.value;
        //console.log("validar_texto1");
        
        let val = String($(id_obj).val()).match(patron);
        if(val == null) {
            if ($(id_obj).val().trim() == "") {
                input.setCustomValidity("El campo se debe llenar");
                mostrarError(`El campo ${desc} se debe llenar`, id);
                return false;
            } else {
                input.setCustomValidity("");
                ocultarError(id);
                return true;
            }
        }
        else {
            input.setCustomValidity("Ha ingresado caracteres inválidos");
            let texto = "Ha ingresado alguno de los siguientes caracteres no válidos para " + desc + ": ";
            texto += " _ \' \" < > ~ ^ * $ ! ¡ # % & ¿ ? /= + , ; : ( ) { } [ ] \\";
            mostrarError(texto, id);
            return false;
        }
    }

    function validar_rh(id, desc) {
        let id_obj = "#" + id;
        const input = document.getElementById(id);
        const patron = /[_'"\<\>\~\^\*\$\!\¡\#\%\&\¿\?\/\=\|,;:\(\)\{\}\[\]\\]{1,}/;
        //const valor = input.value;
        //console.log("validar_texto");
        
        let val = String($(id_obj).val()).match(patron);
        if(val == null) {
            if ($(id_obj).val().trim() == "") {
                input.setCustomValidity("El campo se debe llenar");
                mostrarError(`El campo ${desc} se debe llenar`, id);
                return false;
            } else {
                input.setCustomValidity("");
                ocultarError(id);
                return true;
            }
        }
        else {
            input.setCustomValidity("Ha ingresado caracteres inválidos");
            let texto = "Ha ingresado alguno de los siguientes caracteres no válidos para " + desc + ": ";
            texto += "- _ \' \" < > ~ ^ * $ ! ¡ # % & ¿ ? /= + , ; : ( ) { } [ ] \\";
            mostrarError(texto, id);
            return false;
        }
    }

    // --- VALIDACIÓN DE NÚMEROS ---
    function validar_numero(id, desc) {
        let id_obj = "#" + id;
        const input = document.getElementById(id);
        const patron = /^[0-9]+$/;
        //const valor = input.value;
        //console.log("validar_numero");

        let esCoincidente = patron.test($(id_obj).val());
        if(esCoincidente) {
            input.setCustomValidity("");
            ocultarError(id);
            return true;
        }
        else {            
            if ($(id_obj).val().trim() == "") {
                input.setCustomValidity("El campo se debe llenar");
                mostrarError(`El campo ${desc} se debe llenar`, id);
                return false;
            } else {
                input.setCustomValidity("Ha ingresado caracteres inválidos");
                let texto = "Ingrese sólamente números para " + desc;
                mostrarError(texto, id);
                return false;
            }            
        }
    }

    // --- VALIDACIÓN DE EMAIL ---
    function validar_email(id, desc) {
        const input = document.getElementById(id);
        const patron = /^[_-\w.]+@[a-z]+\.[a-z.]{2,6}$/;
        const valor = input.value.trim();
        //console.log("validar_email");

        if (!valor) {
            input.setCustomValidity("El campo se debe llenar");
            mostrarError(`El campo ${desc} se debe llenar`, id);
            return false;
        }

        if (!patron.test(valor)) {
            input.setCustomValidity("Ha ingresado caracteres inválidos");
            mostrarError(`No es un patrón de correo válido para ${desc}`, id);
            return false;
        }

        // Validar coincidencia entre email y confirmación
        if (id === "correo" || id === "confirmar_correo") {
            const correo = document.getElementById("correo").value;
            const inputCorreo = document.getElementById("correo");
            const confirmar = document.getElementById("confirmar_correo").value;
            if (correo !== confirmar) {
                mostrarError("El email y la confirmación del email del estudiante deben ser iguales", id);
                return false;
            }
            else {
                inputCorreo.setCustomValidity("");
                inputCorreo.classList.remove("is-invalid");
                inputCorreo.style.border = "1px solid #ccc";
            }
        }

        if (id === "correo_acudiente" || id === "confirmar_correo_acudiente") {
            const correo = document.getElementById("correo_acudiente").value;
            const inputCorreoAcudiente = document.getElementById("correo_acudiente");
            const confirmar = document.getElementById("confirmar_correo_acudiente").value;
            if (correo !== confirmar) {
                mostrarError("El email y la confirmación del email del acudiente deben ser iguales", id);
                return false;
            }
            else {
                inputCorreoAcudiente.setCustomValidity("");
                inputCorreoAcudiente.classList.remove("is-invalid");
                inputCorreoAcudiente.style.border = "1px solid #ccc";
            }
        }

        input.setCustomValidity("");
        ocultarError(id);
        return true;
    }

    // --- VALIDACIÓN DE FECHA (opcional) ---
    function validar_fecha(id, desc) {
        let id_obj = "#" + id;
        const input = document.getElementById(id);
        const patron = /^[0-9]{4}-[0-1]{1}[0-9]{1}-[0-3]{1}[0-9]{1}$/;
        //const valor = input.value;
        //console.log("validar_fecha");

        let esCoincidente = patron.test($(id_obj).val());
        if(esCoincidente) {
            input_email.setCustomValidity("");
            
            let fecha = $(id_obj).val();
            let porciones = fecha.split("-");
            let a = parseInt(porciones[0]);
            let m = parseInt(porciones[1]);
            let d = parseInt(porciones[2]);
            
            if(a < 1850 || a > 3050) {
                input.setCustomValidity("Año inválido");
                mostrarError(`Año inválido para ${desc}`, id);
                return false;
            } else if(m < 1 || m > 12) {
                input.setCustomValidity("Mes inválido");
                mostrarError(`Mes inválido para ${desc}`, id);
                return false;
            } else if(m == 2) {
                if(d < 1 || d > 29) {
                    input.setCustomValidity("Día inválido");
                    mostrarError(`Día inválido para ${desc}`, id);
                    return false;
                } 
            } else if(m == 4 || m == 6 || m == 9 || m == 11) {
                if(d < 1 || d > 30) {
                    input.setCustomValidity("Día inválido");
                    mostrarError(`Día inválido para ${desc}`, id);
                    return false;
                } 
            } else if(d < 1 || d > 31) {
                input.setCustomValidity("Día inválido");
                mostrarError(`Día inválido para ${desc}`, id);
                return false;
            } else {
                input.setCustomValidity("");
                ocultarError(id);
                return true;
            }            
        }
        else {
            input.setCustomValidity("No es una fecha de nacimiento válida");
            var texto = "No es un patrón válido para " + desc;
            mostrarError(texto, id);
        }
    }

    function mostrarError(mensaje, id) {
        const alerta = document.getElementById("alert");
        const pDesc = document.getElementById("pdesc");
        pDesc.textContent = mensaje;
        alerta.style.display = "block";

        const elemento = document.getElementById(id);
        if (elemento) {
            elemento.classList.add("is-invalid");
            elemento.style.border = "2px solid red";
            elemento.style.setProperty('border', '2px solid #dc3545', 'important');
        }

        habilitarBoton(false);
    }

    function ocultarError(id) {
        const alerta = document.getElementById("alert");
        alerta.style.display = "none";

        const elemento = document.getElementById(id);
        if (elemento) {
            elemento.classList.remove("is-invalid");
            elemento.style.border = "1px solid #ccc";
        }

        //habilitarBoton(sonTodosValidos());
    }

    function habilitarBoton(habilitar) {
        const boton = document.querySelector("button[type='submit']");
        if (boton) {
            boton.disabled = !habilitar;
            boton.style.opacity = habilitar ? "1" : "0.6";
            boton.style.cursor = habilitar ? "pointer" : "not-allowed";
        }        
    }

    function sonTodosValidos() {
        const campos = document.querySelectorAll("[data-validar]");
        for (let campo of campos) {
            if (campo.classList.contains("is-invalid") || campo.value.trim() === "" || (campo.tagName === "SELECT" && campo.value === "0")) {
                return false;
            }
        }
        return true;
    }

    //Esta función es para abrir pagos Epayco en otra ventana
    function redirigirPOST(url, parametros) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = url;
        form.style.display = 'none'; // invisible
        form.target = "_blank";
        
        for (const clave in parametros) {
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = clave;
            input.value = parametros[clave];
            form.appendChild(input);
        }

        document.body.appendChild(form);
        form.submit(); // redirige
    }

    function formatoCadenaNumero(cadenaNumero) {
        let clean = String(cadenaNumero).replace(/[^\d.-]/g, '');    // quita todo lo que no es número, punto o guión
        let num = parseInt(clean, 10);                        // obtiene entero
        let formato = "$ " + (isNaN(num) ? "0" : num.toLocaleString('es-CO'));
        //console.log(formato);

        //opcional si se quiere sin redondeos y con decimales a 2
        //let formato = "$ " + (isNaN(num) ? "0" : num.toLocaleString('es-CO', { minimumFractionDigits: 0 });
        return formato
    }

    function asegurarScrollArriba(root) {
        if (!root) return;

        // intento inmediato
        try { root.scrollTop = 0; } catch (e) {}

        // repetimos en varios frames por si otro código hace scroll después
        let attempts = 0;
        const maxAttempts = 30; // ~ medio segundo a 60fps
        const rafLoop = () => {
            attempts++;
            try { root.scrollTop = 0; } catch (e) {}
            if (attempts < maxAttempts) requestAnimationFrame(rafLoop);
        };
        requestAnimationFrame(rafLoop);

        // además usamos MutationObserver: cuando el DOM se estabilice, forzamos arriba una última vez
        // (evita "pelea" con procesos asíncronos que sigan añadiendo nodos)
        const mo = new MutationObserver(() => {
            clearTimeout(window.__sf_timer);
            window.__sf_timer = setTimeout(() => {
            try { root.scrollTo({ top: 0, behavior: 'smooth' }); } catch (e) { try { root.scrollTop = 0; } catch (e) {} }
            mo.disconnect();
            }, 70); // espera a que dejen de llegar mutaciones por 70ms
        });
        mo.observe(root, { childList: true, subtree: true, attributes: false });
    }

    function estadoValidacion(tipo) {
        // Crear tarjeta amarilla de estado
        const estadoDiv = document.createElement("div");
        estadoDiv.style.display = "flex";
        estadoDiv.style.alignItems = "center";
        estadoDiv.style.justifyContent = "center";
        estadoDiv.style.gap = "12px";
        estadoDiv.style.padding = "16px 20px";
        estadoDiv.style.borderTop = "3px solid #ff9805";
        estadoDiv.style.borderBottom = "3px solid #ff9805";
        estadoDiv.style.backgroundColor = "#fff";
        estadoDiv.style.color = "#000";
        estadoDiv.style.fontFamily = "Arial, sans-serif";
        estadoDiv.style.fontSize = "18px";
        estadoDiv.style.fontWeight = "500";
        estadoDiv.style.textAlign = "center";
        estadoDiv.style.margin = "20px auto";
        estadoDiv.style.maxWidth = "600px";
        //estadoDiv.style.borderRadius = "6px";
        //estadoDiv.style.boxShadow = "0 2px 6px rgba(0,0,0,0.1)";

        // Icono de advertencia
        const icono = document.createElement("img");
        icono.src = "chatbot/img/warning.png";
        icono.alt = "Advertencia";
        icono.style.width = "40px";
        icono.style.height = "40px";
        icono.style.flexShrink = "0";

        // Texto del estado
        const texto = document.createElement("div");
        if (con_nota_receso) {
            if (tipo == "Estado evaluación admisión") {
                texto.innerHTML = `
                    Evaluación de admisión en estado <br>
                    <strong style="font-size: 22px;">Pendiente.</strong><br>
                <span style="color: red;">` + nota_receso + `</span>`;
            }
            else {
                texto.innerHTML = `
                    Validación ` + tipo + ` en estado <br>
                    <strong style="font-size: 22px;">Pendiente.</strong><br>
                    La verificación se realiza por orden de llegada y el proceso tiene un plazo de cinco días para dar respuesta.
                <span style="color: red;">` + nota_receso + `</span>`;
            }            
        }
        else {
            if (tipo == "Estado evaluación admisión") {
                texto.innerHTML = `
                    Evaluación de admisión en estado <br>
                    <strong style="font-size: 22px;">Pendiente.</strong>
                `;
            }
            else {
                texto.innerHTML = `
                    Validación ` + tipo + ` en estado <br>
                    <strong style="font-size: 22px;">Pendiente.</strong><br>
                    La verificación se realiza por orden de llegada y el proceso tiene un plazo de cinco días para dar respuesta.
                `;
            }
            
        }                

        estadoDiv.appendChild(icono);
        estadoDiv.appendChild(texto);

        return estadoDiv;
    }

    function estadoEntrevista(entrevista, admitido) {
        // Crear tarjeta amarilla de estado
        const estadoDiv = document.createElement("div");
        estadoDiv.style.display = "flex";
        estadoDiv.style.alignItems = "center";
        estadoDiv.style.justifyContent = "center";
        estadoDiv.style.gap = "12px";
        estadoDiv.style.padding = "16px 20px";
        estadoDiv.style.borderTop = "3px solid #ff9805";
        estadoDiv.style.borderBottom = "3px solid #ff9805";
        estadoDiv.style.backgroundColor = "#fff";
        estadoDiv.style.color = "#000";
        estadoDiv.style.fontFamily = "Arial, sans-serif";
        estadoDiv.style.fontSize = "18px";
        estadoDiv.style.fontWeight = "500";
        estadoDiv.style.textAlign = "center";
        estadoDiv.style.margin = "20px auto";
        estadoDiv.style.maxWidth = "600px";
        //estadoDiv.style.borderRadius = "6px";
        //estadoDiv.style.boxShadow = "0 2px 6px rgba(0,0,0,0.1)";

        // Icono de advertencia
        const icono = document.createElement("img");
        icono.src = "chatbot/img/warning.png";
        icono.alt = "Advertencia";
        icono.style.width = "40px";
        icono.style.height = "40px";
        icono.style.flexShrink = "0";

        // Texto del estado
        const texto = document.createElement("div");
        if (entrevista == "SI" && admitido == 0) {
            texto.innerHTML = `
                <strong style="font-size: 22px;">Estudiante no admitido en entrevista.</strong>`;
        }
        else if (entrevista == "NO") {
            texto.innerHTML = `
                Entrevista en estado <br>
                <strong style="font-size: 22px;">Pendiente.</strong>`;
        }        

        estadoDiv.appendChild(icono);
        estadoDiv.appendChild(texto);

        return estadoDiv;
    }

    function crearBoton(tipo, color, texto1) {
        const boton = document.createElement("button");
        //boton.textContent = btn.texto;
        boton.style.padding = "12px 16px";
        boton.style.border = "none";
        //boton.style.borderRadius = "8px";
        boton.style.borderRadius = "8px 0px 0px 0px";
        boton.style.cursor = "pointer";
        boton.style.fontSize = "14px";
        boton.style.width = "100%";
        boton.style.textAlign = "left";
        boton.style.display = "flex";
        boton.style.alignItems = "center";
        boton.style.gap = "10px"; // Espacio entre ícono y texto

        // Colores por tipo
        // azul #0B77B3
        //verde #28A745
        //naranja #FF9805
        /*if (tipo === "intencion") {
            boton.style.backgroundColor = "#127eb5";
            boton.style.color = "white";
        } else if (btn.tipo === "pdf") {
            boton.style.backgroundColor = "#fe9100";
            boton.style.color = "white";
        }*/
        boton.style.backgroundColor = color;
        boton.style.color = "white";

        // Icono (imagen)
        const icono = document.createElement("img");
        icono.style.width = "30px";
        icono.style.height = "30px";
        icono.style.borderRadius = "4px";

        if (tipo === "d_pdf") {
            icono.src = "chatbot/img/descargar_pdf1.png"; // ← Ruta a tu imagen
            icono.alt = "PDF";
        } 
        else if (tipo === "intencion" || tipo === "proceso" || tipo === "servicio") {
            icono.src = "chatbot/img/click5.png";
            icono.alt = "Click";
            //icono.style.display = "none";
        }

        // Texto
        boton.textContent = ""; // Limpia cualquier texto previo
        const texto = document.createElement("span");
        texto.textContent = texto1;
        texto.style.fontWeight = "600";
        texto.style.flexGrow = "1"; // Para que el texto ocupe el espacio disponible
        //texto.style.overflow = "hidden"; // Recorta si es muy largo
        //texto.style.textOverflow = "ellipsis"; // Muestra ... si se corta

        boton.appendChild(icono);
        boton.appendChild(texto);

        return boton;
    }

});