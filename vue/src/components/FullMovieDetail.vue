
<template>
    <div class="movie">
        <div class="column">
            <img :src="movie.primaryImage" alt="movie img" class="movie-img">

            <header>
                <h1 class="movie-title">{{ movie.titleText }}</h1>

            </header>

            <div class="release-genres">
                <div>{{ movie.releaseDate.substr(0, 4) }}</div>
                <div>{{ movie.genres }}</div>
            </div>


            <button v-show="!isFav" class="fav-button" @click="addFav">

                Favorite
            </button>
            <button v-show="isFav" class="fav-button" @click="removeFav">

                Unfavorite
            </button>
        </div>
        <div>
            <div class="section-title">Plot Summary</div>
            <div class="description">
                {{ movie.plot }}
            </div>
            <div class="section-title">
                User Reviews
            </div>
            <div class="section-title">Write A Review</div>
            <div id="review">
                <ReviewList :movieId="movie.id" />
                <CreateReview />
            </div>
        </div>
    </div>
</template> 
  
<script>
import { computed } from 'vue';
import MovieService from '../services/MovieService';
import ReviewList from './ReviewList.vue';
import CreateReview from './CreateReview.vue';


export default {
    data() {
        return {
            isFav: false
        }
    },
    props: {
        movie: Object,

    },
    components: {
        ReviewList,
        CreateReview
    },
    methods: {
        addFav: function () {
            MovieService.addFav(this.movie.id).then(() => {
                this.updateFav();
            });


        },
        removeFav: function () {
            MovieService.deleteFav(this.movie.id).then(() => {
                this.updateFav();
            });

        },
        updateFav: function () {

            MovieService.isFav(this.movie.id).then((response) => {
                this.isFav = response.data;
            });
        }
    },
    created: function () {
        this.updateFav();
    },
    watch: {
        '$route': 'updateFav'
    },


}

</script>

<style scoped>
.movie {
    display: flex;
    flex-direction: row;
    margin-left: 5%;
    margin-top: 4%;
}

.movie-img {
    max-width: 300px;
    max-height: 450px;
    border-radius: .5rem;
}

.movie-title {
    color: #7B3911;
    font-size: 35px;
}

.release-genres {
    color: #002263;
    font-size: 20px;

}

.description {
    color: #7B3911;
    margin-top: 10px;
    margin-bottom: 10px;
    margin-left: 10px;
}

#review {
    margin-left: 10px;
    margin-top: 10px;

}

.fav-button {
    background-color: #890304;
    color: #fff0cb;
    border: 1px solid #890304;
    border-radius: 4px;
    font-family: 'league spartan';
    margin-top: 15px;
    margin-bottom: 15px;
    height: 25px;
}

.section-title {
    color: #7B3911;
    font-size: 20px;
    margin-left: 10px;
    margin-top: 5px;
}
</style>
  
  
  