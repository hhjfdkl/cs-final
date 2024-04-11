package com.techelevator.model;

import org.springframework.web.bind.annotation.RequestBody;

import java.util.Arrays;

public class FilterDto {
    int[] genres;
    String[] mpaas;
    int[] years;

    public FilterDto(int[] genres, String[] mpaas, int[] years) {
        this.genres = genres;
        this.mpaas = mpaas;
        this.years = years;
    }

    public int[] getGenres() {
        return genres;
    }

    public void setGenres(int[] genres) {
        this.genres = genres;
    }

    public String[] getMpaas() {
        return mpaas;
    }

    public void setMpaas(String[] mpaas) {
        this.mpaas = mpaas;
    }

    public int[] getYears() {
        return years;
    }

    public void setYears(int[] years) {
        this.years = years;
    }


    @Override
    public String toString() {
        return "FilterDto{" +
                "genres=" + Arrays.toString(genres) +
                ", mpaas=" + Arrays.toString(mpaas) +
                ", years=" + Arrays.toString(years) +
                '}';
    }
}
