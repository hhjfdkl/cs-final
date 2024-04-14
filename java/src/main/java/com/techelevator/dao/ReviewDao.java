package com.techelevator.dao;

import com.techelevator.model.Review;

import java.util.List;

public interface ReviewDao {


    List<Review> getReviewsByAccountId(int acctId);

    List<Review> getReviewsByMovieId(int movieId);

    List<Review> getAllReviews();   //admin

    List<Review> getReviewsByRating(int rating);

    Review getReviewByKey(int acctId, int movieId);


    boolean createReview(int account_id, int rating, String reviewText, int movie_id);
}
