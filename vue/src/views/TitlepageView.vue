<template>
    <div id="titlepage">

        <img class="logo" src="src\assets\BoxOfficeBuzzLogo.png" alt="BOB Logo">
        <p>Welcome to Box Office Buzz!</p>

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
    font-size: 1.5rem;
    margin-bottom: 1rem;

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