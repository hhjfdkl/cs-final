<template>
    <h2>
        Favorite Movies
    </h2>
    <form @submit.prevent="searchMovies" class="search-change">
        <input type="text" v-model="usersPerPage" placeholder="Movies per page" />
        <button v-show="usersPerPage != ''" class="change" type="submit">Change</button>
    </form>


    <MovieDetails v-for="movie in movies" v-bind:key="movie.movie_id" :movie="movie" />

    <button class="prev-next" id="prev" @click="previousPage">Previous Page</button>
    <button class="prev-next" @click="nextPage">Next Page</button>
</template>
  
<script>
import MovieDetails from "../components/MovieDetails.vue";

import MovieService from "../services/MovieService";

export default {
    data() {
        return {
            movies: [],
            usersPerPage: ""
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
    },

    methods: {
        nextPage() {
            if (Number(this.$route.params.pageSize) > this.movies.length) return; //this doesn't work if the page was full
            this.$router.push({
                name: this.$route.name,
                params: {
                    pageSize: this.$route.params.pageSize,
                    page: Number(this.$route.params.page) + 1,
                    sort: this.$route.params.sort
                }
            });

            this.updateMovies();
        },
        updateMovies() {

            MovieService.getUserFavMovie(this.$route.params.pageSize, this.$route.params.page, this.$route.params.sort).then((response) => {
                this.movies = response.data;
            });
        },
        previousPage() {
            if (Number(this.$route.params.page) <= 1) return;
            this.$router.push({
                name: this.$route.name,
                params: {
                    pageSize: this.$route.params.pageSize,
                    page: Number(this.$route.params.page) - 1,
                    sort: this.$route.params.sort
                }
            });
        }

        ,
        searchMovies() {
            this.$router.push({
                name: this.$route.name,
                params: {
                    pageSize: this.usersPerPage,
                    page: 1,
                    sort: this.$route.params.sort
                }
            });
        }

    }


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

.prev-next {
    background-color: #fff0cb;
    color: #890304;
    border: 1px solid #890304;
    margin-top: 10px;

}

#prev {
    margin-left: 5%;
    margin-right: 1%;
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
    margin-left: 5%;
}
</style>
  