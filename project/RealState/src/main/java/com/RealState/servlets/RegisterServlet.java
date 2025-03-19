package com.RealState.servlets;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import com.google.gson.*;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        // Create user data as a Map
        Map<String, String> userData = new HashMap<>();
        userData.put("firstName", firstName);
        userData.put("lastName", lastName);
        userData.put("email", email);
        userData.put("phone", phone);
        userData.put("password", password);
        

        // Determine which file to update based on user type
        String filePath;
        if ("agent".equals(userType)) {
            filePath = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\estateAgent.json";
        } else {
            filePath = "C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data\\buyer.json";
        }

        File jsonFile = new File(filePath);

        // Create Gson instance
        Gson gson = new GsonBuilder().setPrettyPrinting().create();

        // Initialize list to store users
        List<Map<String, String>> userList = new ArrayList<>();

        // If file exists, read existing data
        if (jsonFile.exists()) {
            try (Reader reader = new FileReader(jsonFile)) {
                // Create a Type for List<Map<String, String>>
                Type userListType = new TypeToken<List<Map<String, String>>>() {
                }.getType();
                userList = gson.fromJson(reader, userListType);

                // If parsing returns null, initialize with empty list
                if (userList == null) {
                    userList = new ArrayList<>();
                }
            } catch (Exception e) {
                // If parsing fails, start with empty list
                userList = new ArrayList<>();
            }
        }

        // Add new user to the list
        userList.add(userData);

        // Ensure directory exists
        jsonFile.getParentFile().mkdirs();

        // Write updated JSON back to file
        try (Writer writer = new FileWriter(jsonFile)) {
            gson.toJson(userList, writer);
        } catch (IOException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to save user data");
            return;
        }

        // Redirect to success page or login page
        response.sendRedirect("login.jsp?registered=true");
    }
}