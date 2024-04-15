<template>
    <div>
        <div v-for="review in reviews" v-bind:key="review.account_id">
            <div>review: </div>
            <div>{{ review.username }}</div>
            <div>{{ review.rating }}</div>
            <div>{{ review.review }}</div>

            <router-link v-bind:to="{ name: 'fullMovieDetails', params: { movieId: review.movie_id } }"> link </router-link>
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

<style scoped></style>