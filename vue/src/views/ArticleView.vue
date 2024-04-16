<template>
    <div>
        <img v-if="this.$route.params.articleId == 1" src="@\assets\Fake Articles\Arrest.png" alt="Arrest Img"
            class="article-img">
        <img v-if="this.$route.params.articleId == 2" src="@\assets\Fake Articles\Seagal.png" alt="Seagal Img"
            class="article-img">
        <img v-if="this.$route.params.articleId == 3" src="@\assets\Fake Articles\Commando.png" alt="Commando Img"
            class="article-img">
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
            return this.article.body.split('||');
        }
    }
}
</script>

<style scoped>
.article-img {
    width: 50%;
    margin-left: 5%;
    margin-top: 5%;

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