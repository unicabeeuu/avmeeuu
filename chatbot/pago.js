let handler = ePayco.checkout.configure({
    key: '870fd53ee9274a76a62c34f434b09569',
    test: false
});

$(function() {
     $("#alert").hide();
     habilitarBoton(sonTodosValidos());

    $("#selmedio").change(function() {
        let id = this.id;
        //let id = $(this).attr('id'); //otra opción
        //let id = event.target.id; //otra opción

        let medio = $("#selmedio").val();
        //Se arma la referencia de pago
        if(medio == "NA") {
            mostrarError(id);
            let texto = "Seleccione una opción para medio de pago";
            $("#pdesc").html(texto).css("color","red");
            $("#alert").show();
        }
        else {
            ocultarError(id);
            $("#pdesc").html("");
            $("#alert").hide();
        }
        
        //mostrar_submit();
        habilitarBoton(sonTodosValidos());
    });

    //Referencia de payco que viene por url
    let ref_payco = getQueryParam('ref_payco');
    //Url Rest Metodo get, se pasa la llave y la ref_payco como paremetro
    let urlapp = "https://secure.epayco.co/validation/v1/reference/" + ref_payco;

    $.get(urlapp, function(response) {
    
    if (response.success) {

        if (response.data.x_cod_response == 1) {
        //Codigo personalizado
        $("#respuesta").addClass("aceptada");
        }
        //Transaccion Rechazada
        if (response.data.x_cod_response == 2) {
        $("#respuesta").addClass("rechazada");
        }
        //Transaccion Pendiente
        if (response.data.x_cod_response == 3) {
        $("#respuesta").addClass("pendiente");
        }
        //Transaccion Fallida
        if (response.data.x_cod_response == 4) {
        
        }

        $('#fecha').html(response.data.x_transaction_date);
        $('#respuesta').html(response.data.x_response);
        $('#referencia').text(response.data.x_extra1);
        $('#motivo').text(response.data.x_response_reason_text);
        $('#recibo').text(response.data.x_transaction_id);
        $('#banco').text(response.data.x_bank_name);
        $('#autorizacion').text(response.data.x_approval_code);
        $('#factura').text(response.data.x_id_invoice);
        $('#concepto').text(response.data.x_description);
        $('#ref_epayco').text(response.data.x_ref_payco);

        let cod_proyecto = "";
        if(response.data.x_bank_name == "GANA") {
            cod_proyecto = 242;
        }
        else if(response.data.x_bank_name == "EFECTY") {
            cod_proyecto = 111992;
        }
        else if(response.data.x_bank_name == "BALOTO") {
            cod_proyecto = 950715;
        }
        else if(response.data.x_bank_name == "PUNTO RED") {
            cod_proyecto = 110342;
        }
        else if(response.data.x_bank_name == "RED SERVI") {
            cod_proyecto = 761;
        }
        else if(response.data.x_bank_name == "SURED") {
                cod_proyecto = 'MR0382';
            }
        else {
            cod_proyecto = "";
        }
        $('#cod_proyecto').text(cod_proyecto);
        $('#desc_res').text(response.data.x_response_reason_text);
        $('#valor').text(response.data.x_amount + ' ' + response.data.x_currency_code);


    } else {
        //alert("Error consultando la información");
    }
    });
});

function callEpayco() {
    //Se genera código de factura
    let codfact1 = "";
    let ale = 0;
    let sa1 = ["q","a","1","z","x","2","s","w","3","p","l","4","m","k","5","o","e","6",
            "d","c","7","i","j","8","n","r","9","f","v","0","u","h","b","t","g"];
    //alert (sa1.length)
    
    let medio = $("#selmedio").val();
    
    for(let i = 1; i <=10; i++) {
        ale = parseInt(Math.random()*sa1.length);
        //alert (ale);
        codfact1 = codfact1 + sa1[ale];
    }
    //alert (codfact1);
    
    //Se arma la petición de pago
    let codigo = $("#txtref").val();
    let doc_est = $("#txtndoc").val();
    let nombre = $("#txtnom").val();
    let identif = $("#txtidentif").val();
    let fecha = $("#txtano").val();
    let valor = $("#txtvalor").val();
    let concepto = $("#concepto").val();
    let data = {};
    
    let factura = doc_est + "_" + codfact1;
    //alert (factura);
    
    //Se arma la referencia de pago
    if(medio == "E") {
        data={
            //Parametros compra (obligatorio)
            name: "Unicab Colegio Virtual",
            description: concepto,
            invoice: factura,
            currency: "cop",
            amount: valor,
            tax_base: "0",
            tax: "0",
            country: "co",
            lang: "es",
            
            //Onpage="false" - Standard="true"
            external: "false",
            key: "870fd53ee9274a76a62c34f434b09569",
            
            //Atributos opcionales
            extra1: codigo,
            extra2: "extra2",
            extra3: "extra3",
            confirmation: "https://unicab.org/avadmisiones/avadmisiones/resultado_pagos.php",
            response: "https://unicab.org/avadmisiones/avadmisiones/resultado_pagos.php",
            
            
            //Atributos cliente
            name_billing: nombre,
            //address_billing: "Carrera 19 numero 14 91",
            type_doc_billing: "cc",
            //mobilephone_billing: "3050000000",
            number_doc_billing: identif,
            
            //atributo deshabilitación metodo de pago
            methodsDisable: ["TDC", "PSE", "SP", "DP"]
            
        };
        console.log(data);
    }
    else if(medio == "P" || medio == "P6") {
        data={
            //Parametros compra (obligatorio)
            name: "Unicab Colegio Virtual",
            description: concepto,
            invoice: factura,
            currency: "cop",
            amount: valor,
            tax_base: "0",
            tax: "0",
            country: "co",
            lang: "es",
            
            //Onpage="false" - Standard="true"
            external: "false",
            key: "870fd53ee9274a76a62c34f434b09569",
            
            //Atributos opcionales
            extra1: codigo,
            extra2: "extra2",
            extra3: "extra3",
            confirmation: "https://unicab.org/avadmisiones/avadmisiones/resultado_pagos.php",
            response: "https://unicab.org/avadmisiones/avadmisiones/resultado_pagos.php",
            
            
            //Atributos cliente
            name_billing: nombre,
            //address_billing: "Carrera 19 numero 14 91",
            type_doc_billing: "cc",
            //mobilephone_billing: "3050000000",
            number_doc_billing: identif,
            
            //atributo deshabilitación metodo de pago
            methodsDisable: ["TDC", "SP", "CASH", "DP"]
            
        };
    }
    else if(medio == "TC") {
        data={
            //Parametros compra (obligatorio)
            name: "Unicab Colegio Virtual",
            description: concepto,
            invoice: factura,
            currency: "cop",
            amount: valor,
            tax_base: "0",
            tax: "0",
            country: "co",
            lang: "es",
            
            //Onpage="false" - Standard="true"
            external: "false",
            key: "870fd53ee9274a76a62c34f434b09569",
            
            //Atributos opcionales
            extra1: codigo,
            extra2: "extra2",
            extra3: "extra3",
            confirmation: "https://unicab.org/avadmisiones/avadmisiones/resultado_pagos.php",
            response: "https://unicab.org/avadmisiones/avadmisiones/resultado_pagos.php",
            
            
            //Atributos cliente
            name_billing: nombre,
            //address_billing: "Carrera 19 numero 14 91",
            type_doc_billing: "cc",
            //mobilephone_billing: "3050000000",
            number_doc_billing: identif,
            
            //atributo deshabilitación metodo de pago
            methodsDisable: ["PSE", "SP", "CASH", "DP"]
            
        };
    }
    
    handler.open(data);
    
}

