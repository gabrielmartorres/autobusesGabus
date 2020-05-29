//Función para completar los datos de registro del viajero para ser cliente
function completarDatos(valor) {
    var checkX = document.getElementById("x");
    var checkY = document.getElementById("v");
    if (valor != "nuevo") {
        console.log(document.getElementById("nombre" + valor));
        var nombre = document.getElementById("nombre" + valor).value;
        document.getElementById("nombre").value = nombre;
        var apellidos = document.getElementById("apellidos" + valor).value;
        document.getElementById("apellidos").value = apellidos;
        var documento = document.getElementById("documento" + valor).value;
        document.getElementById("documento").value = documento;
        var documentoOculto = document.getElementById("documentoOculto" + valor).value;
        document.getElementById("inputDocumentoOculto").value = documentoOculto;

        checkY.removeAttribute("class");
        checkY.setAttribute("class", "fas fa-check");
        checkX.removeAttribute("class");
        checkX.setAttribute("class", "d-none fas fa-times");
    } else {
        document.getElementById("nombre").value = "";
        document.getElementById("apellidos").value = "";
        document.getElementById("documento").value = "";
        document.getElementById("inputDocumentoOculto").value = "";

        checkX.removeAttribute("class");
        checkX.setAttribute("class", "fas fa-times");
        checkY.removeAttribute("class");
        checkY.setAttribute("class", "d-none fas fa-check");
    }
}

//Función para diferenciar al cliente nuevo del ya registrado anteriormente.
function compruebaCliente(numTarjetas) {
    //console.log("HOLA BIENVENIDO!!!!" + numTarjetas);
    if (numTarjetas == 0) {
        var antiguoCliente = document.getElementById("antiguoCliente");
        antiguoCliente.removeAttribute("class");
        antiguoCliente.setAttribute("class", "form-group d-none");
    } else {
        var nuevoCliente = document.getElementById("nuevoCliente");
        nuevoCliente.removeAttribute("class");
        nuevoCliente.setAttribute("class", "form-group d-none");
    }

}

//Funciones para las tarjetas de crédito

function muestraTarjeta(tipo) {
    if (tipo != "") {
        var imagen = document.getElementById("imgTarjeta");
        imagen.removeAttribute("src");
        imagen.setAttribute("src", "../IMG/tarjeta-" + tipo + ".png");

        var primero = document.getElementById("primero").value = "";
        var segundo = document.getElementById("segundo").value = "";
        var tercero = document.getElementById("tercero").value = "";
        var cuarto = document.getElementById("cuarto").value = "";
        var cvv = document.getElementById("cvv").value = "";
    }

}

