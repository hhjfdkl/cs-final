<template>
    <div id="titlepage">
        <link href='https://fonts.googleapis.com/css?family=League Spartan' rel='stylesheet'>
        <img class="logo" src="src\assets\Dark Theme Logo.png" alt="BOB Dark LogoLogo">
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
    display: flex;
    flex-direction: column;

}

.logo {
    margin: auto;
}

p {
    font-size: 1.25rem;
    font-weight: 500;
    font-family: 'league Spartan';
    width: 50%;
    margin: auto;
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
</style>