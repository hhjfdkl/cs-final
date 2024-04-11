<template>
    <div class="main-block">
        <form @submit.prevent="submitForm">
            <label for="genres">Genres</label>
            <ul>
                <li v-for="genre in genres" :key="genre.id">
                    <input type="checkbox" :id="'genre-' + genre.id" :value="genre.id" v-model="selectedGenres" />
                    <label :for="'genre-' + genre.id">{{ genre.name }}</label>
                </li>
            </ul>
            <br />
            <label for="years">Years</label>
            <div id="year-boxes">
                <div class="year-box">
                    <input type="number" v-model.number="years" @keyup.enter="addSelectedYear(years)" />

                    <button @click.prevent="addSelectedYear(years)">+</button>
                </div>
            </div>
            <div v-for="(year, index) in selectedYears" :key="index" class="year-box">
                {{ year }}
                <button @click="removeSelectedYear(index)">X</button>
            </div>
            <br />
            <label for="ratings">MPAA Ratings</label>
            <ul>


                <li v-for="rating in ratings" :key="rating">

                    <input type="checkbox" :id="'rating-' + rating" :value="rating" v-model="selectedRating" />
                    <label :for="'rating-' + rating"> {{ rating }}</label>
                </li>
            </ul>
            <!-- <select id="ratings" v-model="selectedRating">
                <option v-for="rating in ratings" :key="rating" :value="rating">{{ rating }}</option>
            </select> -->
            <br />
            <!-- <router-link :to="{ name: 'filterMovies', params: { pageSize: 9, page: 1, sort: 'movie_id' } }" v-bind:props="{
                years: selectedYears,
                genres: selectedGenres,
                mpaas: selectedRating
            }">
                Link Text
            </router-link> -->

            <button type="submit">Search</button>
        </form>
    </div>
</template>
  
<script>
import { computed, ref } from 'vue';

export default {
    data() {
        return {

            ratings: ["G", "PG", "PG-13", "R", "NC-17"],
            selectedGenres: [],
            years: ref(2000),
            selectedYears: [],
            selectedRating: [], //change this?
        }
    },
    methods: {
        submitForm() {
            this.$store.commit("FILTER_GENRES", this.selectedGenres);
            this.$store.commit("FILTER_RATINGS", this.selectedRating);
            this.$store.commit("FILTER_YEARS", this.selectedYears);
            this.$router.push({
                name: "filterMovies",
                params: {
                    pageSize: 9,
                    page: 1,
                    sort: "movie_id"
                }
            })
        },

        removeYear(index) {
            this.years.value.splice(index, 1);
        },
        addSelectedYear(year) {

            this.selectedYears.push(year);
        },
        removeSelectedYear(index) {
            this.selectedYears.splice(index, 1);
        }
    },
    // watch: {
    //     years(newVal, oldVal) {

    //         // if (!this.selectedYears.value.includes(newVal)) {
    //         //     this.addSelectedYear(this.years);
    //         // }

    //         // this.selectedYears.value = this.selectedYears.value.filter(year => newVal.includes(year));
    //     }
    // }
    created() {

        this.$store.commit("UPDATE_GENRES");
    }, computed: {
        genres: function () {

            return this.$store.state.genres;
        }
    }

}
</script>
  
<style scoped>
.year-box {
    display: flex;
    align-items: center;
    margin-bottom: 0.5rem;
}

.year-box button {
    margin-left: 0.5rem;
}
</style>
  
  
  
  
  
  
  
  

  
  
  


