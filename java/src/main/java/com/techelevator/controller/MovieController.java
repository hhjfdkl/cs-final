package com.techelevator.controller;

import com.techelevator.dao.MovieDao;
import com.techelevator.dao.UserDao;
import com.techelevator.exception.DaoException;
import com.techelevator.model.FilterDto;
import com.techelevator.model.Movie;
import com.techelevator.model.User;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.security.Principal;
import java.util.Arrays;
import java.util.List;

@RestController
@CrossOrigin
public class MovieController {
    private MovieDao movieDao;
    private UserDao userDao;

    public MovieController(MovieDao movieDao, UserDao userDao) {
        this.movieDao = movieDao;
        this.userDao =  userDao;

        movieDao.fullMovieUpdateRatings();
    }

    @GetMapping("/movies/{moviePerPage}/{page}/{sortBy}")
    public List<Movie> getGroupOfMovies(@PathVariable int moviePerPage , @PathVariable int page, @PathVariable String sortBy ,@RequestParam( defaultValue = "true") boolean asc , Principal principal){
        User user = userDao.getUserByUsername(principal.getName());

        try {
            return movieDao.getGroupOfMovies(moviePerPage, page,sortBy, asc, user.getId());
        }
        catch (DaoException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "retrieving movies failed failed.");
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

        movieDao.updateAvgRating(id); //this  is ineffecent

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
        System.out.println("tttttttttttt");




        try {
            return movieDao.getMoviesByUserFavMovies(moviePerPage,page,sortBy,user.getId());
        }
        catch (DaoException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "User registration failed.");
        }
    }



    @PostMapping("/movies/filter/{moviePerPage}/{page}/{sortBy}")
    public List<Movie> getFilteredMovies(@PathVariable int moviePerPage , @PathVariable int page, @PathVariable String sortBy , @RequestBody FilterDto filterDto, Principal principal){
        User user = userDao.getUserByUsername(principal.getName());

        System.out.println(Arrays.toString(filterDto.getMpaas()));
        if(filterDto.getMpaas() == null){
            filterDto.setMpaas(new String[] {});
        }



        try {
            return movieDao.filterMovies(filterDto.getGenres(),filterDto.getMpaas(),filterDto.getYears(),moviePerPage,page,sortBy, user.getId());
        }
        catch (DaoException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Filter failed.");
        }
    }

    @GetMapping("/movies")
    public List<Movie> getMoviesFilteredByTitle(@RequestParam int  moviePerPage , @RequestParam int page, @RequestParam String sortBy, @RequestParam String titleContains ){

        try {
            return movieDao.filterMoviesByTitle(moviePerPage,page,sortBy,titleContains);
        }
        catch (DaoException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Filter failed.");
        }


    }








}
