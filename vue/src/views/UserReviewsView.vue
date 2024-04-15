<template>
    <div>
        user REviews

        <ReviewList />

    </div>
</template>

<script>
import ReviewList from '../components/ReviewList.vue';
import AccountService from '../services/AccountService.js';

export default {

    components: {
        ReviewList
    },



}
</script>

<style scoped></style>