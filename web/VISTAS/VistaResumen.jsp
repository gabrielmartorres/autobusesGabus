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
        <title>Autobuses Gabus - Detalles de la ruta</title>
    </head>
    <body>
        <jsp:include page="menuPrincipal.jsp" />
        <header class="cabecera text-center">
            <h1>Detalles de la ruta <%out.print(ObjReserva.getObjRuta().getComentario());%></h1>
            <h2>Resumen del viaje</h2>
        </header>
        <section class="container contenedorPrincipal">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="progress" style="height: 1px;">
                            <div class="progress-bar" role="progressbar" style="width: 80%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                        <p class="progreso">Resumen del viaje</p>
                        <div class="progress" style="height: 20px;">
                            <div class="progress-bar" role="progressbar" style="width: 80%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                </div>
                <form name="seleccionAsientos" action="VistaRegistroCliente.jsp" method="POST">
                    <div class="row">
                        <div class="col-lg-12">
                            <h3 class="text-center">Resumen de Billetes</h3>
                        </div>
                        <%
                            double total=0.f;
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
                                <div class="row no-gutters">
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
                                            <p class="card-text titulo4"><%out.print(asiento);%></p>
                                            <p class="card-text titulo3"><small class="text-muted titulo">Precio</small></p>
                                            <p class="card-text titulo4"><%out.print(ObjReserva.getObjRuta().getPrecio());%>€</p>
                                            <%
                                            total=total+ObjReserva.getObjRuta().getPrecio();
                                            %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                                }//while
                        %>
                        <div class="col-lg-12 p-3 mb-2 bg-info text-white">
                            <p><span id="total">TOTAL:</span> <span id="precioTotal"><%out.print(String.format("%.2f", total));%>€</span></p>
                        </div>
                        <div class="form-row col-lg-12">
                            <div class="col-lg-6 botonera">
                                <button type="submit" class="btn btn-primary2 btn-primary btn-lg btn-block">CONFIRMAR COMPRA</button>
                            </div>
                            <div class="col-lg-6 botonera">
                                <button type="button" class="btn btn-primary2 btn-primary btn-lg btn-block" onclick="self.location.href = '../ControladorCargarEstacion'">CANCELAR</button>
                            </div>
                        </div>
                    </div>
                </form>
        </section>
        <jsp:include page="footer.jsp" />
        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>

