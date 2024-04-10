package com.techelevator.controller;


import com.techelevator.dao.GenreDao;
import com.techelevator.model.Genre;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@CrossOrigin
public class GenreController {

    GenreDao genreDao;

    public GenreController(GenreDao genreDao) {
        this.genreDao = genreDao;
    }

    @GetMapping
    public List<Genre> getListOfGenres(){
        return genreDao.getListOfGenres();//add try catch

    }
}
