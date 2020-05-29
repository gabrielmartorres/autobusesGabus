<%-- 
    Document   : VistaDetallesRutas
    Created on : 26-ene-2020, 1:39:12
    Author     : Gabriel
--%>

<%@page import="org.hibernate.Hibernate"%>
<%@page import="java.time.LocalDate"%>
<%@page import="POJOS.Viaje"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="POJOS.Horario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="CLASES.Reserva"%>
<%@page import="POJOS.Ruta"%>
<%@page import="POJOS.Estacion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        HttpSession Session = (HttpSession) request.getSession();
        Reserva ObjReserva = (Reserva) session.getAttribute("ObjReserva");
        
        Iterator IterHorarios = ObjReserva.getObjRuta().getHorarios().iterator();
        Boolean conViaje = false;
        int contador = 0; //Para indicar si hay billetes o no
        Boolean plazas = true; //Para indicar si quedan plazas en el autobús
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
        <title>Autobuses Gabus - Detalles de la ruta</title>
    </head>
    <body>
    <jsp:include page="menuPrincipal.jsp" />
    <header class="cabecera text-center">
        <h1>Detalles de la ruta <%out.print(ObjReserva.getObjRuta().getComentario());%></h1>
        <h2>Selecciona un horario para la ruta</h2>
    </header>
    <section class="container contenedorPrincipal">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">

                    <div class="progress" style="height: 1px;">
                        <div class="progress-bar" role="progressbar" style="width: 40%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                    <p class="progreso">Listado de horarios</p>
                    <div class="progress" style="height: 20px;">
                        <div class="progress-bar" role="progressbar" style="width: 40%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3"></div>
                <div class="col-lg-6">
                    <%while (IterHorarios.hasNext()) {
                        conViaje = false;
                        Horario ObjHorario = (Horario) IterHorarios.next();
                        Iterator IterViajes = ObjHorario.getViajes().iterator();
                        while (IterViajes.hasNext()) {
                            Viaje ObjViaje = (Viaje) IterViajes.next();
                            Date Fecha = ObjViaje.getFecha();
                            if (Fecha.equals(ObjReserva.getFechaViaje()) && ObjReserva.getNumeroViajeros() <= ObjViaje.getPlazasLibres()) {
                                conViaje = true;
                                contador++;
                    %>
                                <form name="buscadorViajes" action="../ControladorCargaReserva" method="POST">
                                    <div class="form-row">
                                        <div class="col">
                                            <div class="card mb-3" style="max-width: 540px;">
                                                <div class="row no-gutters">
                                                    <div class="col-md-4">
                                                        <div class="card-body">
                                                            <h5>Hora de salida:<br><br><%out.print(ObjHorario.getHoraSalida());%></h5>
                                                            <br><br><br><br>
                                                            <%if (ObjHorario.getTipoDia().equals("semana")) {%>
                                                                <h6>L - V</h6>
                                                            <%} else {%>
                                                                <h6>SÁBADO</h6>
                                                            <%}%>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-8">
                                                        <div class="card-body">
                                                            <h5 class="card-title"><%out.print(ObjReserva.getObjRuta().getComentario());%></h5>
                                                                <%
                                                                    Date duracion = ObjReserva.getObjRuta().getDuracion();
                                                                    // En esta linea de código estamos indicando el nuevo formato que queremos para nuestra fecha.
                                                                    SimpleDateFormat formatter = new SimpleDateFormat("HH:mm");
                                                                    // Aqui usamos la instancia formatter para darle el formato a la fecha. Es importante ver que el resultado es un string.
                                                                    String duracionTexto = formatter.format(duracion);
                                                                    //calculo la hora estimada de la llegada del autobus.
                                                                    Calendar calendar = Calendar.getInstance();
                                                                    Date fecha = ObjHorario.getHoraSalida();
                                                                    calendar.setTime(fecha); // Configuramos la fecha que se recibe
                                                                    //Extraigo los minutos de la duración del viaje
                                                                    SimpleDateFormat minutos = new SimpleDateFormat("mm"); //Guardos los minutos.
                                                                    String duracionMinutos = minutos.format(duracion);
                                                                    int duracionMin = Integer.parseInt(duracionMinutos);
                                                                    calendar.add(Calendar.MINUTE, duracionMin); // numero de horas a añadir, o restar en caso de horas<0
                                                                    calendar.getTime(); //Contiene la hora sumada.
                                                                    //Le doy el formato a la hora.
                                                                    Date HoraLLegada = calendar.getTime();
                                                                    SimpleDateFormat formatter2 = new SimpleDateFormat("HH:mm");
                                                                    String horaLLegada = formatter.format(HoraLLegada);
                                                                %>

                                                                <p class="card-text">Hora de llegada: <%out.print(horaLLegada);%> horas.</p>
                                                                <p class="card-text">Duración del viaje: <%out.print(duracionTexto);%> minutos.</p>
                                                                <p class="card-text">Distancia: <%out.print(ObjReserva.getObjRuta().getDistancia());%> km.</p>
                                                                <p class="card-text">Plazas disponibles: <%out.print(ObjViaje.getPlazasLibres());%>.</p>
                                                                <p class="card-text"><small class="text-muted">Fecha <%out.print(ObjReserva.dimeFecha(ObjReserva.getFechaViaje()));%></small></p>
                                                                <button type="submit" class="btn btn-primary2">ELEGIR</button>
                                                                <h3 class="precio"><%out.print(ObjReserva.getObjRuta().getPrecio());%>€</h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <input type="hidden" name="horaSalida" value="<%out.print(ObjHorario.getHoraSalida());%>"> 
                                    <input type="hidden" name="idHorario" value="<%out.print(ObjHorario.getIdHorario());%>">
                                    <input type="hidden" name="idViaje" value="<%out.print(ObjViaje.getIdViaje());%>"> 
                                    <input type="hidden" name="idRuta" value="<%out.print(ObjHorario.getRuta().getIdRuta());%>"> 
                                    <input type="hidden" name="tipoDia" value="<%out.print(ObjHorario.getTipoDia());%>"> 
                                    <input type="hidden" name="numViajeros" value="<%out.print(ObjReserva.getNumeroViajeros());%>">
                                </form>
                            <%}//if linea 80
                            else{
                                if(Fecha.equals(ObjReserva.getFechaViaje()) && ObjReserva.getNumeroViajeros() > ObjViaje.getPlazasLibres()){
                                    plazas = false;
                                }
                            }
                            
                            %>
                        <%}//while linea 77%> 
                    <%}//while linea 73%> 
                    <%if (conViaje == false && contador==0) {%>
                    <div class="form-row">
                        <div class="col">
                            <div class="card mb-3" style="max-width: 540px;">
                                <div class="row no-gutters">
                                    <div class="col-md-12">
                                        <div class="card-body text-center">
                                            <%if(plazas == true){%>
                                                <h5>No hay billetes para la fecha: <%out.print(ObjReserva.dimeFecha(ObjReserva.getFechaViaje()));%></h5>
                                            <%}else{%>
                                                <h5>No hay suficiente plazas el día <%out.print(ObjReserva.dimeFecha(ObjReserva.getFechaViaje()));%></h5>
                                            <%}%>
                                            
                                            <a href="../ControladorCargarEstacion" class="btn btn-primary2" role="button">Volver atrás</a>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                        </div>
                    </div>
                    <%
                    }             
                    %>                        
                    
                </div>
                <div class="col-lg-3"></div>
            </div>
        </div>


    </section>
    <jsp:include page="footer.jsp" />
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>
