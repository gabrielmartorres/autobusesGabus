<%-- 
    Document   : VistaPanelAdministracion
    Created on : 17-feb-2020, 20:46:31
    Author     : Gabriel
--%>

<%@page import="POJOS.Estacion"%>
<%@page import="POJOS.Configuracion"%>
<%@page import="POJOS.Ocupacion"%>
<%@page import="POJOS.Viajero"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        HttpSession Session = (HttpSession) request.getSession();
        ArrayList<Estacion> ListadoEstaciones = (ArrayList) session.getAttribute("ListadoEstaciones");
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
                <form name="buscadorViajes" action="../ControladorFinalizarViaje" method="POST">
                    <div class="card-body col-lg-6 offset-lg-3">
                        <div class="form-group row">
                            <label for="inputFecha" class="col-sm-4 col-form-label">Fecha del viaje:</label>
                            <div class="col-sm-8">
                                <input type="date" class="form-control" id="fecha" name="fecha" required="" onClick="borrarCampos()">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="inputOrigen" class="col-sm-4 col-form-label">Origen:</label>
                            <div class="col-sm-8">
                                <select class="form-control" id="origen" name="origen" required onChange="muestradestinos(this.value)">
                                    <option value="" selected>Selecciona un origen</option>
                                    <%for (Estacion ObjEstacion : ListadoEstaciones) {%>
                                    <option value="<%out.print(ObjEstacion.getIdEstacion());%>"><%out.print(ObjEstacion.getNombre());%></option>
                                    <%}%>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="inputDestino" class="col-sm-4 col-form-label">Destino:</label>
                            <div class="col-sm-8">
                                <select class="form-control" id="destino" name="destino" required onChange="muestrahorarios(this.value)">
                                    <option value="" selected>Selecciona un destino</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="inputHorario" class="col-sm-4 col-form-label">Hora de salida:</label>
                            <div class="col-sm-8">
                                <select class="form-control" id="horario" name="horario" required>
                                    <option value="" selected>Selecciona un horario</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <button id="botonEnviar" type="submit" class="btn btn-primary2 btn-primary btn-lg btn-block">FINALIZAR VIAJE</button>
                        </div>
                        <div id="alerta1" class="d-none alert alert-danger alert-dismissible fade show" role="alert">
                            <strong>ERROR.</strong> Viaje no encontrado.
                        </div>
                    </div>
                </form>

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



