/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package phuclh.utils;

import java.io.Serializable;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Random;

/**
 *
 * @author Acer
 */
public class HelpUtil implements Serializable {

    private static final String DIGITS = "0123456789"; // 0-9

    public static String encodePassword(String password) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
        String encoded = Base64.getEncoder().encodeToString(hash);
        return encoded;
    }

//    public static Map<String, String> loadTextFile() throws FileNotFoundException {
//        Map<String, String> listURL = new HashMap<>();
//        File file = new File("");
//        Path path = Paths.get("/lab3datafilter.txt");
//        System.out.println(Files.exists(path));
//        String a = null;
//        String b = null;
//        Path currentDirectory = FileSystems.getDefault().getPath("").toAbsolutePath();
//        Scanner sc = new Scanner(new File(currentDirectory+"\\lab3datafilter.txt"));
//        while (sc.hasNext()) {
//            a = sc.next();
//            b = sc.next();
//            listURL.put(a, b);
//        }
//        return listURL;
//    }
    public static boolean checkFormat(String credit, String format) {
        boolean result = true;
        boolean match;
        match = credit.matches(format);
        if (match) {
            result = false;
        }
        return result;
    }

    private static Random generator = new Random();

    public static int randomNumber(int min, int max) {
        return generator.nextInt((max - min) + 1) + min;
    }

    public static String randomNumeric(int numberOfCharactor) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < numberOfCharactor; i++) {
            int number = randomNumber(0, DIGITS.length() - 1);
            char ch = DIGITS.charAt(number);
            sb.append(ch);
        }
        return sb.toString();
    }

}
