function muestrahorarios(str) {
    var xmlhttp;
    if (str === "") {
        document.getElementById("horario").innerHTML = "";
        return;
    }
    if (window.XMLHttpRequest) {
    //code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    } else {
    // code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
            document.getElementById("horario").innerHTML = xmlhttp.responseText;
        }
    };
    var fecha = document.getElementById("fecha").value;
    var origen = document.getElementById("origen").value;
    
    xmlhttp.open("GET", "/Autobuses/servlet_ajaxHorario?destino=" + str+"&origen="+origen+"&fecha="+fecha, true);
    xmlhttp.send();
}
// muestraDestinos


