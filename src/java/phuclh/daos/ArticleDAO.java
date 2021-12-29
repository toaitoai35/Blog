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
import phuclh.dtos.ArticleDTO;
import phuclh.utils.DBUtil;

/**
 *
 * @author Acer
 */
public class ArticleDAO implements Serializable {

    private List<ArticleDTO> articleList;
    private int noOfRecord;

    public int getNoOfRecord() {
        return noOfRecord;
    }

    public List<ArticleDTO> getArticleList() {
        return articleList;
    }

    public boolean insertArticle(ArticleDTO dto) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pst = null;
        boolean check = false;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String sql = "insert tblArticle(articleTitle, articleShortDesc, articleContent, articleAuthor, articlePostingDate, articleStatus) values(?,?,?,?,?,?)";
                pst = con.prepareStatement(sql);
                pst.setString(1, dto.getArticleTitle());
                pst.setString(2, dto.getArticleShortDesc());
                pst.setString(3, dto.getArticleContent());
                pst.setString(4, dto.getArticleAuthor());
                pst.setDate(5, dto.getPostingDate());
                pst.setString(6, dto.getArticleStatus());
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

    public void loadRecord(int offset, int numberOfRecord, String role) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String sql = "";
                if (role.equals("Member")) {
                    sql = "SELECT articleID, articleTitle, articleShortDesc, articleContent, us.userName, articlePostingDate, articleName\n"
                            + "FROM (tblArticle art join tblUser us on art.articleAuthor = us.email) join tblArticleStatus sta on art.articleStatus = sta.articleStatusID\n"
                            + "where articleStatus = 'A'\n"
                            + "ORDER BY articleID\n"
                            + "  OFFSET ? ROWS\n"
                            + "  FETCH NEXT ? ROWS ONLY;";
                }
                if (role.equals("Admin")) {
                    sql = "SELECT articleID, articleTitle, articleShortDesc, articleContent, us.userName, articlePostingDate, articleName\n"
                            + "FROM (tblArticle art join tblUser us on art.articleAuthor = us.email) join tblArticleStatus sta on art.articleStatus = sta.articleStatusID\n"
                            + "ORDER BY articleID\n"
                            + "  OFFSET ? ROWS\n"
                            + "  FETCH NEXT ? ROWS ONLY;";
                }
                pst = con.prepareStatement(sql);
                pst.setInt(1, offset);
                pst.setInt(2, numberOfRecord);
                rs = pst.executeQuery();

                while (rs.next()) {
                    int artID = rs.getInt("articleID");
                    String artTitle = rs.getString("articleTitle");
                    String artShortDesc = rs.getString("articleShortDesc");
                    String artContent = rs.getString("articleContent");
                    String artAuthor = rs.getString("userName");
                    Date artDate = rs.getDate("articlePostingDate");
                    String artStatus = rs.getString("articleName");
                    ArticleDTO dto = new ArticleDTO(artID, artTitle, artShortDesc, artContent, artAuthor, artDate, artStatus);

                    if (this.articleList == null) {
                        this.articleList = new ArrayList();
                    }
                    this.articleList.add(dto);
                }

                if (role.equals("Member")) {
                    sql = "select COUNT(*) as 'Row' from tblArticle where articleStatus = 'A'";
                }
                if (role.equals("Admin")) {
                    sql = "select COUNT(*) as 'Row' from tblArticle";
                }
                pst = con.prepareStatement(sql);
                rs = pst.executeQuery();

