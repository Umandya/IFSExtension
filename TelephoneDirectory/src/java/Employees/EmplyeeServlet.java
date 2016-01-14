/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Employees;

import ActiveDirectory.Authentication;
import DbConnect.MyConnection;
import Model.User;
import com.google.gson.Gson;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author pvpelk
 */
@WebServlet(name = "EmplyeeServlet", urlPatterns = {"/EmplyeeServlet"})
public class EmplyeeServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.lang.ClassNotFoundException
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException, NamingException {
        response.setContentType("text/html;charset=UTF-8");

        RequestDispatcher rd;
        MyConnection empEx = new MyConnection();
        String url = request.getServletPath();
        ArrayList<String> myArray = new ArrayList<>();
        String username = request.getParameter("username");
        String type = request.getParameter("type");
        Authentication ac= new Authentication();
        
        if ("/EmplyeeServlet".equals(url)) {
            String name = request.getParameter("text");
            
            String sql = "SELECT distinct(username),fullname FROM IFSEXTENSIONS WHERE LOWER(FULLNAME)  LIKE LOWER('%" + name + "%')";
            ResultSet rs = empEx.getResults(sql);
            System.out.println(sql);
            String tempU = null,tempS = null, tempIS = null;
            int tempI, count = 0;
            ArrayList<String> arr = new ArrayList<String>();
            ArrayList<User> users = new ArrayList<>();

            if ("".equals(name)) {
                arr.add("");
            } else {
                while (rs.next()) {
                    User u =  new User();
                    u.setFullname(rs.getString("fullname"));
                    u.setUsername(rs.getString("username"));
                    tempU =  rs.getString("username");
                    tempS = rs.getString("fullname");
                   
                    users.add(u);
                    
//                    tempI = rs.getInt("extension");
//                    tempIS = Integer.toString(tempI);
//                    arr.add(tempS.concat("  ").concat(tempIS));
                }
                
                for(User u: users){
                ArrayList<String> list = empEx.GetExtension(u.getUsername());
                String num = "";
                for(String l:list){
                   
                    num =num+"  "+ l+",";
                }
                String str =num;
                str = str.substring(0, str.length()-1);
                arr.add(u.getFullname().concat(" : ").concat(str));
            }
            }
            
            

            Map<String, Object> map = new HashMap<String, Object>();
            map.put("names", arr);
            write(response, map);
            
            
            
            
        }
        
        if("/ProfileView".equals(url)){
//               
            
            
            String exName = request.getParameter("member");
            String[] name1 = exName.split("(?=[a-zA-Z])");
           //String [] name1 = exName.split("(?=[a-zA-z]):(?=)");
            String adminName = request.getParameter("admin");
            System.out.println(adminName);
            System.out.println("running here oK");
            String[] name = exName.split("\\s:\\s");
            String fullname = name[0];
            
            User user = empEx.getMember(fullname);
            ArrayList<String> exnum = empEx.GetExtension(user.getUsername());
                request.setAttribute("username", adminName);
                request.setAttribute("myusername", user.getUsername());
                request.setAttribute("fullname", fullname);
                request.setAttribute("exNum", exnum);
                request.setAttribute("type", user.getUsertype());
               
                rd = request.getRequestDispatcher("memberView.jsp");
                rd.forward(request, response);
            }
                       
                
             
      
        
        
        if ("/ProfileEdit".equals(url)) {
        
            try{
            
            int Nextension = Integer.parseInt(request.getParameter("Nextension"));
            
            int extension = Integer.parseInt(request.getParameter("extension"));
            String myname = request.getParameter("myusername");
            username = request.getParameter("username");
            type = request.getParameter("type");
            System.out.println("myname :"+myname);
                System.out.println("new extension:"+Nextension);
            Boolean updateSuccess = empEx.editExtension(myname, extension, Nextension);
            System.out.println(updateSuccess);
            if (updateSuccess) {
                System.out.println("success");

                String name = empEx.GetName(myname);
                myArray = empEx.GetExtension(myname);

                request.setAttribute("username", username);
                request.setAttribute("myusername", myname);
                request.setAttribute("fullname", name);
                request.setAttribute("exNum", myArray);
                request.setAttribute("type", type);
                
                if(!username.equals(myname)){
                    rd = request.getRequestDispatcher("memberView.jsp");
                }else if("admin".equals(type)){
                    rd = request.getRequestDispatcher("profile.jsp");
                }else{
                    rd = request.getRequestDispatcher("memberProfile.jsp");
                }
                
                
                rd.forward(request, response);
            } 
            
            
            }catch(Exception e){
            
                int extension = Integer.parseInt(request.getParameter("extension"));
                String myname = request.getParameter("myusername");
                username = request.getParameter("username");
                type = request.getParameter("type");
                String name = empEx.GetName(myname);
                myArray = empEx.GetExtension(myname);

                request.setAttribute("username", username);
                request.setAttribute("myusername", myname);
                request.setAttribute("fullname", name);
                request.setAttribute("exNum", myArray);
                request.setAttribute("type", type);
                
                if(!username.equals(myname)){
                    rd = request.getRequestDispatcher("memberView.jsp");
                }else if("admin".equals(type)){
                    rd = request.getRequestDispatcher("profile.jsp");
                }else{
                    rd = request.getRequestDispatcher("memberProfile.jsp");
                }
                
                rd.forward(request, response);
            }
            
        }

        if ("/ProfileAdd".equals(url)) {

            int extension = Integer.parseInt(request.getParameter("extension"));
            String fullname = request.getParameter("fullname");
            String myname = request.getParameter("myusername");
            username = request.getParameter("username");
            type = request.getParameter("type");
            Boolean updateSuccess = empEx.addExtension(myname, fullname, extension,type);

            if (updateSuccess) {
                System.out.println(updateSuccess +" "+username);

                String name = empEx.GetName(myname);
                myArray = empEx.GetExtension(myname);

                request.setAttribute("username", username);
                request.setAttribute("myusername", myname);
                request.setAttribute("fullname", name);
                request.setAttribute("exNum", myArray);
                request.setAttribute("type", type);
                if(!username.equals(myname)){
                    rd = request.getRequestDispatcher("memberView.jsp");
                }else if("admin".equals(type)){
                    rd = request.getRequestDispatcher("profile.jsp");
                }else{
                    rd = request.getRequestDispatcher("memberProfile.jsp");
                }
                
                rd.forward(request, response);
            }

        }

        if ("/ProfileDelete".equals(url)) {

            int extension = Integer.parseInt(request.getParameter("extension"));
            String fullname = request.getParameter("fullname");
            username = request.getParameter("username");
            String myname= request.getParameter("myusername");
            type =request.getParameter("type");
            Boolean updateSuccess = empEx.deleteExtension(myname, fullname, extension);

            if (updateSuccess) {
                System.out.println(updateSuccess);

                myArray = empEx.GetExtension(myname);

                request.setAttribute("username", username);
                request.setAttribute("myusername", myname);
                request.setAttribute("fullname", fullname);
                request.setAttribute("exNum", myArray);
                request.setAttribute("type", type);
                if(!username.equals(myname)){
                    rd = request.getRequestDispatcher("memberView.jsp");
                }else if("admin".equals(type)){
                    rd = request.getRequestDispatcher("profile.jsp");
                }else{
                    rd = request.getRequestDispatcher("memberProfile.jsp");
                }
                
                
                rd.forward(request, response);
            }

        }
        
        if ("/AddNewEmployee".equals(url)) {
            
//            
           
//            
            System.out.println("on d way");
            username = request.getParameter("newusername");
            String fullname = request.getParameter("newfname");
            String extension = request.getParameter("newextension");
            String admin = request.getParameter("username");
            type = "member";
            
            
            int exten = Integer.parseInt(extension);
            System.out.println("type "+fullname);
            boolean validate = empEx.addNewUser(username, fullname, exten,type);
            
            ArrayList<String> memberList = new ArrayList<>();
            request.setAttribute("username", admin);
            request.setAttribute("fullname", fullname);
            request.setAttribute("myusername", username);
            request.setAttribute("type", type);
            request.setAttribute("exNum", empEx.GetExtension(username));
                    
            
            rd = request.getRequestDispatcher("memberProfile.jsp");
            rd.forward(request, response);
        }
        
        if("/NewEmployee".equals(url)){
            System.out.println("hiiii");
             String name = request.getParameter("text");
            System.out.println(name);
            String fn = null;
            if(name.endsWith("lk") || name.endsWith("LK")){
                fn = ac.checkNewEmployee(name);
                System.out.println("fullname :"+fn);
                ArrayList<String> list = new ArrayList<>();
                
                list.add(fn);
                
                Map<String, Object>  map = new HashMap<String, Object>();
                map.put("fullname", list);
                System.out.println("fn :"+map.get("fullname").toString());
                
                write(response, map);
                
            }
        
        }
        
        


        
        
       
        
        
        
        
        
    }

    private void write(HttpServletResponse response, Map<String, Object> map) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        response.getWriter().write(new Gson().toJson(map));
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException | SQLException | NamingException ex) {
            Logger.getLogger(EmplyeeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException | SQLException | NamingException ex) {
            Logger.getLogger(EmplyeeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
