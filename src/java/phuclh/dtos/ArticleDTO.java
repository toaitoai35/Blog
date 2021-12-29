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
public class ArticleDTO implements Serializable{
    private int articleID;
    private String articleTitle;
    private String articleShortDesc;
    private String articleContent;
    private String articleAuthor;
    private Date postingDate;
    private String articleStatus;

    public ArticleDTO(int articleID, String articleTitle, String articleShortDesc, String articleContent, String articleAuthor, Date postingDate, String articleStatus) {
        this.articleID = articleID;
        this.articleTitle = articleTitle;
        this.articleShortDesc = articleShortDesc;
        this.articleContent = articleContent;
        this.articleAuthor = articleAuthor;
        this.postingDate = postingDate;
        this.articleStatus = articleStatus;
    }

    public ArticleDTO(String articleTitle, String articleShortDesc, String articleContent, String articleAuthor, Date postingDate, String articleStatus) {
        this.articleTitle = articleTitle;
        this.articleShortDesc = articleShortDesc;
        this.articleContent = articleContent;
        this.articleAuthor = articleAuthor;
        this.postingDate = postingDate;
        this.articleStatus = articleStatus;
    }

    public ArticleDTO() {
    }

    public int getArticleID() {
        return articleID;
    }

    public void setArticleID(int articleID) {
        this.articleID = articleID;
    }

    public String getArticleTitle() {
        return articleTitle;
    }

    public void setArticleTitle(String articleTitle) {
        this.articleTitle = articleTitle;
    }

    public String getArticleShortDesc() {
        return articleShortDesc;
    }

    public void setArticleShortDesc(String articleShortDesc) {
        this.articleShortDesc = articleShortDesc;
    }

    public String getArticleContent() {
        return articleContent;
    }

    public void setArticleContent(String articleContent) {
        this.articleContent = articleContent;
    }

    public String getArticleAuthor() {
        return articleAuthor;
    }

    public void setArticleAuthor(String articleAuthor) {
        this.articleAuthor = articleAuthor;
    }

    public Date getPostingDate() {
        return postingDate;
    }

    public void setPostingDate(Date postingDate) {
        this.postingDate = postingDate;
    }

    public String getArticleStatus() {
        return articleStatus;
    }

    public void setArticleStatus(String articleStatus) {
        this.articleStatus = articleStatus;
    }
}
