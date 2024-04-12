<template>
    <div>
        <select id="order-select" v-model="selectedOrder">
            <option value="releasedate">Release Date</option>
            <option value="titleText">Title</option>
            <option value="runtime">Runtime</option>
        </select>
        <select id="asc-desc" v-model="selectedDirection">
            <option value="true">Ascending</option>
            <option value="false">Descending</option>
        </select>
        <button @click="changeOrder">Change Order</button>
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