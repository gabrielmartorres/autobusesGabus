/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servicio;

import java.util.ArrayList;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 *
 * @author Gabriel
 */
@WebService(serviceName = "WebServiceAutobuses")
public class WebServiceAutobuses {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {
        return "Hello " + txt + " !";
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "ListadoRutas")
    public ArrayList<RutaXML> ListadoRutas() {
        ArrayList ListadoRutas = new OperacionesServicioWeb().getListadoRutas();
        return ListadoRutas;
    }
}
