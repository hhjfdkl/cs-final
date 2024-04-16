<template>
    <link href='https://fonts.googleapis.com/css?family=League Spartan' rel='stylesheet'>
    <div class="main-block">
        <h1>Advance Filter</h1>
        <form @submit.prevent="submitForm">
            <label id=section-title for="genres">By Genre:</label>
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
            <label id=section-title for="ratings">By MPAA Rating:</label>
            <div id="mpaa-rating-boxes">
                <div v-for="rating in ratings" :key="rating" class="mpaa-rating-item">
                    <label :for="'rating-' + rating" :class="{ 'selected': !selectedRating.includes(rating) }"
                        class="rating-label">
                        <img :src="getMPAARatingPng(rating)" alt="rating" class="mpaa-rating-image">
                        <input type="checkbox" :id="'rating-' + rating" :value="rating" v-model="selectedRating"
                            class="mpaa-rating-checkbox" />
                        <span class="rating-name">{{ rating }}</span>
                    </label>
                </div>
            </div>

            <br />
            <label id=section-title for="years">By Release Year:</label>
            <div id="year-boxes">
                <div class="year-box-search">
                    <input type="number" v-model.number="years" @keyup.enter="addSelectedYear(years)" />

                    <button class="year-box-button" @click.prevent="addSelectedYear(years)">+</button>
                </div>
            </div>
            <div v-for="(year, index) in selectedYears" :key="index" class="year-box">

                <div class=year-box-button-x @click="removeSelectedYear(index)" @submit.prevent="">X</div>
                {{ year }}
            </div>
            <br />

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
            console.log(this.selectedRating);
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

            if (!this.selectedYears.includes(year)) {
                this.selectedYears.push(year);
            }


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
    margin-top: 0.5rem;
    margin-left: 7px;
}

.year-box-button {
    margin-left: 0.5rem;
    background-color: #890304;
    color: #f8f2bf;
    border: none;
    padding: 0.2rem 1rem;
    border-radius: 4px;
    cursor: pointer;
    display: block;
    /* margin: 0 auto; */
    font-family: 'league spartan';
    font-size: 20px;
    font-weight: bolder;
}

.year-box-button-x {
    margin-left: none;
    background-color: #f8f2bf;
    color: #d60000c7;
    border: none;
    /* padding: 0.5rem 1.5rem; */
    /* border-radius: 4px; */
    cursor: pointer;
    display: block;
    /* margin: 0 auto; */
    font-family: 'league spartan';
    font-size: larger;
    font-weight: bolder;
}

.year-box-search {
    display: flex;
    align-items: center;
    margin-bottom: 0.5rem;
    margin-top: 0.5rem;
    margin-left: 7px;
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
    margin-top: 0.5rem;
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
    font-size: 1.4rem;
    font-weight: bold;
    font-family: 'League Spartan';
    color: #7B3911;
    margin-left: 7px;
}

#mpaa-rating-boxes {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    /* justify-content: space-between; */
    /* justify-content: start; */
    gap: 14px;
    margin-top: 0.5rem;
    margin-left: 7px;
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
    margin-left: 7px;
}

.rating-label {
    display: inline-block;
    cursor: pointer;
}

.selected .mpaa-rating-image {
    filter: brightness(75%);
}

h1 {
    font-size: 2rem;
    color: #7B3911;
    text-align: left;
    margin-bottom: 1rem;
    margin-top: 1rem;
    font-family: 'League Spartan';
    font-weight: bold;
    margin-left: 7px;
}

.year-box-button-x {
    border: #890304 1px solid;
    width: 1rem;
    height: 1rem;
    text-align: center;
    margin-right: 0.5rem;

}

.year-box {
    width: 5rem;
}
</style>
  
  
  
  
  
  
  
  

  
  
  


