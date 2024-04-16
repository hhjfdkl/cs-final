package com.techelevator.model;

public class Article
{
    private int articleId;
    private String title;
    private String author;
    private String body;

    public Article(int id, String title, String author, String body)
    {
        this.articleId = id;
        this.title = title;
        this.author = author;
        this.body = body;
    }

    public int getArticleId() {
        return articleId;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public String getBody() {
        return body;
    }
}
