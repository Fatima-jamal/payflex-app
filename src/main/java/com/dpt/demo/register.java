package com.dpt.demo;

import java.sql.*;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class register {

    @Value("${spring.datasource.url}")
    private String url;

    @Value("${spring.datasource.username}")
    private String DBusername;

    @Value("${spring.datasource.password}")
    private String DBpassword;

    @RequestMapping(value = "register", method = RequestMethod.GET)
    public ModelAndView registerform() {
        return new ModelAndView("register");
    }

    @RequestMapping(value = "register", method = RequestMethod.POST)
    public ModelAndView register(String email, String userName, String password)
            throws ClassNotFoundException {

        Class.forName("org.postgresql.Driver");

        String sql = "INSERT INTO users (username, email, password, created_at) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";

        try (Connection con = DriverManager.getConnection(url, DBusername, DBpassword);
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, userName);
            ps.setString(2, email);
            ps.setString(3, password);

            int rowsInserted = ps.executeUpdate();
            System.out.println("Rows inserted: " + rowsInserted);

        } catch (SQLException ex) {
            System.out.println("INSERT FAILED:");
            ex.printStackTrace();
        }

        ModelAndView mv = new ModelAndView("register");
        mv.addObject("message", "User account has been added for " + userName);
        return mv;
    }
}
