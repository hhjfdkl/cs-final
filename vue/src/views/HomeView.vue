<template>
  <H2>
    Movies
  </H2>
  <!-- <form @submit.prevent="searchMovies" class="search-change">

    <input class="mpp" type="number" v-model="usersPerPage" placeholder="Movies per page" />
    <button v-show="usersPerPage != ''" class="change" type="submit">Change</button>
  </form> -->
  <div id="fav-upper">
    <ChangeOrder />
  </div>
  <div id="main-display">
    <MovieDetails v-for="movie in movies" v-bind:key="movie.movie_id" :movie="movie" />
  </div>
  <div id="fav-bottom">
    <button class="prev-next" id="prev" @click="previousPage">Previous Page</button>
    <button class="prev-next" id="next" @click="nextPage">Next Page</button>
  </div>
</template>

<script>
import MovieDetails from "../components/MovieDetails.vue";

import MovieService from "../services/MovieService";
import ChangeOrder from "../components/ChangeOrder.vue";

export default {
  data() {
    return {
      movies: [],
      usersPerPage: "",
      selectedOrder: "",
      selectedDirection: ""

    };
  }

  ,
  created() {
    this.updateMovies();

  },



  watch: { //runs updateMovies when route changes
    '$route': 'updateMovies'
  },
  components: {
    MovieDetails,
    ChangeOrder
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
        }, query: { asc: new URLSearchParams(window.location.search).get('asc') }
      });

      this.updateMovies();
    },
    updateMovies() {
      let urlParams = new URLSearchParams(window.location.search);

      let title = urlParams.get('title');


      let ascOrDesc = urlParams.get('asc');
      if (ascOrDesc == undefined) {
        ascOrDesc = true;
      }


      if (title == null) {
        MovieService.getMoviePageOrdered(this.$route.params.pageSize, this.$route.params.page, this.$route.params.sort, ascOrDesc).then((response) => {
          this.movies = response.data;
        });
      } else {
        MovieService.filterMoviesByTitle(this.$route.params.pageSize, this.$route.params.page, this.$route.params.sort, title).then((response) => {
          this.movies = response.data;
        });
      }

    },
    previousPage() {
      if (Number(this.$route.params.page) <= 1) return;
      this.$router.push({
        name: "movies",
        params: {
          pageSize: this.$route.params.pageSize,
          page: Number(this.$route.params.page) - 1,
          sort: this.$route.params.sort
        }, query: { asc: new URLSearchParams(window.location.search).get('asc') }

      });

    }

    ,
    searchMovies() {
      this.$router.push({
        name: "movies",
        params: {
          pageSize: this.usersPerPage,
          page: 1,
          sort: this.$route.params.sort
        },

      });
    },




  }


};
</script>

<style scoped>
h2 {
  color: #7B3911;
  margin-left: 5%;
  font-size: 50px;
}

#fav-upper {
  margin-left: 5%;
}

#main-display {
  display: flex;
  flex-wrap: wrap;
  flex-direction: row;
  justify-content: space-evenly;


  /*needs to be a row*/

  /* justify-content: center; */

}


.home {
  color: #890304;
}

.home-border {
  text-decoration-line: underline;
  text-decoration-thickness: 2px
}

#fav-bottom {
  display: flex;
  justify-content: space-between;
  margin-bottom: 25px;
}

.prev-next {
  background-color: #fff0cb;
  color: #890304;
  border: 1px solid #890304;
  margin-top: 10px;
  padding: 0.5rem 1rem;
  border-radius: 4px;
  cursor: pointer;
  display: block;
  margin: 0 auto;
  font-family: 'league spartan';
}

#prev {
  margin-left: 5%;
  margin-right: 1%;
}

#next {
  margin-right: 5%;
  margin-left: 1%;
}

.prev-next:hover {
  background-color: #890304;
  color: #fff0cb;
}

.change {
  margin-left: 5px;
  background-color: #fff0cb;
  color: #890304;
  border: 1px solid #890304;
}

.change:hover {
  background-color: #890304;
  color: #fff0cb;

}

.search-change {
  margin: 10px;
  margin-left: 15%;

}


.mpp {
  width: 100px;
  padding: 0.5rem;
  border-radius: 4px;
  border: none;
  box-shadow: 0 2px 4px #7B3911;
  margin-right: 1rem;
}
</style>

