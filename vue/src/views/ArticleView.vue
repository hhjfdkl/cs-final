<template>
    <div>
        <img src="@\assets\Fake Articles\Arrest.png" alt="Bootcamp Img" class="article-img">
        <p id="article-title">{{ article.title }}</p>
        <h1 id="article-author">{{ article.author }}</h1>
        <p id="article-body">{{ article.body }}</p>

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

<style scoped>
.article-img {
    width: 50%;
    border-color: #890304;
    border: 1px solid #890304;
    box-shadow: #890304 1px 1px 5px;
}

#article-title {
    color: #7B3911;
    margin-left: 5%;
    font-size: 50px;
}

#article-author {
    color: #7B3911;
    margin-left: 5%;
    font-size: 30px;
}

#article-body {
    color: #002263;
    margin-left: 5%;
    font-size: 20px;
}
</style>