function validarTarjeta() {
    var primero = document.getElementById("primero").value;
    var segundo = document.getElementById("segundo").value;
    var tercero = document.getElementById("tercero").value;
    var cuarto = document.getElementById("cuarto").value;
    var tipo = document.getElementById("tipoTarjeta1").value;

    if (primero != "" && segundo != "" && tercero != "" && cuarto != "" && tipo != "") {

        var cardNumber = primero + segundo + tercero + cuarto;
        //console.log("NUMERO: " + cardNumber);

        var mensaje = validator(cardNumber);
        var imagen = document.getElementById("imgTarjeta");
        imagen.removeAttribute("src");
        imagen.setAttribute("src", "../IMG/tarjeta-" + mensaje + ".png");
        //        console.log("Tarjeta " + document.getElementById("tipoTarjeta1").value);

        var inputTipo = document.getElementById("tipoTarjetaN2");
        inputTipo.setAttribute("value", mensaje);
        //console.log("MENSAJE: " + mensaje);
        if (mensaje == undefined) {
            //console.log("ERROR: " + mensaje);
            var alerta = document.getElementById("alerta");
            alerta.removeAttribute("class");
            alerta.setAttribute("class", "alert alert-danger alert-dismissible fade show");
            var alerta2 = document.getElementById("alerta2");
            alerta2.removeAttribute("class");
            alerta2.setAttribute("class", "d-none alert alert-danger alert-dismissible fade show");
            var alerta3 = document.getElementById("alerta2a");
            alerta3.removeAttribute("class");
            alerta3.setAttribute("class", "d-none alert alert-danger alert-dismissible fade show");
        } else {
            //console.log("MENSAJE: " + mensaje);
            var tipoSelc = document.getElementById("tipoTarjeta1").value;
            if (mensaje == tipoSelc) {
                //                console.log("BIEN");
                boton = document.getElementById("pagar");
                boton.removeAttribute("type");
                boton.removeAttribute("onclick");
                boton.setAttribute("type", "submit");
            } else {
                var alerta = document.getElementById("alerta2a");
                alerta.removeAttribute("class");
                alerta.setAttribute("class", "alert alert-danger alert-dismissible fade show");
                var alerta2 = document.getElementById("alerta");
                alerta2.removeAttribute("class");
                alerta2.setAttribute("class", "d-none alert alert-danger alert-dismissible fade show");
                var alerta3 = document.getElementById("alerta2");
                alerta2.removeAttribute("class");
                alerta2.setAttribute("class", "d-none alert alert-danger alert-dismissible fade show");
            }



        }
    } else {
        //console.log("campos vacios");
        var alerta2 = document.getElementById("alerta2");
        alerta2.removeAttribute("class");
        alerta2.setAttribute("class", "alert alert-danger alert-dismissible fade show");
        var alerta = document.getElementById("alerta");
        alerta.removeAttribute("class");
        alerta.setAttribute("class", "d-none alert alert-danger alert-dismissible fade show");
        var alerta3 = document.getElementById("alerta2a");
        alerta.removeAttribute("class");
        alerta.setAttribute("class", "d-none alert alert-danger alert-dismissible fade show");
    }

}

function validator(cardNumber) {
    const cardArray = cardNumber.toString().split("").map((e) => parseInt(e))
    validlen(cardArray);
    const splitArr = arrSplit(cardArray)
    const checksum = sumArrDigits(splitArr.arr1).reduce((a, c) => a + c) + splitArr.arr2.reduce((a, c) => a + c);

    if (checksum % 10 == 0) {

        const typeValidatorArr = cardArray.slice(0, 2)
        const typeValidatorInt = parseInt(typeValidatorArr.join(""))

        if (typeValidatorArr[0] == 4) {
            //console.log("VISA");
            return "visa"
        } else if (typeValidatorInt == 34 || typeValidatorInt == 37) {
            //console.log("AMERICAN");
            return "american";
        } else if (typeValidatorInt == 22 || typeValidatorInt == 51 || typeValidatorInt == 52 || typeValidatorInt == 53 || typeValidatorInt == 54) {
            return "mastercard";
        } else if (typeValidatorInt == 35) {
            return "jcb";
        } else if (typeValidatorInt == 60) {
            return "discover";
        } else if (typeValidatorInt == 30) {
            return "diners";
        }
    }
}


function sumArrDigits(array) {
    return array.join("").split("").map(e => parseInt(e))
}

function validlen(arr) {
    // checks for card length of 13, 15, or 16
    return arr.length == 13 || arr.length == 15 || arr.length == 16
}

function arrSplit(cardArray) {
    const selectOddValues = cardArray.filter((a, i) => i % 2 === 1);
    const selectEvenValues = cardArray.filter((a, i) => i % 2 === 0);
    let arr1;
    let arr2;
    if (cardArray.length % 2 == 1) {
        arr1 = selectOddValues.map(e => e * 2);
        arr2 = selectEvenValues;
    } else {
        arr1 = selectEvenValues.map(e => e * 2);
        arr2 = selectOddValues;
    }
    return { arr1, arr2 }
}

