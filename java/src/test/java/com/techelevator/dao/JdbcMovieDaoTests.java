package com.techelevator.dao;

import org.junit.Before;
import org.junit.Test;
import org.springframework.jdbc.core.JdbcTemplate;

public class JdbcMovieDaoTests extends BaseDaoTests{

    private JdbcMovieDao sut;

    @Before
    public void setup() {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        sut = new JdbcMovieDao(jdbcTemplate);
    }

    @Test public void simpletest(){
        System.out.println(sut.getGroupOfMovies(3,2,"id").get(0).toString());

    }
}
