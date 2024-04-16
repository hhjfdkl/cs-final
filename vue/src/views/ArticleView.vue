<template>
    <div>


        <p>{{ article.title }}</p>
        <h1>{{ article.author }}</h1>
        <p>{{ article.body }}</p>

    </div>
</template>

<script>
import ArticleService from '../services/ArticleService.js';
export default {
    data() {
        return {
            article: {}
        }
    },

    created() {
        ArticleService.getArticle(this.$route.params.articleId).then((response) => {
            this.article = response.data;
        })
    }
}
</script>

<style scoped></style>