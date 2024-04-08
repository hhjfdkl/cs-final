<template>
  <div class="home">
    <h1 class="home-border">Home</h1>
    <p>You must be authenticated to see this!</p>
    <MovieDetails v-for="movie in movies" v-bind:key="movie.movie_id" :movie="movie" />

  </div>
</template>

<script>
import MovieDetails from "../components/MovieDetails.vue";

import MovieService from "../services/MovieService"; //change this service

export default {
  data() {
    return {
      movies: [],
    };
  }

  ,
  created() {
    MovieService.getMoviePage(4, 1, "id").then((response) => {
      this.movies = response.data;
    });
  },

  components: {
    MovieDetails,
  },


};
</script>

<style>
.home {
  color: #890304;
}

.home-border {
  text-decoration-line: underline;
  text-decoration-thickness: 2px
}
</style>
