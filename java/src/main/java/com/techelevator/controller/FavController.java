package com.techelevator.controller;

import com.techelevator.dao.FavDao;
import com.techelevator.dao.MovieDao;
import com.techelevator.dao.UserDao;
import com.techelevator.exception.DaoException;
import com.techelevator.model.Movie;
import com.techelevator.model.User;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.security.Principal;
import java.util.List;

@RestController
@CrossOrigin
public class FavController {

    private FavDao favDao;
    private UserDao userDao;

    public FavController(FavDao favDao, UserDao userDao) {
        this.favDao = favDao;
        this.userDao =  userDao;
    }

    @PostMapping("/favorites/{movie_id}")
    public boolean createFav(@PathVariable int movie_id, Principal principal){
        User user = userDao.getUserByUsername(principal.getName());

        try {
            return favDao.addFav(user.getId(),movie_id);
        }
        catch (DaoException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "failed ro add fav.");
        }
    }

    @DeleteMapping("/favorites/{movie_id}")
    public boolean removeFav(@PathVariable int movie_id, Principal principal){
        User user = userDao.getUserByUsername(principal.getName());

        try {
            return favDao.removeFav(user.getId(),movie_id);
        }
        catch (DaoException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "failed to remove fav");
        }
    }
}
