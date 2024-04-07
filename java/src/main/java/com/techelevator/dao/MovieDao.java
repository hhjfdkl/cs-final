package com.techelevator.dao;

import com.techelevator.model.Movie;

import java.util.List;

public interface MovieDao {

//    public List<Movie> getMovies();
    public List<Movie> getGroupOfMovies(int moviePerPage, int pageNumber, String sortedBy);


}
