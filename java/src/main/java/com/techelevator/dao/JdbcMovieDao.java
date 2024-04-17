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
    public List<Movie> filterMovies(int genres[], String[] mpaa, int[] years, int moviePerPage, int pageNumber, String sortedBy , int userId , boolean ascending){

        String direction = "ASC";
        if(!ascending){
            direction = "DESC";
        }
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
                " WHERE "+ whereInBuilder.toString() + " Order by "+ sortedBy+ " " + direction + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        if(genres.length == 0 && years.length == 0 && mpaa.length ==0 ){
            System.out.println("  nothing");
            sql = "SELECT distinct titletext, movies.movie_id as movie_id, primaryimage, releasedate" +
                    ", genres, runtime, plot, meterranking, ratingssummary, episodes , avgRating FROM "+ removingAlreadyReview + " LEFT Join movie_to_genre\n" +
                    "as mg on mg.movie_id = movies.movie_id" +
                    "  Order by "+ sortedBy+ " " + direction + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
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
        if(sortedBy.equalsIgnoreCase("avgRating")){
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
                }else if(randomReviewSeed < .70) {
                    randomReview ="Worst movie ever! The acting was atrocious, the plot made absolutely no sense, and I felt like I wasted two hours of my life that I'll never get back. Save your money and avoid this disaster!";
                }else if(randomReviewSeed < .80) {
                    randomReview ="I couldn't even finish watching this garbage. The special effects were laughable, the dialogue was cringeworthy, and I honestly have no idea how anyone involved in making this film thought it was a good idea.";
                }else if(randomReviewSeed < .90) {
                    randomReview ="I wouldn't wish this movie on my worst enemy. It's like the filmmakers didn't even try. It's a complete mess from start to finish, and I'm still trying to understand what the point of it was.";
                }else {
                    randomReview ="I've seen student films with higher production value than this trainwreck. The acting was wooden, the script was terrible, and I'm convinced that the only reason this movie exists is to torture unsuspecting audiences.";
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
                }else if(randomReviewSeed < .50){
                    randomReview = "I can't believe the actors got away with this. What was this even. And the direction? Please hire some writers at least next time.";
                }else if(randomReviewSeed < .60){
                    randomReview = "I'd give this a one star but I liked the noise.";
                }else if(randomReviewSeed < .70) {
                    randomReview ="It's like they took a bunch of random ideas and threw them together without any rhyme or reason. There were moments where I thought it might start to make sense, but then it veered off into nonsense again. Disappointing.";
                }else if(randomReviewSeed < .80) {
                    randomReview ="I wanted to like this movie, I really did. But it just couldn't hold my attention. The pacing was off, the characters were forgettable, and by the end, I found myself wondering why I even bothered watching.";
                }else if(randomReviewSeed < .90) {
                    randomReview ="Eh, it's okay I guess. There were a few moments that were mildly entertaining, but they were few and far between. Overall, it's pretty forgettable.";
                }else {
                    randomReview ="I'm giving it two stars because I'm feeling generous. The only reason I didn't give it one star is because I've seen worse movies. Not much worse, but still worse.";
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
                }else if(randomReviewSeed < .60){
                    randomReview = "Kinda mid but I liked the ending.";
                }else if(randomReviewSeed < .70) {
                    randomReview ="It's not terrible, but it's not great either. The visuals were impressive, and there were some interesting ideas, but it felt like it was trying too hard to be profound. Worth a watch if you're really bored.";
                }else if(randomReviewSeed < .80) {
                    randomReview ="I'm on the fence with this one. It had its moments, but they were overshadowed by the movie's many flaws. If you're a fan of the genre, you might enjoy it, but don't expect to be blown away.";
                }else if(randomReviewSeed < .90) {
                    randomReview ="I don't regret watching it, but I don't think I'll ever watch it again. It had its moments, but overall it was pretty forgettable. If you're looking for something mindless to pass the time, this might do the trick.";
                }else {
                    randomReview ="It's a decent enough movie, I suppose. The acting was decent, the visuals were impressive, and there were a few moments that made me think. It's not something I'll rush to watch again, but it's not something I regret watching either.";
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
                }else if(randomReviewSeed < .60){
                    randomReview = "I'd give this 5 stars but I will only give it 5 stars if it has Florence Pugh in it. This movie did not.";
                }else if(randomReviewSeed < .70) {
                    randomReview ="I actually enjoyed this movie. Sure, it had its flaws, but it was entertaining enough to keep me engaged from start to finish. The visuals were stunning, and the story, while not perfect, kept me interested.";
                }else if(randomReviewSeed < .80) {
                    randomReview ="I thought this movie was pretty good. It's not going to win any awards, but it kept me entertained for a couple of hours. The acting was decent, the story was interesting enough, and the ending was satisfying.";
                }else if(randomReviewSeed < .90) {
                    randomReview ="I enjoyed this movie more than I expected to. The pacing was good, the action scenes were well-done, and the story, while a bit predictable, kept me engaged. If you're looking for a fun way to pass the time, give this one a shot.";
                }else {
                    randomReview ="This movie exceeded my expectations. The visuals were stunning, the acting was solid, and the story, while not groundbreaking, was engaging enough to keep me hooked until the end. Definitely worth checking out.";
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
                    randomReview = "The greatest movie EVER made. I swear all people need to watch this. PERIOD.";
                }else if(randomReviewSeed < .70) {
                    randomReview ="Absolutely loved it! This movie has everything - action, suspense, drama, you name it. The performances were top-notch, the special effects were jaw-dropping, and the story was incredibly compelling. I can't recommend it enough!";
                }else if(randomReviewSeed < .80) {
                    randomReview ="Incredible! This movie blew me away. The attention to detail in every frame, the depth of the characters, the sheer emotional impact - it's rare to find a film that fires on all cylinders like this one does. A true masterpiece!";
                }else if(randomReviewSeed < .90) {
                    randomReview ="I have no words to describe how much I loved this movie. It's a masterpiece in every sense of the word. The acting, the direction, the writing - everything is top-notch. If you only see one movie this year, make it this one.";
                }else {
                    randomReview ="This movie is a triumph. The cinematography is stunning, the performances are electrifying, and the story is both thrilling and thought-provoking. It's the kind of movie that stays with you long after the credits roll. Bravo!";
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


    @Override
    public void assignMovieGenres()
    {
        List<Movie> movies = new ArrayList<>();

        String sql = "SELECT MAX(movie_id) AS total FROM movies;";
        SqlRowSet total = jdbcTemplate.queryForRowSet(sql);
        int max = 0;
        if(total.next())
            max = total.getInt("total");
        sql =   "SELECT genres " +
                "FROM movies " +
                "WHERE movie_id = ? ;";

        String sqlGetGenreId =
                "SELECT genre_id " +
                "FROM genres " +
                "WHERE genre_name ILIKE ?;";

        String sqlInsertMovieGenre =
                "INSERT INTO movie_to_genre (movie_id, genre_id)" +
                "VALUES (?, ?);";

        for (int movieId = 1; movieId <= max; movieId++)
        {
            SqlRowSet join = jdbcTemplate.queryForRowSet(sql, movieId);
            String result = "";
            if(join.next())
                result = join.getString("genres");
            String[] results = result.split(", ");
            for (String r : results)
            {
                int genreId = 0;
                SqlRowSet n = jdbcTemplate.queryForRowSet(sqlGetGenreId, r);
                if(n.next())
                    genreId = n.getInt("genre_id");
                try {
                    jdbcTemplate.update(sqlInsertMovieGenre, movieId, genreId);
                }catch (CannotGetJdbcConnectionException e) {
                        //
                    } catch (DataIntegrityViolationException e) {
                        //
                    } finally {

                }
            }
        }
    }



//    public List<Movie> getMovies() {
//        return null;
//    }
}
