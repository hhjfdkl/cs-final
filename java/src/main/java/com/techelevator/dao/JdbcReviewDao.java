package com.techelevator.dao;

import com.techelevator.exception.DaoException;
import com.techelevator.model.Review;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.CannotGetJdbcConnectionException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;

import java.util.List;

public class JdbcReviewDao implements ReviewDao
{

    private JdbcTemplate jdbcTemplate;

    public JdbcReviewDao(JdbcTemplate jdbcTemplate)
    {
        this.jdbcTemplate = jdbcTemplate;
    }


    @Override
    public List<Review> getReviewsByAccountId(int acctId) //shows on user profile
    {
        List<Review> reviews = null;
        String sql =
                "SELECT r.account_id, r.rating, r.review, r.movie_id\n" +
                "FROM reviews AS r\n" +
                "JOIN movies AS m ON m.movie_id = r.movie_id\n" +
                "where ACCOUNT_ID = ?\n" +
                "ORDER BY m.titletext ASC;";
        try{
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, acctId);
            while(results.next())
                reviews.add(mapRowToReview(results));

        } catch (CannotGetJdbcConnectionException e ){
            throw new DaoException("Unable to connect to server or database", e);
        }catch (DataIntegrityViolationException e){
            throw new DaoException("Illegal arguments", e);
        }

        return reviews;
    }

    @Override
    public List<Review> getReviewsByMovieId(int movieId)
    {
        List<Review> reviews = null;
        String sql =
                "SELECT account_id, rating, review, movie_id\n" +
                "FROM reviews\n" +
                "WHERE movie_id = ? ORDER BY rating DESC;";
        try{
        SqlRowSet results = jdbcTemplate.queryForRowSet(sql, movieId);
        while(results.next())
            reviews.add(mapRowToReview(results));

        } catch (CannotGetJdbcConnectionException e ){
            throw new DaoException("Unable to connect to server or database", e);
        }catch (DataIntegrityViolationException e){
            throw new DaoException("Illegal arguments", e);
        }

        return reviews;
    }

    @Override
    public List<Review> getAllReviews() //admin method
    {
        List<Review> reviews = null;
        String sql =
                "SELECT account_id, rating, review, movie_id\n" +
                "FROM reviews ORDER BY account_id;";
        try{
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
            while(results.next())
                reviews.add(mapRowToReview(results));

        } catch (CannotGetJdbcConnectionException e ){
            throw new DaoException("Unable to connect to server or database", e);
        }catch (DataIntegrityViolationException e){
            throw new DaoException("Illegal arguments", e);
        }

        return reviews;
    }

    @Override
    public Review getReviewByKey(int acctId, int movieId)
    {
        Review review = null;
        String sql =
                "SELECT account_id, rating, review, movie_id\n" +
                "FROM reviews\n" +
                "WHERE account_id = ?\n" +
                "AND movie_id = ?;";

        try{
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, acctId, movieId);
            if(results.next())
                review = mapRowToReview(results);

        } catch (CannotGetJdbcConnectionException e ){
            throw new DaoException("Unable to connect to server or database", e);
        }catch (DataIntegrityViolationException e){
            throw new DaoException("Illegal arguments", e);
        }

        return review;
    }

    @Override
    public List<Review> getReviewsByRating(int rating)
    {   //could use some ordering, but for now no ordering
        List<Review> reviews = null;
        String sql =
                "SELECT account_id, rating, review, movie_id\n" +
                "FROM reviews\n" +
                "WHERE rating = ?;";

        try{
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, rating);
            while(results.next())
                reviews.add(mapRowToReview(results));

        } catch (CannotGetJdbcConnectionException e ){
            throw new DaoException("Unable to connect to server or database", e);
        }catch (DataIntegrityViolationException e){
            throw new DaoException("Illegal arguments", e);
        }

        return reviews;
    }


    private Review mapRowToReview(SqlRowSet rs)
    {
        return new Review(
                rs.getInt("account_id"),
                rs.getInt("rating"),
                rs.getString("review"),
                rs.getInt("movie_id")
        );
    }
}
