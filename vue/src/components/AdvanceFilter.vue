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
                <div v-for="(year, index) in years" :key="year" class="year-box">
                    <input type="number" v-model.number="years[index]" @keyup.enter="addSelectedYear(1900)" />

                    <button @click="addSelectedYear(years[index])">+</button>
                </div>
            </div>
            <div v-for="(year, index) in selectedYears" :key="index" class="year-box">
                {{ year }}
                <button @click="removeSelectedYear(index)">X</button>
            </div>
            <br />
            <label for="ratings">MPAA Ratings</label>
            <select id="ratings" v-model="selectedRating">
                <option v-for="rating in ratings" :key="rating" :value="rating">{{ rating }}</option>
            </select>
            <br />
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
            years: ref([1900]),
            selectedYears: [],
            selectedRating: "",
        }
    },
    methods: {
        submitForm() {
            console.log(this.selectedGenres);
            console.log(this.selectedYears);
            console.log(this.selectedRating);
        },
        addYear() {
            this.years.value.push(1900);
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
    watch: {
        years(newVal, oldVal) {
            newVal.forEach(year => {
                if (!this.selectedYears.value.includes(year)) {
                    this.addSelectedYear(year);
                }
            });
            this.selectedYears.value = this.selectedYears.value.filter(year => newVal.includes(year));
        }
    }
    , created() {

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
  
  
  
  
  
  
  
  

  
  
  
