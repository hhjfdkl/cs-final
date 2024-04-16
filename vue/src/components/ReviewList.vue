<template>
    <div>
        <div id="reviews" v-for="review in reviews" v-bind:key="review.account_id">

            <div id="username">{{ review.username }}</div>
            <div id="movie_title">{{ review.movie_title }}</div>
            <div id="rating">{{ review.rating }}</div>
            <div id="review-text">{{ review.review }}</div>


            <router-link v-bind:to="{ name: 'fullMovieDetails', params: { movieId: review.movie_id } }"
                v-if="movieId == null"> Movie Details </router-link>
        </div>
    </div>
</template>

<script>
import AccountService from '../services/AccountService';
import MovieService from '../services/MovieService';
export default {
    data() {
        return {
            reviews: []
        }
    },

    props: {



        movieId: Number

    },

    created() {
        if (this.movieId) {

            MovieService.getReviewsByMovieId(this.movieId).then((response) => {
                this.reviews = response.data;
            })
        }
        else {

            AccountService.getReviews().then((response) => {
                this.reviews = response.data;
            })
        }
    },

}
</script>

<style scoped>
#reviews {
    border: .001rem solid #890304;
    width: auto;
    padding: 5px;
    margin-right: 10px;
    margin-bottom: 25px;
    margin-top: 25px;
    box-shadow: 0 2px 4px #7B3911;
    background-color: #e8e5c3;
    /* margin-left: 5%; */
    border-radius: .5rem;
}

#username {
    font-weight: bold;

    font-family: 'League Spartan';
    color: #7B3911;
    margin-bottom: 5px;
}

#rating {
    margin-bottom: 5px;
}

#review-text {
    font-family: 'League Spartan';
    color: #002263;
    margin-bottom: 5px;
}

#movie_title {
    font-family: 'League Spartan';
    color: #002263;
    margin-bottom: 5px;
}
</style>