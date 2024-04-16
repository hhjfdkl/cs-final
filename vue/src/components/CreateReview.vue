<template>
    <div>
        <form @submit.prevent="submitForm" id="create-review">
            <div>
                <label for="rating">Rating (1-5):</label>
                <input type="number" id="rating" v-model="review.rating" min="1" max="5" required>
            </div>
            <div>
                <label for="details">Write Review:</label>
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

#create-review>div {
    display: flex;
    flex-direction: column;
    margin-bottom: 10px;
}

#rating {
    width: 30px;
}

#create-review>button {
    width: 100px;
    height: 20px;
    background-color: #890304;
    color: #fff0cb;
    border: 1px solid #890304;
    border-radius: 4px;
    font-family: 'league spartan';
    margin-top: 15px;
    margin-bottom: 15px;
    box-shadow: #a52600 1px 1px 2px;
    cursor: pointer;
}

#details {
    width: 300px;
    height: 150px;

}
</style>
