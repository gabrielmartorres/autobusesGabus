function borrarCampos(){
    document.getElementById("origen").value="";
    document.getElementById("destino").value="";
    document.getElementById("horario").value="";
}

function muestradestinos(str) {
    var xmlhttp;
    if (str === "") {
        document.getElementById("destino").innerHTML = "";
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
            document.getElementById("destino").innerHTML = xmlhttp.responseText;
        }
    };
    xmlhttp.open("GET", "/Autobuses/servlet_ajaxDestino?origen=" + str, true);
    xmlhttp.send();
}
// muestraDestinos


