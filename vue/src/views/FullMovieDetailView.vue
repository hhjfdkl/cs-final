<template>
    <div>

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

<style scoped>
#movie-details {
    color: #7B3911;
    margin-left: 5%;
    font-size: 50px;
}
</style>



