<template>
    <AccountDetails v-bind:Account="this.Account" />
    <FavView />
</template>



<script>
import AccountDetails from "../components/AccountDetails.vue";
import AccountService from "../services/AccountService";
import FavView from "../views/FavView.vue";




export default {
    data() {
        return {
            Account: {}
        };
    }

    ,
    created() {
        this.updateAccount();
    },

    components: {
        AccountDetails,
        FavView



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
