<template>
    <AccountDetails v-bind:Account="this.Account" />
    <GenreList :genres="this.Account.favGenreIds" />
    <FavView />
</template>



<script>
import AccountDetails from "../components/AccountDetails.vue";
import AccountService from "../services/AccountService";
import FavView from "../views/FavView.vue";
import GenreList from "../components/GenreList.vue";






export default {
    data() {
        return {
            Account: {}
        };
    },



    created() {
        this.updateAccount();
    },

    components: {
        AccountDetails,
        FavView,
        GenreList



    },
    methods: {
        updateAccount() {
            AccountService.getAccount().then((response) => {
                this.Account = response.data;
            });
        }
    }






};
</script>

<style></style>
