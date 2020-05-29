<%-- 
    Document   : VistaErrores
    Created on : 08-mar-2020, 12:52:22
    Author     : Gabriel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Required meta tags -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="../CSS/style.css">

        <!-- Fuentes -->
        <!-- Para títulos-->
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,400i,500,700,900&display=swap" rel="stylesheet">
        <!-- Para texto-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet"> 


        <!-- Iconos -->
        <link href="/your-path-to-fontawesome/css/all.css" rel="stylesheet">
        <title>Autobuses Gabus - Detalles de la ruta</title>
    </head>
    <body>
        <jsp:include page="menuPrincipal.jsp" />
        <header class="cabecera text-center">
            <h1>Ha ocurrido un error</h1>
        </header>
        <section class="container contenedorPrincipal">
            <div class="container">
                <div class="row">
                    <div class="offset-3 col-lg-6">
                        <img src="../IMG/error.jpg">
                    </div>
                </div>
                <div class="row">
                    <div class="offset-1 col-lg-10 botonera">
                        <button type="button" class="btn btn-primary2 btn-primary btn-lg btn-block" onclick="self.location.href = '../ControladorCargarEstacion'">VOLVER AL INICIO</button>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>
