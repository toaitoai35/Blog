/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuclh.daos;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import phuclh.dtos.UserDTO;
import phuclh.utils.DBUtil;

/**
 *
 * @author Acer
 */
public class UserDAO implements Serializable {

    public UserDTO checkLogin(String email, String password) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        UserDTO dto = null;
        try {
            con = DBUtil.getConnection();

            if (con != null) {
                String sql = "select userName, roleName, status from tblUser us join tblRole ro on us.roleID = ro.roleID where email = ? and password = ?";
                pst = con.prepareStatement(sql);
                pst.setString(1, email);
                pst.setString(2, password);
                rs = pst.executeQuery();

                if (rs.next()) {
                    String name = rs.getString("userName");
                    String role = rs.getString("roleName");
                    String status = rs.getString("status");
                    dto = new UserDTO(email, password, name, role, status);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return dto;
    }
    
    public UserDTO getUserAccount(UserDTO userDTO) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        UserDTO dto = null;
        try {
            con = DBUtil.getConnection();

            if (con != null) {
                String sql = "select status from tblUser where email = ?";
                pst = con.prepareStatement(sql);
                pst.setString(1, userDTO.getEmail());
                rs = pst.executeQuery();

                if (rs.next()) {
                    String status = rs.getString("status");
                    dto = new UserDTO(userDTO.getEmail(), userDTO.getPassword(), userDTO.getUserName(), userDTO.getRole(), status);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return dto;
    }

    public boolean checkUserExist(String email) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        boolean check = false;
        try {
            con = DBUtil.getConnection();

            if (con != null) {
                String sql = "select email from tblUser where email = ?";

                pst = con.prepareStatement(sql);
                pst.setString(1, email);
                rs = pst.executeQuery();

                if (rs.next()) {
                    check = true;
                }

            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return check;
    }
    
    public boolean createUser (UserDTO userDTO) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pst = null;
        boolean check = false;
        try {
            con = DBUtil.getConnection();
            
            if (con != null) {
                String sql = "insert tblUser(email, password, userName, roleID, status, createDate) values(?,?,?,?,?,?)";
                pst = con.prepareStatement(sql);
                pst.setString(1, userDTO.getEmail());
                pst.setString(2, userDTO.getPassword());
                pst.setString(3, userDTO.getUserName());
                pst.setString(4, userDTO.getRole());
                pst.setString(5, userDTO.getStatus());
                pst.setDate(6, userDTO.getCreateDate());
                int row = pst.executeUpdate();
                
                if (row > 0) {
                    check = true;
                }
                
            }
        } finally {
            if (pst != null) {
                pst.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return check;
    }
    
    public boolean updateAccountStatus (UserDTO dto) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pst = null;
        boolean check = false;
        try {
            con = DBUtil.getConnection();
            
            if (con != null) {
                String sql = "update tblUser set status = 'Active' where email = ?";
                pst = con.prepareStatement(sql);
                pst.setString(1, dto.getEmail());
                int row = pst.executeUpdate();
                
                if (row > 0) {
                    check = true;
                }
                
            }
        } finally {
            if (pst != null) {
                pst.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return check;
    }
    
    public UserDTO getEmailSender() throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        UserDTO dto = null;
        try {
            con = DBUtil.getConnection();

            if (con != null) {
                String sql = "select top 1 senderEmail, senderPassword from tblSenderEmail where senderStatus = 1 order by NEWID()";
                pst = con.prepareStatement(sql);
                rs = pst.executeQuery();

                if (rs.next()) {
                    String email = rs.getString("senderEmail");
                    String password = rs.getString("senderPassword");
                    dto = new UserDTO(email, password);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return dto;
    }
}
