package com.techelevator.controller;

import com.techelevator.dao.MovieDao;
import com.techelevator.dao.UserDao;
import com.techelevator.exception.DaoException;
import com.techelevator.model.Movie;
import com.techelevator.model.User;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import java.security.Principal;
import java.util.List;

@RestController
@CrossOrigin
public class MovieController {
    private MovieDao movieDao;
    private UserDao userDao;

    public MovieController(MovieDao movieDao, UserDao userDao) {
        this.movieDao = movieDao;
        this.userDao =  userDao;
    }

    @GetMapping("/movies/{moviePerPage}/{page}/{sortBy}")
    public List<Movie> getGroupOfMovies(@PathVariable int moviePerPage , @PathVariable int page, @PathVariable String sortBy){
        
        try {
            return movieDao.getGroupOfMovies(moviePerPage, page,sortBy);
        }
        catch (DaoException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "User registration failed.");
        }
    }

//    @GetMapping("/movies")
//    public List<Movie> getGroupOfMoviesDefult(){
//        getGroupOfMovies(5,1,"movie_id")
//
//        try {
//            return movieDao.getGroupOfMovies(5, 1,"movie_id");
//        }
//        catch (DaoException e) {
//            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "User registration failed.");
//        }
//    }

    @GetMapping("/movies/{id}")
    public Movie getMovieById(@PathVariable int id){

        try {
            return movieDao.getMovieById(id);
        }
        catch (DaoException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "User registration failed.");
        }
    }


    @GetMapping("/movies/favorites/{moviePerPage}/{page}/{sortBy}")
    public List<Movie> getFavMovies(Principal principal , @PathVariable int moviePerPage , @PathVariable int page, @PathVariable String sortBy){
        User user = userDao.getUserByUsername(principal.getName());



        try {
            return movieDao.getMoviesByUserFavMovies(moviePerPage,page,sortBy,user.getId());
        }
        catch (DaoException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "User registration failed.");
        }
    }






}
