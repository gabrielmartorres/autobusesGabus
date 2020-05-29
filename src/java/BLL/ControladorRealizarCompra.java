/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BLL;

import CLASES.Reserva;
import DAO.HibernateUtil;
import DAO.Operaciones;
import POJOS.Cliente;
import POJOS.Compra;
import POJOS.Ocupacion;
import POJOS.Tarjeta;
import POJOS.Viaje;
import POJOS.Viajero;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.Integer.parseInt;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;

/**
 *
 * @author Gabriel
 */
public class ControladorRealizarCompra extends HttpServlet {

    //Conexión de la sesión.
    private SessionFactory SessionBuilder;

    public void init() {
        SessionBuilder = HibernateUtil.getSessionFactory();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession Session = (HttpSession) request.getSession();
            Reserva ObjReserva = (Reserva) Session.getAttribute("ObjReserva");
            Cliente ObjCliente = (Cliente) Session.getAttribute("ObjCliente");
            try {
                Set SetViajeros = new Operaciones().comprobarViajeros(ObjReserva.getViajeros(), SessionBuilder);
                ObjReserva.setViajeros(SetViajeros);
                //Valores para un nuevo registro de tarjeta.
                String numero1 = request.getParameter("numeroTarjeta1");
                String numero2 = request.getParameter("numeroTarjeta2");
                String numero3 = request.getParameter("numeroTarjeta3");
                String numero4 = request.getParameter("numeroTarjeta4");
                Tarjeta ObjTarjeta = new Tarjeta();
                String localizador = request.getParameter("codLocalizador");
                ObjReserva.setLocalizador(localizador);

                if (numero1 != null && numero2 != null && numero3 != null && numero4 != null) {
                    String numero = numero1 + "" + numero2 + "" + numero3 + "" + numero4;
                    byte[] numeroTarjeta = numero.getBytes(StandardCharsets.UTF_8);
                    String tipoTarjeta = request.getParameter("tipoTarjeta");
                    String cvvTarjeta = request.getParameter("cvv");
                    int caducidadMes = Integer.parseInt(request.getParameter("mesCad"));
                    int caducidadAno = Integer.parseInt(request.getParameter("anoCad"));

                    ObjTarjeta = new Tarjeta(ObjCliente, numeroTarjeta, tipoTarjeta, caducidadMes, caducidadAno);

                } else { //Valores para una tarjeta ya registrada.
                    String idTarjeta = request.getParameter("tipoTarjetaRegistrada");
                    int idTarjetaRegistrada = Integer.parseInt(idTarjeta);
                    String cvvTarjetaRegistrada = request.getParameter("cvvTarjetaRegistrada");

                    ObjTarjeta = new Operaciones().comprobarTarjeta(idTarjetaRegistrada, SessionBuilder);
                }
                Compra ObjCompra = new Compra(ObjTarjeta, ObjReserva.getViajeSeleccionado(), localizador, ObjReserva.getFechaCompra(), ObjReserva.getObjRuta().getPrecio() * ObjReserva.getViajeros().size());
                Set<Ocupacion> SetOcupaciones = new HashSet<>();

                Iterator IterViajeros = ObjReserva.getViajeros().iterator();
                while (IterViajeros.hasNext()) {
                    Viajero ObjViajero = (Viajero) IterViajeros.next();
                    Iterator IterOcupacion = ObjViajero.getOcupacions().iterator();
                    int asiento = 0;
                    while (IterOcupacion.hasNext()) {
                        Ocupacion ObjOcupacion = (Ocupacion) IterOcupacion.next();
                        if (ObjOcupacion.getViajero().getNifViajero() == ObjViajero.getNifViajero()) {
                            asiento = ObjOcupacion.getAsiento();

                            ObjOcupacion = new Ocupacion(ObjCompra, ObjViajero, asiento, ObjReserva.getObjRuta().getPrecio());
                            SetOcupaciones.add(ObjOcupacion);
                            ObjViajero.setOcupacions(SetOcupaciones);

                        }
                    }
                }
                ObjCompra.setOcupacions(SetOcupaciones);
                Set<Compra> SetCompras = new HashSet<>();
                SetCompras.add(ObjCompra);
                ObjTarjeta.setCompras(SetCompras);
                ObjTarjeta.setCliente(ObjCliente);
                Viaje ObjViaje = ObjReserva.getViajeSeleccionado();
                ObjViaje.setCompras(SetCompras);

                int numPlazas = ObjViaje.getPlazasLibres();
                int numPlazasActualizadas = numPlazas - ObjReserva.getViajeros().size();
                ObjViaje.setPlazasLibres(numPlazasActualizadas);

                Set<Tarjeta> SetTarjetas = new HashSet<>();
                SetTarjetas.add(ObjTarjeta);
                ObjCliente.setTarjetas(SetTarjetas);

                new Operaciones().registrarCompra(ObjCompra, SessionBuilder);
                response.sendRedirect("VISTAS/VistaDatosBillete.jsp");
            } catch (HibernateException HE) {
                response.sendRedirect("VISTAS/VistaErrores.jsp");
            }

        } catch (HibernateException HE) {
            HE.printStackTrace();
            throw HE;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
