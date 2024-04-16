package com.techelevator.dao;

import com.techelevator.model.Movie;

import java.util.List;

public interface MovieDao {

    double updateAvgRating(int movie_id);

    List<Movie> filterMovies(int genres[], String[] mpaa, int[] years, int moviePerPage, int pageNumber, String sortedBy, int userId);

    //    public List<Movie> getMovies();
    public List<Movie> getGroupOfMovies(int moviePerPage, int pageNumber, String sortedBy, int userId);

    List<Movie> getGroupOfMovies(int moviePerPage, int pageNumber, String sortedBy, boolean ascending, int userId);

    public Movie getMovieById(int id);

    List<Movie> filterMoviesByTitle(int moviePerPage, int pageNumber, String sortedBy, String titleSearch);

    public List<Movie> getMoviesByUserFavGenre(int moviePerPage, int pageNumber, String sortedBy, int[] genres_id );


    public List<Movie> getMoviesByUserFavMovies(int moviePerPage, int pageNumber, String sortedBy,int userId );

    void fullMovieUpdateRatings();
}