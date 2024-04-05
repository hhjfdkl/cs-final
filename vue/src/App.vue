<template>
  <div id="capstone-app">

    <nav id="nav-bar">
      <router-link v-bind:to="{ name: 'title' }">
        <img src="src/assets/BoxOfficeBuzzLogo.png" alt="BOB Logo" class="logo">
      </router-link>
      <router-link v-bind:to="{ name: 'login' }" class="nav-button">Login</router-link>&nbsp;|&nbsp;
      <router-link v-bind:to="{ name: 'register' }" class="nav-button">Sign Up</router-link>
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

#nav-bar {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  border-bottom: 1px solid #002263;
  /* padding: 1rem; */
  background-color: #ffdede;
  height: 100vh;
  width: 10%;
  position: fixed;
  /* added */
  top: 0;
  /* added */
}


.logo {
  width: 40%;
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
  margin-left: 10%;
  background-color: aqua;
}
</style>
