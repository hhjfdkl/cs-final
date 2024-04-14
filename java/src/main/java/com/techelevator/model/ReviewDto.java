package com.techelevator.model;

public class ReviewDto {
    private  int rating;
    private  String review;
    private  int movie_id;

    public ReviewDto(int rating, String review, int movie_id) {
        this.rating = rating;
        this.review = review;
        this.movie_id = movie_id;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }

    public int getMovie_id() {
        return movie_id;
    }

    public void setMovie_id(int movie_id) {
        this.movie_id = movie_id;
    }
}
