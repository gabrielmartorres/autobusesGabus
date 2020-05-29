/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BLL;

import DAO.HibernateUtil;
import DAO.Operaciones;
import POJOS.Estacion;
import POJOS.Horario;
import POJOS.Ruta;
import POJOS.Viaje;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
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
public class servlet_ajaxHorario extends HttpServlet {

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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            // Recibimos el id de estacion de origen del select
            String id_estacionO_s = request.getParameter("origen");

            String id_estacionD_s = request.getParameter("destino");
    
            String fechaViaje = request.getParameter("fecha");

            Ruta ObjRuta = new Operaciones().devolverRuta(id_estacionO_s, id_estacionD_s, SessionBuilder);

            Boolean conViaje = false;
            ArrayList<Horario> arrayHorarios = new ArrayList<>();

            Iterator IterHorarios = ObjRuta.getHorarios().iterator();
            while (IterHorarios.hasNext()) {
                conViaje = false;
                Horario ObjHorario = (Horario) IterHorarios.next();
                Iterator IterViajes = ObjHorario.getViajes().iterator();
                while (IterViajes.hasNext()) {
                    Viaje ObjViaje = (Viaje) IterViajes.next();

                    Date fecha = new Date(Calendar.getInstance().getTimeInMillis());
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                    String fechaTexto = formatter.format(ObjViaje.getFecha());

                    if (fechaTexto.equals(fechaViaje)) {
                        arrayHorarios.add(ObjHorario);
                    }
                }
            }

            int prueba = 0;

            out.print("<option value=''>Selecciona un horario</option>");
            for (int i = 0; i < arrayHorarios.size(); i++) {
                // Devolvemos una option por cada una de las localidades destino
                Date hora = arrayHorarios.get(i).getHoraSalida();
                // En esta linea de código estamos indicando el nuevo formato que queremos para nuestra fecha.
                SimpleDateFormat formatter = new SimpleDateFormat("HH:mm");
                // Aqui usamos la instancia formatter para darle el formato a la fecha. Es importante ver que el resultado es un string.
                String horasalida = formatter.format(hora);
                                                                    
                out.print("<option value='" + arrayHorarios.get(i).getIdHorario()+ "'> " +horasalida+ " </option>");
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
