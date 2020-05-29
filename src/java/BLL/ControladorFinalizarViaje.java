/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BLL;

import DAO.HibernateUtil;
import DAO.Operaciones;
import POJOS.Compra;
import POJOS.Comprabackup;
import POJOS.Horario;
import POJOS.Ocupacion;
import POJOS.Ocupacionbackup;
import POJOS.Viaje;
import POJOS.Viajebackup;
import POJOS.Viajero;
import POJOS.Viajerobackup;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;

/**
 *
 * @author Gabriel
 */
public class ControladorFinalizarViaje extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            String idOrigen = request.getParameter("origen");
            String idDestino = request.getParameter("destino");
            String fecha = request.getParameter("fecha");
            String idHorarioString = request.getParameter("horario");
            int idHorario = Integer.parseInt(idHorarioString);
            try {
                Viaje ObjViaje = new Operaciones().obtenerViaje(idOrigen, idDestino, idHorario, fecha, SessionBuilder);
                new Operaciones().guardarBackups(ObjViaje, SessionBuilder);
                new Operaciones().finalizarViaje(ObjViaje, SessionBuilder);
                response.sendRedirect("VISTAS/VistaViajeFinalizado.jsp");
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
