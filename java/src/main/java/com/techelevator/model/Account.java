package com.techelevator.model;

public class Account
{
    private  final int account_id;
    private  final String username;
    private  int[] favMovieIds;
    private  int[] favGenreIds;
    private  Review[] reviews;


//    public Account(){}

    public Account(int account_id, String username)
    {
        this.account_id = account_id;
        this.username = username;
    }

    public void setFavMovieIds(int[] favMovieIds) {
        this.favMovieIds = favMovieIds;
    }

    public void setFavGenreIds(int[] favGenreIds) {
        this.favGenreIds = favGenreIds;
    }

    public void setReviews(Review[] reviews) {
        this.reviews = reviews;
    }

    public Account(int account_id, String username, int[] favMovieIds, int[] favGenreIds, Review[] reviews)
    {
        this.account_id = account_id;
        this.username = username;
        this.favMovieIds = favMovieIds;
        this.favGenreIds = favGenreIds;
        this.reviews = reviews;
    }



    public int getAccount_id()
    {
        return account_id;
    }
    public String getUsername()
    {
        return username;
    }
    public int[] getFavMovieIds()
    {
        return favMovieIds;
    }

    public int[] getFavGenreIds()
    {
        return favGenreIds;
    }

    public Review[] getReviewIds()
    {
        return reviews;
    }

    /*
       We aren't required to include a status/description per the PO, but we may have this functionality later
       current, we just need to have users 'interact' with other users via reviews

        String user_description;
        public String getUser_description() {
            return user_description;
        }
    */
}