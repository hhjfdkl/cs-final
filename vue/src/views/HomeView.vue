<template>
  <div class="home">
    <h1>Home</h1>
    <p>You must be authenticated to see this</p>

    <form @submit.prevent="searchMovies">
      <input type="text" v-model="searchTerm" placeholder="Movies per page" />
      <button type="submit">Change</button>
    </form>

    <MovieDetails v-for="movie in movies" v-bind:key="movie.movie_id" :movie="movie" />

    <button @click="previousPage">Previous Page</button>
    <button @click="nextPage">Next Page</button>


  </div>
</template>

<script>
import MovieDetails from "../components/MovieDetails.vue";

import MovieService from "../services/MovieService";

export default {
  data() {
    return {
      movies: [],
    };
  }

  ,
  created() {
    this.updateMovies();

  },

  updated() {
    this.updateMovies();
  },

  components: {
    MovieDetails,
  },

  methods: {
    nextPage() {
      if (Number(this.$route.params.pageSize) > this.movies.length) return; //this doesn't work if the page was full
      this.$router.push({
        name: "movies",
        params: {
          pageSize: this.$route.params.pageSize,
          page: Number(this.$route.params.page) + 1,
          sort: this.$route.params.sort
        }
      });

      this.updateMovies();
    },
    updateMovies() {
      MovieService.getMoviePage(this.$route.params.pageSize, this.$route.params.page, this.$route.params.sort).then((response) => {
        this.movies = response.data;
      });
    },
    previousPage() {
      if (Number(this.$route.params.page) <= 1) return;
      this.$router.push({
        name: "movies",
        params: {
          pageSize: this.$route.params.pageSize,
          page: Number(this.$route.params.page) - 1,
          sort: this.$route.params.sort
        }
      });
    }

    ,
    searchMovies(newPageSize) {
      this.$router.push({
        name: "movies",
        params: {
          pageSize: newPageSize,
          page: 1,
          sort: this.searchTerm
        }
      });
    }

  }


};
</script>
