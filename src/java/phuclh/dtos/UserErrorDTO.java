/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuclh.dtos;

import java.io.Serializable;

/**
 *
 * @author Acer
 */
public class UserErrorDTO implements Serializable{
    private String emailError;
    private String password;
    private String rePassword;
    private String username;

    public UserErrorDTO(String emailError, String password, String rePassword, String username) {
        this.emailError = emailError;
        this.password = password;
        this.rePassword = rePassword;
        this.username = username;
    }

    public UserErrorDTO() {
    }

    public String getEmailError() {
        return emailError;
    }

    public void setEmailError(String emailError) {
        this.emailError = emailError;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRePassword() {
        return rePassword;
    }

    public void setRePassword(String rePassword) {
        this.rePassword = rePassword;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
