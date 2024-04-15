<template>
    <div>
        <h3>Full Movie Details</h3>

        <FullMovieDetail :movie="movie" />

    </div>
</template>

<script>
import FullMovieDetail from '../components/FullMovieDetail.vue';
import MovieService from '../services/MovieService';
export default {
    components: {
        FullMovieDetail
    },
    data() {
        return {
            movie: {}
        }
    },
    created() {
        MovieService.getMovieById(this.$route.params.movieId).then((response) => {
            this.movie = response.data;
        });
    }

}
</script>

<style scoped></style>



