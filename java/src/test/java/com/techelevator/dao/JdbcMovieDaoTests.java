package com.techelevator.dao;

import org.junit.Assert;
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

    @Test
    public void moviesreturntherightsize(){
        Assert.assertEquals("only 4 movies should be given",4, sut.getGroupOfMovies(4,2,"id").size());
    }

    @Test
    public void moviesskipoverpages(){
        System.out.println();

        Assert.assertEquals("method should start at 5",5, sut.getGroupOfMovies(4,2,"id").get(0).getId());
        Assert.assertEquals("method should start at 5",6, sut.getGroupOfMovies(4,2,"id").get(1).getId());
    }

    @Test
    public void getsremainingmovieswhenonfinalpage(){
        System.out.println();




        Assert.assertEquals("method should return 4 movies even when page size is 8",4, sut.getGroupOfMovies(-1,2,"id").size());
    }





//    @Test public void simpletest(){
//        System.out.println(sut.getGroupOfMovies(3,2,"id").get(0).toString());
//
//    }
}
