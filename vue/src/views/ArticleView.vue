<template>
    <div>
        <img src="@\assets\Fake Articles\Arrest.png" alt="Bootcamp Img" class="article-img">
        <p id="article-title">{{ article.title }}</p>
        <h1 id="article-author">{{ article.author }}</h1>
        <!-- <p id="article-body">{{ article.body }}</p> -->

        <div v-for="paragraph in collectionOfParagraphs" :key="paragraph">
            <p id="article-body">{{ paragraph }}</p>
        </div>
    </div>
</template>

<script>
import ArticleService from '../services/ArticleService.js';
export default {
    data() {
        return {
            article: { title: '', author: '', body: '' }

        }
    },

    created() {
        ArticleService.getArticle(this.$route.params.articleId).then((response) => {
            this.article = response.data;

        })
    },
    computed: {
        collectionOfParagraphs() {
            console.log(this.article.body)
            return this.article.body.split('\\n');
        }
    }
}
</script>

<style scoped>
.article-img {
    width: 50%;

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