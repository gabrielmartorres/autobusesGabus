<%-- 
    Document   : VistaFinalizarCompra
    Created on : 04-feb-2020, 21:34:21
    Author     : Gabriel
--%>

<%@page import="POJOS.Tarjeta"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="CLASES.Localizador"%>
<%@page import="CLASES.Reserva"%>
<%@page import="POJOS.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        HttpSession Session = (HttpSession) request.getSession();
        Cliente ObjCliente = (Cliente) session.getAttribute("ObjCliente");
        Reserva ObjReserva = (Reserva) session.getAttribute("ObjReserva");

        double total = ObjReserva.getObjRuta().getPrecio() * ObjReserva.getViajeros().size();
        Localizador ObjLocalizador = new Localizador();
        String localizador = ObjLocalizador.randomString(12);

        Date fecha = new Date(Calendar.getInstance().getTimeInMillis());
        // En esta linea de código estamos indicando el nuevo formato que queremos para nuestra fecha.
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy - HH:mm:ss");
        // Aqui usamos la instancia formatter para darle el formato a la fecha.
        String fechaTexto = formatter.format(fecha);
    %>
    <head>
        <!-- Required meta tags -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="../CSS/style.css">
        <link rel="stylesheet" type="text/css" href="../CSS/styleTarjeta.css">
        <!-- Fuentes -->
        <!-- Para títulos-->
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,400i,500,700,900&display=swap" rel="stylesheet">
        <!-- Para texto-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet"> 


        <!-- Iconos -->
        <title>Autobuses Gabus - Finalizar compra</title>
    </head>
    <body>
        <jsp:include page="menuPrincipal.jsp" />
        <header class="cabecera text-center">
            <h1>Detalles de la ruta <%out.print(ObjReserva.getObjRuta().getComentario());%></h1>
            <h2>Finalizar Compra</h2>
        </header>
        <section class="container contenedorPrincipal">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">

                        <div class="progress" style="height: 1px;">
                            <div class="progress-bar" role="progressbar" style="width: 80%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                        <p class="progreso">Finalizar Compra</p>
                        <div class="progress" style="height: 20px;">
                            <div class="progress-bar" role="progressbar" style="width: 80%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12">
                        <h3 class="text-center">Pasarela de pago</h3>
                    </div>
                    <div class="col-lg-12">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="card mb-3" style="max-width: 80%;">
                                    <div class="row no-gutters">
                                        <div class="col-md-12">
                                            <div class="card-body">
                                                <h5 class="card-title" id="total">IMPORTE:</h5>
                                                <p id="precioTotal"><%out.print(total);%>€</p>
                                                <br><br><br>
                                                <p class="titulo">Localizador: <span class="titulo5"><%out.print(localizador);%></span></p>
                                                <p class="titulo">Fecha: <span class="titulo5"><%out.print(fechaTexto);%></span></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <form name="compras" action="../ControladorRealizarCompra" method="POST">
                                        <label for="inputTarjeta" class="col-sm-9 col-form-label"><h4>Pagar con tarjeta:</h4></label>
                                        <div class="col-sm-9">
                                            <label for="inputTipoTarjeta" class="col-sm-10 col-form-label">Seleccione un tipo de tarjeta:</label> 
                                            <select class="form-control" name="tipoTarjeta" id="tipoTarjeta" onchange="muestraTarjeta(this.value)">
                                                <option value="nulo">-- Tipo de tarjeta --</option>
                                                <option value="visa">Visa</option>
                                                <option value="mastercard">Mastercard</option>
                                                <option value="maestro">Maestro</option>
                                                <option value="american">American Express</option>
                                            </select>
                                            <br>
                                        </div>
                                        <div class="col-sm-9">
                                            <label for="inputTipoTarjeta" class="col-sm-9 col-form-label">Datos de su tarjeta:</label>
                                            <div id="area">
                                                <div class="master-card">
                                                    <div class="card">
                                                        <div class="title">TARJETA DE CRÉDITO</div>
                                                        <div class="input-number"><span class="title-number">NÚMERO DE TARJETA</span>
                                                            <div class="inputs-number">
                                                                <input type="text" id="primero" maxlength="4" name="number-card" placeholder="0000" required="required"/>
                                                                <input type="text" id="segundo" maxlength="4" name="number-card" placeholder="0000" required="required"/>
                                                                <input type="text" id="tercero" maxlength="4" name="number-card" placeholder="0000" required="required"/>
                                                                <input type="text" id="cuarto" maxlength="4" name="number-card" placeholder="0000" required="required"/>
                                                            </div>
                                                            <div class="selects-date selecters">
                                                                <div class="day-select"><span>DÍA</span>
                                                                    <select id="dates">
                                                                        <%
                                                                            for (int i = 1; i <= 30; i++) {%>
                                                                        <option value=""><%out.print(i);%></option>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    </select>
                                                                </div>
                                                                <div class="year-select"><span>AÑO</span>
                                                                    <select id="dates">
                                                                        <%
                                                                            for (int i = 20; i <= 30; i++) {%>
                                                                        <option value=""><%out.print(i);%></option>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="mark-gold">
                                                            <img id="imgTarjeta" src="../IMG/tarjeta-mastercard.png" alt="tarjetaMastercad">
                                                        </div>
                                                        <div class="name"><span><%out.print(ObjCliente.getNombreCliente() + " " + ObjCliente.getApellidosCliente());%></span></div>
                                                    </div>

                                                </div>
                                            </div>
                                            <label for="inputTipoTarjeta" class="col-sm-9 col-form-label">Introduce el CVV: <input type="text" id="cvv" name="cvv"></label>
                                            <div id="alerta" class="d-none alert alert-danger alert-dismissible fade show" role="alert">
                                                <strong>Tarjeta no válida.</strong> Por favor, compruebe su tarjeta.
                                            </div>
                                            <div id="alerta2" class="d-none alert alert-danger alert-dismissible fade show" role="alert">
                                                Por favor, complete todos los campos.
                                            </div>
                                        </div>
                                        <div class="col-sm-9">
                                            <br>
                                            <button type="button" id="pagar" class="btn btn-primary2 btn-primary btn-lg btn-block" onclick="validarTarjeta()">Pagar</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>                                            
        </section>
        <jsp:include page="footer.jsp" />
        <!-- Optional JavaScript -->
        <script src="../JS/registro.js"></script>
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>
