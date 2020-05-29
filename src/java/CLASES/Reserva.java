/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CLASES;

import POJOS.Ruta;
import POJOS.Viaje;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 *
 * @author addaw19
 */
public class Reserva {

    private Integer idReserva;
    private Date fechaCompra;
    private Date fechaViaje;
    private Integer numeroViajeros;
    private Ruta ObjRuta;
    private Viaje viajeSeleccionado;
    private String localizador;
    private Set viajeros = new HashSet(0);

    public Reserva(Integer idReserva, Date fechaCompra, Date fechaViaje, Integer numeroViajeros, Ruta ObjRuta, Viaje viajeSeleccionado) {
        this.idReserva = idReserva;
        this.fechaCompra = fechaCompra;
        this.fechaViaje = fechaViaje;
        this.numeroViajeros = numeroViajeros;
        this.ObjRuta = ObjRuta;
        this.viajeSeleccionado = viajeSeleccionado;
    }

    public Reserva(Date fechaCompra, Date fechaViaje, Integer numeroViajeros, Ruta ObjRuta, Viaje viajeSeleccionado) {
        this.fechaCompra = fechaCompra;
        this.fechaViaje = fechaViaje;
        this.numeroViajeros = numeroViajeros;
        this.ObjRuta = ObjRuta;
        this.viajeSeleccionado = viajeSeleccionado;
    }

    //constructor para mandar los datos seleccionados del viaje a consultar.
    public Reserva(Date fechaViaje, Integer numeroViajeros, Ruta ObjRuta) {
        this.fechaViaje = fechaViaje;
        this.numeroViajeros = numeroViajeros;
        this.ObjRuta = ObjRuta;
    }
   
   
    public Reserva() {
    }

    public Integer getIdReserva() {
        return idReserva;
    }

    public void setIdReserva(Integer idReserva) {
        this.idReserva = idReserva;
    }

    public Date getFechaCompra() {
        return fechaCompra;
    }

    public void setFechaCompra(Date fechaCompra) {
        this.fechaCompra = fechaCompra;
    }

    public Date getFechaViaje() {
        return fechaViaje;
    }

    public void setFechaViaje(Date fechaViaje) {
        this.fechaViaje = fechaViaje;
    }

    public Integer getNumeroViajeros() {
        return numeroViajeros;
    }

    public void setNumeroViajeros(Integer numeroViajeros) {
        this.numeroViajeros = numeroViajeros;
    }

    public Ruta getObjRuta() {
        return ObjRuta;
    }

    public void setObjRuta(Ruta ObjRuta) {
        this.ObjRuta = ObjRuta;
    }

    public Viaje getViajeSeleccionado() {
        return viajeSeleccionado;
    }

    public void setViajeSeleccionado(Viaje viajeSeleccionado) {
        this.viajeSeleccionado = viajeSeleccionado;
    }

    public Set getViajeros() {
        return viajeros;
    }

    public void setViajeros(Set viajeros) {
        this.viajeros = viajeros;
    }

    public String getLocalizador() {
        return localizador;
    }

    public void setLocalizador(String localizador) {
        this.localizador = localizador;
    }
    
    

    public String dimeFecha(Date fecha) {
        // En esta linea de código estamos indicando el nuevo formato que queremos para nuestra fecha.
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
        // Aqui usamos la instancia formatter para darle el formato a la fecha. Es importante ver que el resultado es un string.
        String fechaTexto = formatter.format(fecha);
        return fechaTexto;
    }

    @Override
    public String toString() {
        return "Reserva{" + "fechaCompra=" + fechaCompra + ", fechaViaje=" + fechaViaje + ", numeroViajeros=" + numeroViajeros + ", ObjRuta=" + ObjRuta + ", viajeSeleccionado=" + viajeSeleccionado + ", viajeros=" + viajeros + '}';
    }

}
