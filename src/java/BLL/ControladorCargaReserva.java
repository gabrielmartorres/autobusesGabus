/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BLL;

import CLASES.Reserva;
import DAO.HibernateUtil;
import DAO.Operaciones;
import POJOS.Compra;
import POJOS.Horario;
import POJOS.Ocupacion;
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
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;

/**
 *
 * @author Gabriel
 */
public class ControladorCargaReserva extends HttpServlet {

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

            String horaSalida = request.getParameter("horaSalida");
            String idHorario = request.getParameter("idHorario");
            String idViaje = request.getParameter("idViaje");
            String idRuta = request.getParameter("idRuta");
            String tipoDia = request.getParameter("tipoDia");
            String numViajeros = request.getParameter("numViajeros");
            Date fechaCompra = new Date(Calendar.getInstance().getTimeInMillis());

            try {
                Viaje ObjViaje = new Operaciones().devolverViaje(idViaje, SessionBuilder);
                Horario objHorario = new Operaciones().devolverHorario(idHorario, SessionBuilder);
                ObjViaje.setHorario(objHorario);

                HttpSession Session = (HttpSession) request.getSession();
                Reserva ObjReserva = (Reserva) Session.getAttribute("ObjReserva");

                ObjViaje.getHorario().setRuta(ObjReserva.getObjRuta());

                Reserva NuevoObjReserva = new Reserva(fechaCompra, ObjReserva.getFechaViaje(), ObjReserva.getNumeroViajeros(), ObjReserva.getObjRuta(), ObjViaje);
                Session.setAttribute("ObjReserva", NuevoObjReserva);

                //HAY QUE CREAR UN ARRAYLIST CON LAS PLAZAS LIBRES.
                ArrayList asientosLibres = new ArrayList();
                ArrayList asientosOcupados = new ArrayList();
                if (ObjViaje.getPlazasLibres() == 6) {
                    for (int i = 1; i <= 6; i++) {
                        asientosLibres.add(i);
                    }
                } else {
                    Iterator IterCompras = ObjViaje.getCompras().iterator();
                    Compra ObjCompra = new Compra();
                    Ocupacion ObjOcupacion = new Ocupacion();
                    while (IterCompras.hasNext()) {
                        ObjCompra = (Compra) IterCompras.next();
                        Hibernate.initialize(ObjCompra.getOcupacions());
                        Iterator IterOcupacion = ObjCompra.getOcupacions().iterator();

                        if (ObjCompra.getViaje().getIdViaje() == Integer.parseInt(idViaje)) {
                            while (IterOcupacion.hasNext()) {
                                ObjOcupacion = (Ocupacion) IterOcupacion.next();
                                Hibernate.initialize(ObjOcupacion.getAsiento());
                                if (ObjOcupacion.getCompra().getViaje().getIdViaje() == Integer.parseInt(idViaje)) {
                                    asientosOcupados.add(ObjOcupacion.getAsiento());
                                }
                            }
                        }

                    }
                    //Creo el arraylist con los asientos vacios
                    Boolean guardar;
                    for (int i = 1; i <= 6; i++) {
                        guardar = true;
                        for (int j = 0; j < asientosOcupados.size(); j++) {

                            if (i == (int) asientosOcupados.get(j)) {
                                guardar = false;
                            }
                        }
                        if (guardar) {
                            asientosLibres.add(i);
                        }
                    }

                }

                Session.setAttribute("asientosLibres", asientosLibres);
                Session.setAttribute("asientosOcupados", asientosOcupados);
                response.sendRedirect("VISTAS/VistaDatosAsientos.jsp");
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
