package com.techelevator.dao;

import com.techelevator.model.Genre;

import java.util.List;

public interface GenreDao {

    List<Genre> getListOfGenres();


    boolean addGenre(int genre_id, int movie_id);



    boolean removeGenre(int genre_id, int movie_id);
}
