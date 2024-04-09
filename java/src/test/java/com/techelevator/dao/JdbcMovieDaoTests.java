package com.techelevator.dao;

import com.techelevator.exception.DaoException;
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

        Assert.assertEquals("method should start at 5",5, sut.getGroupOfMovies(4,2,"id").get(0).getId());
        Assert.assertEquals("method should start at 5",6, sut.getGroupOfMovies(4,2,"id").get(1).getId());
    }


    @Test
    public void geting_fav_movies_return_4_movies_for_user_1(){
        Assert.assertEquals("method should return 4 values",4,sut.getMoviesByUserFavMovies(5,1,"movie_id", 1).size());
    }

    @Test
    public void geting_fav_movies_only_returns_page_size(){
        Assert.assertEquals("method should return 1 values",1,sut.getMoviesByUserFavMovies(1,2,"movie_id", 1).size());
    }

    @Test(expected = DaoException.class)
    public void illegalParamtersThrowDaoException (){

        sut.getGroupOfMovies(1,-1,"nnnnnnnnnnnnnnnn");

    }





//    @Test public void simpletest(){
//        System.out.println(sut.getGroupOfMovies(3,2,"id").get(0).toString());
//
//    }
}
