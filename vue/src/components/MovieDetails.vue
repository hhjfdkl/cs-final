<template>
  <div class="main-block">
    <img :src="movie.primaryImage" alt="movie img" class="movie-img">
    <div class="column">
      <header>
        <h1 class="movie-title">{{ movie.titleText }}</h1>
      </header>
      <div class="release-genres">
        <div>{{ movie.releaseDate.substring(0, 4) }}</div>
        <div>{{ movie.genres }}</div>
      </div>
      <div class="description">
        {{ movie.plot }}
      </div>
    </div>
  </div>
</template> 

<script>
import { computed } from 'vue';


export default {
  props: {
    movie: Object
  }
}

</script>

<style>
.movie-img {
  max-width: 20%;
  max-height: 20%;
  margin: 5px;
}

.main-block {
  display: flex;
  flex-direction: row;
  border: .001rem solid #890304;
}

.column {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.movie-title {
  font-weight: bold;
  color: #890304;
  font-size: 20px;

}

.release-genres {
  color: gray;
  margin-bottom: 5px;
  font-size: 13px;
}

.description {
  color: #890304;
  margin-bottom: 5px;
  font-size: 15px;
}

.rating {
  color: #890304;
  font-size: 13px;
}
</style>