                if (rs.next()) {
                    this.noOfRecord = rs.getInt("Row");
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

    public void searchRecord(String searchValue, int offset, int numberOfRecord) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String sql = "SELECT articleID, articleTitle, articleShortDesc, articleContent, userName, articlePostingDate, articleName\n"
                        + "FROM (tblArticle art join tblUser us on art.articleAuthor = us.email) join tblArticleStatus sta on art.articleStatus = sta.articleStatusID\n"
                        + "where articleContent like ? and articleStatus = 'A'\n"
                        + "ORDER BY articleID\n"
                        + "  OFFSET ? ROWS\n"
                        + "  FETCH NEXT ? ROWS ONLY;";
                pst = con.prepareStatement(sql);
                pst.setString(1, "%" + searchValue + "%");
                pst.setInt(2, offset);
                pst.setInt(3, numberOfRecord);
                rs = pst.executeQuery();

                while (rs.next()) {
                    int artID = rs.getInt("articleID");
                    String artTitle = rs.getString("articleTitle");
                    String artShortDesc = rs.getString("articleShortDesc");
                    String artContent = rs.getString("articleContent");
                    String artAuthor = rs.getString("userName");
                    Date artDate = rs.getDate("articlePostingDate");
                    String artStatus = rs.getString("articleName");
                    ArticleDTO dto = new ArticleDTO(artID, artTitle, artShortDesc, artContent, artAuthor, artDate, artStatus);

                    if (this.articleList == null) {
                        this.articleList = new ArrayList();
                    }
                    this.articleList.add(dto);
                }

                sql = "select COUNT(*) as 'Row' from tblArticle where articleContent like ? and articleStatus = 'A'";
                pst = con.prepareStatement(sql);
                pst.setString(1, "%" + searchValue + "%");
                rs = pst.executeQuery();

                if (rs.next()) {
                    this.noOfRecord = rs.getInt("Row");
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

    public void searchRecordForAdmin(String searchValue, int offset, int numberOfRecord, String status) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String sql = "";
                if ((!searchValue.equals("") && !status.equals("")) || (searchValue.equals("") && !status.equals(""))) {
                    sql = "SELECT articleID, articleTitle, articleShortDesc, articleContent, userName, articlePostingDate, articleName\n"
                            + "FROM (tblArticle art join tblUser us on art.articleAuthor = us.email) join tblArticleStatus sta on art.articleStatus = sta.articleStatusID\n"
                            + "where articleContent like ? and articleName = ?\n"
                            + "ORDER BY articleID\n"
                            + "  OFFSET ? ROWS\n"
                            + "  FETCH NEXT ? ROWS ONLY;";
                }
                if (!searchValue.equals("") && status.equals("")) {
                    sql = "SELECT articleID, articleTitle, articleShortDesc, articleContent, userName, articlePostingDate, articleName\n"
                            + "FROM (tblArticle art join tblUser us on art.articleAuthor = us.email) join tblArticleStatus sta on art.articleStatus = sta.articleStatusID\n"
                            + "where articleContent like ? or articleName = ?\n"
                            + "ORDER BY articleID\n"
                            + "  OFFSET ? ROWS\n"
                            + "  FETCH NEXT ? ROWS ONLY;";
                }
                pst = con.prepareStatement(sql);
                pst.setString(1, "%" + searchValue + "%");
                pst.setString(2, status);
                pst.setInt(3, offset);
                pst.setInt(4, numberOfRecord);
                rs = pst.executeQuery();

                while (rs.next()) {
                    int artID = rs.getInt("articleID");
                    String artTitle = rs.getString("articleTitle");
                    String artShortDesc = rs.getString("articleShortDesc");
                    String artContent = rs.getString("articleContent");
                    String artAuthor = rs.getString("userName");
                    Date artDate = rs.getDate("articlePostingDate");
                    String artStatus = rs.getString("articleName");
                    ArticleDTO dto = new ArticleDTO(artID, artTitle, artShortDesc, artContent, artAuthor, artDate, artStatus);

                    if (this.articleList == null) {
                        this.articleList = new ArrayList();
                    }
                    this.articleList.add(dto);
                }

                if (!searchValue.equals("") && !status.equals("") || (searchValue.equals("") && !status.equals(""))) {
                    sql = "select COUNT(*) as 'Row' from tblArticle art join tblArticleStatus sta on art.articleStatus = sta.articleStatusID where articleContent like ? and sta.articleName = ?";
                }
                if (!searchValue.equals("") && status.equals("")) {
                    sql = "select COUNT(*) as 'Row' from tblArticle art join tblArticleStatus sta on art.articleStatus = sta.articleStatusID where articleContent like ? or sta.articleName = ?";
                }
                pst = con.prepareStatement(sql);
                pst.setString(1, "%" + searchValue + "%");
                pst.setString(2, status);
                rs = pst.executeQuery();

                if (rs.next()) {
                    this.noOfRecord = rs.getInt("Row");
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

    public ArticleDTO getArticleByDetail(String id, String role) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        ArticleDTO dto = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String sql = "";
                if (role.equals("Member")) {
                    sql = "select articleID, articleTitle, articleShortDesc, articleContent, us.userName, articlePostingDate, articleName \n"
                            + "from (tblArticle art join tblUser us on art.articleAuthor = us.email) join tblArticleStatus sta on art.articleStatus = sta.articleStatusID\n"
                            + "where articleID = ? and articleStatus = 'A'";
                }
                if (role.equals("Admin")) {
                    sql = "select articleID, articleTitle, articleShortDesc, articleContent, us.userName, articlePostingDate, articleName \n"
                            + "from (tblArticle art join tblUser us on art.articleAuthor = us.email) join tblArticleStatus sta on art.articleStatus = sta.articleStatusID\n"
                            + "where articleID = ?";
                }
                pst = con.prepareStatement(sql);
                pst.setString(1, id);

                rs = pst.executeQuery();

                if (rs.next()) {
                    int artID = rs.getInt("articleID");
                    String artTitle = rs.getString("articleTitle");
                    String artShortDesc = rs.getString("articleShortDesc");
                    String artContent = rs.getString("articleContent");
                    String artAuthor = rs.getString("userName");
                    Date artDate = rs.getDate("articlePostingDate");
                    String artStatus = rs.getString("articleName");
                    dto = new ArticleDTO(artID, artTitle, artShortDesc, artContent, artAuthor, artDate, artStatus);
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

    public List<String> getArticleStatusList() throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        List<String> listStatus = null;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String sql = "select articleName from tblArticleStatus";
                pst = con.prepareStatement(sql);
                rs = pst.executeQuery();

                while (rs.next()) {
                    String status = rs.getString("articleName");
                    if (listStatus == null) {
                        listStatus = new ArrayList<>();
                    }
                    listStatus.add(status);
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
        return listStatus;
    }

    public boolean updateStatus(String id, String status) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement pst = null;
        boolean check = false;
        try {
            con = DBUtil.getConnection();
            if (con != null) {
                String sql = "update tblArticle set articleStatus = ? where articleID = ?";
                pst = con.prepareStatement(sql);
                pst.setString(1, status);
                pst.setString(2, id);
                int row = pst.executeUpdate();
                
                if (row > 0 ) {
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
}
