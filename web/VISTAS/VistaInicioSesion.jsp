<%-- 
    Document   : VistaResumen
    Created on : 02-feb-2020, 23:32:31
    Author     : Gabriel
--%>

<%@page import="POJOS.Ocupacion"%>
<%@page import="POJOS.Viajero"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="CLASES.Reserva"%>




<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        String mensaje = request.getParameter("error");
    %>
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

        <title>Autobuses Gabus - Panel de Administración</title>
    </head>
    <body>
        <jsp:include page="menuAdministracionLogin.jsp" />
        <header class="cabecera text-center">
            <h1>Panel de administración de Gabus</h1>
        </header>
        <section class="container contenedorPrincipal">
            <div class="container">

                <div class="row justify-content-center align-items-center minh-100">
                    <img class="loginLogo" src="../IMG/logobus-transparente.png">
                </div>
                <div class="row justify-content-center align-items-center minh-100">
                    <form class="needs-validation" novalidate action="../ControladorIniciarSesion" method="POST">
                        <div class="form-row col-lg-12 justify-content-center align-items-center minh-100">
                            <div class="col-md-5 mb-4">
                                <label for="validationCustom01">Usuario</label>
                                <input type="text" class="form-control" id="validationCustom01" name="usuario" placeholder="Usuario" required>
                                <div class="valid-feedback">
                                    ¡Correcto!
                                </div>
                                <div class="invalid-feedback">
                                    ¡Por favor introduce un Usuario!
                                </div>
                            </div>
                            <div class="form-group col-md-5 mb-4">
                                <label for="validationCustom02">Contraseña</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="validationCustom02" name="password" placeholder="Contraseña" required>
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="basic-addon1" onclick="mostrarPassword3()"><i id="ojo2" class="fas fa-eye"></i></span>
                                    </div
                                </div>
                                <div class="valid-feedback">
                                    ¡Correcto!
                                </div>
                                <div class="invalid-feedback">
                                    ¡Por favor introduce una contraseña!
                                </div>
                            </div>
                        </div>
                        <div class="form-row col-lg-12 justify-content-center align-items-center minh-100">
                            <button class="btn btn-primary2" type="submit">Iniciar Sesión</button>
                        </div>

                    </form>
                    <%if (mensaje != null) {%>
                    <div id="alerta" class="alertaLogin alert alert-danger alert-dismissible fade show" role="alert">
                        <strong>Error al iniciar sesión.</strong> Por favor, consulte con el administrador de Gabus.
                    </div>
                    <%}%>
                </div>

            </div>
        </section>
        <jsp:include page="footer.jsp" />
        <!-- Optional JavaScript -->
        <script src="../JS/registro.js"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>



