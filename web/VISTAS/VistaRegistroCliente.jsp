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

        String mensajeRegistro = request.getParameter("error");
        String mensajeLogin = request.getParameter("errorLogin");
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
        <title>Autobuses Gabus - Registro de cliente</title>
    </head>
    <body>
        <jsp:include page="menuPrincipal.jsp" />
        <header class="cabecera text-center">
            <h1>Detalles de la ruta <%out.print(ObjReserva.getObjRuta().getComentario());%></h1>
            <h2>Confirmación de compra</h2>
        </header>
        <section class="container contenedorPrincipal">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">

                        <div class="progress" style="height: 1px;">
                            <div class="progress-bar" role="progressbar" style="width: 80%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                        <p class="progreso">Confirmación de compra</p>
                        <div class="progress" style="height: 20px;">
                            <div class="progress-bar" role="progressbar" style="width: 80%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <h3 class="text-center">Confirmación de compra</h3>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="row">
                            <div class="col-lg-6">
                                <%
                                    double total = 0;
                                    int numViajeros = 1;
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
                                        Date horaSalida = ObjReserva.getViajeSeleccionado().getHorario().getHoraSalida();
                                        // En esta linea de código estamos indicando el nuevo formato que queremos para nuestra fecha.
                                        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm");
                                        // Aqui usamos la instancia formatter para darle el formato a la fecha. Es importante ver que el resultado es un string.
                                        String horaSalidaTexto = formatter.format(horaSalida);

                                %>

                                <div class="col-lg-12">
                                    <div class="card mb-3 shadow rounded" style="max-width: 100%;">
                                        <div class="row no-gutters">
                                            <div class="col-md-4">
                                                <img src="../IMG/usuario.jpg" class="card-img" alt="Imagen de un usuario">
                                            </div>
                                            <div class="col-md-8">
                                                <div class="card-body">
                                                    <h5 class="card-title">Viajero</h5>
                                                    <p class="card-text titulo3"><small class="text-muted titulo">Nº de Documento</small></p>
                                                    <p class="card-text titulo4"><%out.print(ObjViajero.getNifViajero());%></p>
                                                    <p class="card-text titulo3"><small class="text-muted titulo">Nombre y Apellidos</small></p>
                                                    <p class="card-text titulo4"><%out.print(ObjViajero.getNombreViajero());%> <%out.print(ObjViajero.getApellidosViajero());%></p>
                                                    <input type="hidden" id="documento<%out.print(numViajeros);%>" value="<%out.print(ObjViajero.getNifViajero());%>"> 
                                                    <input type="hidden" id="documentoOculto<%out.print(numViajeros);%>" value="<%out.print(ObjViajero.getNifViajero());%>">
                                                    <input type="hidden" id="nombre<%out.print(numViajeros);%>" value="<%out.print(ObjViajero.getNombreViajero());%>"> 
                                                    <input type="hidden" id="apellidos<%out.print(numViajeros);%>" value="<%out.print(ObjViajero.getApellidosViajero());%>"> 
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                        numViajeros++;
                                    }//while
                                %>
                            </div>
                            <div class="col-lg-6">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <h4>Nuevo Cliente</h4>
                                        <div class="form-group">
                                            <p>Para realizar una compra deberás ser cliente o registrarte en nuestra página web.</p>
                                            <button type="button" class="btn btn-primary2 btn-primary btn-lg btn-block" data-toggle="modal" data-target="#exampleModal">
                                                Registro
                                            </button>
                                            <%
                                                if (mensajeRegistro != null) {%>
                                            <div id="alerta" class="alert alert-danger alert-dismissible fade show" role="alert">
                                                <strong>Error.</strong> El cliente ya está registrado.
                                            </div>
                                            <%
                                                }
                                            %>
                                            <!-- Modal -->
                                            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog" role="document">
                                                    <div class="modal-content">
                                                        <form name="registro" action="../ControladorRegistroCliente" method="POST">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Nuevo Cliente</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">

                                                                <div class="form-group">
                                                                    <label for="Viajero">Selecciona un viajero:</label>
                                                                    <select class="form-control" id="exampleFormControlSelect1" onchange="completarDatos(this.value)">
                                                                        <option value="nuevo">REGISTRAR NUEVO CLIENTE</option>
                                                                        <%
                                                                            Iterator IterViajeros2 = ObjReserva.getViajeros().iterator();
                                                                            int numViajero = 1;
                                                                            while (IterViajeros2.hasNext()) {
                                                                                Viajero ObjViajero = (Viajero) IterViajeros2.next();
                                                                        %>
                                                                        <option value="<%out.print(numViajero);%>"><%out.print(ObjViajero.getNifViajero());%> - <%out.print(ObjViajero.getNombreViajero());%></option>
                                                                        <%
                                                                                numViajero++;
                                                                            }//while
                                                                        %>
                                                                    </select>
                                                                </div>
                                                                <div class="form-row">    
                                                                    <div class="form-group col-md-6">
                                                                        <label for="nombre">Nombre:</label>
                                                                        <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Nombre" required>
                                                                    </div>

                                                                    <div class="form-group col-md-6">
                                                                        <label for="apellidos">Apellidos:</label>
                                                                        <input type="text" class="form-control" id="apellidos" name="apellidos" placeholder="Apellidos" required>
                                                                    </div>
                                                                </div>
                                                                <div class="form-row">
                                                                    <div class="form-group col-md-6">
                                                                        <label for="tipoDocumento">Tipo de Documento:</label>
                                                                        <select id="tipoDocumento" name="tipoDocumento" required class="form-control" onchange="seleccionaDocumentoR(this.value)" required>
                                                                            <option value="nif">NIF</option>
                                                                            <option value="nie">NIE</option>
                                                                        </select>
                                                                    </div>        
                                                                    <div class="form-group col-md-6">
                                                                        <label for="documento">Número de Documento:</label>
                                                                        <div class="input-group">
                                                                            <input type="text" class="form-control" id="documento" name="documento" placeholder="Núm. de documento" pattern="[0-9]{8}[A-Za-z]{1}" onkeyup="compruebaDocumentoR()" onchange="compruebaDocumentoR()" required>
                                                                            <div class="input-group-prepend">
                                                                                <span class="input-group-text" id="basic-addon1"><i id="x" class="d-none fas fa-times"></i><i id="v" class="d-none fas fa-check"></i></span>
                                                                            </div>
                                                                        </div>
                                                                        <input type="hidden" value="" id="inputDocumentoOculto" required>
                                                                    </div>
                                                                </div>
                                                                <div id="alerta" class="d-none alert alert-danger alert-dismissible fade show" role="alert">
                                                                    <strong>DNI/NIE no válido.</strong> Por favor, revise su número de documento.
                                                                </div>
                                                                <div class="form-row">
                                                                    <div class="form-group col-md-6">
                                                                        <label for="email">Email:</label>
                                                                        <input type="email" class="form-control" id="email" name="email" placeholder="email" required>
                                                                    </div>        
                                                                    <div class="form-group col-md-6">
                                                                        <label for="contraseña">Contraseña:</label>
                                                                        <div class="input-group">
                                                                            <input type="password" class="form-control" id="password" name="password" required>
                                                                            <div class="input-group-prepend">
                                                                                <span class="input-group-text" id="basic-addon1" onclick="mostrarPassword2()"><i id="ojo2" class="fas fa-eye"></i></span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="form-row">
                                                                    <div class="form-group col-md-6">
                                                                        <label for="domicilio">Domicilio</label>
                                                                        <input type="text" class="form-control" id="domicilio" name="domicilio" placeholder="Domicilio" required>
                                                                    </div>        
                                                                    <div class="form-group col-md-6">
                                                                        <label for="telefono">Teléfono</label>
                                                                        <input type="text" class="form-control" id="telefono" name="telefono" placeholder="Teléfono" pattern="[0-9]{9}" maxlength=9 required>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                                                <button id="botonEnviar" type="button" class="btn btn-primary" onclick="comprobarCamposR()">Registrar</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <form name="login" action="../ControladorLoginCliente" method="POST">
                                            <div class="form-group">
                                                <h4>Clientes</h4>
                                                <label for="exampleInputEmail1">Nº Documento:</label>
                                                <input type="text" class="form-control" id="InicioSesionNif" name="InicioSesionNif" aria-describedby="emailHelp">
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleInputPassword1">Contraseña</label>
                                                <div class="input-group">
                                                    <input type="password" class="form-control" id="InicioSesionPassword" name="InicioSesionPassword" required="">
                                                    <div class="input-group-prepend">
                                                        <span class="input-group-text" id="basic-addon1" onclick="mostrarPassword()"><i id="ojo" class="fas fa-eye"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <button type="submit" class="btn btn-primary2 btn-primary btn-lg btn-block">Iniciar sesión</button>
                                        </form>
                                        <%
                                                if (mensajeLogin != null) {%>
                                            <div id="alerta" class="alert alert-danger alert-dismissible fade show" role="alert">
                                                <strong>Error al iniciar sesión.</strong> Comprueba tus datos.
                                            </div>
                                            <%
                                                }
                                            %>
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
        <!-- Optional JavaScript Icons -->
        <script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>


