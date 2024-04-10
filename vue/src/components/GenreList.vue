
<template>
    <div class="main-block">



        <div v-for="genre in favGenreArray" :key="genre.id" class="main-block">
            {{ genre.name }}
        </div>


    </div>
</template> 
  
<script>
import { computed } from 'vue';


export default {
    props: {
        genres: {
            type: Array,
            required: true
        }
    },
    created() {
        this.$store.commit("UPDATE_GENRES");
    },
    methods: {
        convertToGenreString(genre) {
            console.log("test");

            for (let i = 0; i < genre.length; i++) {
                console.log(i)
                if (genre[i].id) {
                    return genre[i].name
                }
            }
            return "??"

        }

    },
    computed: {
        favGenreArray: function () {
            let out = [];
            for (let i = 0; i < this.$store.state.genres.length; i++) {
                console.log(i)
                if (this.genres.includes(this.$store.state.genres[i].id)) {
                    out.push(this.$store.state.genres[i])
                }
            }
            return out
        }
    }

}

</script>
  
<style>
/* .movie-img {
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
  } */
</style>
  
  
  
  