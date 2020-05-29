<%-- 
    Document   : VistaInicio
    Created on : 25-ene-2020, 19:50:07
    Author     : Gabriel
--%>

<%@page import="POJOS.Estacion"%>
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
        <title>Autobuses Gabus - Todas las rutas de autobuses en un buscador</title>
    </head>
    <body>
        <jsp:include page="menuPrincipal.jsp" />
        <section class="fondoPrincipal">
            <header class="cabecera text-center">
                <h1>Autobuses desde y hasta Albacete.</h1>                
            </header>
            <section class="container-fluid">
                <div class="container">
                    <div class="row formulario">
                        <div class="col-lg-12">
                            <div class="progress" style="height: 1px;">
                                <div class="progress-bar" role="progressbar" style="width: 20%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <p class="progreso">Búsqueda de billetes</p>
                            <div class="progress" style="height: 20px;">
                                <div class="progress-bar" role="progressbar" style="width: 20%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <form name="buscadorViajes" action="../ControladorConsultarRuta" method="POST">
                                <div class="form-row">
                                    <div class="col">
                                        <label for="origen">Origen</label>
                                        <select id="origen" name="origen" required onChange="muestradestinos(this.value)" class="form-control">
                                            <option value="">Selecciona un origen</option>
                                            <%for (Estacion ObjEstacion : ListadoEstaciones) {%>
                                            <option value="<%out.print(ObjEstacion.getIdEstacion());%>"><%out.print(ObjEstacion.getNombre());%></option>
                                            <%}%>
                                        </select>
                                    </div>
                                    <div class="col">
                                        <label for="destino">Destino</label>
                                        <select id="destino" name="destino" required class="form-control">
                                            <option value="">Selecciona un destino</option>
                                        </select>
                                    </div>
                                    <div class="col">
                                        <label for="fecha">Fecha</label>
                                        <input type="date" class="form-control" required name="fecha" id="fecha">
                                    </div>
                                    <div class="col">
                                        <label for="numPlazas">Número de plazas</label>
                                        <input type="text" class="form-control" required name="numPlazas" id="numPlazas" pattern="[0-9]">
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="col botonera">
                                        <button type="submit" class="btn btn-primary2 btn-primary btn-lg btn-block">BUSCAR</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </section>
            <section>
                <div class="container">
                    <div class="row">
                        <div class="offset-2 col-lg-10 tiempo">
                            <div id="c_15e51bd4997808bc03e632e204b1c811" class="ancho"></div><script type="text/javascript" src="https://www.eltiempo.es/widget/widget_loader/15e51bd4997808bc03e632e204b1c811"></script>
                        </div>
                    </div>
                </div>
            </section>

        </section>
        <jsp:include page="footer.jsp" />
        <!-- Optional JavaScript -->
        <script src="../JS/muestraDestinos.js"></script>
        <script type="text/javascript" src="//www.tiempo.es/widload/es/hor/620/146/110/es0ae0003/bcf56e8835f92afc105eed57201e77a8.js"></script>
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>
