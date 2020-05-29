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
        HttpSession Session = (HttpSession) request.getSession();
        Reserva ObjReserva = (Reserva) session.getAttribute("ObjReserva");
        ArrayList asientosOcupados = (ArrayList) session.getAttribute("asientosOcupados");
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
        <title>Autobuses Gabus - Billetes</title>
    </head>
    <body>
        <input type="hidden" id="numViajeros" value="<%out.print(ObjReserva.getNumeroViajeros());%>">
        <jsp:include page="menuPrincipal.jsp" />
        <header class="cabecera text-center">
            <h1>Detalles de la ruta <%out.print(ObjReserva.getObjRuta().getComentario());%></h1>
            <h2>Compra Finalizada</h2>
        </header>
        <section class="container contenedorPrincipal">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">

                        <div class="progress" style="height: 1px;">
                            <div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                        <p class="progreso">Compra finalizada</p>
                        <div class="progress" style="height: 20px;">
                            <div class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <h3 class="text-center">Billetes</h3>
                    </div>
                    <%

                        int contadorViajeros = 1;
                        Iterator IterViajeros = ObjReserva.getViajeros().iterator();
                        while (IterViajeros.hasNext()) {
                            Viajero ObjViajero = (Viajero) IterViajeros.next();
                            Iterator IterOcupacion = ObjViajero.getOcupacions().iterator();
                            int asiento = 0;
                            while (IterOcupacion.hasNext()) {
                                Ocupacion ObjOcupacion = (Ocupacion) IterOcupacion.next();
                                if (ObjOcupacion.getViajero().getNifViajero() == ObjViajero.getNifViajero()) {
                                    asiento = ObjOcupacion.getAsiento();
                                }

                            }
                    %>
                    <div class="col-lg-10 offset-lg-2">
                        <div class="card mb-3" style="max-width: 80%;">
                            <div class="row no-gutters billete">
                                <div class="col-md-4">
                                    <div class="card-body tarjetaIzquierda">
                                        <h5 class="card-title">BILLETE DE AUTOBÚS</h5>
                                        <p class="card-text titulo3"><small class="text-muted titulo">Origen</small></p>
                                        <p class="card-text titulo2"><%out.print(ObjReserva.getObjRuta().getEstacionByIdOrigen().getNombre());%></p>
                                        <p class="card-text titulo3"><small class="text-muted titulo">Destino</small></p>
                                        <p class="card-text titulo2"><%out.print(ObjReserva.getObjRuta().getEstacionByIdDestino().getNombre());%></p>
                                        <p class="card-text titulo3"><small class="text-muted titulo">Fecha Salida</small></p>
                                        <p class="card-text titulo2"><%out.print(ObjReserva.dimeFecha(ObjReserva.getFechaViaje()));%></p>
                                        <p class="card-text titulo3"><small class="text-muted titulo">Hora</small></p>
                                        <%
                                            Date horaSalida = ObjReserva.getViajeSeleccionado().getHorario().getHoraSalida();
                                            // En esta linea de código estamos indicando el nuevo formato que queremos para nuestra fecha.
                                            SimpleDateFormat formatter = new SimpleDateFormat("HH:mm");
                                            // Aqui usamos la instancia formatter para darle el formato a la fecha. Es importante ver que el resultado es un string.
                                            String horaSalidaTexto = formatter.format(horaSalida);
                                        %>
                                        <p class="card-text titulo2"><%out.print(horaSalidaTexto);%></p>
                                        <p class="card-text titulo3"><small class="text-muted titulo">Asiento</small></p>
                                        <p class="card-text titulo2"><%out.print(asiento);%></p>
                                        <div class="codigoqr1" id="qr1-<%out.print(contadorViajeros);%>">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h5 class="card-title">BILLETE DE AUTOBÚS</h5>
                                        <p class="card-text titulo3"><small class="text-muted titulo">Nombre y Apellidos</small></p>
                                        <p class="card-text titulo4"><%out.print(ObjViajero.getNombreViajero());%> <%out.print(ObjViajero.getApellidosViajero());%></p>
                                        <p class="card-text titulo3"><small class="text-muted titulo">Nº de Documento</small></p>
                                        <p class="card-text titulo4"><%out.print(ObjViajero.getNifViajero());%></p>
                                        <p class="card-text titulo3"><small class="text-muted titulo">Fecha de salida </small> - <small class="text-muted titulo">Hora</small></p>
                                        <p class="card-text titulo4"><%out.print(ObjReserva.dimeFecha(ObjReserva.getFechaViaje()));%> - <%out.print(horaSalidaTexto);%></p>
                                        <p class="card-text titulo3"><small class="text-muted titulo">Asiento</small></p>
                                        <p class="card-text titulo4 asientoBillete"><%out.print(asiento);%></p>
                                        <p class="card-text titulo3"><small class="text-muted titulo">Precio</small></p>
                                        <p class="card-text titulo4"><%out.print(ObjReserva.getObjRuta().getPrecio());%>€</p>
                                        <div class="localizador">
                                            <p class="card-text titulo3"><small class="text-muted titulo">Localizador</small></p>
                                            <p class="card-text titulo4"><%out.print(ObjReserva.getLocalizador());%></p> 
                                        </div>
                                        <div class="fondobus">
                                            <img src="../IMG/fondobus.png" alt="Logo de autobuses Gabus">
                                        </div>
                                        <div class="codigoqr" id="qr<%out.print(contadorViajeros);%>">
                                        </div>
                                        <div class="logoBillete">
                                            <img src="../IMG/logobus-transparente.png" alt="Logo de autobuses Gabus">
                                        </div>
                                        <input type="hidden" id="informacionqr<%out.print(contadorViajeros);%>" value="Localizador: <%out.print(ObjReserva.getLocalizador() + "\nNIF/NIE: " + ObjViajero.getNifViajero());%>">

                                        <%
                                            contadorViajeros++;
                                        %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        }//while
                    %>
                    <div class="form-row col-lg-12">
                        <div class="col-lg-6 botonera">
                            <button type="button" class="btn btn-primary2 btn-primary btn-lg btn-block" onclick="self.location.href = 'VistaInicio.jsp'">BUSCAR MÁS VIAJES</button>
                        </div>
                        <div class="col-lg-6 botonera">
                            <button type="button" class="btn btn-primary2 btn-primary btn-lg btn-block" onclick="self.location.href = '../ControladorCargarEstacion'">IMPRIMIR</button>
                        </div>
                    </div>
                </div>
        </section>
        <jsp:include page="footer.jsp" />
        <!-- Optional JavaScript -->
        <script src="../JS/qrcode.js"></script>
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>


