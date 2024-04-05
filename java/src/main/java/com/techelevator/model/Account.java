package com.techelevator.model;

public class Account {
    int user_id;
    String user_description;
    String username;

    public Account(int user_id, String user_description, String username) {
        this.user_id = user_id;
        this.user_description = user_description;
        this.username = username;
    }

    public int getUser_id() {
        return user_id;
    }

    public String getUser_description() {
        return user_description;
    }

    public String getUsername() {
        return username;
    }
}