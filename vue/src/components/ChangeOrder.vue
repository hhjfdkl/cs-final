<template>
    <div>
        <select id="order-select" v-model="selectedOrder">
            <option value="" selected disabled>Filter By</option>
            <option value="releasedate">Release Date</option>
            <option value="titleText">Title</option>
            <option value="runtime">Runtime</option>
        </select>
        <select id="asc-desc" v-model="selectedDirection">
            <option value="" selected disabled>Sort By</option>
            <option value="true">Ascending</option>
            <option value="false">Descending</option>
        </select>
        <button id="change-order-button" @click="changeOrder">Change Order</button>
    </div>
</template>

<script>
export default {

    data() {
        return {
            selectedOrder: "",
            selectedDirection: ""
        };
    },
    methods: {
        changeOrder() {

            if (this.selectedOrder == "") {
                this.selectedOrder = this.$route.params.sort;
            }

            if (this.selectedDirection == "") {
                this.selectedDirection = "asc";
            }
            this.$router.push({
                name: this.$route.name,
                params: {
                    pageSize: this.$route.params.pageSize,
                    page: 1,
                    sort: this.selectedOrder
                },
                query: { asc: this.selectedDirection }
            });
        },
    },
};
</script>

<style scoped>
#order-select {
    margin-right: 10px;
    height: 25px;
    width: 150px;
}

#asc-desc {
    margin-right: 10px;
    height: 25px;
    width: 150px
}

#change-order-button {
    height: 25px;
    align-content: center;
    background-color: #890304;
    color: #f8f2bf;
    border: none;

    border-radius: 4px;



    font-family: 'league spartan';

}
</style>