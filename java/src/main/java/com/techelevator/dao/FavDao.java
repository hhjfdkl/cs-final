package com.techelevator.dao;

public interface FavDao {




    boolean addFav(int account_id, int movie_id);

    boolean removeFav(int account_id, int movie_id);
}
