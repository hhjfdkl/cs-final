<template>
    <h2 id="account">
        <AccountDetails v-bind:Account="Account" />
    </h2>
    <div id="account-info">
        <GenreList :genres="Account.favGenreIds" :AccountService="AccountService" />
    </div>
    <div>
        <FavView />
    </div>
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
        },
        addGenre(event) {
            console.log(event.target.dataset.genreId);
            const genreId = event.target.dataset.genreId;
            this.AccountService.addGenre(genreId);
        }
        ,
        created() {
            this.$root.$on('add', this.addGenre);
        },
        beforeUnmount() {
            this.$root.$off('update-account', this.handleEvent);
        }






    }
}
</script>

<style>
#account {
    color: #7B3911;
    margin-left: 5%;
    font-size: 50px;
}

#account-info {
    color: #7B3911;
    margin-left: 5%;
}

AccountDetails {
    font-size: 120%;
}
</style>
