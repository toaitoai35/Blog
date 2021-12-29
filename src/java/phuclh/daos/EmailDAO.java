/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuclh.daos;

import java.io.Serializable;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import phuclh.dtos.UserDTO;
import phuclh.utils.HelpUtil;

/**
 *
 * @author Acer
 */
public class EmailDAO implements Serializable {

    public String sendEmail(UserDTO user, UserDTO sender) {
        String toEmail = user.getEmail();
        String fromEmail = sender.getEmail();
        String password = sender.getPassword();
        String code = HelpUtil.randomNumeric(6);
        try {
            Properties pr = new Properties();
            pr.setProperty("mail.smtp.host", "smtp.gmail.com");
            pr.setProperty("mail.smtp.port", "587");
            pr.setProperty("mail.smtp.auth", "true");
            pr.setProperty("mail.smtp.starttls.enable", "true");
            pr.put("mail.smtp.socketFactory.port", "587");
            pr.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

            Session session = Session.getInstance(pr, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }

            });

            Message msg = new MimeMessage(session);
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            msg.setFrom(new InternetAddress(fromEmail));
            msg.setSubject("Thank you to booking");

            msg.setText("Please verify your checkout by using this code: " + code);
            Transport.send(msg);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return code;
    }
}
