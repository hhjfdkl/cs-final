
<template>
  <div class="main-block">
    <img :src="movie.primaryImage" alt="movie img" class="movie-img">
    <div class="column">
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
      console.log("upp")
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

<style>
.movie-img {
  max-width: 14%;
  max-height: 14%;
  margin: 5px;
}

.main-block {
  display: flex;
  flex-direction: row;
  border: .001rem solid #890304;
  width: 70%;
  margin-left: 5%;
}

.column {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  justify-content: start;
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
  width: 70%;
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
    width: 90%;
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


