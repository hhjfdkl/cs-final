<template>
    <main>
        <div id="title-page">
            <link href='https://fonts.googleapis.com/css?family=League Spartan' rel='stylesheet'>
            <img class="logo" src="src\assets\Logos\Box_ffice__5_-removebg-preview.png" alt="BOB Dark LogoLogo">
            <p id="title-text">Welcome to Box Office Buzz! Box Office Buzz is your ultimate destination for all things
                cinema. From the
                latest
                blockbuster hits to hidden gems, our curated recommendations and in-depth reviews ensure you're always in
                the
                know about what's worth watching. Whether you're a casual moviegoer or a dedicated cinephile, let Box Office
                Buzz guide you to your next cinematic adventure. </p>
        </div>
        <div id="bottom-content">
            <div id="buttons">
                <button class="prev-next" id="prev" @click="previousPage">Previous Article</button>
            </div>
            <div class="slideshow">
                <Swiper :modules="[Autoplay]" :spaceBetween="30" :centeredSlides="true"
                    :autoplay="{ delay: 4000, disableOnInteraction: false, }" :pagination="{
                        clickable: true,
                    }" :navigation="true" @autoplayTimeLeft="onAutoplayTimeLeft" class="mySwiper">

                    <SwiperSlide v-for="photo in  photos " :key="photo">
                        <router-link v-bind:to="{ name: 'articles', params: { articleId: photos.indexOf(photo) + 1 } }">
                            <img class="article-img" :src="`src\\assets\\Fake Articles\\${photo}`" alt="photo">
                        </router-link>
                    </SwiperSlide>


                </Swiper>

            </div>
            <div id="buttons">
                <button class="prev-next" id="next" @click="nextPage">Next Article</button>
            </div>

        </div>

    </main>
</template>

<script setup>
import { Swiper, SwiperSlide } from 'swiper/vue';
import 'swiper/css';
import { Autoplay } from 'swiper/modules';
import 'swiper/css/autoplay';


const photos = [
    'Arrest.png',
    'Seagal.png',
    'Commando.png',
    'canceled.png',

    'bobross.png',
    'AI.png',

];


</script>

<script>
export default {
    methods: {
        nextPage() {
            const swiper = document.querySelector('.mySwiper').swiper;


            swiper.slideNext();

        },

        previousPage() {
            const swiper = document.querySelector('.mySwiper').swiper;
            swiper.slidePrev();
        }
    },
};
</script>



<style scoped>
#title-text {
    color: #002263;
    margin-left: 70px;
}

#buttons {
    margin-top: 15px;
}

#title-page {
    text-align: center;
    display: flex;
    flex-direction: column;
    margin-left: 25px;

    align-items: center;
}

#bottom-content {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    margin-left: 5%;
    margin-right: 5%;
    margin-top: 0px;
}

.prev-next {
    background-color: #7B3911;
    border: none;
    color: white;
    padding: 10px 20px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    border-radius: 5px;
}

.slideshow {
    margin-top: 20px;
    margin-bottom: 20px;
}

.swiper {
    overflow: visible;
    width: 770px;
    height: 520px;
}

.swiper-slide img {
    width: 100%;
    height: 100%;

}

.logo {
    margin: auto;
    width: 18rem;
    height: 18rem;

}

p {


    width: 50%;
    color: #7B3911;
}

.link {
    display: inline-block;
    padding: 0.5rem 1rem;
    font-weight: 600;
    color: #7B3911;
    text-decoration: none;
    transition: all 0.3s ease-in-out;
    font-family: 'league Spartan';

}

.link:hover {
    background-color: #7B3911;
    border-radius: 0.5rem;
    color: #fff7d5;
    cursor: pointer;
}

.swiper-slide:not(.swiper-slide-active) img {
    max-width: 100%;
    height: auto;
    transition: 0.3s ease-in-out;
    overflow: visible;

}

.swiper {
    overflow: hidden;
}

.article-img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 0.5rem;
}

.swiper-slide .swiper-slide-active {}
</style>