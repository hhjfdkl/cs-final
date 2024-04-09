<template>
    <AccountDetails v-bind:Account="this.Account" />
</template>



<script>
import AccountDetails from "../components/AccountDetails.vue";
import AccountService from "../services/AccountService";




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
