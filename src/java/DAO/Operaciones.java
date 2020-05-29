/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJOS.Cliente;
import POJOS.Compra;
import POJOS.Comprabackup;
import POJOS.Configuracion;
import POJOS.Estacion;
import POJOS.Horario;
import POJOS.Ocupacion;
import POJOS.Ocupacionbackup;
import POJOS.Ruta;
import POJOS.Tarjeta;
import POJOS.Viaje;
import POJOS.Viajebackup;
import POJOS.Viajero;
import POJOS.Viajerobackup;
import Servicio.RutaXML;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author Gabriel
 */
public class Operaciones {

    public List<Estacion> getListadoEstaciones(SessionFactory _SessionBuilder) {

        Session sesion = _SessionBuilder.openSession();
        Transaction Tx = null;
        Tx = sesion.beginTransaction();
        try {
            String ordenHQL = "from Estacion";
            Query q = sesion.createQuery(ordenHQL);
            List ListadoEstaciones = q.list();
            return ListadoEstaciones;
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

    public Ruta devolverRuta(String _idEstacionOrigen, String _idEstacionDestino, SessionFactory _SessionBuilder) {
        Session sesion = _SessionBuilder.openSession();
        Transaction Tx = null;
        try {
            Tx = sesion.beginTransaction();
            //Debemos obtener el objeto Empleado de la tabla.
            String ordenHQL = "from Ruta R where R.estacionByIdOrigen= :vidEstacionOrigen and R.estacionByIdDestino= :vidEstacionDestino";
            Query q = sesion.createQuery(ordenHQL);
            q.setParameter("vidEstacionOrigen", _idEstacionOrigen);
            q.setParameter("vidEstacionDestino", _idEstacionDestino);
            Ruta ObjRuta = (Ruta) q.uniqueResult();

            Hibernate.initialize(ObjRuta.getEstacionByIdOrigen());
            Hibernate.initialize(ObjRuta.getEstacionByIdDestino());

            Hibernate.initialize(ObjRuta.getHorarios());

            //*****
            Iterator IterHorarios = ObjRuta.getHorarios().iterator();
            while (IterHorarios.hasNext()) {
                Horario OHorario = (Horario) IterHorarios.next();
                Hibernate.initialize(OHorario.getViajes());
                Hibernate.initialize(OHorario.getViajebackups());
            }
            //*****

            Tx.commit();

            return ObjRuta;

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

    public Viaje devolverViaje(String _idViaje, SessionFactory _SessionBuilder) {
        Session sesion = _SessionBuilder.openSession();
        Transaction Tx = null;
        try {
            Tx = sesion.beginTransaction();
            String ordenHQL = "from Viaje V where V.idViaje= :vidViaje";
            Query q = sesion.createQuery(ordenHQL);
            q.setParameter("vidViaje", _idViaje);
            Viaje ObjViaje = (Viaje) q.uniqueResult();

            Hibernate.initialize(ObjViaje.getHorario());
            Hibernate.initialize(ObjViaje.getCompras());

            //*****
            Iterator IterCompras = ObjViaje.getCompras().iterator();
            while (IterCompras.hasNext()) {
                Compra OCompra = (Compra) IterCompras.next();
                Hibernate.initialize(OCompra.getOcupacions());
            }
            //*****

            return ObjViaje;

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

    public Cliente comprobarCliente(Cliente _ObjCliente, SessionFactory _SessionBuilder) {
        Session sesion = _SessionBuilder.openSession();
        Transaction Tx = null;
        try {
            Tx = sesion.beginTransaction();
            String nif = _ObjCliente.getNifCliente();
            String ordenHQL = "from Cliente C where C.nifCliente= :vnif";
            Query q = sesion.createQuery(ordenHQL);
            q.setParameter("vnif", nif);

            Cliente ObjCliente2 = (Cliente) q.uniqueResult();
            if (ObjCliente2 == null) {
                return _ObjCliente;
            } else {
                return ObjCliente2;
            }

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

    public void insertarCliente(Cliente _ObjCliente, SessionFactory _SessionBuilder) {
        Session sesion = _SessionBuilder.openSession();
        Transaction Tx = null;
        try {
            Tx = sesion.beginTransaction();
            sesion.save(_ObjCliente);
            Tx.commit();
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

    public Cliente iniciarSesionCliente(String _nif, String _password, SessionFactory _SessionBuilder) {
        Session sesion = _SessionBuilder.openSession();
        Transaction Tx = null;
        try {
            Tx = sesion.beginTransaction();
            String ordenHQL = "from Cliente C where C.nifCliente= :vnif and C.password= :vpassword";
            Query q = sesion.createQuery(ordenHQL);
            q.setParameter("vnif", _nif);
            q.setParameter("vpassword", _password);
            Cliente ObjCliente = (Cliente) q.uniqueResult();
            if (ObjCliente == null) {
                return ObjCliente;
            } else {
                Hibernate.initialize(ObjCliente.getTarjetas());

                //*****
                Iterator IterTarjetas = ObjCliente.getTarjetas().iterator();
                while (IterTarjetas.hasNext()) {
                    Tarjeta Objtarjeta = (Tarjeta) IterTarjetas.next();
                    Hibernate.initialize(Objtarjeta.getCliente());

                    Iterator IterCompras = Objtarjeta.getCompras().iterator();
                    while (IterCompras.hasNext()) {
                        Compra ObjCompra = (Compra) IterCompras.next();
                        Hibernate.initialize(ObjCompra);
                    }
                }
                //*****

                return ObjCliente;
            }
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

    public void insertarTarjeta(Tarjeta _ObjTarjeta, SessionFactory _SessionBuilder) {
        Session sesion = _SessionBuilder.openSession();
        Transaction Tx = null;
        try {
            Tx = sesion.beginTransaction();
            sesion.save(_ObjTarjeta);
            Tx.commit();
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

    public Tarjeta comprobarTarjeta(int _idTarjetaRegistrada, SessionFactory _SessionBuilder) {
        Session sesion = _SessionBuilder.openSession();
        Transaction Tx = null;
        try {
            Tx = sesion.beginTransaction();
            String ordenHQL = "from Tarjeta T where T.idTarjeta= :vidTarjetaRegistrada";
            Query q = sesion.createQuery(ordenHQL);
            q.setParameter("vidTarjetaRegistrada", _idTarjetaRegistrada);
            Tarjeta ObjTarjeta = (Tarjeta) q.uniqueResult();

            if (ObjTarjeta == null) {
                Tarjeta ObjTarjeta2 = new Tarjeta();
                return ObjTarjeta2;
            } else {
                Hibernate.initialize(ObjTarjeta.getCliente());
                Hibernate.initialize(ObjTarjeta.getCompras());

                //*****
                Iterator IterCompras = ObjTarjeta.getCompras().iterator();
                while (IterCompras.hasNext()) {
                    Compra ObjCompra = (Compra) IterCompras.next();
                    Hibernate.initialize(ObjCompra);
                }
                //*****
            }
            return ObjTarjeta;

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

    public void registrarCompra(Compra _ObjCompra, SessionFactory _SessionBuilder) {
        Session sesion = _SessionBuilder.openSession();
        Transaction Tx = null;
        try {
            Tx = sesion.beginTransaction();
            sesion.saveOrUpdate(_ObjCompra);
            Tx.commit();

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

    public Horario devolverHorario(String _idHorario, SessionFactory _SessionBuilder) {
        Session sesion = _SessionBuilder.openSession();
        Transaction Tx = null;
        try {
            Tx = sesion.beginTransaction();
            String ordenHQL = "from Horario H where H.idHorario= :vidHorario";
            Query q = sesion.createQuery(ordenHQL);
            q.setParameter("vidHorario", _idHorario);
            Horario ObjHorario = (Horario) q.uniqueResult();

            Hibernate.initialize(ObjHorario.getRuta());
            Hibernate.initialize(ObjHorario.getViajes());
            Hibernate.initialize(ObjHorario.getViajebackups());
            //*****
            Iterator IterViajes = ObjHorario.getViajes().iterator();
            while (IterViajes.hasNext()) {
                Viaje ObjViaje = (Viaje) IterViajes.next();
                Hibernate.initialize(ObjViaje.getCompras());
            }

            //*****
            return ObjHorario;

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

    public void insertarViajero(Set _viajeros, SessionFactory _SessionBuilder) {
        Iterator IterViajeros = _viajeros.iterator();
        while (IterViajeros.hasNext()) {
            Viajero ObjViajero = (Viajero) IterViajeros.next();

            Session sesion = _SessionBuilder.openSession();
            Transaction Tx = null;
            try {
                Tx = sesion.beginTransaction();
                sesion.saveOrUpdate(ObjViajero);
                Tx.commit();
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

    public void insertarOcupacion(Set<Ocupacion> _SetOcupaciones, SessionFactory _SessionBuilder) {
        Iterator IterOcupacion = _SetOcupaciones.iterator();
        while (IterOcupacion.hasNext()) {
            Ocupacion ObjOcupacion = (Ocupacion) IterOcupacion.next();

            Session sesion = _SessionBuilder.openSession();
            Transaction Tx = null;
            try {
                Tx = sesion.beginTransaction();
                sesion.saveOrUpdate(ObjOcupacion);
                Tx.commit();
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

    public Set comprobarViajeros(Set<Viajero> _Setviajeros, SessionFactory _SessionBuilder) {
        Set<Viajero> SetViajeros = new HashSet<>();
        Iterator IterViajeros = _Setviajeros.iterator();
        while (IterViajeros.hasNext()) {
            Viajero ObjViajero = (Viajero) IterViajeros.next();

            Session sesion = _SessionBuilder.openSession();
            Transaction Tx = null;
            try {
                Tx = sesion.beginTransaction();
                String nif = ObjViajero.getNifViajero();
                String ordenHQL = "from Viajero V where V.nifViajero= :vnif";
                Query q = sesion.createQuery(ordenHQL);
                q.setParameter("vnif", nif);

                Viajero ObjViajero2 = (Viajero) q.uniqueResult();
                if (ObjViajero2 != null) {
                    ObjViajero.setIdViajero(ObjViajero2.getIdViajero());
                }

                SetViajeros.add(ObjViajero);

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
        return SetViajeros;
    }

    public Configuracion iniciarSesionAdministrador(String _usuario, String _password, SessionFactory _SessionBuilder) {
        Session sesion = _SessionBuilder.openSession();
        Transaction Tx = null;
        try {
            Tx = sesion.beginTransaction();
            String ordenHQL = "from Configuracion C where C.usuario= :vusuario and C.password= :vpassword";
            Query q = sesion.createQuery(ordenHQL);
            q.setParameter("vusuario", _usuario);
            q.setParameter("vpassword", _password);
            Configuracion ObjConfiguracion = (Configuracion) q.uniqueResult();

            return ObjConfiguracion;

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

    public Viaje obtenerViaje(String _idOrigen, String _idDestino, int _idHorario, String _fecha, SessionFactory _SessionBuilder) {
        Session sesion = _SessionBuilder.openSession();
        Transaction Tx = null;
        try {
            Tx = sesion.beginTransaction();
            Viaje ObjViaje = new Viaje();
            String ordenHQL = "from Ruta R where R.estacionByIdOrigen =:vidOrigen and R.estacionByIdDestino =:vidDestino";
            Query q = sesion.createQuery(ordenHQL);
            q.setParameter("vidOrigen", _idOrigen);
            q.setParameter("vidDestino", _idDestino);
            Ruta ObjRuta = (Ruta) q.uniqueResult();

            Hibernate.initialize(ObjRuta.getEstacionByIdOrigen());
            Hibernate.initialize(ObjRuta.getEstacionByIdDestino());
            Hibernate.initialize(ObjRuta.getHorarios());
            
            Iterator IterHorarios = ObjRuta.getHorarios().iterator();
            while (IterHorarios.hasNext()) {
                Horario ObjHorario = (Horario) IterHorarios.next();

                if (ObjHorario.getIdHorario() == _idHorario) {
                    
                    Hibernate.initialize(ObjHorario.getViajes());
                    Hibernate.initialize(ObjHorario.getViajebackups());
                
                    Iterator IterViajes = ObjHorario.getViajes().iterator();
                    while (IterViajes.hasNext()) {
                        ObjViaje = (Viaje) IterViajes.next();
                        //Pasar la fecha a string para comparar
                        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                        String fechaTexto = formatter.format(ObjViaje.getFecha());

                        if (fechaTexto.equals(_fecha)) {

                            Hibernate.initialize(ObjViaje.getCompras());

                            Iterator IterCompras = ObjViaje.getCompras().iterator();
                            while (IterCompras.hasNext()) {
                                Compra ObjCompra = (Compra) IterCompras.next();
                                
                                Hibernate.initialize(ObjCompra.getTarjeta());
                                Hibernate.initialize(ObjCompra.getOcupacions());
                                
                                Iterator IterOcupacions = ObjCompra.getOcupacions().iterator();
                                while (IterOcupacions.hasNext()) {
                                    Ocupacion ObjOcupacion = (Ocupacion) IterOcupacions.next();
                                    Hibernate.initialize(ObjOcupacion.getViajero());

                                }

                            }
                        }

                    }
                }

            }

            return ObjViaje;

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

    public Viajerobackup comprobarViajerosbackup(String _nifViajero, SessionFactory _SessionBuilder) {
        Session sesion = _SessionBuilder.openSession();
        Transaction Tx = null;
        try {
            Tx = sesion.beginTransaction();
            String ordenHQL = "from Viajerobackup V where V.nifViajeroBackup= :vnifViajero";
            Query q = sesion.createQuery(ordenHQL);
            q.setParameter("vnifViajero", _nifViajero);
            Viajerobackup ObjViajero = (Viajerobackup) q.uniqueResult();

            if (ObjViajero == null) {
                Viajerobackup ObjViajero2 = new Viajerobackup();
                return ObjViajero2;
            } else {
                return ObjViajero;
            }

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

    public void guardarBackups(Viaje ObjViaje, SessionFactory _SessionBuilder) {
        Session sesion = _SessionBuilder.openSession();
        Transaction Tx = null;
        try {

            Set<Comprabackup> setComprabackup = new HashSet<>();
            Set<Ocupacionbackup> setOcupacionbackup = new HashSet<>();
            Set<Viajebackup> setViajebackups = new HashSet<>();

            Date fechaBaja = new Date();
            int plazasLibresBackup = ObjViaje.getPlazasLibres();
            Viajebackup ObjViajebackup = new Viajebackup(ObjViaje.getHorario(), ObjViaje.getFecha(), plazasLibresBackup, fechaBaja);

            Hibernate.initialize(ObjViaje.getCompras());
            Iterator IterCompras = ObjViaje.getCompras().iterator();
            while (IterCompras.hasNext()) {
                Compra ObjCompra = (Compra) IterCompras.next();

                //Creo las comprasbackup
                Comprabackup ObjComprabackup = new Comprabackup();
                ObjComprabackup.setTarjeta(ObjCompra.getTarjeta());
                ObjComprabackup.setLocalizadorCompraBackup(ObjCompra.getLocalizadorCompra());
                ObjComprabackup.setFechaCompraBackup(ObjCompra.getFechaCompra());
                ObjComprabackup.setImporteCompraBackup(ObjCompra.getImporteCompra());
                ObjComprabackup.setFechaBajaCompraBackup(fechaBaja);
                ObjComprabackup.setViajebackup(ObjViajebackup);
                ObjComprabackup.setOcupacionbackups(setOcupacionbackup);

                Hibernate.initialize(ObjCompra.getOcupacions());
                Iterator IterOcupacions = ObjCompra.getOcupacions().iterator();
                while (IterOcupacions.hasNext()) {
                    Ocupacion ObjOcupacion = (Ocupacion) IterOcupacions.next();

                    Hibernate.initialize(ObjOcupacion.getViajero());
                    Viajero ObjViajero = ObjOcupacion.getViajero();
                    Viajerobackup ObjViajerobackup = new Operaciones().comprobarViajerosbackup(ObjViajero.getNifViajero(), _SessionBuilder);

                    //Compruebo que no exista el viajero
                    if (ObjViajerobackup.getIdViajeroBackup() == null) {
                        ObjViajerobackup = new Viajerobackup(ObjViajero.getNifViajero(), ObjViajero.getNombreViajero(), ObjViajero.getApellidosViajero(), fechaBaja);
                    }

                    //Creo las ocupacionesbackup
                    Ocupacionbackup ObjOcupacionbackup = new Ocupacionbackup();
                    ObjOcupacionbackup.setComprabackup(ObjComprabackup);
                    ObjOcupacionbackup.setViajerobackup(ObjViajerobackup);
                    ObjOcupacionbackup.setAsientoBackup(ObjOcupacion.getAsiento());
                    ObjOcupacionbackup.setImporteBackup(ObjOcupacion.getImporte());
                    ObjOcupacionbackup.setFechaBajaOcupacionBackup(fechaBaja);

                    setOcupacionbackup.add(ObjOcupacionbackup);

                    ObjViajerobackup.setOcupacionbackups(setOcupacionbackup);

                    setComprabackup.add(ObjComprabackup);
                }
            }

            ObjViajebackup.setComprabackups(setComprabackup);

            setViajebackups = ObjViaje.getHorario().getViajebackups();
            setViajebackups.add(ObjViajebackup);
            ObjViaje.getHorario().setViajebackups(setViajebackups);

            Tx = sesion.beginTransaction();
            sesion.saveOrUpdate(ObjViajebackup);
            Tx.commit();
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

    public void finalizarViaje(Viaje _ObjViaje, SessionFactory _SessionBuilder) {
        Session sesion = _SessionBuilder.openSession();
        Transaction Tx = null;
        try {
            Tx = sesion.beginTransaction();
            ArrayList<Viajero> ArrayViajerosBorrar = new ArrayList<>();

            sesion.delete(_ObjViaje);

            String ordenHQL = "from Viajero V where V.idViajero NOT IN(select OC.viajero from Ocupacion OC)";
            Query q = sesion.createQuery(ordenHQL);
            ArrayViajerosBorrar = (ArrayList) q.list();

            for (Viajero ObjViajero : ArrayViajerosBorrar) {
                sesion.delete(ObjViajero);
            }

            Tx.commit();
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
