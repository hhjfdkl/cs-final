
<template>
    <div class="movie">
        <img :src="movie.primaryImage" alt="movie img" class="movie-img">
        <div class="column">
            <div>THIS IS THE FULL MOVIE DETAILS </div>
            <header>
                <h1 class="movie-title">{{ movie.titleText }}</h1>

            </header>

            <div class="release-genres">
                <div>{{ movie.releaseDate.substr(0, 4) }}</div>
                <div>{{ movie.genres }}</div>
            </div>
            <div class="description">
                {{ movie.plot }}
            </div>


            <button v-show="!isFav" class="fav-button" @click="addFav">

                Favorite
            </button>
            <button v-show="isFav" class="fav-button" @click="removeFav">

                Unfavorite
            </button>

        </div>
    </div>
</template> 
  
<script>
import { computed } from 'vue';
import MovieService from '../services/MovieService';


export default {
    data() {
        return {
            isFav: false
        }
    },
    props: {
        movie: Object,
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
  
  <!-- <style  scoped>
 
  </style> -->
  
  
  