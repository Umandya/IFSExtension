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
    
    
      public void update(String sql) throws SQLException, ClassNotFoundException {
          Connection con = DBConnection.getConnectionToDB();
        Statement stm = con.createStatement();
        stm.executeQuery(sql);
    }

    public ResultSet getResults(String sql) throws SQLException, ClassNotFoundException {
        Connection con = DBConnection.getConnectionToDB();
        Statement stm = con.createStatement();
        //stm.executeQuery(sql);
        ResultSet rs = stm.executeQuery(sql);
//        con.close();
        return rs;
    }

    
    
    public boolean userIdentification(String u_name) throws SQLException, ClassNotFoundException {
        Connection con = DBConnection.getConnectionToDB();
        boolean validate = false;
        //String sql = "select * from ifsextensions";
        String sql = "select * from users";
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

    public String GetName(String u_name) throws SQLException, ClassNotFoundException {
        Connection con = DBConnection.getConnectionToDB();
        String sql = "select distinct(fullname) from users where username='" + u_name + "'";
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

    public boolean deleteUser(String[] arr) throws SQLException, ClassNotFoundException {
        Connection con = DBConnection.getConnectionToDB();
        PreparedStatement delemp = con.prepareStatement("DELETE FROM pravi.USERS WHERE id = ?");
        for (String s : arr) {
            delemp.setInt(1, Integer.parseInt(s));
            delemp.executeUpdate();
        }
        return true;
    }

    public ArrayList GetExtension(String u_name) throws SQLException, ClassNotFoundException {
        Connection con = DBConnection.getConnectionToDB();
        String sql = "select distinct(extension) from extension where username='" + u_name + "'";
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

    public boolean editExtension(String username, int extension, int newextension) throws SQLException {
        try {
            Connection con = DBConnection.getConnectionToDB();
            String sql = "update extension set extension='" + newextension + "' where extension='" + extension + "' and username='" + username + "'";
            Statement stm = con.createStatement();
            
            stm.executeQuery(sql);
            System.out.println(sql);
            return true;
        } catch (Exception e) {

            return false;
        }
    }

    public boolean addExtension(String username, String fullname, int extension,String type) {
        try {
            Connection con = DBConnection.getConnectionToDB();
            boolean state = false;
                String sql = "select username from USERS where username ='"+username+"'";
                Statement stm = con.createStatement();
                ResultSet resultSet = stm.executeQuery(sql);
                System.out.println(sql + " "+ resultSet.next());
               
                
                if(resultSet.next()){
                    System.out.println("ane mnda");
                    sql = "insert into EXTENSION values ("+extension+",'"+username+"','"+username+"')";
                    stm.executeQuery(sql);
                    System.out.println("1 :"+sql);
                    
                }else{
                    System.out.println("ane mnda 2");
                    sql = "insert into USERS values ('"+username+"','"+fullname+"','admin')";
                    state= stm.execute(sql);
                    //if(state){
                        sql = "insert into EXTENSION values("+extension+",'"+username+"','"+username+"')";
                        stm.execute(sql);
                        System.out.println("2 :"+sql);
                   // }
                    
                }
                
                //sql = "insert into ifsextensions values(" + extension + ",'" + username + "','" + fullname + "','"+type+"')";
                
                //stm.executeQuery(sql);
               System.out.println(sql);
                state = true;
               
            
            return state;

           
        } catch (Exception e) {
            System.out.println(e.toString());
            return false;
        }
    }

    public boolean deleteExtension(String username, String fullname, int extension) {
        try {
            Connection con = DBConnection.getConnectionToDB();
            System.out.println("delete");
            String sql = "delete from extension where extension=" + extension + " and username='" + username + "'";
            Statement stm = con.createStatement();
            System.out.println(sql);
            stm.executeQuery(sql);

            return true;
        } catch (Exception e) {

            return false;
        }
    }
    
    public String getUsername(String firstname, int extension) throws SQLException, ClassNotFoundException{
        Connection con = DBConnection.getConnectionToDB();
        String username;
        String sql = "select u.username from USERS u\n" +
"  LEFT JOIN EXTENSION e ON u.USERNAME = e.USERNAME\n" +
"  where u.FULLNAME = '"+firstname+"' AND e.EXTENSION = "+extension+"";
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
    
    public boolean getAdminvalidated(String username) throws SQLException, ClassNotFoundException {
        Connection con = DBConnection.getConnectionToDB();
        boolean validate = false;
        String sql = "select username from users ";
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery(sql);
        System.out.println(sql);
        if(rs.next()){
        validate = true;
        }
        System.out.println(validate);
        return validate;
    }
    
    public boolean addNewUser(String username, String fullname, int extension,String type) throws SQLException, ClassNotFoundException{
        Connection con = DBConnection.getConnectionToDB();
        boolean validate = false;
        
        String sql = "INSERT INTO USERS VALUES ('"+username+"','"+fullname+"','"+username+"')";
        Statement stm = con.createStatement();
         validate =stm.execute(sql);
        if(validate){
            sql = "INSERT INTO EXTENSION VALUES ("+extension+",'"+username+"','"+username+"')";
            
        }
         
        return validate;
    }
    
    public boolean checkExtension(int extension) throws SQLException, ClassNotFoundException{
        Connection con = DBConnection.getConnectionToDB();
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
    
    
    
    public boolean testAdmin(String username) throws SQLException, ClassNotFoundException{
        Connection con = DBConnection.getConnectionToDB();
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
    
    public  User getMember(String fullname) throws SQLException, ClassNotFoundException{
        Connection con = DBConnection.getConnectionToDB();
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
    
    public boolean getEmployee(String username) throws SQLException, ClassNotFoundException{
        Connection con = DBConnection.getConnectionToDB();
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
