package com.techelevator.dao;

import com.techelevator.exception.DaoException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.CannotGetJdbcConnectionException;
import org.springframework.jdbc.core.JdbcTemplate;

public class JdbcFavDao implements FavDao{



    private JdbcTemplate jdbcTemplate;

    public JdbcFavDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }


    @Override
    public boolean addFav(int account_id, int movie_id){

        String sql = "INSERT INTO favorites(" +
                "account_id, movie_id)" +
                "VALUES (?, ?);";

        try {

             if(jdbcTemplate.update(sql, account_id ,movie_id) == 1){
                 return true;
             }

        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        }catch (DataIntegrityViolationException e){
            throw new DaoException("Fav already exists", e);
        }

        return false;
    }

    @Override
    public boolean removeFav(int account_id, int movie_id){

        String sql = "DELETE FROM favorites" +
                "WHERE account_id = ? AND movie_id = ?;";

        try {

            if(jdbcTemplate.update(sql, account_id ,movie_id) == 1){
                return true;
            }

        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        }catch (DataIntegrityViolationException e){
            throw new DaoException("Fav doesn't exists ??", e);
        }

        return false;
    }
}
