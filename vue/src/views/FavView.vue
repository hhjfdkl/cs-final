<template>
    <h2>
        Favorite Movies
    </h2>
    <!-- <form @submit.prevent="searchMovies" class="search-change">
        <input class="mpp" type="number" v-model="usersPerPage" placeholder="Movies per page" />
        <button v-show="usersPerPage != ''" class="change" type="submit">Change</button>
    </form> -->

    <div id="main-display">
        <MovieDetails v-for="movie in movies" v-bind:key="movie.movie_id" :movie="movie" />
    </div>
    <div id="bottom-buttons">
        <ChangeOrder />
        <button class="prev-next" id="prev" @click="previousPage">Previous Page</button>
        <button class="prev-next" @click="nextPage">Next Page</button>
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
        ChangeOrder
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
                },
                query: { asc: new URLSearchParams(window.location.search).get('asc') }
            });

            this.updateMovies();
        },
        updateMovies() {

            MovieService.getMoviePageOrdered(this.$route.params.pageSize, this.$route.params.page, this.$route.params.sort, new URLSearchParams(window.location.search).get('asc')).then((response) => {
                console.log("ff");
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
                },
                query: { asc: new URLSearchParams(window.location.search).get('asc') }
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
                },
                query: { asc: new URLSearchParams(window.location.search).get('asc') }
            });
        }

    }


};
</script>
  
<style scoped>
#main-display {
    display: flex;
    flex-wrap: wrap;
    flex-direction: row;
}

.home {
    color: #890304;
}

.home-border {
    text-decoration-line: underline;
    text-decoration-thickness: 2px
}

#bottom-buttons {
    display: flex;
    justify-content: space-between;
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

.mpp {
    width: 100px;
    padding: 0.5rem;
    border-radius: 4px;
    border: none;
    box-shadow: 0 2px 4px #7B3911;
    margin-right: 1rem;
}
</style>
  