//completa los datos de la tarjeta del cliente registrado
function rellenarTarjeta(idTarjeta, numero) {
    if (idTarjeta != "") {

        //var selectTarjetas = document.getElementById("tipoTarjetaRegistrada").value;
        //console.log("SELECT: " + idTarjeta);

        var seleccionada = numero[numero.selectedIndex].text;
        //RECOGER LOS VALORES DE LOS 4 INPUT

        var numerotarjeta = seleccionada.replace(/[*]/gi, ''); //quito los * del número.

        var primero = document.getElementById("numTarjetaRegistrada1").value = "****";
        var segundo = document.getElementById("numTarjetaRegistrada2").value = "****";
        var tercero = document.getElementById("numTarjetaRegistrada3").value = "****";
        var cuarto = document.getElementById("numTarjetaRegistrada4").value = numerotarjeta;
        var cvv = document.getElementById("cvv").value = "";
    }

}

//Función para mostrar el cargar para pasar de tarjetas a nueva tarjeta
function mostrarRegistroTarjeta() {
    var spinner = document.getElementById("spinner");
    spinner.removeAttribute("class");
    spinner.setAttribute("class", "spinner-border float-right");
    setTimeout('cambiarFormTarjeta()', 1000);
}

function cambiarFormTarjeta() {
    var antiguoCliente = document.getElementById("antiguoCliente");
    antiguoCliente.removeAttribute("class");
    antiguoCliente.setAttribute("class", "form-group d-none");
    var nuevoCliente = document.getElementById("nuevoCliente");
    nuevoCliente.removeAttribute("class");
    nuevoCliente.setAttribute("class", "form-group");
}



//Funcion para elegir el tipo de documento
function seleccionaDocumento(tipoDocumento, numViajero) {
    //console.log("tipoDocumento " + tipoDocumento);
    //console.log("numViajero " + numViajero);
    var numDocumento = document.getElementById("documento" + numViajero);
    if (tipoDocumento == "nif") {
        numDocumento.setAttribute("pattern", "[0-9]{8}[A-Za-z]{1}");
    } else {
        numDocumento.setAttribute("pattern", "[A-Za-z]{1}[0-9]{7}[A-Za-z]{1}");
    }
}

function compruebaDocumento2(numViajero) {
    var inputDocumento = document.getElementById("documento" + numViajero);
    //console.log("num: " + inputDocumento.value.length);
    var checkX = document.getElementById("x" + numViajero);
    var checkY = document.getElementById("v" + numViajero);

    checkX.removeAttribute("class");
    checkX.setAttribute("class", "fas fa-times");
    if (inputDocumento.value.length == 0) {
        checkX.removeAttribute("class");
        checkX.setAttribute("class", "d-none fas fa-times");
        checkY.removeAttribute("class");
        checkY.setAttribute("class", "d-none fas fa-check");
    }

    if (inputDocumento.value.length == 8 || inputDocumento.value.length == 9) {
        //console.log("CONSEGUIDO!!" + inputDocumento.value);
        var dni = inputDocumento.value;
        var numero;
        var letr;
        var letra;
        var expresion_regular_dni = /^[XYZ]?\d{5,8}[A-Z]$/;

        if (expresion_regular_dni.test(dni) == true) {
            numero = dni.substr(0, dni.length - 1);
            letr = dni.substr(dni.length - 1, 1);
            numero = numero % 23;
            letra = 'TRWAGMYFPDXBNJZSQVHLCKET';
            letra = letra.substring(numero, numero + 1);
            //console.log("a ver");
            if (letra != letr.toUpperCase()) {
                //ERROR DNI
                //console.log("MAL!!");
                var alerta = document.getElementById("alerta" + numViajero);
                alerta.removeAttribute("class");
                alerta.setAttribute("class", "alert alert-danger alert-dismissible fade show");
                //inputDocumento.focus();

                checkX.removeAttribute("class");
                checkX.setAttribute("class", "fas fa-times");
                checkY.removeAttribute("class");
                checkY.setAttribute("class", "d-none fas fa-check");

            } else {
                //CORRECTO DNI
                //console.log("BIEN!!");
                var alerta = document.getElementById("alerta" + numViajero);
                alerta.removeAttribute("class");
                alerta.setAttribute("class", "d-none alert alert-danger alert-dismissible fade show");

                checkY.removeAttribute("class");
                checkY.setAttribute("class", "fas fa-check");
                checkX.removeAttribute("class");
                checkX.setAttribute("class", "d-none fas fa-times");
            }
        } else {
            //alert('Dni erroneo, formato no válido');
            //console.log("EMM aun no");
            checkX.removeAttribute("class");
            checkX.setAttribute("class", "fas fa-times");
            checkY.removeAttribute("class");
            checkY.setAttribute("class", "d-none fas fa-check");
        }
    }
}

