package com.techelevator.controller;

import com.techelevator.dao.AccountDao;
import com.techelevator.dao.MovieDao;
import com.techelevator.dao.UserDao;
import com.techelevator.exception.DaoException;
import com.techelevator.model.Account;
import com.techelevator.model.User;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import java.security.Principal;

@RestController
@CrossOrigin
public class AccountController {


    private UserDao userDao;
    private AccountDao accountDao;

    public AccountController(UserDao userDao, AccountDao accountDao) {
        this.userDao =  userDao;
        this.accountDao = accountDao;
    }


    @GetMapping("/account")
    public Account getAccount(Principal principal){
        User user = userDao.getUserByUsername(principal.getName());

        try {
            return accountDao.getAccountById(user.getId());
        } catch (DaoException e){
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR , "accounts not found");
        }


    }
}
