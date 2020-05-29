/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BLL;

import CLASES.Hash;
import DAO.HibernateUtil;
import DAO.Operaciones;
import POJOS.Configuracion;
import POJOS.Estacion;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;

/**
 *
 * @author addaw19
 */
public class ControladorIniciarSesion extends HttpServlet {

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
            String usuario = request.getParameter("usuario");
            String password = request.getParameter("password");
            String PasswordEncriptado = Hash.sha1(password);

            Configuracion ObjConfiguracion = new Operaciones().iniciarSesionAdministrador(usuario, PasswordEncriptado, SessionBuilder);

            if (ObjConfiguracion != null) {
                List<Estacion> ListadoEstacion = new Operaciones().getListadoEstaciones(SessionBuilder);

                Iterator IterEstacion;
                IterEstacion = ListadoEstacion.iterator();

                ArrayList<Estacion> ListadoEstaciones = new ArrayList<Estacion>();

                while (IterEstacion.hasNext()) {
                    Estacion ObjEstacion = (Estacion) IterEstacion.next();
                    ListadoEstaciones.add(ObjEstacion);
                }

                HttpSession Session = request.getSession(true);
                Session.setAttribute("ListadoEstaciones", ListadoEstaciones);
                response.sendRedirect("VISTAS/VistaPanelAdministracion.jsp");
            } else {
                response.sendRedirect("VISTAS/VistaInicioSesion.jsp?error=1");
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
