<template>
    <div>
        <form @submit.prevent="submitForm" id="create-review">
            <div>
                <label for="rating">Rating (1-5):</label>
                <input type="number" id="rating" v-model="review.rating" min="1" max="5" required>
            </div>
            <div>
                <label for="details">Details:</label>
                <textarea id="details" v-model="review.details" required></textarea>
            </div>

            <button type="submit">Submit</button>
        </form>
    </div>
</template>

<script>
import MovieService from '../services/MovieService';
export default {
    data() {
        return {
            review: {
                rating: null,
                details: ""
            }
        }
    },
    methods: {
        submitForm() {

            console.log(this.review);

            MovieService.addReview(this.$route.params.movieId, this.review.details, this.review.rating).then(() => {
                //nothing right now
            })

            this.rating = null;
            this.details = "";

            window.location.reload();
        }
    }
}
</script>

 

<style scoped>
#create-review {

    display: flex;
    flex-direction: column;




    margin-bottom: 30px;

}

#create-review>* {}

#create-review>button {
    width: 100px;
    height: 20px;
}

#details {
    width: 300px;

}
</style>
