/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuclh.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import phuclh.daos.ArticleDAO;
import phuclh.dtos.ArticleDTO;
import phuclh.dtos.UserDTO;

/**
 *
 * @author Acer
 */
public class PostArticleServlet extends HttpServlet {

    private static final String SUCCESS = "LoadServlet";
    private static final String ERROR = "index.html";

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
        String url = ERROR;
        HttpSession session = request.getSession();
        UserDTO userDTO = (UserDTO) session.getAttribute("LOGIN_INFO");
        System.out.println(userDTO.getUserName());
        try {
            /* TODO output your page here. You may use following sample code. */
            String title = request.getParameter("txtArticleTitle");
            String desc = request.getParameter("txtShortDescription");
            String content = request.getParameter("txtContent");

            if (title.equals("") || desc.equals("") || content.equals("")) {
                request.setAttribute("MESSAGE", "Please fill field.");
            } else {

//                HttpSession session = request.getSession();
//                UserDTO userDTO = (UserDTO) session.getAttribute("LOGIN_INFO");
//                System.out.println(userDTO.getUserName());
                Date currentDate = new Date(System.currentTimeMillis());
                ArticleDAO dao = new ArticleDAO();
                ArticleDTO dto = new ArticleDTO(title, desc, content, userDTO.getEmail(), currentDate, "N");
                boolean check = dao.insertArticle(dto);
                if (check) {
                    url = SUCCESS;
                    request.setAttribute("MESSAGE", "Your blog is posted, please wait admin confirm");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
