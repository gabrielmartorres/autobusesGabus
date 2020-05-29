/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servicio;

/**
 *
 * @author Gabriel
 */
public class RutaXML {
    private String origen;
    private String destino;
    private String dia;
    private String horaSalida;
    private String plazasDisponibles;
    private String precio;

    public RutaXML(String origen, String destino, String dia, String horaSalida, String plazasDisponibles, String precio) {
        this.origen = origen;
        this.destino = destino;
        this.dia = dia;
        this.horaSalida = horaSalida;
        this.plazasDisponibles = plazasDisponibles;
        this.precio = precio;
    }

   
    
    

    public RutaXML() {
    }

    public String getOrigen() {
        return origen;
    }

    public void setOrigen(String origen) {
        this.origen = origen;
    }

    public String getDestino() {
        return destino;
    }

    public void setDestino(String destino) {
        this.destino = destino;
    }

    public String getDia() {
        return dia;
    }

    public void setDia(String dia) {
        this.dia = dia;
    }

    public String getHoraSalida() {
        return horaSalida;
    }

    public void setHoraSalida(String horaSalida) {
        this.horaSalida = horaSalida;
    }

    public String getPlazasDisponibles() {
        return plazasDisponibles;
    }

    public void setPlazasDisponibles(String plazasDisponibles) {
        this.plazasDisponibles = plazasDisponibles;
    }

    public String getPrecio() {
        return precio;
    }

    public void setPrecio(String precio) {
        this.precio = precio;
    }
    
    
}
