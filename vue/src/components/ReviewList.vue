<template>
    <div>
        <div v-for="review in reviews" v-bind:key="review.account_id">
            <div>review: </div>
            <div>{{ review.rating }}</div>
        </div>

    </div>
</template>

<script>
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

        MovieService.getReviewsByMovieId(this.movieId).then((response) => {
            this.reviews = response.data;
        })
    },

}
</script>

<style scoped></style>