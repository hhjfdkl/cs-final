package com.techelevator.dao;

import com.techelevator.exception.DaoException;
import com.techelevator.model.Movie;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.CannotGetJdbcConnectionException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class JdbcMovieDao implements MovieDao  {




    private JdbcTemplate jdbcTemplate;

    public JdbcMovieDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Movie> filterMovies(int genres[], String[] mpaa, int[] years, int moviePerPage, int pageNumber, String sortedBy){


        if(!checkSortBy(sortedBy)){ //add a check for mpaa
            sortedBy = "movie_id";
        }
        for(int i = 0; i < mpaa.length; i++ ){
            if(!checkMpaa(mpaa[i])){
                mpaa[i] = "XX";
            }
        }


        List<Movie> movies = new ArrayList<>();

        StringBuilder whereInBuilder = new StringBuilder();


       if(genres.length != 0) {
           whereInBuilder.append(" genre_id IN ( ");

           whereInBuilder.append(genres[0]);
           for (int i = 1; genres.length > i; i++) {
               whereInBuilder.append("," + genres[i]);

           }

           whereInBuilder.append(" ) ");
       }

        if(mpaa.length != 0) {
            if(genres.length != 0){
                whereInBuilder.append(" AND ");

            }


            whereInBuilder.append("meterRanking IN ( ");

            whereInBuilder.append("\'" + mpaa[0] + "\'");
            for (int i = 1; mpaa.length > i; i++) {
                whereInBuilder.append("," + "\'" + mpaa[i] + "\'");

            }
            whereInBuilder.append(" ) ");

        }

        if(years.length != 0) {
            if(mpaa.length != 0 || genres.length != 0){
                whereInBuilder.append(" AND ");

            }

            whereInBuilder.append("EXTRACT(year from releasedate) IN ( ");

            whereInBuilder.append(years[0]);
            for (int i = 1; years.length > i; i++) {
                whereInBuilder.append("," + years[i]);

            }
            whereInBuilder.append(" ) ");

        }


        String sql = "SELECT distinct titletext, movies.movie_id as movie_id, primaryimage, releasedate" +
                ", genres, runtime, plot, meterranking, ratingssummary, episodes FROM movies LEFT Join movie_to_genre\n" +
                "as mg on mg.movie_id = movies.movie_id" +
                " WHERE "+ whereInBuilder.toString() + " Order by "+ sortedBy+ " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        if(genres.length == 0 && years.length == 0 && mpaa.length ==0 ){
            sql = "SELECT distinct titletext, movies.movie_id as movie_id, primaryimage, releasedate" +
                    ", genres, runtime, plot, meterranking, ratingssummary, episodes FROM movies LEFT Join movie_to_genre\n" +
                    "as mg on mg.movie_id = movies.movie_id" +
                    "  Order by "+ sortedBy+ " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        }
        try {

            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, moviePerPage * (pageNumber-1) , moviePerPage);
            while (results.next()) {
                Movie movie = mapRowToMovie(results);
                movies.add(movie);
            }
        } catch (CannotGetJdbcConnectionException e) { //add another catch for sortedBy error
            throw new DaoException("Unable to connect to server or database", e);
        }catch (DataIntegrityViolationException e){
            throw new DaoException("Illegal arguments", e);
        }
        return movies;





    }



    public List<Movie> getGroupOfMovies(int moviePerPage, int pageNumber, String sortedBy){

        if(!checkSortBy(sortedBy)){
            sortedBy = "movie_id";
        }

        List<Movie> movies = new ArrayList<>();

        //remove the * when table is finalised
        String sql = "SELECT * FROM movies ORDER BY ? OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, sortedBy, moviePerPage * (pageNumber-1) , moviePerPage);
            while (results.next()) {
                Movie movie = mapRowToMovie(results);
                movies.add(movie);
            }
        } catch (CannotGetJdbcConnectionException e) { //add another catch for sortedBy error
            throw new DaoException("Unable to connect to server or database", e);
        }catch (DataIntegrityViolationException e){
            throw new DaoException("Illegal arguments", e);
        }
        return movies;


    }
    public Movie getMovieById(int id){

        Movie movie = null;

        //remove the * when table is finalised
        String sql = "SELECT * FROM movies WHERE movie_id = ?";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, id);
            if (results.next()) {//add check if nothing is found?
                movie = mapRowToMovie(results);
               
            }
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        }
        return movie;
        
    }

    @Override
    public List<Movie> getMoviesByUserFavGenre(int moviePerPage, int pageNumber, String sortedBy,int[] genres_id ) {
        List<Movie> movies = new ArrayList<>();
        StringBuilder whereInBuilder = new StringBuilder();
//        sortedBy = "movies." + sortedBy;

        System.out.println(sortedBy);
        whereInBuilder.append(genres_id[0]);
        for(int i = 1; genres_id.length > i; i++){
            whereInBuilder.append("," + genres_id[i]);

        }


        System.out.println(whereInBuilder.toString());
        //remove the * when table is finalised
        String sql = "SELECT distinct titletext, movies.movie_id as movie_id, primaryimage, releasedate" +
                ", genres, runtime, plot, meterranking, ratingssummary, episodes FROM movies Join movie_to_genre\n" +
                "as mg on mg.movie_id = movies.movie_id" +
                " where genre_id in ("+ whereInBuilder.toString() + ") Order by "+ sortedBy+ " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        try {

            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, moviePerPage * (pageNumber-1) , moviePerPage);


            while (results.next()) {
                Movie movie = mapRowToMovie(results);
                movies.add(movie);
            }
        } catch (CannotGetJdbcConnectionException e) { //add another catch for sortedBy error
            throw new DaoException("Unable to connect to server or database", e);
        }catch (DataIntegrityViolationException e){
            throw new DaoException("Illegal arguments", e);
        }
        return movies;
    }

    @Override
    public List<Movie> getMoviesByUserFavMovies(int moviePerPage, int pageNumber, String sortedBy, int userId) {
        List<Movie> movies = new ArrayList<>();

        if(!checkSortBy(sortedBy)){     //prevent sql injection
          sortedBy = "movie_id";
        }





        String sql = "SELECT distinct titletext, movies.movie_id as movie_id, primaryimage, releasedate " +
                "  , genres, runtime, plot, meterranking, ratingssummary, episodes " +
                " FROM movies Join favorites" +
                "    on favorites.movie_id = movies.movie_id" +

                " where account_id = ?" +
                " Order by movies." +  sortedBy +
                " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        try {

            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, userId , moviePerPage * (pageNumber-1) , moviePerPage);


            while (results.next()) {
                Movie movie = mapRowToMovie(results);
                movies.add(movie);
            }
        } catch (CannotGetJdbcConnectionException e) { //add another catch for sortedBy error
            throw new DaoException("Unable to connect to server or database", e);
        }catch (DataIntegrityViolationException e){
            throw new DaoException("Illegal arguments", e);
        }
        return movies;
    }

    public boolean checkSortBy(String sortedBy){
        if(sortedBy.equals("movie_id")){
            return true;
        }
        //add other possable sorts
        return false;

    }

    public boolean checkMpaa(String mpaa){
        if(mpaa.equalsIgnoreCase("g")){
            return true;
        }
        if(mpaa.equalsIgnoreCase("pg")){
            return true;
        }
        if(mpaa.equalsIgnoreCase("pg-13")){
            return true;
        }
        if(mpaa.equalsIgnoreCase("r")){
            return true;
        }
        if(mpaa.equalsIgnoreCase("nc-17")){
            return true;
        }
        return false;

    }



    private Movie mapRowToMovie(SqlRowSet rs) {

        Movie movie = new Movie(
                rs.getString("titleText"),
                rs.getInt("movie_id"),
                rs.getString("primaryImage"), rs.getDate("releaseDate").toLocalDate(),
                rs.getString("genres"), rs.getTime("runtime"), rs.getString("plot"),
                rs.getString("meterRanking"), rs.getString("ratingsSummary"), rs.getInt("episodes") );

        return movie;
    }






//    public List<Movie> getMovies() {
//        return null;
//    }
}
