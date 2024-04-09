package com.techelevator.dao;

import com.techelevator.model.Account;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

public class JdbcAccountDao implements AccountDao
{



    private final JdbcTemplate jdbcTemplate;

    public JdbcAccountDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Account> getAccounts()
    {
        return null;
    }

    @Override
    public Account getAccountById(int id)
    {
        Account account = null;
        String sql = "SELECT account_id, ";
        return account;
    }

    @Override
    public Account getAccountByUsername(String username)
    {
        return null;
    }
}
