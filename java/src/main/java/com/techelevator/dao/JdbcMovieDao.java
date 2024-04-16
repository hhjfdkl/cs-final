package com.techelevator.dao;

import com.techelevator.exception.DaoException;
import com.techelevator.model.Movie;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.CannotGetJdbcConnectionException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Component
public class JdbcMovieDao implements MovieDao  {


    private String removingAlreadyReview = " (SELECT * FROM movies where  movie_id IN (Select  movie_id  From Movies where movie_id  NOT IN (select movie_id from reviews where account_id = ?))) as movies ";

    private JdbcTemplate jdbcTemplate;

    public JdbcMovieDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

   @Override
    public double updateAvgRating(int movie_id){
        String sql = "\n" +
                "UPDATE movies\n" +
                "\tSET  avgrating= (SELECT AVG(rating)\n" +
                "\tFROM reviews WHERE movie_id = ?)\n" +
                "\tWHERE movie_id = ? Returning avgrating;";

        double results = 0;
        try {

            results = jdbcTemplate.queryForObject(sql,double.class, movie_id,movie_id);

        } catch (CannotGetJdbcConnectionException e) { //add another catch for sortedBy error
            throw new DaoException("Unable to connect to server or database", e);
        }catch (DataIntegrityViolationException e){
            throw new DaoException("Illegal arguments", e);
        }catch (NullPointerException e){
            //skip empty reviews
        }

        return results;
    }

    @Override
    public List<Movie> filterMovies(int genres[], String[] mpaa, int[] years, int moviePerPage, int pageNumber, String sortedBy , int userId){


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


            whereInBuilder.append(" meterRanking IN ( ");

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

            whereInBuilder.append(" EXTRACT(year from releasedate) IN ( ");

            whereInBuilder.append(years[0]);
            for (int i = 1; years.length > i; i++) {
                whereInBuilder.append("," + years[i]);

            }
            whereInBuilder.append(" ) ");

        }
        System.out.println(Arrays.toString(mpaa));

        String sql = "SELECT distinct titletext, movies.movie_id as movie_id, primaryimage, releasedate" +
                ", genres, runtime, plot, meterranking, ratingssummary, episodes , avgRating FROM "+ removingAlreadyReview + " LEFT Join movie_to_genre\n" +
                "as mg on mg.movie_id = movies.movie_id" +
                " WHERE "+ whereInBuilder.toString() + " Order by "+ sortedBy+ " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        if(genres.length == 0 && years.length == 0 && mpaa.length ==0 ){
            System.out.println("  nothing");
            sql = "SELECT distinct titletext, movies.movie_id as movie_id, primaryimage, releasedate" +
                    ", genres, runtime, plot, meterranking, ratingssummary, episodes , avgRating FROM "+ removingAlreadyReview + " LEFT Join movie_to_genre\n" +
                    "as mg on mg.movie_id = movies.movie_id" +
                    "  Order by "+ sortedBy+ " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        }
        System.out.println(sql);
        try {

            SqlRowSet results = jdbcTemplate.queryForRowSet(sql,userId, moviePerPage * (pageNumber-1) , moviePerPage);
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



    public List<Movie> getGroupOfMovies(int moviePerPage, int pageNumber, String sortedBy, int userId){
        return getGroupOfMovies(moviePerPage,pageNumber,sortedBy,true, userId);

//        if(!checkSortBy(sortedBy)){
//            sortedBy = "movie_id";
//        }
//
//        List<Movie> movies = new ArrayList<>();
//
//        //remove the * when table is finalised
//        String sql = "SELECT * FROM movies ORDER BY ? OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
//        try {
//            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, sortedBy, moviePerPage * (pageNumber-1) , moviePerPage);
//            while (results.next()) {
//                Movie movie = mapRowToMovie(results);
//                movies.add(movie);
//            }
//        } catch (CannotGetJdbcConnectionException e) { //add another catch for sortedBy error
//            throw new DaoException("Unable to connect to server or database", e);
//        }catch (DataIntegrityViolationException e){
//            throw new DaoException("Illegal arguments", e);
//        }
//        return movies;


    }

    @Override
    public List<Movie> getGroupOfMovies(int moviePerPage, int pageNumber, String sortedBy, boolean ascending, int userId){
        System.out.println(sortedBy);

        if(!checkSortBy(sortedBy)){
            sortedBy = "movie_id";
        }
        System.out.println(sortedBy);
        String direction = "ASC";
        if(!ascending){
            direction = "DESC";
        }

        List<Movie> movies = new ArrayList<>();

        //remove the * when table is finalised
        String sql = "SELECT * FROM  " + removingAlreadyReview +  "  ORDER BY "+ sortedBy +  " " + direction +" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, userId, moviePerPage * (pageNumber-1) , moviePerPage);
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
    public List<Movie> filterMoviesByTitle(int moviePerPage, int pageNumber, String sortedBy, String titleSearch){
        if(!checkSortBy(sortedBy)){
            sortedBy = "movie_id";
        }
        titleSearch = "%" + titleSearch + "%";

        List<Movie> movies = new ArrayList<>();

        //remove the * when table is finalised
        String sql = "SELECT * FROM movies WHERE titletext ILIKE ?  ORDER BY ? OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ;";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, titleSearch, sortedBy, moviePerPage * (pageNumber-1) , moviePerPage);
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
                ", genres, runtime, plot, meterranking, ratingssummary, episodes, avgRating FROM movies Join movie_to_genre\n" +
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
        System.out.println(userId);
        System.out.println("ppp");

        if(!checkSortBy(sortedBy)){     //prevent sql injection
          sortedBy = "movie_id";
        }





        String sql = "SELECT distinct titletext, movies.movie_id as movie_id, primaryimage, releasedate " +
                "  , genres, runtime, plot, meterranking, ratingssummary, episodes, avgRating " +
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
        if(sortedBy.equalsIgnoreCase("movie_id")){
            return true;
        }
        if(sortedBy.equalsIgnoreCase("releasedate")){
            return true;
        }
        if(sortedBy.equalsIgnoreCase("runtime")){
            return true;
        }
        if(sortedBy.equalsIgnoreCase("titletext")){
            return true;
        }
        //add one for avg rating
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
                rs.getString("meterRanking"), rs.getString("ratingsSummary"), rs.getInt("episodes"),
                rs.getDouble("avgRating"));

        return movie;
    }

