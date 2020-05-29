<%-- 
    Document   : VistaDatosAsientos
    Created on : 31-ene-2020, 19:56:56
    Author     : Gabriel
--%>

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
        <link href="/your-path-to-fontawesome/css/all.css" rel="stylesheet">
        <title>Autobuses Gabus - Detalles de la ruta</title>
    </head>
    <body>
        <jsp:include page="menuPrincipal.jsp" />
        <header class="cabecera text-center">
            <h1>Detalles de la ruta <%out.print(ObjReserva.getObjRuta().getComentario());%></h1>
            <h2>Datos de viajeros y asientos</h2>
        </header>
        <section class="container contenedorPrincipal">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">

                        <div class="progress" style="height: 1px;">
                            <div class="progress-bar" role="progressbar" style="width: 60%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                        <p class="progreso">Datos de viajeros y asientos</p>
                        <div class="progress" style="height: 20px;">
                            <div class="progress-bar" role="progressbar" style="width: 60%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                </div>
                <form name="seleccionAsientos" action="../ControladorCargaCompra" method="POST">
                    <div class="row">
                        <div class="col-lg-12">
                            <h3 class="text-center">Datos de los viajeros</h3>
                        </div>
                        <div class="col-lg-12">
                            <div class="accordion" id="accordionExample">
                                <%for (int i = 1; i <= ObjReserva.getNumeroViajeros(); i++) {%>
                                <div class="card">
                                    <div class="card-header" id="heading<%out.print(i);%>">
                                        <h2 class="mb-0">
                                            <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapse<%out.print(i);%>" aria-expanded="false" aria-controls="collapse<%out.print(i);%>">
                                                Datos del viajero <%out.print(i);%>
                                            </button>
                                        </h2>
                                    </div>

                                    <div id="collapse<%out.print(i);%>" class="collapse" aria-labelledby="heading<%out.print(i);%>" data-parent="#accordionExample">
                                        <div class="card-body col-lg-6 offset-lg-3">
                                            <div class="form-group row">
                                                <label for="inputNombre" class="col-sm-3 col-form-label">Nombre:</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" id="nombre<%out.print(i);%>" name="nombre<%out.print(i);%>"placeholder="Nombre" required>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="inputApellidos" class="col-sm-3 col-form-label">Apellidos:</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" id="apellidos<%out.print(i);%>" name="apellidos<%out.print(i);%>"placeholder="Apellidos" required>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="inputDocumento" class="col-sm-5 col-form-label">Tipo de Documento:</label>
                                                <div class="col-sm-7">
                                                    <select id="tipoDocumento<%out.print(i);%>" name="tipoDocumento<%out.print(i);%>" required class="form-control" onchange="seleccionaDocumento(this.value,<%out.print(i);%>)" required>
                                                        <option value="nif">NIF</option>
                                                        <option value="nie">NIE</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label for="inputDocumento" class="col-sm-3 col-form-label">Documento:</label>
                                                <div class="col-sm-9 input-group">
                                                    <input type="text" class="form-control" id="documento<%out.print(i);%>" name="documento<%out.print(i);%>"placeholder="Documento" maxlength="9" onkeyup="compruebaDocumento(<%out.print(i);%>)" onchange="compruebaDocumento(<%out.print(i);%>)" required>
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text" id="basic-addon1"><i id="x<%out.print(i);%>" class="d-none fas fa-times"></i><i id="v<%out.print(i);%>" class="d-none fas fa-check"></i></span>
                                                    </div>
                                                </div>
                                                    <input type="hidden" value="" id="inputDocumentoOculto<%out.print(i);%>" required>
                                            </div>
                                            <div id="alerta<%out.print(i);%>" class="d-none alert alert-danger alert-dismissible fade show" role="alert">
                                                <strong>DNI/NIE no válido.</strong> Por favor, revise su número de documento.
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    } // for
                                %>
                            </div>

                        </div>
                        <div class="col-lg-12">
                            <h3 class="text-center">Selección de asiento</h3>
                            <p class="text-center">Elige <span id="numTotalAsientos"><%out.print(ObjReserva.getNumeroViajeros());%></span> asientos</p>
                            <input type="hidden" id="numViajeros" value="<%out.print(ObjReserva.getNumeroViajeros());%>">
                        </div>
                        <div class="col-lg-8 offset-lg-2 autobus">
                            <table>
                                <tr>
                                    <th id="1" class="asiento" onclick="seleccionarAsiento(1)">1</th>
                                    <th class="espacioAsiento"></th>
                                    <th id="3" class="asiento" onclick="seleccionarAsiento(3)">3</th>
                                    <th class="espacioAsiento"></th>
                                    <th id="5" class="asiento" onclick="seleccionarAsiento(5)">5</th>
                                </tr>
                                <tr class="pasilloAsiento"></tr>
                                <tr>
                                    <th id="2" class="asiento" onclick="seleccionarAsiento(2)">2</th>
                                    <th class="espacioAsiento"></th>
                                    <th id="4" class="asiento" onclick="seleccionarAsiento(4)">4</th>
                                    <th class="espacioAsiento"></th>
                                    <th id="6" class="asiento" onclick="seleccionarAsiento(6)">6</th>
                                </tr>
                            </table>
                        </div>
                        <!--Guardo los número de asiento ocupados-->                      
                        <input id="numerosDeAsientos" type="hidden" value="<%for (int i = 0; i < asientosOcupados.size(); i++) {%><%out.print(asientosOcupados.get(i));%>-<%}%>"></input>

                        <div class="col-lg-2">
                            <%int numAsiento = ObjReserva.getNumeroViajeros();%>
                            <%for (int i = 1; i <= ObjReserva.getNumeroViajeros(); i++) {%>
                            <p><b>Viajero <%out.print(i);%></b></p>
                            <p id="prueba">Nº de asiento: <span class="numeroAsiento" id="asiento<%out.print(numAsiento);%>">-</span></p>
                            <input type="hidden" id="numeroAsientoH<%out.print(numAsiento);%>" name="numeroAsientoH<%out.print(numAsiento);%>" value="">
                            <%numAsiento--;%>
                            <%}%>
                        </div> 
                        <div class="col-lg-8 offset-lg-2">
                            <div id="alertaGeneral" class="d-none alert alert-danger alert-dismissible fade show" role="alert">
                                <strong>Por favor,</strong> debe elegir los asientos para los viajeros.
                            </div>
                            <div id="alertaGeneral2" class="d-none alert alert-danger alert-dismissible fade show" role="alert">
                                <strong>Error,</strong> alguno de los viajeros no tiene datos.
                            </div>
                            <div id="alertaGeneral3" class="d-none alert alert-danger alert-dismissible fade show" role="alert">
                                <strong>Error,</strong> El nº de documento ha sido repetido para alguno de los viajeros.
                            </div>
                        </div>

                        <div class="form-row col-lg-12">
                            <div class="col botonera">
                                <button id="botonEnviar" type="button" class="btn btn-primary2 btn-primary btn-lg btn-block" onclick="comprobarCampos()">COMPRAR BILLETE</button>
                            </div>
                        </div>
                    </div>
                </form>
        </section>
        <jsp:include page="footer.jsp" />
        <!-- Optional JavaScript -->
        <script src="../JS/gestionAsientosAutobus.js"></script>
        <script src="../JS/registro.js"></script>
        <!-- Optional JavaScript Icons -->
        <script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>
