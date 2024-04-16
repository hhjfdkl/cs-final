<template>
    <div class="section-title">
        Reviews
    </div>
    <div>
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

<style scoped>
.section-title {
    color: #7B3911;
    font-size: 2rem;
    margin-left: 10px;
    margin-top: 5px;
}
</style>