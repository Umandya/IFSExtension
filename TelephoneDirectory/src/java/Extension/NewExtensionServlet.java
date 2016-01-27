/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Extension;

import ActiveDirectory.Authentication;
import DbConnect.MyConnection;
import java.io.IOException;
import java.io.PrintWriter;
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
 * @author umchlk
 */
@WebServlet(name = "NewExtensionServlet", urlPatterns = {"/NewExtensionServlet"})
public class NewExtensionServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException, NamingException {
        response.setContentType("text/html;charset=UTF-8");
       
        RequestDispatcher requestDispatcher;
        Authentication ac = new Authentication();
        MyConnection connection = new MyConnection();
               
        String url = request.getServletPath();
        String username = request.getParameter("username");
        String myname = request.getParameter("myusername");
        String fullname = request.getParameter("fullname");  
        String type = request.getParameter("type");
        int extension = 0;
//        if(request.getParameter("extension") != null){
//            extension = Integer.parseInt(request.getParameter("extension"));
//        }
        ArrayList<String> myarray = connection.GetExtension(myname);
     //   ArrayList<String> memberList = ac.memberNames(fullname, username, password);
        
        
        if("/NewExtensionServlet" .equals(url)){
            System.out.println("new extn");
           String extn = "Correct extension";    
           
        username = request.getParameter("username");
        myname = request.getParameter("myusername");
        fullname = request.getParameter("fullname");  
        type = request.getParameter("type");
        
        try{
            extension = Integer.parseInt(request.getParameter("extension"));
        }catch(Exception e){
            extension = 0;
        }
        
        
           
           Boolean result = connection.addExtension(myname, fullname, extension,type);
            System.out.println("hi "+result);
           if(result){
               
            request.setAttribute("check", extn);
            
            myarray = connection.GetExtension(myname);
            
            
            request.setAttribute("username", username);
            request.setAttribute("myusername", myname);
            request.setAttribute("fullname", fullname);
            request.setAttribute("exNum", myarray);
            request.setAttribute("type", type);
            
            if(!username.equals(myname)){
                    requestDispatcher = request.getRequestDispatcher("memberView.jsp");
            }else if("admin".equals(type)){
                      requestDispatcher = request.getRequestDispatcher("profile.jsp");
            }else{
                    requestDispatcher = request.getRequestDispatcher("memberProfile.jsp");
            }
                  
            
            requestDispatcher.forward(request, response);
            
            
           }else{
               extn = "Extension using";
               request.setAttribute("check", extn);
               request.getRequestDispatcher("/ExtensionSavingError").forward(request, response); 
               
           }   
        }
        
        
        
        
        if("/ExtensionSavingError".equals(url)){           
               try (PrintWriter out = response.getWriter()) {
                  
                   
                   request.setAttribute("username", username);
                    request.setAttribute("fullname", fullname);
                    request.setAttribute("exNum", myarray);
                   request.setAttribute("myusername", myname);
                    request.setAttribute("type", type);
            
            if(!username.equals(myname)){
                    requestDispatcher = request.getRequestDispatcher("memberView.jsp");
            }else if("admin".equals(type)){
                     requestDispatcher = request.getRequestDispatcher("profile.jsp");
            }else{
                    requestDispatcher = request.getRequestDispatcher("memberProfile.jsp");
            }
                
               
               
        }
            
            
           /* try (PrintWriter out = response.getWriter()) {
                    out.println("<!DOCTYPE html>");
                    out.println("<html>");
                    out.println("<head>");
                    out.println("<title>ExtensionSavingError</title>");
                    out.println("</head>");
                    out.println("<body>");
                    out.println("<h1>Its already used</h1>");
                    out.println("</body>");
                    out.println("</html>");
                }*/
        }
        
        
        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NewExtension</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Login failed!!</h1>");
            out.println("</body>");
            out.println("</html>");
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
            Logger.getLogger(NewExtensionServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(NewExtensionServlet.class.getName()).log(Level.SEVERE, null, ex);
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
