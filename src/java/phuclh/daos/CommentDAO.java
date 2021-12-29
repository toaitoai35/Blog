/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuclh.daos;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import phuclh.dtos.CommentDTO;
import phuclh.utils.DBUtil;

/**
 *
 * @author Acer
 */
public class CommentDAO implements Serializable{
    
    private List<CommentDTO> commentList;

    public List<CommentDTO> getCommentList() {
        return commentList;
    }
    
    public boolean insertComment(CommentDTO dto) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pst = null;
        boolean check = false;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String sql = "insert tblComment(articleID, commentContent, commentDate, commentStatus,  commentEmail) values(?,?,?,?,?)";
                pst = con.prepareStatement(sql);
                pst.setInt(1, dto.getArticleID());
                pst.setString(2, dto.getCommentContent());
                pst.setDate(3, dto.getCommentDate());
                pst.setBoolean(4, dto.isCommentStatus());
                pst.setString(5, dto.getCommentEmail());
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
    
    public void getListComment(String id) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String sql = "select commentContent, commentDate, us.userName\n" +
                            "from tblComment com join tblUser us on com.commentEmail = us.email\n" +
                            "where articleID = ? and commentStatus = 1";
                pst = con.prepareStatement(sql);
                pst.setString(1, id);
                rs = pst.executeQuery();
                
                while (rs.next()) {
                    String commentContent = rs.getString("commentContent");
                    Date commentDate = rs.getDate("commentDate");
                    String userName = rs.getString("userName");
                    CommentDTO dto = new CommentDTO(commentContent, commentDate, userName);
                   
                    if (this.commentList == null) {
                        this.commentList = new ArrayList<>();
                    }
                    this.commentList.add(dto);
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
    }
}
