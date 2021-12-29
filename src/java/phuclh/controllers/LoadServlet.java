/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuclh.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
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
public class LoadServlet extends HttpServlet {

    private static final String USER_PAGE = "home.jsp";
    private static final String ADMIN_PAGE = "admin.jsp";

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
        String url = USER_PAGE;
        try {
            HttpSession session = request.getSession();
            UserDTO dto = (UserDTO) session.getAttribute("LOGIN_INFO");
            int page = 1;
            int recordOfPage = 20;
            if (request.getParameter("PAGE") != null) {
                page = Integer.parseInt(request.getParameter("PAGE"));
            }
            List<ArticleDTO> artList = new ArrayList<>();
            ArticleDAO artDAO = new ArticleDAO();
            if (dto == null || dto.getRole().equals("Member")) {
                artDAO.loadRecord((page - 1) * recordOfPage, recordOfPage, "Member");
                artList = artDAO.getArticleList();
                url = USER_PAGE;
            } else {
                String status = request.getParameter("cbxStatus");
                if (status != null) {
                    if (status.equals("")) {
                        artDAO.loadRecord((page - 1) * recordOfPage, recordOfPage, dto.getRole());
                    } else {
                        artDAO.searchRecordForAdmin("", (page - 1) * recordOfPage, recordOfPage, status);
                    }
                } else {
                    artDAO.loadRecord((page - 1) * recordOfPage, recordOfPage, dto.getRole());
                }
                artList = artDAO.getArticleList();
                url = ADMIN_PAGE;
            }

            int noOfRecord = artDAO.getNoOfRecord();
            int noOfPage = (int) Math.ceil(noOfRecord * 1.0 / recordOfPage);
            request.setAttribute("ARTICLE_LIST", artList);
            request.setAttribute("NUM_OF_PAGE", noOfPage);
            request.setAttribute("CURREN_PAGE", page);
            List<String> listStatus = artDAO.getArticleStatusList();
            session.setAttribute("STATUS_LIST", listStatus);
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