    //this method is for fixing the way the data base is set up this wouldn't be used in a real situation
    @Override
    public void fullMovieUpdateRatings(){

       List<Movie> movies = getGroupOfMovies(500, 1, "movie_id", 2);


       //extra stuff


        for(Movie movie : movies){
            int randomUser = (int) ((Math.random() *10 ) + 2);
            int randomScore = (int) ((Math.random() *5 ) + 1);
            
            
            
            String randomReview = "this was a movie!";

            double randomReviewSeed = Math.random();
            
            if(randomScore == 1){
                if(randomReviewSeed < .10){
                    randomReview = "Utterly disappointing. Save your time and money.";
                }else if(randomReviewSeed < .20){
                    randomReview = "A complete waste of potential. Avoid at all costs.";
                }else if(randomReviewSeed < .30){
                    randomReview = "I could not even finish this movie it was so terrible. If I had tried I would have fallen asleep.";
                }else if(randomReviewSeed < .40){
                    randomReview = "Is this even a movie? I'd rather watch a turtle travel 20 miles!";
                }else if(randomReviewSeed < .50){
                    randomReview = "Arrest the director! This movie is an assault on the senses!";
                }else if(randomReviewSeed < .60){
                    randomReview = "This director's vision is clearly incomprehensible to typical mortals like myself. Horrible.";
                }
            } else if (randomScore == 2) {
                if(randomReviewSeed < .10){
                    randomReview = "Had moments, but overall fell flat.";
                }else if(randomReviewSeed < .20){
                    randomReview = "Lacked depth, left me wanting more substance.";
                }else if(randomReviewSeed < .30){
                    randomReview = "This movie was so confusing to watch. The overall plot must have been written by people who don't understand basic story telling.";
                }else if(randomReviewSeed < .40){
                    randomReview = "This movie was like banging my head up against a brick wall repeatedly then doing it again and again...... and again some more.";
                } else if(randomReviewSeed < .50){
                    randomReview = "I can't believe the actors got away with this. What was this even. And the direction? Please hire some writers at least next time.";
                }
                
            }else if (randomScore == 3) {
                if(randomReviewSeed < .10){
                    randomReview = "Decent enough, but forgettable.";
                }else if(randomReviewSeed < .20){
                    randomReview = "Average entertainment, nothing remarkable.";
                }else if(randomReviewSeed < .30){
                    randomReview = "This movie was ok. I wouldn't watch it again though unless I was stuck on an airplane with nothing else to do. " +
                            "It fills time that you can never get back.";
                }else if(randomReviewSeed < .40){
                    randomReview = "The plot was amazing but the actors sucked.";
                }else if(randomReviewSeed < .50){
                    randomReview = "I really can't believe how mediocre the writing was. Not really too painful but easily forgettable.";
                }

            }else if (randomScore == 4) {
                if(randomReviewSeed < .10){
                    randomReview = "Solid film, worth a watch.";
                }else if(randomReviewSeed < .20){
                    randomReview = "Engaging storyline, well-executed.";
                }else if(randomReviewSeed < .30){
                    randomReview = "This movie was really good. It told an interesting story and" +
                            " was entertaining from start to finish. Would recommend to everyone.";
                }else if(randomReviewSeed < .40){
                    randomReview = "Everything was great but the CGI was worse than the moon landing but overall great movie!";
                }else if(randomReviewSeed < .50){
                    randomReview = "Really above average film. Only real problem was the poorly written Macguffin which was kind of stupid. Fun to watch though.";
                }

            }else if (randomScore == 5) {
                if(randomReviewSeed < .10){
                    randomReview = "A masterpiece! Captivating from start to finish.";
                }else if(randomReviewSeed < .20){
                    randomReview = "Absolutely brilliant! A must-see for all.";
                }else if(randomReviewSeed < .30){
                    randomReview = "This movie was the best ever! If you haven't watched this movie I honestly" +
                            " don't know what your are doing with your life! Watching this movie should be a requirement!";
                }else if(randomReviewSeed < .40){
                    randomReview = "The only thing I've seen more impressive than this movie is my buddy Mikes Knife collection!";
                } else if (randomReviewSeed < .50) {
                    randomReview = "so good that I left my wife and kids. This movie has filled their void and I'm happy about it damnit!";
                } else if (randomReviewSeed < .60) {
                    randomReview = "";
                }

            }


            String sql = "INSERT INTO reviews(\n" +
                    "\taccount_id, rating, review, movie_id)\n" +
                    "\tVALUES (?, ?, ?, ?);";


            try {
                int out = jdbcTemplate.update(sql, randomUser, randomScore , randomReview , movie.getId());
            }catch (CannotGetJdbcConnectionException e) {
               //
            } catch (DataIntegrityViolationException e) {
             //
            }finally {
                //this is the important stuff
                updateAvgRating(movie.getId());
            }


        }





    }






//    public List<Movie> getMovies() {
//        return null;
//    }
}
