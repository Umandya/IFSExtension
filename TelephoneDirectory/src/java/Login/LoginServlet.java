/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Login;

import ActiveDirectory.Authentication;
import DbConnect.DBConnection;
import DbConnect.MyConnection;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
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
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

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
        /* TODO output your page here. You may use following sample code. */
        RequestDispatcher rd;
        String url = request.getServletPath();
        MyConnection emp= new MyConnection();
                
        
        ActiveDirectory.Authentication ac = new Authentication();
       
         
        String IpAddress =  request.getRemoteAddr();
        InetAddress address = InetAddress.getByName(IpAddress);
        String username = address.getHostName();
        
        System.out.println("user:" + username);
        
        String[] user1 =  username.split("\\d");
        username = user1[0];
        username = username.toLowerCase();
        System.out.println("username: " + username);
        


        if ("/LoginServlet".equals(url)) {
            
//            String username = request.getParameter("username");
//            String password = request.getParameter("password");
             
            String user = "Correct user";
            String validate ;
            ArrayList<String> myArray = new ArrayList<>();
            ArrayList<String> memberArray = new ArrayList<String>();
           
           

            validate = ac.authenticate(username);
            System.out.println(username);
           // String director;
            
            if (validate != null) {
                    System.out.println(validate);
                    request.setAttribute("check", user);
                    String name = emp.GetName(username);
                    myArray = emp.GetExtension(username);
                   
                    
                    
                    
                    if(name==null)
                    {
                    name=ac.authenticate2(username);
                    }
                    
                    //admin priviledges
                    if("admin".equals(validate)){                   
                        System.out.println("admin");
                        request.setAttribute("username", username);
                        request.setAttribute("myusername", username);
                        request.setAttribute("fullname", name);
                        request.setAttribute("exNum", myArray);
                        request.setAttribute("type", "admin");
                        rd = request.getRequestDispatcher("profile.jsp");
                        rd.forward(request, response);                    
                        
                    }else{
                        System.out.println("member");
                        request.setAttribute("username", username);
                        request.setAttribute("myusername", username);
                        request.setAttribute("fullname", name);
                        request.setAttribute("exNum", myArray);
                        request.setAttribute("type", "member");
                        rd = request.getRequestDispatcher("memberProfile.jsp");
                        rd.forward(request, response);
                    }
                  
            } else {
                user = "Incorrect user";
            request.setAttribute("check", user);
                request.getRequestDispatcher("/loginError").forward(request, response);   
            }

        }
        if("/loginError".equals(url)){           
                try (PrintWriter out = response.getWriter()) {
                    rd = request.getRequestDispatcher("index.jsp");
                    rd.forward(request, response);
                }catch(Exception e){
                    System.out.println("end");
                }
        }   
        if ("/AdminLogin".equals(url)) {
            String user = request.getParameter("username");
            String fullname = request.getParameter("fullname");
            //String password =  request.getParameter("password");
          
             System.out.println(username+" "+fullname+" " );
            ArrayList<User> memberList = ac.memberNames(fullname, user);
            //ArrayList<User> memberList = emp.testUsernames();
            
            if(memberList.isEmpty()){
                System.out.println("you are not an admin");
                request.setAttribute("username", user);
                request.setAttribute("myusername", username);
                request.setAttribute("fullname", fullname);
                request.setAttribute("exNum", emp.GetExtension(username));
                rd = request.getRequestDispatcher("memberProfile.jsp");
                rd.forward(request, response);
               
            }else{
                System.out.println("you are  an admin");
                request.setAttribute("username", user);
                request.setAttribute("myusername", username);
                request.setAttribute("fullname", fullname);
                request.setAttribute("members", memberList);
                 rd = request.getRequestDispatcher("profile.jsp");
                 rd.forward(request, response);
           
            }
           
           
            }

    
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
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
