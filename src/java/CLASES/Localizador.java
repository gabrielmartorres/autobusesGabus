/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CLASES;

import java.security.SecureRandom;

/**
 *
 * @author addaw19
 */
public class Localizador {
    static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    static SecureRandom rnd= new SecureRandom();
            
    public static String randomString(int len){
        StringBuilder sb = new StringBuilder(len);
        for(int i=0;i<len;i++){
            sb.append(AB.charAt(rnd.nextInt(AB.length())));
        }
        return sb.toString();
    }        
    
}
