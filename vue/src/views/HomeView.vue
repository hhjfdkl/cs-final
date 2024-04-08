<template>
  <div class="home">
    <h1>Home</h1>
    <p>You must be authenticated to see this</p>
    <div v-for="movie in movies" v-bind:key="movie.titleText">
      <p>{{ movie.titleText }}</p>
    </div>
  </div>
</template>

<script>

import MovieService from "../services/MovieService"; //change this service

export default {
  data() {
    return {
      movies: [],
    };
  }

  ,
  created() {
    MovieService.getMoviePage(2, 1, "id").then((response) => {
      this.movies = response.data;
    });
  },


};
</script>
