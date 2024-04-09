package com.techelevator.dao;

import com.techelevator.model.Account;
import com.techelevator.model.RegisterUserDto;
import com.techelevator.model.User;

import java.util.List;

public interface AccountDao
{
    //grab an account for use on front end
    Account getAccountById(int id);
    List<Account> getAccounts();
    Account getAccountByUsername(String username);


}
