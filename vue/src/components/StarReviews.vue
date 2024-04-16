<template>
    <div class="rating">
        <img src="src\assets\Other Images\New Star.png" v-bind:title="rating + ' stars'" class="star-rating"
            v-for="n in rating" v-bind:key="n" />
    </div>
</template>

<script>
export default {
    props: {
        rating: {
            type: Number,
            required: true
        }
    }
}
</script>

<style>
.rating {
    display: flex;
    flex-direction: row;
    height: 1rem;
}

.rating-star {
    height: 100%;
}
</style>