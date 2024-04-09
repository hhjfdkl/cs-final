package com.techelevator.dao;

import com.techelevator.exception.DaoException;
import com.techelevator.model.Account;
import com.techelevator.model.Review;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.CannotGetJdbcConnectionException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.util.List;
@Component

public class JdbcAccountDao implements AccountDao
{



    private final JdbcTemplate jdbcTemplate;

    public JdbcAccountDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Account> getAccounts()//remove this
    {
        return null;
    }

    @Override
    public Account getAccountById(int accountId)
    {
        Account account = null;
        int[] favMovies;
        int[] favGenres;
        Review[] reviews;
        String nameAndIdQuery = "SELECT a.account_id, u.username\n" +
                "FROM accounts AS a\n" +
                "JOIN users AS u ON u.user_id = a.account_id\n" +
                "WHERE a.account_id = ?;";
        String favoriteMovieIdsQuery = "SELECT movie_id\n" +
                "FROM accounts AS a\n" +
                "JOIN favorites AS fm ON fm.account_id = a.account_id\n" +
                "WHERE a.account_id = ?;";
        String favoriteGenreIdsQuery = "SELECT genre_id\n" +
                "FROM accounts AS a\n" +
                "JOIN favorite_genres AS fg ON fg.account_id = a.account_id\n" +
                "WHERE a.account_id = ?;";
        String reviewsQuery = "SELECT r.account_id, r.rating, r.review, r.movie_id\n" +
                "FROM accounts AS a\n" +
                "JOIN reviews AS r ON r.account_id = a.account_id\n" +
                "WHERE a.account_id = ?;";

        try
        {

            SqlRowSet nameAndIdResults = jdbcTemplate.queryForRowSet(nameAndIdQuery, accountId);
            SqlRowSet favMovieIdsResults = jdbcTemplate.queryForRowSet(favoriteMovieIdsQuery, accountId);
            SqlRowSet favGenreIdsResults = jdbcTemplate.queryForRowSet(favoriteGenreIdsQuery, accountId);
            SqlRowSet reviewsResults = jdbcTemplate.queryForRowSet(reviewsQuery, accountId);

            if(nameAndIdResults.next())
                account = mapRowToAccount(nameAndIdResults, favMovieIdsResults,
                        favGenreIdsResults, reviewsResults);

        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Illegal arguments", e);
        }

        return account;
    }

    @Override
    public Account getAccountByUsername(String username)
    {
        return null;
    }

    private Account mapRowToAccount(SqlRowSet nameAndId,
                                    SqlRowSet favMovies,
                                    SqlRowSet favGenres,
                                    SqlRowSet reviews)
    {
        Account account = new Account(nameAndId.getInt("account_id"),
                nameAndId.getString("username"));
        if(favMovies.next())
        {
            favMovies.beforeFirst();
            account.setFavMovieIds(mapRowsToArray(favMovies, "movie_id"));
        }
        if(favGenres.next())
        {
            favGenres.beforeFirst();
            account.setFavGenreIds(mapRowsToArray(favGenres, "genre_id"));
        }
        if(reviews.next())
        {
            reviews.beforeFirst();
            account.setReviews(mapRowsToReviews(reviews));
        }
        return account;
    }

    private int[] mapRowsToArray(SqlRowSet idSet, String condition)
    {

        int[] result = new int[getQuerySize(idSet)];
        for(int i = 0 ; i < result.length ; i ++)
        {
            idSet.next();
            result[i] = idSet.getInt(condition);
        }


        return result;
    }

    private Review[] mapRowsToReviews(SqlRowSet reviewSet)
    {
        Review[] reviews = new Review[getQuerySize(reviewSet)];
        if (reviews.length > 0)
        {
            for (int i = 0; i < reviews.length; i++)
            {
                reviewSet.next();
                reviews[i] = new Review(reviewSet.getInt("account_id"),
                        reviewSet.getInt("rating"),
                        reviewSet.getString("review"),
                        reviewSet.getInt("movie_id"));

            }
        }
        return reviews;

    }

    private int getQuerySize(SqlRowSet rs)
    {
        int size =0;
        if (rs != null)
        {
            rs.last();    // moves cursor to the last row
            size = rs.getRow(); // get row id
        }
        rs.beforeFirst();
        return size;
    }



}
