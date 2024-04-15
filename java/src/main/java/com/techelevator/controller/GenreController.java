package com.techelevator.controller;


import com.techelevator.dao.GenreDao;
import com.techelevator.dao.UserDao;
import com.techelevator.exception.DaoException;
import com.techelevator.model.Genre;
import com.techelevator.model.User;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.security.Principal;
import java.util.List;

@RestController
@CrossOrigin
public class GenreController {

    GenreDao genreDao;
    UserDao userDao;

    public GenreController(GenreDao genreDao, UserDao userDao) {
        this.genreDao = genreDao;
        this.userDao = userDao;
    }

    @GetMapping("/genres")
    public List<Genre> getListOfGenres(){
        try {
            return genreDao.getListOfGenres();
        }
        catch (DaoException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "failed to find genres");
         }

    }

    @PostMapping("/genres/{genre_id}")
    public boolean addGenre(@PathVariable int genre_id, Principal principal){
        User user = userDao.getUserByUsername(principal.getName());

        try {
            return genreDao.addGenre(user.getId(),genre_id);
        }
        catch (DaoException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "failed to add genre");
        }
    }

    @DeleteMapping("/genres/{genre_id}")
    public boolean removeGenre(@PathVariable int genre_id, Principal principal){
        User user = userDao.getUserByUsername(principal.getName());

        try {
            return genreDao.removeGenre(user.getId(),genre_id);
        }
        catch (DaoException e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "failed to remove genre");
        }
    }
}
