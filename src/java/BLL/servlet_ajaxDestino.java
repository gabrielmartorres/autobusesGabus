/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BLL;

import DAO.HibernateUtil;
import DAO.Operaciones;
import POJOS.Estacion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.HibernateException;
import org.hibernate.SessionBuilder;
import org.hibernate.SessionFactory;

/**
 *
 * @author Gabriel
 */
public class servlet_ajaxDestino extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    //Conexión de la sesión.
    private SessionFactory SessionBuilder;
    public void init() {
        SessionBuilder = HibernateUtil.getSessionFactory();
    }
    //private Connection Conexion;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            // Recibimos el id de estacion de origen del select
            String id_estacion_s = request.getParameter("origen");
            int id_estacion = Integer.parseInt(id_estacion_s);
           
            HttpSession Session = (HttpSession) request.getSession();
            
            ArrayList<Estacion> arrayEstaciones_destino = (ArrayList) Session.getAttribute("ListadoEstaciones");
            
            out.print("<option value=''>Selecciona un destino</option>");  
            for (int i = 0; i < arrayEstaciones_destino.size(); i++) {
                // devolvemos una option por cada una de las localidades destino
                if(arrayEstaciones_destino.get(i).getIdEstacion() != id_estacion){
                    out.print("<option value='" + arrayEstaciones_destino.get(i).getIdEstacion() + "'> " + arrayEstaciones_destino.get(i).getNombre() + " </option>");
                }
                
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
