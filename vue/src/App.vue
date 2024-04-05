<template>
  <div id="capstone-app">

    <nav id="nav-bar">
      <router-link v-bind:to="{ name: 'title' }">
        <img src="src/assets/BoxOfficeBuzzLogo.png" alt="BOB Logo" class="logo">
      </router-link>
      <router-link v-bind:to="{ name: 'login' }" class="nav-button"
        v-if="$store.state.token == ''">Login</router-link>&nbsp;|&nbsp;
      <router-link v-bind:to="{ name: 'register' }" class="nav-button" v-if="$store.state.token == ''">Sign
        Up</router-link>
      <router-link v-bind:to="{ name: 'logout' }" class="nav-button" v-else>Log out</router-link>

    </nav>
    <div id="outofnav">
      <router-view />
    </div>
  </div>
</template>

<style>
html {
  background-color: #fff0cb;
}

#capstone-app {
  display: grid;
  grid-template-columns: 1fr, 1fr, 1fr;
  grid-template-areas:
    "nav main main"
    "nav jim bill"
  ;
  /* grid-area */
  margin: 0px;
  padding: 0px;
  border: 0px;

}

#nav-bar {
  grid-area: nav;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  border-bottom: 1px solid #002263;
  /* padding: 1rem; */
  background-color: #ffdede;
  height: 100vh;
  width: 150px;
  position: fixed;
  /* added */
  top: 0;
  /* added */
}


.logo {
  width: 40%;
  min-width: 100px;
  height: auto;
}

#nav-bar .logo {
  width: 100%;
  height: auto;
}


#nav-bar .nav-button {

  display: inline-block;
  padding: 0.5rem 1rem;

  background-color: #ffdede;
  border-bottom: solid 1px #002263;
  color: #002263;
  text-decoration: none;
  transition: all 0.3s ease-in-out;

}


#nav-bar .nav-button:hover {
  background-color: #002263;
  border-radius: 0.5rem;
  color: #fff7d5;
  cursor: pointer;
}

#outofnav {
  grid-area: main;
  /* margin-left: 150px; */
  margin-left: 10%;

}
</style>