function compruebaDocumento(numViajero) {
    //http://www.yporqueno.es/blog/javascript-validar-dni
    var inputDocumento = document.getElementById("documento" + numViajero);
    var checkX = document.getElementById("x" + numViajero);
    var checkY = document.getElementById("v" + numViajero);
    var dniOculto = document.getElementById("inputDocumentoOculto" + numViajero);
    checkX.removeAttribute("class");
    checkX.setAttribute("class", "fas fa-times");
    if (inputDocumento.value.length == 0) {
        checkX.removeAttribute("class");
        checkX.setAttribute("class", "d-none fas fa-times");
        checkY.removeAttribute("class");
        checkY.setAttribute("class", "d-none fas fa-check");
    }

    var numero,
        let, letra;
    var expresion_regular_dni = /^[XYZ]?\d{5,8}[A-Z]$/;
    dni = inputDocumento = document.getElementById("documento" + numViajero).value;
    dni = dni.toUpperCase();

    if (expresion_regular_dni.test(dni) === true) {
        numero = dni.substr(0, dni.length - 1);
        numero = numero.replace('X', 0);
        numero = numero.replace('Y', 1);
        numero = numero.replace('Z', 2);
        let = dni.substr(dni.length - 1, 1);
        numero = numero % 23;
        letra = 'TRWAGMYFPDXBNJZSQVHLCKET';
        letra = letra.substring(numero, numero + 1);
        if (letra !=
            let) {
            var alerta = document.getElementById("alerta" + numViajero);
            alerta.removeAttribute("class");
            alerta.setAttribute("class", "alert alert-danger alert-dismissible fade show");
            //inputDocumento.focus();

            checkX.removeAttribute("class");
            checkX.setAttribute("class", "fas fa-times");
            checkY.removeAttribute("class");
            checkY.setAttribute("class", "d-none fas fa-check");

            dniOculto.value = "";
        } else {
            var alerta = document.getElementById("alerta" + numViajero);
            alerta.removeAttribute("class");
            alerta.setAttribute("class", "d-none alert alert-danger alert-dismissible fade show");

            checkY.removeAttribute("class");
            checkY.setAttribute("class", "fas fa-check");
            checkX.removeAttribute("class");
            checkX.setAttribute("class", "d-none fas fa-times");

            dniOculto.value = dni;
        }
    } else {
        checkX.removeAttribute("class");
        checkX.setAttribute("class", "fas fa-times");
        checkY.removeAttribute("class");
        checkY.setAttribute("class", "d-none fas fa-check");

        dniOculto.value = "";
    }
}

