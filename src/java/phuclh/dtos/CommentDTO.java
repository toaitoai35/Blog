/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuclh.dtos;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author Acer
 */
public class CommentDTO implements Serializable {

    private int commentID;
    private int articleID;
    private String commentContent;
    private Date commentDate;
    private boolean commentStatus;
    private String commentEmail;

    public String getCommentEmail() {
        return commentEmail;
    }

    public void setCommentEmail(String commentEmail) {
        this.commentEmail = commentEmail;
    }

    public CommentDTO(String commentContent, Date commentDate, String commentEmail) {
        this.commentContent = commentContent;
        this.commentDate = commentDate;
        this.commentEmail = commentEmail;
    }

    public CommentDTO(int commentID, int articleID, String commentContent, Date commentDate, boolean commentStatus, String commentEmail) {
        this.commentID = commentID;
        this.articleID = articleID;
        this.commentContent = commentContent;
        this.commentDate = commentDate;
        this.commentStatus = commentStatus;
        this.commentEmail = commentEmail;
    }

    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }

    public int getArticleID() {
        return articleID;
    }

    public void setArticleID(int articleID) {
        this.articleID = articleID;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public Date getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(Date commentDate) {
        this.commentDate = commentDate;
    }

    public boolean isCommentStatus() {
        return commentStatus;
    }

    public void setCommentStatus(boolean commentStatus) {
        this.commentStatus = commentStatus;
    }

    public CommentDTO(int articleID, String commentContent, Date commentDate, boolean commentStatus, String commentEmail) {
        this.articleID = articleID;
        this.commentContent = commentContent;
        this.commentDate = commentDate;
        this.commentStatus = commentStatus;
        this.commentEmail = commentEmail;
    }

    public CommentDTO() {
    }
}
