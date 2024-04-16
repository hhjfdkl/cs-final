<template>
    <div>
        <div id="review" v-for="review in reviews" v-bind:key="review.account_id">

            <div>{{ review.username }}</div>
            <div>{{ review.rating }}</div>
            <div>{{ review.review }}</div>
            <div>{{ review.movie_title }}</div>

            <router-link v-bind:to="{ name: 'fullMovieDetails', params: { movieId: review.movie_id } }"
                v-if="movieId == null"> link </router-link>
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
#review {
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
</style>