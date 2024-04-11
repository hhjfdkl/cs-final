package com.techelevator.controller;

import com.techelevator.dao.ArticleDao;
import com.techelevator.exception.DaoException;
import com.techelevator.model.Article;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@RestController
@CrossOrigin
public class ArticleController
{
    private ArticleDao articleDao;

    public ArticleController(ArticleDao articleDao)
    {
        this.articleDao = articleDao;
    }

    @GetMapping("/articles/{id}")
    public Article getArticleById(@PathVariable int id)
    {
        try {
            return articleDao.getArticleById(id);
        } catch (DaoException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }
}
