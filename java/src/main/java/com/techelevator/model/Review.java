package com.techelevator.model;

public class Review
{
    private final int accountId;
    private final int rating;
    private final String review;
    private final int movie_id;

    public Review(int accountId, int rating, String review, int movie_id)
    {
        this.accountId = accountId;
        this.rating = rating;
        this.review = review;
        this.movie_id = movie_id;
    }


    public int getAccountId()
    {
        return accountId;
    }

    public int getRating()
    {
        return rating;
    }

    public String getReview()
    {
        return review;
    }

    public int getMovie_id()
    {
        return movie_id;
    }


}