function validar_texto(id, desc) {
    let control = 0;
    let id_obj = "#" + id;
    let ctr_obj = "#ctr_" + id;
    //var input_desc = document.getElementById("desc");
    let v_input = document.getElementById(id);
    let v_val = /[-_'"\<\>\~\^\*\$\!\¡\#\%\&\¿\?\/\=\+\|,;:\(\)\{\}\[\]\\]{1,}/;
    let val = String($(id_obj).val()).match(v_val);
    if(val == null) {
        //v_input.setCustomValidity("");
        ocultarError(id);
        $("#pdesc").html("");
        $("#alert").hide();
    }
    else {
        //v_input.setCustomValidity("Ha ingresado caracteres inválidos");
        let texto = "Ha ingresado alguno de los siguientes caracteres no válidos para " + desc + ": ";
        texto += "- _ \' \" < > ~ ^ * $ ! ¡ # % & ¿ ? /= + , ; : ( ) { } [ ] \\";
        mostrarError(id);
        $("#pdesc").html(texto).css("color","red");
        $("#alert").show();
    }
    
    //Sa valida que no esté vacío
    let contenido = $(id_obj).val();
    if(contenido == "") {
        $(ctr_obj).val(1);
    }
    
    habilitarBoton(sonTodosValidos());
}

function validar_numero(id, desc) {
    let control = 0;
    let id_obj = "#" + id;
    let ctr_obj = "#ctr_" + id;
    let v_input = document.getElementById(id);
    let patron = /^[0-9]{1,}$/;
    //var val = String($(id_obj).val()).match(v_val);
    let esCoincidente = patron.test($(id_obj).val());
    //alert(esCoincidente);
    if(esCoincidente) {
        ocultarError(id);
        $("#pdesc").html("");
        $("#alert").hide();
    }
    else {
        let texto = "Ingrese sólamente números para " + desc;
        mostrarError(id);
        $("#pdesc").html(texto).css("color","red");
        $("#alert").show();
    }

    habilitarBoton(sonTodosValidos());
}

function mayus(e, id, desc) {
    e.value = e.value.toUpperCase();
    validar_texto(id, desc);
}

function mostrarError(id) {
    const elemento = document.getElementById(id);
    if (elemento) {
        elemento.classList.add("is-invalid");
        elemento.style.border = "2px solid red";
        elemento.style.setProperty('border', '2px solid #dc3545', 'important');
    }

    habilitarBoton(false);
}

function ocultarError(id) {
    const elemento = document.getElementById(id);
    if (elemento) {
        elemento.classList.remove("is-invalid");
        elemento.style.border = "1px solid #ccc";
    }
}

function habilitarBoton(habilitar) {
    //const elemento = document.querySelector(".miClase");
    //const elemento = document.querySelector('[name="correo"]');
    //const elemento = document.querySelector("input");
    //const elemento = document.querySelector('input[name="correo"]');

    const boton = document.querySelector("#btncontinuar");
    if (boton) {
        boton.disabled = !habilitar;
        boton.style.opacity = habilitar ? "1" : "0.6";
        boton.style.cursor = habilitar ? "pointer" : "not-allowed";
    }        
}

function sonTodosValidos() {
    //const campos = document.querySelectorAll("[data-validar]");
    const campos = document.querySelectorAll('.validar');
    for (let campo of campos) {
        if (campo.classList.contains("is-invalid") || campo.value.trim() === "" || (campo.tagName === "SELECT" && campo.value === "NA")) {
            return false;
        }
    }
    return true;
}

function getQueryParam(param) {
    location.search.substr(1)
    .split("&")
    .some(function(item) { // returns first occurence and stops
        return item.split("=")[0] == param && (param = item.split("=")[1])
    })
    return param
}
