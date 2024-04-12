
<template>
    <div class="main-block">
        <h3>Your Fav</h3>
        <div v-for="genre in favGenreArray" :key="genre.id" class="main-block">
            {{ genre.name }}

            <button @click="removeGenre(genre.id)">Remove</button>
        </div>

        <h3>Add to your Fav</h3>
        <div v-for="genre in unfavGenreArray" :key="genre.id" class="main-block">
            {{ genre.name }}

            <button @click="addGenre(genre.id)">Add</button>
        </div>
    </div>
</template> 
  
<script>
import { computed } from 'vue';
import AccountService from '../services/AccountService';


export default {

    props: {
        genres: {
            type: Array,
            required: true
        },
        AccountService: {
            type: Object,
        }
    },
    created() {

        this.$store.commit("UPDATE_GENRES");


    },
    methods: {
        convertToGenreString(genre) {


            for (let i = 0; i < genre.length; i++) {

                if (genre[i].id) {
                    return genre[i].name
                }
            }
            return "??"

        },
        addGenre(id) {

            AccountService.addGenre(id);
            // eslint-disable-next-line vue/no-mutating-props
            this.genres.push(id);


        },

        removeGenre(id) {

            AccountService.removeGenre(id);
            // eslint-disable-next-line vue/no-mutating-props
            this.genres.splice(this.genres.indexOf(id), 1);

        },


    },
    computed: {
        favGenreArray: function () {
            if (this.genres == undefined) {
                return []
            }

            let out = [];

            // if (this.genres == null) {


            //     this.genres = [];
            // }
            for (let i = 0; i < this.$store.state.genres.length; i++) {
                if (this.genres.includes(this.$store.state.genres[i].id)) {
                    out.push(this.$store.state.genres[i])
                }
            }
            return out
        },
        unfavGenreArray: function () {
            if (this.genres == undefined) {
                return []
            }
            let out = [];
            for (let i = 0; i < this.$store.state.genres.length; i++) {
                if (!this.genres.includes(this.$store.state.genres[i].id)) {
                    out.push(this.$store.state.genres[i])
                }
            }
            return out
        }
    }

}

</script>
  
<style scoped>
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
  
  
  
  