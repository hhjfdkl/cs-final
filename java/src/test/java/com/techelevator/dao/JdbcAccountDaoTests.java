package com.techelevator.dao;


import com.techelevator.model.Account;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.jdbc.core.JdbcTemplate;

public class JdbcAccountDaoTests extends BaseDaoTests
{

    private JdbcAccountDao sut;

    @Before
    public void setup()
    {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        sut = new JdbcAccountDao(jdbcTemplate);
    }

    @Test
    public void get_account_by_id()
    {
        Assert.assertEquals(1, sut.getAccountById(1).getAccount_id());
    }
    

}
