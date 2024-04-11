package com.techelevator.dao;

import com.techelevator.exception.DaoException;
import com.techelevator.model.Article;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.CannotGetJdbcConnectionException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;

public class JdbcArticleDao implements ArticleDao
{
    private final JdbcTemplate jdbcTemplate;

    public JdbcArticleDao(JdbcTemplate jdbcTemplate)
    {
        this.jdbcTemplate = jdbcTemplate;
    }
    @Override
    public Article getArticleById(int id)
    {
        Article article = null;
        String query = "SELECT article_id, title, author, body\n" +
                "FROM articles\n" +
                "WHERE article_id = ?;";

        try
        {
            SqlRowSet results = jdbcTemplate.queryForRowSet(query, id);

            if(results.next())
                article = mapRowToArticle(results);

        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Illegal arguments", e);
        }


        return article;
    }

    private Article mapRowToArticle(SqlRowSet rs)
    {
        return new Article(rs.getInt("article_id"), rs.getString("title"),
                rs.getString("author"), rs.getString("body"));
    }
}
