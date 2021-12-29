/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuclh.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import phuclh.daos.UserDAO;
import phuclh.dtos.UserDTO;
import phuclh.dtos.UserErrorDTO;
import phuclh.utils.HelpUtil;

/**
 *
 * @author Acer
 */
public class CreateNewAccountServlet extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            /* TODO output your page here. You may use following sample code. */
            String email = request.getParameter("txtEmail");
            String password = request.getParameter("txtPassword");
            String rePassword = request.getParameter("txtRePassword");
            String username = request.getParameter("txtUsername");
            Date currentDate = new Date(System.currentTimeMillis());
            boolean check = false;
            boolean checkEmail = false;

            UserErrorDTO errorDTO = new UserErrorDTO();
            UserDAO userDAO = new UserDAO();

            if (email.equals("")) {
                check = true;
                errorDTO.setEmailError("This field cant be blank!");
            }
            if (password.equals("")) {
                check = true;
                errorDTO.setPassword("This field cant be blank!");
            }
            if (rePassword.equals("")) {
                check = true;
                errorDTO.setRePassword("This field cant be blank!");
            }
            if (username.equals("")) {
                check = true;
                errorDTO.setUsername("This field cant be blank!");
            }
            if (check) {
                request.setAttribute("CREATE_ERROR", errorDTO);
            } else {
                if (!rePassword.equals(password)) {
                    check = true;
                    errorDTO.setRePassword("Password is not macth");
                }

                checkEmail = HelpUtil.checkFormat(email, "^[a-z][a-z0-9_\\.]{5,32}@[a-z0-9]{2,}(\\.[a-z0-9]{2,4}){1,2}$");
                if (checkEmail) {
                    check = true;
                    errorDTO.setEmailError("Email is not valid format");
                }
                
                checkEmail = userDAO.checkUserExist(email);
                if (checkEmail) {
                    check = true;
                    errorDTO.setEmailError("Email is exist");
                }
                
                if (check) {
                    request.setAttribute("CREATE_ERROR", errorDTO);
                } else {
                    String encodePassword = HelpUtil.encodePassword(password);
                    UserDTO userDTO = new UserDTO(email, encodePassword, username, "MEM", "New", currentDate);
                    
                    boolean checkInsert = userDAO.createUser(userDTO);
                    
                    if (checkInsert) {
                        request.setAttribute("CREATE_USER", "Create successful");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher("createNewAccount.jsp").forward(request, response);
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
        processRequest(request, response);
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
        processRequest(request, response);
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
