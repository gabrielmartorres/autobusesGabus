/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BLL;

import CLASES.Reserva;
import DAO.HibernateUtil;
import DAO.Operaciones;
import POJOS.Horario;
import POJOS.Ruta;
import POJOS.Viaje;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Iterator;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;

/**
 *
 * @author Gabriel
 */
public class ControladorConsultarRuta extends HttpServlet {

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

            String idEstacionOrigen = request.getParameter("origen");
            String idEstacionDestino = request.getParameter("destino");
            try {
                Ruta ORutaDev = new Operaciones().devolverRuta(idEstacionOrigen, idEstacionDestino, SessionBuilder);

                int numeroViajeros = Integer.parseInt(request.getParameter("numPlazas"));
                String fechaString = request.getParameter("fecha");
                LocalDate localDate1 = LocalDate.parse(fechaString, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                Date fechaViaje = Date.from(localDate1.atStartOfDay(ZoneId.systemDefault()).toInstant());

                //AÑADE AL OBJ DE RESERVA LA FECHA DE COMPRA
                Reserva ObjReserva = new Reserva(fechaViaje, numeroViajeros, ORutaDev);

                HttpSession Session = request.getSession(true);
                Session.setAttribute("ORutaDev", ORutaDev);
                Session.setAttribute("ObjReserva", ObjReserva);
                response.sendRedirect("VISTAS/VistaDetallesRutas.jsp");
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
