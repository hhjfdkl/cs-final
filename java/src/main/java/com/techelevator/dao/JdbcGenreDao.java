package com.techelevator.dao;

import com.techelevator.exception.DaoException;
import com.techelevator.model.Genre;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.CannotGetJdbcConnectionException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class JdbcGenreDao implements GenreDao{

    private JdbcTemplate jdbcTemplate;

    public JdbcGenreDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }


    @Override
    public List<Genre> getListOfGenres() {

        List<Genre> genres = new ArrayList<>();
        String sql = "SELECT genre_id, genre_name\n" +
                "    FROM genres;";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql);
            while (results.next()) {
                Genre genre = mapRowToGenre(results);
                genres.add(genre);

            }
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        }
        return genres;

    }


    @Override
    public boolean addGenre(int genre_id, int movie_id){

        String sql = "INSERT INTO favorite_genres(\n" +
                "\taccount_id, genre_id)\n" +
                "\tVALUES (?, ?);";

        try {

            if(jdbcTemplate.update(sql, genre_id ,movie_id) == 1){
                return true;
            }

        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        }catch (DataIntegrityViolationException e){
            throw new DaoException("unable to add genre", e);
        }

        return false;

    }

    @Override
    public  boolean removeGenre(int genre_id,  int movie_id){

        String sql = "DELETE FROM favorite_genres\n" +
                "\tWHERE account_id = ? AND genre_id = ?;";

        try {

            if(jdbcTemplate.update(sql, genre_id ,movie_id) == 1){
                return true;
            }

        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        }catch (DataIntegrityViolationException e){
            throw new DaoException("unable to remove genre", e);
        }

        return false;
    }

    private Genre mapRowToGenre(SqlRowSet rs) {

        return  new Genre(rs.getInt("genre_id"),rs.getString("genre_name"));
    }
}
