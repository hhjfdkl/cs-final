<template>
    <div>
        <select id="order-select" v-model="selectedOrder">
            <option value="releasedate">Release Date</option>
            <option value="title">Title</option>
            <option value="runtime">Runtime</option>
        </select>
        <select id="asc-desc" v-model="selectedDirection">
            <option value="asc">Ascending</option>
            <option value="desc">Descending</option>
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
            console.log(this.selectedOrder, this.selectedDirection);
            if (this.selectedOrder == "") {
                this.selectedOrder = this.$route.params.sort;
            }
            this.$router.push({
                name: this.$route.name,
                params: {
                    pageSize: this.$route.params.pageSize,
                    page: 1,
                    sort: this.selectedOrder
                }
            });
        },
    },
};
</script>