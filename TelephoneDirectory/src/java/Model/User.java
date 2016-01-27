/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.util.ArrayList;

/**
 *
 * @author umchlk
 */
public class User {
    private String username;
    private String fullname;
    private String password;
    private String usertype;
    private String extension;
    private ArrayList<String> exnum;

    public User() {
    }

    public User(String username, String fullname, String password, String usertype, ArrayList<String> exnum) {
        this.username = username;
        this.fullname = fullname;
        this.password = password;
        this.usertype = usertype;
        this.exnum = exnum;
    }

    public User(String username, String fullname, String password, String usertype, String extension, ArrayList<String> exnum) {
        this.username = username;
        this.fullname = fullname;
        this.password = password;
        this.usertype = usertype;
        this.extension = extension;
        this.exnum = exnum;
    }

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }
    
    
    
    
   
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsertype() {
        return usertype;
    }

    public void setUsertype(String usertype) {
        this.usertype = usertype;
    }

    public ArrayList<String> getExnum() {
        return exnum;
    }

    public void setExnum(ArrayList<String> exnum) {
        this.exnum = exnum;
    }
    
   
    
}