//Compruebo los campos del formulario para que no estén vacios. datos del viajero y dni en la vista asientos.
function comprobarCampos() {

    compruebaAsiento();
    var numTotalAsientos = document.getElementById("numViajeros").value;

    //Compruebo que los datos del viajero están vacios o no para mostrar el error
    for (var i = 1; i <= numTotalAsientos; i++) {
        var nombre = document.getElementById("nombre" + i).value;
        var apellidos = document.getElementById("apellidos" + i).value;
        var dni = document.getElementById("inputDocumentoOculto" + i).value;
        if (nombre == "" || apellidos == "" || dni == "") {
            var alerta = document.getElementById("alertaGeneral2");
            alerta.removeAttribute("class");
            alerta.setAttribute("class", "alert alert-danger alert-dismissible fade show");
            i = numTotalAsientos + 1;
        } else {
            var alerta = document.getElementById("alertaGeneral2");
            alerta.removeAttribute("class");
            alerta.setAttribute("class", "d-none alert alert-danger alert-dismissible fade show");
        }
    }

    //Compruebo que no haya ningun dni vacio
    var enviarD = true;
    for (var i = 1; i <= numTotalAsientos; i++) {
        var dni = document.getElementById("inputDocumentoOculto" + i).value;
        if (dni == "") {
            enviarD = false;
        }
    }

    //Compruebo que no haya ningun asiento vacio
    var enviarA = true;
    for (var i = 1; i <= numTotalAsientos; i++) {
        var numAsiento = document.getElementById("asiento" + i).innerHTML;
        if (numAsiento == "-") {
            enviarA = false;
        }
    }

    //Compruebo que no haya ningun dni repetido
    var enviarR = true;
    for (var i = 1; i <= numTotalAsientos; i++) {
        var dni = document.getElementById("inputDocumentoOculto" + i).value;
        //console.log(dni);
        for (var j = i + 1; j <= numTotalAsientos; j++) {
            var dniComprobado = document.getElementById("inputDocumentoOculto" + j).value;
            //console.log(dniComprobado);
            if (dni == dniComprobado) {
                var dniRojo = document.getElementById("documento" + j);
                dniRojo.removeAttribute("class");
                dniRojo.setAttribute("class", "form-control rojo");
                enviarR = false;
                //console.log("en rojo!!");
            }
        }
    }

    if (enviarR == true) {
        var alerta = document.getElementById("alertaGeneral3");
        alerta.removeAttribute("class");
        alerta.setAttribute("class", "d-none alert alert-danger alert-dismissible fade show");
    } else {
        var alerta = document.getElementById("alertaGeneral3");
        alerta.removeAttribute("class");
        alerta.setAttribute("class", "alert alert-danger alert-dismissible fade show");
    }

    //Compruebo que no haya asientos y datos vacios para enviar el formulario
    if (enviarA == true && enviarD == true && enviarR == true) {
        boton = document.getElementById("botonEnviar");
        boton.removeAttribute("type");
        boton.setAttribute("type", "submit");
    }

}

//Compruebo que los asientos estén seleccionados o no para mostrar el error. vista asientos.
function compruebaAsiento() {

    var numTotalAsientos = document.getElementById("numViajeros").value;
    for (var i = 1; i <= numTotalAsientos; i++) {
        var numAsiento = document.getElementById("asiento" + i).innerHTML;
        if (numAsiento == "-") {
            var alerta = document.getElementById("alertaGeneral");
            alerta.removeAttribute("class");
            alerta.setAttribute("class", "alert alert-danger alert-dismissible fade show");
            i = numTotalAsientos + 1;
        } else {
            console.log("oculta");
            var alerta = document.getElementById("alertaGeneral");
            alerta.removeAttribute("class");
            alerta.setAttribute("class", "d-none alert alert-danger alert-dismissible fade show");
        }
    }
}

//Funcion para elegir el tipo de documento en la vista registro
function seleccionaDocumentoR(tipoDocumento) {
    var numDocumento = document.getElementById("documento");
    if (tipoDocumento == "nif") {
        numDocumento.setAttribute("pattern", "[0-9]{8}[A-Za-z]{1}");
    } else {
        numDocumento.setAttribute("pattern", "[A-Za-z]{1}[0-9]{7}[A-Za-z]{1}");
    }
}


