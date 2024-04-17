<template>
    <div>
        <h2>News</h2>
    </div>
    <div>
        <img v-if="this.$route.params.articleId == 1" src="@\assets\Fake Articles\Arrest.png" alt="Arrest Img"
            class="article-img">
        <img v-if="this.$route.params.articleId == 2" src="@\assets\Fake Articles\Seagal.png" alt="Seagal Img"
            class="article-img">
        <img v-if="this.$route.params.articleId == 3" src="@\assets\Fake Articles\Commando.png" alt="Commando Img"
            class="article-img">
        <img v-if="this.$route.params.articleId == 4" src="@\assets\Fake Articles\fizzbuzz.png" alt="Fizzbuzz Img"
            class="article-img">
        <img v-if="this.$route.params.articleId == 5" src="@\assets\Fake Articles\bobross.png" alt="Bobross Img"
            class="article-img">
        <img v-if="this.$route.params.articleId == 6" src="@\assets\Fake Articles\AI.png" alt="AI Img" class="article-img">

        <p id="article-title">{{ article.title }}</p>
        <h1 id="article-author">{{ article.author }}</h1>
        <!-- <p id="article-body">{{ article.body }}</p> -->


        <div v-for="paragraph in collectionOfParagraphs" :key="paragraph">
            <p id="article-body">{{ paragraph }}</p>
        </div>
        <div id="buttons">
            <button class="prev-next" id="prev" @click="prevArt">Previous
                Article</button>
            <button class="prev-next" id="next" @click="nextArt">Next
                Article</button>
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
    },
    methods: {
        nextArt() {

            this.$router.push({
                name: 'articles',
                params: {
                    articleId: Math.min(Number(this.$route.params.articleId) + 1, 6)
                }
            })
        },
        prevArt() {
            this.$router.push({
                name: 'articles',
                params: {
                    articleId: Math.max(Number(this.$route.params.articleId) - 1, 0)
                }
            })
        }
    },


    watch: { //runs updateMovies when route changes
        '$route': function () {
            ArticleService.getArticle(this.$route.params.articleId).then((response) => {
                this.article = response.data;

            })
        }
    },

}
</script>

<style scoped>
h2 {
    color: #7B3911;
    margin-left: 5%;
    font-size: 50px;
}

.article-img {
    width: 50%;
    margin-left: 5%;


}

#article-title {
    color: #7B3911;
    margin-left: 5%;
    font-size: 50px;
    margin-right: 5%;
}

#article-author {
    color: #7B3911;
    margin-left: 5%;
    font-size: 30px;
}

#article-body {
    color: #002263;
    margin-left: 5%;
    margin-right: 5%;
    font-size: 20px;
}

.prev-next {
    background-color: #fff0cb;
    color: #890304;
    border: 1px solid #890304;
    margin-top: 10px;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    cursor: pointer;
    display: block;
    margin: 0 auto;
    font-family: 'league spartan';
}

#prev {
    margin-left: 5%;
    margin-right: 1%;
}

#next {
    margin-right: 1%;
    margin-left: 1%;
}

.prev-next:hover {
    background-color: #890304;
    color: #fff0cb;
}

#buttons {
    width: 95%;

    margin-left: 0;
    margin-right: 0;
    display: flex;
    justify-content: space-between;
    margin-bottom: 25px;
}
</style>