<%-- 
    Document   : VistaPanelAdministracion
    Created on : 17-feb-2020, 20:46:31
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
        <title>Autobuses Gabus - Panel de Administración</title>
    </head>
    <body>
        <jsp:include page="menuAdministracion.jsp" />
        <header class="cabecera text-center">
            <h1>Panel de administración de Gabus</h1>
            <h2>Gestión de Viajes</h2>
        </header>
        <section class="container contenedorPrincipal">
            <div class="container">
                <div class="col-lg-12 text-center">
                    <br><br>
                    <h3>El viaje ha sido finalizado</h3>
                </div>
                <div class="offset-3 col-lg-6 text-center">
                    <button type="button" id="pagar" class="btn btn-primary2 btn-primary btn-lg btn-block" onclick="self.location.href = 'VistaPanelAdministracion.jsp'">Finalizar más viajes</button>
                </div>
            </div>
        </section>
        <jsp:include page="footer.jsp" />
        <!-- Optional JavaScript -->
        <script src="../JS/muestraDestinos.js"></script>
        <script src="../JS/muestraHorarios.js"></script>
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>
