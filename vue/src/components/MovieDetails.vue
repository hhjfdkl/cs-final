
<template>
  <div class="movie">
    <router-link :to="{ name: 'fullMovieDetails', params: { movieId: movie.id } }">
      <img :src="movie.primaryImage" alt="movie img" class="movie-img">
    </router-link>
    <div class="column">
      <header>
        <h1 class="movie-title">{{ movie.titleText }}</h1>
      </header>
      <div class="non-title-info">
        <div class="avg-rating">
          <img class=rating-star src="@\assets\Other Images\New Star.png" alt="star">
          {{ movie.avgRating.toFixed(1) }}
        </div>
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
    },
    shortenPlot: function (plot) {
      if (plot.length > 100) {
        return plot.substr(0, 100) + '...';
      }
    }
  },
  created: function () {
    this.updateFav();
  },
  updated: function () {
    console.log("updated");
    this.updateFav();
  },





  /*watch: {
    '$route': 'updateFav'
  },*/


}

</script>

<style  scoped>
.movie-img {
  max-width: 75%;
  max-height: 75%;
  margin: 5px;
  border-radius: .5rem;
}



div .movie {
  /* display: flex; */
  /* flex-direction: row; */
  text-align: center;
  border: .001rem solid #890304;
  width: 25%;
  padding: 5px;
  margin-right: 10px;
  margin-left: 10px;
  margin-bottom: 25px;
  margin-top: 25px;
  box-shadow: 0 2px 4px #7B3911;
  background-color: #e8e5c3;
  /* margin-left: 5%; */
  border-radius: .5rem;
}

.column {
  display: flex;
  flex-direction: column;
  justify-content: space-between;

}

.movie-title {
  font-weight: bold;
  color: #890304;
  font-size: 1.5rem;

}

.release-genres {
  color: gray;
  margin-bottom: .8rem;
  font-size: .8REM;
}

.description {
  color: #890304;
  margin-bottom: 5px;
  font-size: 1rem;
  /* width: 70%; */
}

.rating {
  color: #890304;
  font-size: 13px;
}

.fav-button {
  background-color: #890304;
  color: #f8f2bf;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 4px;
  cursor: pointer;
  display: block;
  margin: 0 auto;
  font-family: 'league spartan';

}

#more-info {
  padding: 0.5rem 1rem;
  border-radius: 4px;
  cursor: pointer;
  display: block;
  margin: 0 auto;
  font-family: 'league spartan';
  margin-top: 5px;
}

.rating-star {
  height: 1.3rem;
}

.avg-rating {
  color: #7B3911;
  font-size: 1.5rem;
  margin-bottom: 5px;
}

.non-title-info {
  display: flex;
  justify-content: flex-end;
  flex-direction: column;

}

@media screen and (max-width: 600px) {
  .main-block {
    flex-direction: column;
    margin: auto;


  }

  .movie-img {
    max-width: 100%;
    max-height: 100%;

  }

  .description {
    width: 100%;
  }

  .movie-title {
    font-size: 1.5rem;
  }

  .release-genres {
    font-size: .8rem;
  }

  .description {
    font-size: 1rem;
  }

  .rating {
    font-size: 13px;
  }

}

@media screen and (max-width: 800px) {

  .main-block {
    flex-direction: column;
    width: 30%;
  }

  .movie-img {
    max-width: 35%;
    max-height: 35%;

  }

  .description {
    width: 100%;
  }

  .movie-title {
    font-size: 1.5rem;
  }

  .release-genres {
    font-size: .8rem;
  }

  .description {
    font-size: 1rem;
  }

  .rating {
    font-size: 13px;
  }

}
</style>


