<template>
    <div id="titlepage">

        <img class="logo" src="src\assets\BoxOfficeBuzzLogo.png" alt="BOB Logo">
        <p>Welcome to Box Office Buzz! Box Office Buzz is your ultimate destination for all things cinema. From the latest
            blockbuster hits to hidden gems, our curated recommendations and in-depth reviews ensure you're always in the
            know about what's worth watching. Whether you're a casual moviegoer or a dedicated cinephile, let Box Office
            Buzz guide you to your next cinematic adventure. </p>

        <router-link v-bind:to="{ name: 'login' }" class="link" v-if="$store.state.token == ''">Login</router-link>
        <br>
        <router-link v-bind:to="{ name: 'register' }" class="link" v-if="$store.state.token == ''">Register</router-link>

    </div>
</template>

<script>
export default {

}
</script>

<style scoped>
#titlepage {
    text-align: center;
}

p {
    font-size: 1.25rem;
    margin: 1rem;
    padding: 2rem;
    font-weight: 900;
}

.link {

    display: inline-block;
    padding: 0.5rem 1rem;


    border-bottom: solid 1px #002263;
    color: #002263;
    text-decoration: none;
    transition: all 0.3s ease-in-out;

}

.link:hover {
    background-color: #002263;
    border-radius: 0.5rem;
    color: #fff7d5;
    cursor: pointer;
}
</style>