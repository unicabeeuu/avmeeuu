function VerDatosCargados() {
    $("#datosCargdos").html("");
    let documento = $("#txtidentif1").val();

    fetch("https://unicab.org/avadmisiones/av_validar_documento.php", {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ documento: documento })
    })
    .then(r => r.json()) // ← Texto → Objeto
    .then(data => {
        console.log(data);                        
        if (data.status == "success") {
            let html = "";
            let rh = data.rh;
            rh = rh.replace("mas", "+");
            rh = rh.replace("menos", "-");
            html += "Año matrícula: <strong>" + data.año_matricula + "</strong><br>";                
            html += "Nombre estudiante: <strong>" + data.nombres + " " + data.apellidos + "</strong><br>";
            html += "Grado a matricular: <strong>" + data.grado_matricular + "</strong><br>";
            html += "Teléfono estudiante: <strong>" + data.tel + "</strong><br>";
            html += "Email estudiante: <strong>" + data.email + "</strong><br>";
            html += "Tipo documento estudiante: <strong>" + data.tdoc + "</strong><br>";
            html += "RH estudiante: <strong>" + rh + "</strong><br>";
            html += "Género estudiante: <strong>" + data.genero + "</strong><br>";
            html += "Actividad extra: <strong>" + data.actividad_extra + "</strong><br>";
            html += "Situación socio-económica estudiante: <strong>" + data.situacion_se + "</strong><br><hr><br>";
            html += "Acudiente: <strong>" + data.acudiente + "</strong><br>";
            html += "Email acudiente: <strong>" + data.emailA + "</strong><br>";
            html += "Teléfono acudiente: <strong>" + data.telA + "</strong><br>";
            html += "Documento acudiente: <strong>" + data.documento_responsable + "</strong><br>";
            html += "Dirección acudiente: <strong>" + data.direccion + "</strong><br>";
            html += "Parentesco acudiente: <strong>" + data.parentesco_acudiente_1 + "</strong><br>";
            
            $("#datosCargdos").html(html);
        } else {
            //agregarMensaje("Unibot", contenido.mensaje_error);
        }
    })
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
