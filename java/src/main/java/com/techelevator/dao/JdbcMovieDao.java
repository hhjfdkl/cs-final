package com.techelevator.dao;

import com.techelevator.exception.DaoException;
import com.techelevator.model.Movie;
import com.techelevator.model.User;
import org.springframework.jdbc.CannotGetJdbcConnectionException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Component
public class JdbcMovieDao implements MovieDao  {




    private JdbcTemplate jdbcTemplate;

    public JdbcMovieDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }



    public List<Movie> getGroupOfMovies(int moviePerPage, int pageNumber, String sortedBy){

        List<Movie> movies = new ArrayList<>();

        //remove the * when table is finalised
        String sql = "SELECT * FROM movie ORDER BY ? OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, sortedBy, moviePerPage * (pageNumber-1) , moviePerPage);
            while (results.next()) {
                Movie movie = mapRowToMovie(results);
                movies.add(movie);
            }
        } catch (CannotGetJdbcConnectionException e) { //add another catch for sortedBy error
            throw new DaoException("Unable to connect to server or database", e);
        }
        return movies;


    }

    private Movie mapRowToMovie(SqlRowSet rs) {

        Movie movie = new Movie(rs.getString("titletext"), rs.getInt("id"), rs.getString("primaryimage"), rs.getDate("releasedate").toLocalDate(), rs.getString("genres"), rs.getTime("runtime"), rs.getString("plot"), rs.getString("meterranking"), rs.getString("ratingssummary"), rs.getInt("episodes") );

        return movie;
    }


//    public List<Movie> getMovies() {
//        return null;
//    }
}
