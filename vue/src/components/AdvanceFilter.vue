<template>
    <link href='https://fonts.googleapis.com/css?family=League Spartan' rel='stylesheet'>
    <div class="main-block">
        <form @submit.prevent="submitForm">
            <label id=section-title for="genres">GENRES</label>
            <div id="genre-boxes">
                <div v-for="genre in genres" :key="genre.id" class="genre-item">
                    <label :for="'genre-' + genre.id" :class="{ 'selected': !selectedGenres.includes(genre.id) }"
                        class="genre-label">
                        <img id=genre-img :src="getGenrePng(genre.name)" :alt="genre.name" class="genre-image">
                        <input type="checkbox" :id="'genre-' + genre.id" :value="genre.id" v-model="selectedGenres"
                            class="genre-checkbox" />
                        <span class="genre-name">{{ genre.name }}</span>
                    </label>
                </div>
            </div>

            <br />
            <label id=section-title for="years">Years</label>
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
            <label id=section-title for="ratings">MPAA Ratings</label>
            <div id="mpaa-rating-boxes">
                <div v-for="rating in ratings" :key="rating">
                    <label :for="'rating-' + rating" class="rating-label">
                        <img :src="getMPAARatingPng(rating)" alt="rating" class="mpaa-rating-image">
                        <input type="checkbox" :id="'rating-' + rating" :value="rating" v-model="selectedRating"
                            class="mpaa-rating-checkbox" />
                        <span class="rating-name">{{ rating }}</span>
                    </label>
                </div>
            </div>
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

            <button class=buttons type="submit">Search</button>
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
        },
        getGenrePng(genreName) {
            return "src\\assets\\Genre Cards\\" + genreName + ".png";
        },
        getMPAARatingPng(rating) {
            return "src\\assets\\MPAA Rating\\" + rating + ".png";
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
.main-block {
    font-family: 'League Spartan';
}

.year-box {
    display: flex;
    align-items: center;
    margin-bottom: 0.5rem;
}

.year-box button {
    margin-left: 0.5rem;
}

#genre-img {
    width: 11rem;
    margin-right: 0.5rem;

}

#genre-boxes {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: space-between;
    justify-content: start;
}

.genre-item {
    margin: 5px;
}

.genre-label {
    display: inline-block;
    cursor: pointer;
}

.genre-checkbox {
    display: none;
}

.genre-name {
    display: none;
}

.selected .genre-image {
    filter: brightness(75%)
}

.genre-label.selected .genre-name {
    font-weight: bold;
}

#section-title {
    margin-right: 0.5rem;
    font-size: 2rem;
    font-weight: bold;
    font-family: 'League Spartan';
    color: #7B3911;
}

#mpaa-rating-boxes {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: space-between;
    justify-content: start;
}

.rating-name {
    display: none;
}

.mpaa-rating-image {
    width: 11rem;
    margin-right: 0.5rem;
}

.mpaa-rating-checkbox {
    display: none;
}

.buttons {
    background-color: #890304;
    color: #f8f2bf;
    border: none;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    cursor: pointer;
    /* display: block; */
    margin: 0 auto;
    font-family: 'league spartan';
}

.rating-label {
    display: inline-block;
    cursor: pointer;
}

.rating-label.selected .mpaa-rating-image {
    filter: brightness(50%)
}
</style>
  
  
  
  
  
  
  
  

  
  
  


