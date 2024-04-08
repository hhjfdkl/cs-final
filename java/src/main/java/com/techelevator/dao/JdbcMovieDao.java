package com.techelevator.dao;

import com.techelevator.exception.DaoException;
import com.techelevator.model.Movie;
import com.techelevator.model.User;
import org.springframework.dao.DataIntegrityViolationException;
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
        String sql = "SELECT * FROM movies ORDER BY ? OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, sortedBy, moviePerPage * (pageNumber-1) , moviePerPage);
            while (results.next()) {
                Movie movie = mapRowToMovie(results);
                movies.add(movie);
            }
        } catch (CannotGetJdbcConnectionException e) { //add another catch for sortedBy error
            throw new DaoException("Unable to connect to server or database", e);
        }catch (DataIntegrityViolationException e){
            throw new DaoException("Illegal arguments", e);
        }
        return movies;


    }
    public Movie getMovieById(int id){

        Movie movie = null;

        //remove the * when table is finalised
        String sql = "SELECT * FROM movies WHERE movie_id = ?";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, id);
            if (results.next()) {//add check if nothing is found?
                movie = mapRowToMovie(results);
               
            }
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        }
        return movie;
        
    }



    private Movie mapRowToMovie(SqlRowSet rs) {

        Movie movie = new Movie(
                rs.getString("titleText"),
                rs.getInt("movie_id"),
                rs.getString("primaryImage"), rs.getDate("releaseDate").toLocalDate(),
                rs.getString("genres"), rs.getTime("runtime"), rs.getString("plot"),
                rs.getString("meterRanking"), rs.getString("ratingsSummary"), rs.getInt("episodes") );

        return movie;
    }


//    public List<Movie> getMovies() {
//        return null;
//    }
}
