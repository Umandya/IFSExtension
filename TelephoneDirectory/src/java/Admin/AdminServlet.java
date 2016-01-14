/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Admin;

import ActiveDirectory.Authentication;
import DbConnect.MyConnection;
import java.io.IOException;
import static java.lang.System.out;
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
@WebServlet(name = "AdminServlet", urlPatterns = {"/AdminServlet"})
public class AdminServlet extends HttpServlet {

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
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet AdminServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet AdminServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }

        RequestDispatcher rd;
        MyConnection empEx = new MyConnection();
        String url = request.getServletPath();
        Authentication ac= new Authentication();
       

        
        if("/AdminServlet".equals(url)){
             System.out.println("admin");
            String user = request.getParameter("musername");
            String fullname = request.getParameter("mfullname");
            ArrayList<String> extn = empEx.GetExtension(user);
            
            
            System.out.println(user+" admin");
            request.setAttribute("username", user);
            request.setAttribute("fullname", fullname);
            request.setAttribute("exNum", extn);
           
            //rd = request.getRequestDispatcher("memberProfile.jsp");
            rd = request.getRequestDispatcher("memberProfile.jsp");
            rd.forward(request, response);
        }else{
        
            out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Servlet LoginServlet</title>");
                out.println("</head>");
                out.println("<body>");
                out.println("<h1>Login Error!!!</h1>");
                out.println("</body>");
                out.println("</html>");
        }
        
        
        if ("/AdminChangeEx".equals(url)) {
            String employee = request.getParameter("bbb");
            String fname = "";
            String ex;
            int extension;
            String[] temp = employee.split("\\s+");
            ex = employee.substring(employee.lastIndexOf(' ') + 1);

            for (int i = 0; i < temp.length; i++) {
                if (temp[i].equals(ex)) {
                    break;
                } else {
                    if (i == 0) {
                        fname = fname.concat(temp[i]);
                    } else {
                        fname = fname.concat(" ");
                        fname = fname.concat(temp[i]);
                    }
                }
            }
            extension = Integer.parseInt(ex);
            String uname = empEx.getUsername(fname, extension);

            ArrayList<String> myArray = new ArrayList<>();
            boolean validate = empEx.userIdentification(uname);

            if (validate) {

                String name = empEx.GetName(uname);
                myArray = empEx.GetExtension(uname);

                request.setAttribute("username", uname);
                request.setAttribute("fullname", name);
                request.setAttribute("exNum", myArray);
                rd = request.getRequestDispatcher("profile.jsp");
                rd.forward(request, response);
            } else {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Servlet LoginServlet</title>");
                out.println("</head>");
                out.println("<body>");
                out.println("<h1>Login Error!!!</h1>");
                out.println("</body>");
                out.println("</html>");
            }
        }

        if ("/AddNewEmployee".equals(url)) {
            String username = request.getParameter("username");
            String fullname = request.getParameter("fullname");
            String extension = request.getParameter("extension");
            int exten = Integer.parseInt(extension);
           // boolean validate = empEx.addNewUser(username, fullname, exten);
            
            ArrayList<String> memberList = new ArrayList<>();
            request.setAttribute("username", username);
            request.setAttribute("fullname", fullname);
            request.setAttribute("exNum", empEx.GetExtension(username));
                    
            
            rd = request.getRequestDispatcher("memberProfile.jsp");
            rd.forward(request, response);
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
            Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
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
