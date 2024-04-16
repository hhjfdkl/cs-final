
<template>
    <div class="movie">
        <div class="column">
            <img :src="movie.primaryImage" alt="movie img" class="movie-img">
            <button v-show="!isFav" class="fav-button" @click="addFav">
                Favorite
            </button>
            <button v-show="isFav" class="fav-button" @click="removeFav">
                Unfavorite
            </button>
        </div>
        <div>
            <header>
                <h1 class="movie-title">{{ movie.titleText }}</h1>
            </header>
            <div class="release-genres">
                <div class="release-date">{{ movie.releaseDate.substr(0, 4) }}</div>
                <div class="genres">{{ movie.genres }}</div>
                <div class="runtime">{{ movie.runtime }}</div>
                <div class="meter-ranking">{{ movie.meterRanking }}</div>
                <div class="avg-rating">{{ movie.avgRating }}</div>
            </div>
            <div class="section-title">Plot Summary</div>
            <div class="description">
                {{ movie.plot }}
            </div>

        </div>
        <div id="reviews">
            <div class="section-title">
                User Reviews
            </div>
            <div id="review">
                <ReviewList :movieId="movie.id" />
            </div>
            <div>
                <div class="section-title">Write A Review</div>
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
    display: grid;
    grid-template-columns: 400px 1fr;
    grid-template-areas:
        "img title"
        "reviews reviews"
    ;
    margin-left: 5%;
    margin-top: 4%;
}

.column {
    display: flex;
    flex-direction: column;
    grid-area: img;
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

.release-date {
    margin-bottom: 10px;

}

.genres {
    margin-bottom: 10px;
}

.runtime {
    margin-bottom: 10px;
}

.meter-ranking {
    margin-bottom: 10px;
}

.avg-rating {
    margin-bottom: 10px;
}

.description {
    color: #002263;
    margin-top: 10px;
    margin-bottom: 10px;
    margin-left: 0px;
    font-size: 1.2rem;
}

#reviews {
    grid-area: reviews;
    margin-left: 10px;
    margin-top: 10px;
    color: #002263;
    font-size: 1.2rem;
    flex-grow: 1;
}


.fav-button {
    background-color: #890304;
    color: #fff0cb;
    border: 1px solid #890304;
    border-radius: 4px;
    font-family: 'league spartan';
    margin-top: 15px;
    margin-bottom: 15px;
    width: 300px;
    height: 30px;
    box-shadow: #a52600 1px 1px 2px;
    cursor: pointer;
}

.section-title {
    color: #7B3911;
    font-size: 2rem;
    margin-left: 0px;
    margin-top: 5px;
    margin-bottom: 15px;
}
</style>
  
  
  