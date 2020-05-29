/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BLL;

import CLASES.Reserva;
import DAO.HibernateUtil;
import POJOS.Ocupacion;
import POJOS.Viajero;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.Integer.parseInt;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
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
public class ControladorCargaCompra extends HttpServlet {

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

            ArrayList nombreViajeros = new ArrayList();
            ArrayList appellidosViajeros = new ArrayList();
            ArrayList documentoViajeros = new ArrayList();
            for (int i = 1; i <= ObjReserva.getNumeroViajeros(); i++) {
                nombreViajeros.add(request.getParameter("nombre" + i));
                appellidosViajeros.add(request.getParameter("apellidos" + i));
                documentoViajeros.add(request.getParameter("documento" + i));
            }
            ArrayList asientoViajeros = new ArrayList();
            for (int i = ObjReserva.getNumeroViajeros(); i >= 1; i--) {
                asientoViajeros.add(parseInt(request.getParameter("numeroAsientoH" + i)));
            }

            Set<Viajero> ArrayListObjViajeros = new HashSet<Viajero>();
            Set<Ocupacion> ArrayListObjOcupacion = new HashSet<Ocupacion>();
            for (int i = 0; i < ObjReserva.getNumeroViajeros(); i++) {
                String documento = (String) documentoViajeros.get(i);
                String nombre = (String) nombreViajeros.get(i);
                String appellidos = (String) appellidosViajeros.get(i);

                Viajero ObjViajero = new Viajero(documento, nombre, appellidos);

                int numAsiento = (int) asientoViajeros.get(i);
                double precio = ObjReserva.getObjRuta().getPrecio();
                Ocupacion ObjOcupacion = new Ocupacion(ObjViajero, numAsiento, precio);

                ArrayListObjViajeros.add(ObjViajero);

                ArrayListObjOcupacion.add(ObjOcupacion);
            }

            Iterator it = ArrayListObjViajeros.iterator();
            Set<Viajero> ListadoViajeros = new HashSet<Viajero>();
            while (it.hasNext()) {
                Viajero ObjViajero=(Viajero)it.next();
                ObjViajero.setOcupacions(ArrayListObjOcupacion);
                ListadoViajeros.add(ObjViajero);
            }

            ObjReserva.setViajeros(ListadoViajeros);
            Session.setAttribute("ObjReserva", ObjReserva);

            response.sendRedirect("VISTAS/VistaResumen.jsp");
           
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
