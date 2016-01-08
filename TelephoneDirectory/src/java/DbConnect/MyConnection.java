/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DbConnect;

import Model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author umchlk
 */
public class MyConnection {
    public boolean userIdentification(String u_name,Connection con) throws SQLException {
        boolean validate = false;
        String sql = "select * from ifsextensions";
        Statement stm = con.createStatement();
        stm.executeQuery(sql);
        ResultSet rs = stm.executeQuery(sql);
        String username;
        while (rs.next()) {
            username = rs.getString("username");
            System.out.println(username);

            if (u_name.equals(username)) {
                validate = true;
                break;
            }

        }
        return validate;
    }

    public String GetName(String u_name,Connection con) throws SQLException {

        String sql = "select distinct(fullname),usertype from ifsextensions where username='" + u_name + "'";
        Statement stm = con.createStatement();
        stm.executeQuery(sql);
        ResultSet rs = stm.executeQuery(sql);
        String name = null;
       
        while (rs.next()) {
            name = rs.getString("fullname");
            
            System.out.println(name);
        }
        return name;

    }

    public boolean deleteUser(String[] arr,Connection con) throws SQLException {
        PreparedStatement delemp = con.prepareStatement("DELETE FROM pravi.USERS WHERE id = ?");
        for (String s : arr) {
            delemp.setInt(1, Integer.parseInt(s));
            delemp.executeUpdate();
        }
        return true;
    }

    public ArrayList GetExtension(String u_name,Connection con) throws SQLException {

        String sql = "select distinct(extension) from ifsextensions where username='" + u_name + "'";
        Statement stm = con.createStatement();
        stm.executeQuery(sql);
        ResultSet rs = stm.executeQuery(sql);
        ArrayList<String> myArray = new ArrayList<>();
       // System.out.println(sql);

        while (rs.next()) {
            myArray.add(rs.getString("extension"));

        }

        return myArray;
    }

    public boolean editExtension(String username, int extension, int newextension,Connection con) throws SQLException {
        try {
            String sql = "update ifsextensions set extension='" + newextension + "' where extension='" + extension + "' and username='" + username + "'";
            Statement stm = con.createStatement();
            
            stm.executeQuery(sql);
            System.out.println(sql);
            return true;
        } catch (Exception e) {

            return false;
        }
    }

    public boolean addExtension(String username, String fullname, int extension,String type,Connection con) {
        try {
            boolean state = false;
            
                String sql = "insert into ifsextensions values(" + extension + ",'" + username + "','" + fullname + "','"+type+"')";
                
                Statement stm = con.createStatement();
                stm.executeQuery(sql);
                System.out.println(sql);
                state = true;
               
            
            return state;

           
        } catch (Exception e) {

            return false;
        }
    }

    public boolean deleteExtension(String username, String fullname, int extension,Connection con) {
        try {
            System.out.println("delete");
            String sql = "delete from ifsextensions where extension=" + extension + " and username='" + username + "'";
            Statement stm = con.createStatement();
            System.out.println(sql);
            stm.executeQuery(sql);

            return true;
        } catch (Exception e) {

            return false;
        }
    }
    
    public String getUsername(String firstname, int extension,Connection con) throws SQLException{
        String username;
        String sql = "select distinct(username) from ifsextensions where extension=" + extension + " and fullname='" + firstname + "'";
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery(sql);
        if(rs.next()){
            username = rs.getString("username");
            return username;
        }
        else{
         return null;   
        }
        
    }
    
    public boolean getAdminvalidated(String username,Connection con) throws SQLException {
        boolean validate = false;
        String sql = "select username from ifsusers ";
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery(sql);
        System.out.println(sql);
        if(rs.next()){
        validate = true;
        }
        System.out.println(validate);
        return validate;
    }
    
    public boolean addNewUser(String username, String fullname, int extension,String type,Connection con) throws SQLException{
        boolean validate = false;
        
        String sql = "insert into ifsextensions values(" + extension + ",'" + username + "','" + fullname + "','" + type + "')";
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery(sql);
        System.out.println(sql);
        if(rs.next()){
            validate = true;
        }
        return validate;
    }
    
    public boolean checkExtension(int extension,Connection con) throws SQLException{
        boolean state = true;
        String sql = "select extension  from ifsextensions where extension = "+extension+"  ";
        System.out.println(sql);
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        
        while(resultSet.next()){
            System.out.println(resultSet.getInt("extension"));
            if(resultSet.getInt("extension")== extension){
                System.out.println(resultSet.getInt("extension")== extension);
                state = false;
                break;
            }
        }
        System.out.println(state);
        return state;
        
    }
    
    
    
    public boolean testAdmin(String username,Connection con) throws SQLException{
        boolean state = false;
        String sql= "select username from ifsusers where username ='"+username+"' AND userType='manager' ";
        System.out.println(sql);
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        
        while (resultSet.next()) {            
            state = true;
        }
        
        return state;
    }
    
    public  User getMember(String fullname,Connection con) throws SQLException{
        User user = new User();
         String sql =  "select username, extension, usertype from ifsextensions where fullname='"+fullname+"'";
        System.out.println(sql);
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        
        while (resultSet.next()) {            
            user.setUsername(resultSet.getString("username"));
            user.setFullname(fullname);
            ArrayList<String> num= new ArrayList<>();
            num.add(resultSet.getString("extension"));
            user.setExnum(num);
            user.setUsertype(resultSet.getString("usertype"));
            
        }
        System.out.println("user :"+user.getUsername()+" "+user.getFullname()+" "+user.getUsertype());
        return user;
        
    }
    
    public boolean getEmployee(String username,Connection con) throws SQLException{
        boolean status = false;
        String sql = "select distinct(username), fullname from ifsextensions where username='"+username+"'";
        System.out.println(sql);
        Statement statement = con.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        
        if(resultSet.next()){
            status =true;
        }
        return status;
    }

    
}
