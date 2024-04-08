package com.techelevator.model;

public class Account
{
    private  int user_id;
    private  String username;
    private  int[] favMovieIds;
    private  int[] favGenreIds;
    private  int[] reviewIds;


    public Account(){}

    public Account(int user_id, String username, int[] favMovieIds, int[] favGenreIds, int[] reviewIds)
    {
        this.user_id = user_id;
        this.username = username;
        this.favMovieIds = favMovieIds;
        this.favGenreIds = favGenreIds;
        this.reviewIds = reviewIds;
    }



    public int getUser_id()
    {
        return user_id;
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

    public int[] getReviewIds()
    {
        return reviewIds;
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