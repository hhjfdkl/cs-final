package com.techelevator.model;

public class Review
{
    private final int account_id;
    private final int rating;
    private final String review;
    private final int movie_id;
    private final  String username;
    private final String movie_title;


    public Review(int account_id, int rating, String review, int movie_id, String userName, String movieTitle)
    {
        this.account_id = account_id;
        this.rating = rating;
        this.review = review;
        this.movie_id = movie_id;
        this.username = userName;
        movie_title = movieTitle;
    }


    public int getAccountId()
    {
        return account_id;
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

    public int getAccount_id() {
        return account_id;
    }

    public String getUsername() {
        return username;
    }
    //add this tostring for testing -luke


    public String getMovie_title() {
        return movie_title;
    }

    @Override
    public String toString() {
        return "Review{" +
                "account_id=" + account_id +
                ", rating=" + rating +
                ", review='" + review + '\'' +
                ", movie_id=" + movie_id +
                '}';
    }
}
