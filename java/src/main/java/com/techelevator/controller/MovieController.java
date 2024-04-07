package com.techelevator.controller;

import com.techelevator.dao.MovieDao;
import com.techelevator.exception.DaoException;
import com.techelevator.model.Movie;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController//do I need to add more annotations?

public class MovieController {
    private MovieDao movieDao;

    public MovieController(MovieDao movieDao) {
        this.movieDao = movieDao;
    }

    @GetMapping("/movies/{moviePerPage}/{page}/{sortBy}")
    public List<Movie> getGroupOfMovies(@PathVariable int moviePerPage, @PathVariable int page, @PathVariable String sortBy){
        try {
            return movieDao.getGroupOfMovies(moviePerPage, page,sortBy);
        }
        catch (DaoException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "User registration failed.");
        }
    }


}
