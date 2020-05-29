window.onload = function() {
    cargarAsientos();
}

var spanNumAsientosTotalGlobal = document.getElementById("numTotalAsientos").innerHTML; //guardo el numero de asientos totales.

function cargarAsientos() {
    var asientosOcupados = document.getElementById("numerosDeAsientos").value;
    console.log("1: " + asientosOcupados);
    for (var i = 0; i < asientosOcupados.length; i = i + 2) {
        var fila = document.getElementById(asientosOcupados[i]);
        console.log("emm: " + asientosOcupados[i]);
        fila.removeAttribute("class");
        fila.removeAttribute("onclick");
        fila.setAttribute("class", "asientoOcupado");
    }
}

function seleccionarAsiento(numero) {
    //console.log(numero);
    //pongo el asiento seleccionado
    var asientosSeleccionado = document.getElementById(numero);
    asientosSeleccionado.removeAttribute("class");
    asientosSeleccionado.setAttribute("class", "asientoElegido");
    asientosSeleccionado.removeAttribute("onclick");
    asientosSeleccionado.setAttribute("onclick", "quitarAsientoSelecion(" + numero + ")");
    //obtengo el número de asientos y le resto uno.
    var spanNumAsientosTotal = document.getElementById("numTotalAsientos").innerHTML; //guardo el numero de asientos totales.
    var spanNumAsientos = document.getElementById("numTotalAsientos").innerHTML;
    var numAsientosRestar = parseInt(spanNumAsientos);
    numAsientosRestar--;
    //console.log("A VER: " + numAsientosRestar);
    //le añado el nuevo valor al número de asientos que falta por seleccionar.
    var span = document.getElementById("numTotalAsientos");
    span.removeChild(span.firstChild);
    var textoSpan = document.createTextNode(numAsientosRestar);
    span.appendChild(textoSpan);
    //quito el onclik cuando se hayan seleccionado el número de asientos para los viajeros.
    if (numAsientosRestar == 0) {
        //console.log(document.getElementsByClassName('asiento'));
        var NumAsientosLibres = document.getElementsByClassName('asiento').length;
        var asientosLibres = document.getElementsByClassName('asiento');
        for (var i = 0; i < NumAsientosLibres; i++) {
            asientosLibres[i].removeAttribute("onclick");
        }

    }

    //muestro el asiento que el viajero ha elegido.
    if (document.getElementById("asiento" + spanNumAsientosTotal).innerHTML == "-") {
        console.log(spanNumAsientosTotal);
        var spanViajero = document.getElementById("asiento" + spanNumAsientosTotal);
        console.log(spanViajero);
        spanViajero.removeChild(spanViajero.firstChild);
        var textoSpanViajero = document.createTextNode(numero);
        spanViajero.appendChild(textoSpanViajero);
        document.getElementById("numeroAsientoH" + spanNumAsientosTotal).value = numero;
    } else {
        console.log("hola " + spanNumAsientosTotalGlobal);
        for (var i = 1; i <= spanNumAsientosTotalGlobal; i++) {
            console.log("EEM: " + document.getElementById("asiento" + i).innerHTML);
            if (document.getElementById("asiento" + i).innerHTML == "-") {
                var spanViajero = document.getElementById("asiento" + i);
                console.log(spanViajero);
                spanViajero.removeChild(spanViajero.firstChild);
                var textoSpanViajero = document.createTextNode(numero);
                spanViajero.appendChild(textoSpanViajero);
                //Al añadir un asiento a un viajero se sale del for para que no añada el número del asiento también a los demás.
                i = spanNumAsientosTotalGlobal + 1;
            }
        }

    }

}

function quitarAsientoSelecion(numero) {
    var asientosSeleccionado = document.getElementById(numero);
    asientosSeleccionado.removeAttribute("class");
    asientosSeleccionado.setAttribute("class", "asiento");
    asientosSeleccionado.removeAttribute("onclick");
    asientosSeleccionado.setAttribute("onclick", "seleccionarAsiento(" + numero + ")");

    //obtengo el número de asientos y le resto uno.
    var spanNumAsientos = document.getElementById("numTotalAsientos").innerHTML;
    var numAsientosSumar = parseInt(spanNumAsientos);
    numAsientosSumar++;
    //console.log("A VER: " + numAsientosSumar);
    //le añado el nuevo valor al número de asientos que falta por seleccionar.
    var span = document.getElementById("numTotalAsientos");
    span.removeChild(span.firstChild);
    var textoSpan = document.createTextNode(numAsientosSumar);
    span.appendChild(textoSpan);

    //Añado el onclik para que se puedan seleccionar asientos.
    if (numAsientosSumar == 1) {
        var NumAsientosLibres = document.getElementsByClassName('asiento').length;
        var asientosLibres = document.getElementsByClassName('asiento');
        for (var i = 0; i < NumAsientosLibres; i++) {
            asientosLibres[i].setAttribute("onclick", "seleccionarAsiento(" + asientosLibres[i].innerHTML + ")");
        }
    }

    //quito el numero de asiento del viajero
    var clases = document.getElementsByClassName('numeroAsiento').length;
    //var clasesA = document.getElementsByClassName('numeroAsiento');
    for (var i = 1; i <= clases; i++) {
        var spanViajero = document.getElementById("asiento" + i);
        if (spanViajero.innerHTML == numero) {
            /* console.log(numero);
            console.log(document.getElementById("asiento" + i));
 */
            var spanNuevo = document.getElementById("asiento" + i);
            spanNuevo.removeChild(spanNuevo.firstChild);
            var textospanNuevo = document.createTextNode("-");
            spanNuevo.appendChild(textospanNuevo);

        }
    }






}