package com.dpt.demo;

import java.sql.*;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class login {

    @Value("${spring.datasource.url}")
    private String url;

    @Value("${spring.datasource.username}")
    private String DBusername;

    @Value("${spring.datasource.password}")
    private String DBpassword;

    @RequestMapping(value = "login", method = RequestMethod.POST)
    public ModelAndView login(String userName, String password) throws ClassNotFoundException {

        String userId = "";
        String errorMessage = "";

        Class.forName("org.postgresql.Driver");


        String query = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (Connection con = DriverManager.getConnection(url, DBusername, DBpassword);
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, userName);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                userId = rs.getString("username");  // or rs.getString(2)
            }

        } catch (SQLException ex) {
            errorMessage = ex.getMessage();
        }

        ModelAndView mv;
        if (!userId.isEmpty()) {
            mv = new ModelAndView("user");
            mv.addObject("username", userId);
        } else {
            mv = new ModelAndView("login");
            mv.addObject("errorMessage", errorMessage);
        }

        return mv;
    }

    @RequestMapping(value = "login", method = RequestMethod.GET)
    public ModelAndView registerform() {
        return new ModelAndView("login");
    }
}
