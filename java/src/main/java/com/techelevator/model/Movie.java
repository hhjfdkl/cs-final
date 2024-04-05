package com.techelevator.model;

import java.sql.Time;
import java.time.LocalDateTime;
import java.util.Timer;

public class Movie {
    String titleText;
    int id;
    String primaryImage;
    LocalDateTime releaseDate;
    String genres;
    Time runtime;
    String plot;
    String meterRanking;
    String ratingsSummary;
    int episodes;

    public Movie(String titleText, int id, String primaryImage, LocalDateTime releaseDate, String genres, Time runtime, String plot, String meterRanking, String ratingsSummary, int episodes) {
        this.titleText = titleText;
        this.id = id;
        this.primaryImage = primaryImage;
        this.releaseDate = releaseDate;
        this.genres = genres;
        this.runtime = runtime;
        this.plot = plot;
        this.meterRanking = meterRanking;
        this.ratingsSummary = ratingsSummary;
        this.episodes = episodes;
    }

    public String getTitleText() {
        return titleText;
    }

    public int getId() {
        return id;
    }

    public String getPrimaryImage() {
        return primaryImage;
    }

    public LocalDateTime getReleaseDate() {
        return releaseDate;
    }

    public String getGenres() {
        return genres;
    }

    public Time getRuntime() {
        return runtime;
    }

    public String getPlot() {
        return plot;
    }

    public String getMeterRanking() {
        return meterRanking;
    }

    public String getRatingsSummary() {
        return ratingsSummary;
    }

    public int getEpisodes() {
        return episodes;
    }
}
