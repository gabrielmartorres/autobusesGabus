/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servicio;

import DAO.HibernateUtil;
import POJOS.Horario;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import POJOS.Ruta;
import POJOS.Viaje;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import org.hibernate.Hibernate;

/**
 *
 * @author Gabriel
 */
public class OperacionesServicioWeb {

    private SessionFactory _SessionBuilder;

    public void init() {
        _SessionBuilder = HibernateUtil.getSessionFactory();
    }

    ArrayList<RutaXML> getListadoRutas() {
        init();
        
        Session sesion = _SessionBuilder.openSession();
        Transaction Tx = null;
        try {
            Tx = sesion.beginTransaction();

            String ordenHQL = "from Ruta";
            Query q = sesion.createQuery(ordenHQL);
            List ListadoObjRutas = q.list();
  
            Iterator IterRuta;
            IterRuta = ListadoObjRutas.iterator();

            ArrayList<RutaXML> ListadoRutasXML = new ArrayList<RutaXML>();

            while (IterRuta.hasNext()) {
                Ruta ObjRuta = (Ruta) IterRuta.next();

                Hibernate.initialize(ObjRuta.getHorarios());
                Iterator IterHorarios = ObjRuta.getHorarios().iterator();
                while (IterHorarios.hasNext()) {
                    Horario ObjHorario = (Horario) IterHorarios.next();

                    Date fecha = new Date(Calendar.getInstance().getTimeInMillis());
                    SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");
                    String horaSalida = formatter.format(ObjHorario.getHoraSalida());
           
                    Hibernate.initialize(ObjHorario.getViajes());
                    Iterator IterViajes = ObjHorario.getViajes().iterator();
                    while (IterViajes.hasNext()) {
                        Viaje ObjViaje = (Viaje) IterViajes.next();

                        Date fecha2 = new Date(Calendar.getInstance().getTimeInMillis());
                        SimpleDateFormat formatter2 = new SimpleDateFormat("dd-MM-yyyy");
                        String fechaDia = formatter2.format(ObjViaje.getFecha());
                        
                        String precio = String.valueOf(ObjRuta.getPrecio());
                        RutaXML ObjRutaXML = new RutaXML(ObjRuta.getEstacionByIdOrigen().getNombre(),ObjRuta.getEstacionByIdDestino().getNombre(),fechaDia,horaSalida,Integer.toString(ObjViaje.getPlazasLibres()),precio);
                        ListadoRutasXML.add(ObjRutaXML);
                    }

                }
                
            }
            return ListadoRutasXML;

        } catch (HibernateException HE) {
            HE.printStackTrace();
            if (Tx != null) {
                Tx.rollback();
            }
            throw HE;
        } finally {
            sesion.close();
        }


    }
}
