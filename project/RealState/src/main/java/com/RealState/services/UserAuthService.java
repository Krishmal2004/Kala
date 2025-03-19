package com.RealState.services;

import com.RealState.model.User;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;

import javax.servlet.ServletContext;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
/*import java.time.LocalDate;
import java.time.LocalDateTime;*/
import java.util.ArrayList;
import java.util.List;

public class UserAuthService {
    
    public boolean authenticateUser(String username, String password, ServletContext context) {
        try {
            List<User> user = loadUsersFromJson(context);

            // Check if any user matches the provided credentials
            for (User users : user) {
                if (users.getUsername().equals(username) && users.getPassword().equals(password)) {
                    return true;
                }
            }

            return false;
        } catch (IOException e) {
            System.err.println("Error reading user data: " + e.getMessage());
            return false;
        } catch (JsonSyntaxException e) {
            System.err.println("Error parsing user JSON data: " + e.getMessage());
            return false;
        }
    }

    private List<User> loadUsersFromJson(ServletContext context) throws IOException {
        // First try to load from real path
        String realPath = context.getRealPath("/WEB-INF/data/users.json");
        File jsonFile = new File(realPath);
        
        // If file exists in the real path, read from there
        if (jsonFile.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(jsonFile))) {
                StringBuilder jsonContent = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    jsonContent.append(line);
                }
                
                Gson gson = new Gson();
                Type userListType = new TypeToken<List<User>>(){}.getType();
                return gson.fromJson(jsonContent.toString(), userListType);
            }
        }
        
        // If file doesn't exist in real path, try to load from classpath resources
        String jsonFilePath = "/WEB-INF/data/user.json";
        InputStream is = context.getResourceAsStream(jsonFilePath);
        
        if (is != null) {
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(is))) {
                StringBuilder jsonContent = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    jsonContent.append(line);
                }
                
                Gson gson = new Gson();
                Type userListType = new TypeToken<List<User>>(){}.getType();
                return gson.fromJson(jsonContent.toString(), userListType);
            }
        }
        
        // If no file is found, return an empty list
        System.out.println("No users.json file found, starting with empty user list");
        return new ArrayList<>();
    }
    
    public boolean registerUser(User newUser, ServletContext context) {
        try {
            // Load existing users from JSON
            List<User> users = loadUsersFromJson(context);
            
            // Check if username or email already exists
            for (User existingUser : users) {
                if (existingUser.getUsername().equals(newUser.getUsername())) {
                    System.out.println("Username already taken: " + newUser.getUsername());
                    return false; // Username already taken
                }
                if (existingUser.getEmail() != null && existingUser.getEmail().equals(newUser.getEmail())) {
                    System.out.println("Email already in use: " + newUser.getEmail());
                    return false; // Email already in use
                }
            }
            
            // Generate user ID based on role
            /* rolePrefix = newUser.getRole().equalsIgnoreCase("student") ? "ST" : 
                                newUser.getRole().equalsIgnoreCase("teacher") ? "TE" : "US";
            String userIdSuffix = String.format("%02d%06d", LocalDate.now().getYear() % 100, 
                                               (int)(Math.random() * 1000000));
            newUser.setUserId(rolePrefix + userIdSuffix);
            
            // Set registration timestamp
            newUser.setDateRegistered(LocalDateTime.now().toString());
            newUser.setLastLogin(LocalDateTime.now().toString());*/
            
            // Set default status
            //newUser.setStatus("active");
            
            // Hash password (simplified version - in production use stronger algorithm with salt)
            newUser.setPassword(hashPassword(newUser.getPassword()));
            
            // Add user to list
            users.add(newUser);
            
            // Save updated user list
            if (saveUsersToJson(users, context)) {
                System.out.println("Successfully registered user: " + newUser.getUsername());
                return true;
            } else {
                System.err.println("Failed to save user data to JSON file");
                return false;
            }
        } catch (IOException e) {
            System.err.println("Error registering user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Simple password hashing (MD5). 
     * Note: For production, use a more secure algorithm like bcrypt or PBKDF2.
     */
    private String hashPassword(String password) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
            byte[] array = md.digest(password.getBytes());
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < array.length; ++i) {
                sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1, 3));
            }
            return sb.toString();
        } catch (java.security.NoSuchAlgorithmException e) {
            // Fallback to plain text if hashing fails
            return password;
        }
    }

    /**
     * Saves the user list back to JSON file
     */
    private boolean saveUsersToJson(List<User> user, ServletContext context) throws IOException {
        // Get the real path to the WEB-INF directory
        String webInfPath = context.getRealPath("C:\\Users\\user\\Downloads\\project\\RealState\\src\\main\\webapp\\WEB-INF\\data");
        
        // Create the data directory if it doesn't exist
        File dataDir = new File(webInfPath, "data");
        if (!dataDir.exists()) {
            if (!dataDir.mkdirs()) {
                System.err.println("Failed to create directory: " + dataDir.getAbsolutePath());
                return false;
            }
        }
        
        // Create the users.json file
        File jsonFile = new File(dataDir, "user.json");
        
        // Write users to the file
        try (FileWriter writer = new FileWriter(jsonFile)) {
            Gson gson = new GsonBuilder().setPrettyPrinting().create();
            gson.toJson(user, writer);
            System.out.println("Users saved to: " + jsonFile.getAbsolutePath());
            return true;
        } catch (IOException e) {
            System.err.println("Error writing to users.json: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}