function compruebaDocumentoR() {
    //http://www.yporqueno.es/blog/javascript-validar-dni
    var inputDocumento = document.getElementById("documento");
    var checkX = document.getElementById("x");
    var checkY = document.getElementById("v");
    var dniOculto = document.getElementById("inputDocumentoOculto");
    var alerta = document.getElementById("alerta");
    checkX.removeAttribute("class");
    checkX.setAttribute("class", "fas fa-times");
    if (inputDocumento.value.length == 0) {
        checkX.removeAttribute("class");
        checkX.setAttribute("class", "d-none fas fa-times");
        checkY.removeAttribute("class");
        checkY.setAttribute("class", "d-none fas fa-check");
        alerta.removeAttribute("class");
        alerta.setAttribute("class", "d-none alert alert-danger alert-dismissible fade show");
    }
    var numero,
        let, letra;
    var expresion_regular_dni = /^[XYZ]?\d{5,8}[A-Z]$/;
    dni = inputDocumento = document.getElementById("documento").value;
    dni = dni.toUpperCase();

    if (expresion_regular_dni.test(dni) === true) {
        numero = dni.substr(0, dni.length - 1);
        numero = numero.replace('X', 0);
        numero = numero.replace('Y', 1);
        numero = numero.replace('Z', 2);
        let = dni.substr(dni.length - 1, 1);
        numero = numero % 23;
        letra = 'TRWAGMYFPDXBNJZSQVHLCKET';
        letra = letra.substring(numero, numero + 1);
        if (letra !=
            let) {
            alerta.removeAttribute("class");
            alerta.setAttribute("class", "alert alert-danger alert-dismissible fade show");
            //inputDocumento.focus();

            checkX.removeAttribute("class");
            checkX.setAttribute("class", "fas fa-times");
            checkY.removeAttribute("class");
            checkY.setAttribute("class", "d-none fas fa-check");

            dniOculto.value = "";
        } else {
            alerta.removeAttribute("class");
            alerta.setAttribute("class", "d-none alert alert-danger alert-dismissible fade show");

            checkY.removeAttribute("class");
            checkY.setAttribute("class", "fas fa-check");
            checkX.removeAttribute("class");
            checkX.setAttribute("class", "d-none fas fa-times");

            dniOculto.value = dni;
        }
    } else {
        checkX.removeAttribute("class");
        checkX.setAttribute("class", "fas fa-times");
        checkY.removeAttribute("class");
        checkY.setAttribute("class", "d-none fas fa-check");

        dniOculto.value = "";
    }
}

//Compruebo los campos del formulario de registro para que no estén vacios. .
function comprobarCamposR() {

    //Compruebo que no haya ningun dni oculto vacio
    var enviarD = true;
    var dni = document.getElementById("inputDocumentoOculto").value;
    if (dni == "") {
        enviarD = false;
        var alerta = document.getElementById("alerta");
        alerta.removeAttribute("class");
        alerta.setAttribute("class", "alert alert-danger alert-dismissible fade show");
    }

    //Compruebo que el dni oculto no está vacío para enviar el formulario
    if (enviarD == true) {
        boton = document.getElementById("botonEnviar");
        boton.removeAttribute("type");
        boton.setAttribute("type", "submit");
    }

}

function mostrarPassword() {
    var tipo = document.getElementById("InicioSesionPassword");
    var ojo = document.getElementById("ojo");
    if (tipo.type == "password") {
        tipo.type = "text";
        ojo.removeAttribute("class");
        ojo.setAttribute("class", "fas fa-eye-slash");
    } else {
        tipo.type = "password";
        ojo.removeAttribute("class");
        ojo.setAttribute("class", "fas fa-eye");
    }
}

function mostrarPassword2() {
    var tipo = document.getElementById("password");
    var ojo = document.getElementById("ojo2");
    if (tipo.type == "password") {
        tipo.type = "text";
        ojo.removeAttribute("class");
        ojo.setAttribute("class", "fas fa-eye-slash");
    } else {
        tipo.type = "password";
        ojo.removeAttribute("class");
        ojo.setAttribute("class", "fas fa-eye");
    }
}

function mostrarPassword3() {
    var tipo = document.getElementById("validationCustom02");
    var ojo = document.getElementById("ojo2");
    if (tipo.type == "password") {
        tipo.type = "text";
        ojo.removeAttribute("class");
        ojo.setAttribute("class", "fas fa-eye-slash");
    } else {
        tipo.type = "password";
        ojo.removeAttribute("class");
        ojo.setAttribute("class", "fas fa-eye");
    }
}